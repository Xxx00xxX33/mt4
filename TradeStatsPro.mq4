//+------------------------------------------------------------------+
//|  TradeStatsPro.mq4                                               |
//|  MT4收益统计指标 - 支持CSV持久化，每日增量写入                      |
//+------------------------------------------------------------------+
#property copyright "TradeStatsPro"
#property link      ""
#property version   "2.0"
#property indicator_chart_window
#property indicator_plots 0

//==========================================================================
// 输入参数
//==========================================================================
input bool   CSV_AutoSave    = true;    // 启用CSV自动保存
input int    CSV_DaysBack    = 1;       // 写入几天前的数据(1=昨天)
input string Only_Magic      = "";      // 只统计指定Magic(逗号分隔,空=全部)
input string Only_Symbol     = "";      // 只统计指定品种(空=全部)
input string Default_Tab     = "综";    // 默认标签页
input int    Day_Count       = 100;     // 日统计显示天数
input int    Week_Count      = 200;     // 周统计显示周数
input int    Month_Count     = 100;     // 月统计显示月数
input int    Quarter_Count   = 40;      // 季度统计显示数
input int    Year_Count      = 20;      // 年统计显示数
input bool   Day_ShowEmpty   = false;   // 日统计显示空行
input bool   Week_ShowEmpty  = false;   // 周统计显示空行
input bool   Month_ShowEmpty = false;   // 月统计显示空行
input bool   Quarter_ShowEmpty = false; // 季度统计显示空行
input bool   Year_ShowEmpty  = false;   // 年统计显示空行
input int    FontSize        = 8;       // 字体大小
input string FontName        = "Consolas"; // 字体
input color  ColorProfit     = clrLime;    // 盈利颜色
input color  ColorLoss       = clrRed;    // 亏损颜色
input color  ColorHeader     = clrYellow; // 表头颜色
input color  ColorNeutral    = clrWhite;  // 中性颜色
input color  ColorLabel      = clrSilver; // 标签颜色
input color  ColorBg         = C'20,20,30'; // 背景颜色
input color  ColorTitle      = clrDarkSlateGray; // 标题栏颜色
input color  ColorTab        = C'30,30,50'; // 标签栏颜色
input color  ColorTabActive  = C'0,80,150'; // 激活标签颜色
input color  ColorCurve      = clrDodgerBlue; // 曲线颜色
input int    Panel_X         = 0;       // 面板X坐标
input int    Panel_Y         = 20;      // 面板Y坐标
input int    Panel_Width     = 1200;    // 面板宽度

//==========================================================================
// 常量
//==========================================================================
#define MAX_TRADES   50000
#define MAX_STATS    2000
#define MAX_DEPOSITS 1000
#define TITLE_H      20
#define TAB_H        20
#define ROW_H        14
#define CHART_H_FULL 120
#define COL_WIDTHS_COUNT 18

//==========================================================================
// 数据结构
//==========================================================================
struct TradeRec
{
    int      ticket;
    string   symbol;
    int      type;       // 0=buy,1=sell
    double   lots;
    datetime openTime;
    datetime closeTime;
    double   openPrice;
    double   closePrice;
    double   profit;
    double   commission;
    double   swap;
    double   openEquity;  // 开仓时净值(用于最大浮亏计算)
    int      magic;
    string   comment;
    double   maxDD;       // 最大浮亏
    double   maxProfit;   // 最大浮盈
};

struct DepositRec
{
    datetime time;
    double   amount;
    int      ticket;
};

struct StatRow
{
    string   label;
    double   lots;
    double   minLots;
    double   maxLots;
    int      count;
    double   profit;      // 净盈亏(含手续费库存费)
    double   rawProfit;   // 纯盈亏
    double   pct;         // 百分比
    double   commission;
    double   swap;
    double   deposit;     // 出入金
    double   balance;     // 期末余额
    double   maxDD;       // 最大浮亏
    double   maxDDPct;
    double   maxProfit;   // 最大浮盈
    double   maxProfitPct;
    int      minDuration; // 秒
    int      avgDuration;
    int      maxDuration;
    int      winCount;
    double   winProfit;
    double   lossProfit;
    double   winRate;
    double   plRatio;
    int      winCountW;   // 胜(含手续费)
};

//==========================================================================
// 全局变量
//==========================================================================
TradeRec   g_trades[];
int        g_tradeCount = 0;
DepositRec g_deposits[];
int        g_depositCount = 0;

// 各维度统计数组
StatRow g_dayStat[];    int g_dayCount = 0;
StatRow g_weekStat[];   int g_weekCount = 0;
StatRow g_monthStat[];  int g_monthCount = 0;
StatRow g_quarterStat[];int g_quarterCount = 0;
StatRow g_yearStat[];   int g_yearCount = 0;
StatRow g_symbolStat[]; int g_symbolCount = 0;
StatRow g_magicStat[];  int g_magicCount = 0;
StatRow g_commentStat[];int g_commentCount = 0;

// 综合视图汇总
StatRow g_weekSum, g_monthSum, g_quarterSum, g_yearSum, g_totalSum;
StatRow g_holdingSum, g_buySum, g_sellSum;

// 面板状态
int    g_panelX = 0;
int    g_panelY = 20;
bool   g_minimized = false;
string g_activeTab = "综";
int    g_scrollOffset = 0;

// 拖动状态
bool   g_dragging = false;
int    g_dragStartX = 0;
int    g_dragStartY = 0;
int    g_dragPanelX = 0;
int    g_dragPanelY = 0;
int    g_lastMouseX = 0;
int    g_lastMouseY = 0;

// 上次刷新时间
datetime g_lastRefresh = 0;
datetime g_lastSave = 0;

// 列宽配置(像素)
int g_colW[COL_WIDTHS_COUNT];

// 曲线数据
double g_curveVals[];
string g_curveLabels[];
int    g_curveCount = 0;

// Magic筛选列表
int    g_filterMagic[];
int    g_filterMagicCount = 0;
string g_filterSymbol = "";

// 对象名前缀
string g_prefix = "TSP_";

//==========================================================================
// 工具函数
//==========================================================================
string IntToStr(int v) { return IntegerToString(v); }

string FormatLots(double v)
{
    return DoubleToString(v, 2);
}

string FormatMoney(double v)
{
    if(MathAbs(v) >= 1000000) return DoubleToString(v/1000000.0, 2) + "M";
    if(MathAbs(v) >= 10000)   return DoubleToString(v, 0);
    return DoubleToString(v, 2);
}

string FormatPct(double v)
{
    return DoubleToString(v*100.0, 2) + " %";
}

string FormatDuration(int secs)
{
    if(secs < 0) secs = 0;
    int d = secs / 86400;
    int h = (secs % 86400) / 3600;
    int m = (secs % 3600) / 60;
    int s = secs % 60;
    return StringFormat("%d:%02d:%02d:%02d", d, h, m, s);
}

string FormatMinMaxDuration(int mn, int avg, int mx)
{
    return FormatDuration(mn) + "|" + FormatDuration(avg) + "|" + FormatDuration(mx);
}

color ProfitColor(double v)
{
    if(v > 0) return ColorProfit;
    if(v < 0) return ColorLoss;
    return ColorNeutral;
}

bool PassFilter(int magic, string symbol)
{
    if(g_filterMagicCount > 0)
    {
        bool ok = false;
        for(int i=0; i<g_filterMagicCount; i++)
            if(g_filterMagic[i] == magic) { ok = true; break; }
        if(!ok) return false;
    }
    if(g_filterSymbol != "" && symbol != g_filterSymbol) return false;
    return true;
}

void ParseMagicFilter()
{
    g_filterMagicCount = 0;
    if(Only_Magic == "") return;
    string parts[];
    int n = StringSplit(Only_Magic, ',', parts);
    ArrayResize(g_filterMagic, n);
    for(int i=0; i<n; i++)
    {
        StringTrimLeft(parts[i]);
        StringTrimRight(parts[i]);
        if(parts[i] != "")
        {
            g_filterMagic[g_filterMagicCount] = (int)StringToInteger(parts[i]);
            g_filterMagicCount++;
        }
    }
}

//==========================================================================
// CSV路径
//==========================================================================
string GetCSVPath()
{
    return "TradeStats_" + IntegerToString(AccountNumber()) + ".csv";
}

//==========================================================================
// CSV写入
//==========================================================================
// CSV格式: ticket,symbol,type,lots,openTime,closeTime,openPrice,closePrice,profit,commission,swap,magic,comment
void SaveToCSV()
{
    if(!CSV_AutoSave) return;
    
    string path = GetCSVPath();
    
    // 先读取已有ticket集合
    int existTickets[];
    int existCount = 0;
    ArrayResize(existTickets, MAX_TRADES);
    
    int fh = FileOpen(path, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh != INVALID_HANDLE)
    {
        while(!FileIsEnding(fh))
        {
            string line = FileReadString(fh);
            if(line == "") { FileReadString(fh); continue; } // skip rest of line
            // read rest of columns to advance
            for(int c=1; c<13; c++) FileReadString(fh);
            int tk = (int)StringToInteger(line);
            if(tk > 0 && existCount < MAX_TRADES)
            {
                existTickets[existCount] = tk;
                existCount++;
            }
        }
        FileClose(fh);
    }
    
    // 计算写入截止时间
    datetime cutoff = TimeCurrent() - (datetime)(CSV_DaysBack * 86400);
    // 写入当天00:00:00
    cutoff = cutoff - cutoff % 86400;
    
    // 追加新记录
    fh = FileOpen(path, FILE_WRITE|FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh == INVALID_HANDLE) return;
    FileSeek(fh, 0, SEEK_END);
    
    int written = 0;
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        if(g_trades[i].closeTime >= cutoff) continue; // 只写cutoff之前的
        
        // 检查是否已存在
        bool exists = false;
        for(int j=0; j<existCount; j++)
            if(existTickets[j] == g_trades[i].ticket) { exists = true; break; }
        if(exists) continue;
        
        FileWrite(fh,
            IntegerToString(g_trades[i].ticket),
            g_trades[i].symbol,
            IntegerToString(g_trades[i].type),
            DoubleToString(g_trades[i].lots, 2),
            TimeToStr(g_trades[i].openTime, TIME_DATE|TIME_MINUTES|TIME_SECONDS),
            TimeToStr(g_trades[i].closeTime, TIME_DATE|TIME_MINUTES|TIME_SECONDS),
            DoubleToString(g_trades[i].openPrice, 5),
            DoubleToString(g_trades[i].closePrice, 5),
            DoubleToString(g_trades[i].profit, 2),
            DoubleToString(g_trades[i].commission, 2),
            DoubleToString(g_trades[i].swap, 2),
            IntegerToString(g_trades[i].magic),
            g_trades[i].comment
        );
        written++;
    }
    FileClose(fh);
    
    if(written > 0)
        Print("TradeStatsPro: CSV写入 ", written, " 条记录");
}

//==========================================================================
// CSV读取
//==========================================================================
void LoadFromCSV()
{
    string path = GetCSVPath();
    int fh = FileOpen(path, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh == INVALID_HANDLE) return;
    
    int loaded = 0;
    while(!FileIsEnding(fh))
    {
        string s_ticket     = FileReadString(fh); if(FileIsEnding(fh)) break;
        string s_symbol     = FileReadString(fh);
        string s_type       = FileReadString(fh);
        string s_lots       = FileReadString(fh);
        string s_openTime   = FileReadString(fh);
        string s_closeTime  = FileReadString(fh);
        string s_openPrice  = FileReadString(fh);
        string s_closePrice = FileReadString(fh);
        string s_profit     = FileReadString(fh);
        string s_commission = FileReadString(fh);
        string s_swap       = FileReadString(fh);
        string s_magic      = FileReadString(fh);
        string s_comment    = FileReadString(fh);
        
        int ticket = (int)StringToInteger(s_ticket);
        if(ticket <= 0) continue;
        
        // 检查是否已从MT4加载
        bool dup = false;
        for(int i=0; i<g_tradeCount; i++)
            if(g_trades[i].ticket == ticket) { dup = true; break; }
        if(dup) continue;
        
        if(g_tradeCount >= MAX_TRADES) break;
        
        TradeRec r;
        r.ticket      = ticket;
        r.symbol      = s_symbol;
        r.type        = (int)StringToInteger(s_type);
        r.lots        = StringToDouble(s_lots);
        r.openTime    = StringToTime(s_openTime);
        r.closeTime   = StringToTime(s_closeTime);
        r.openPrice   = StringToDouble(s_openPrice);
        r.closePrice  = StringToDouble(s_closePrice);
        r.profit      = StringToDouble(s_profit);
        r.commission  = StringToDouble(s_commission);
        r.swap        = StringToDouble(s_swap);
        r.magic       = (int)StringToInteger(s_magic);
        r.comment     = s_comment;
        r.maxDD       = 0;
        r.maxProfit   = 0;
        r.openEquity  = 0;
        
        if(!PassFilter(r.magic, r.symbol)) continue;
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
        loaded++;
    }
    FileClose(fh);
    if(loaded > 0)
        Print("TradeStatsPro: 从CSV加载 ", loaded, " 条历史记录");
}

//==========================================================================
// 从MT4加载全部历史
//==========================================================================
void LoadFromMT4()
{
    // 先加载已平仓订单
    int total = OrdersHistoryTotal();
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        
        int type = OrderType();
        // OP_BUY=0, OP_SELL=1 - 只统计交易订单
        if(type != OP_BUY && type != OP_SELL) continue;
        
        int ticket = OrderTicket();
        if(!PassFilter(OrderMagicNumber(), OrderSymbol())) continue;
        
        // 检查是否已从CSV加载
        bool dup = false;
        for(int j=0; j<g_tradeCount; j++)
            if(g_trades[j].ticket == ticket) { dup = true; break; }
        if(dup) continue;
        
        if(g_tradeCount >= MAX_TRADES) break;
        
        TradeRec r;
        r.ticket      = ticket;
        r.symbol      = OrderSymbol();
        r.type        = type;
        r.lots        = OrderLots();
        r.openTime    = OrderOpenTime();
        r.closeTime   = OrderCloseTime();
        r.openPrice   = OrderOpenPrice();
        r.closePrice  = OrderClosePrice();
        r.profit      = OrderProfit();
        r.commission  = OrderCommission();
        r.swap        = OrderSwap();
        r.magic       = OrderMagicNumber();
        r.comment     = OrderComment();
        r.maxDD       = 0;
        r.maxProfit   = 0;
        r.openEquity  = 0;
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
    }
    
    // 加载出入金记录
    g_depositCount = 0;
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        int type = OrderType();
        // OP_BALANCE=6, OP_CREDIT=7
        if(type != 6 && type != 7) continue;
        if(g_depositCount >= MAX_DEPOSITS) break;
        g_deposits[g_depositCount].time   = OrderCloseTime();
        g_deposits[g_depositCount].amount = OrderProfit();
        g_deposits[g_depositCount].ticket = OrderTicket();
        g_depositCount++;
    }
    
    // 加载持仓订单
    int openTotal = OrdersTotal();
    for(int i=0; i<openTotal; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
        int type = OrderType();
        if(type != OP_BUY && type != OP_SELL) continue;
        if(!PassFilter(OrderMagicNumber(), OrderSymbol())) continue;
        if(g_tradeCount >= MAX_TRADES) break;
        
        TradeRec r;
        r.ticket      = OrderTicket();
        r.symbol      = OrderSymbol();
        r.type        = type;
        r.lots        = OrderLots();
        r.openTime    = OrderOpenTime();
        r.closeTime   = 0; // 持仓
        r.openPrice   = OrderOpenPrice();
        r.closePrice  = 0;
        r.profit      = OrderProfit();
        r.commission  = OrderCommission();
        r.swap        = OrderSwap();
        r.magic       = OrderMagicNumber();
        r.comment     = OrderComment();
        r.maxDD       = 0;
        r.maxProfit   = 0;
        r.openEquity  = AccountEquity();
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
    }
}

//==========================================================================
// 按时间排序（升序）
//==========================================================================
void SortTradesByCloseTime()
{
    // 简单插入排序，已平仓在前，持仓在后
    for(int i=1; i<g_tradeCount; i++)
    {
        TradeRec key = g_trades[i];
        datetime kt = (key.closeTime == 0) ? 9999999999 : key.closeTime;
        int j = i-1;
        while(j >= 0)
        {
            datetime jt = (g_trades[j].closeTime == 0) ? 9999999999 : g_trades[j].closeTime;
            if(jt <= kt) break;
            g_trades[j+1] = g_trades[j];
            j--;
        }
        g_trades[j+1] = key;
    }
}

//==========================================================================
// 计算初始余额（从最早记录推算）
//==========================================================================
double CalcStartBalance()
{
    // 当前余额 = 初始余额 + 所有出入金 + 所有已平仓净盈亏
    double totalPnL = 0;
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        totalPnL += g_trades[i].profit + g_trades[i].commission + g_trades[i].swap;
    }
    double totalDeposit = 0;
    for(int i=0; i<g_depositCount; i++)
        totalDeposit += g_deposits[i].amount;
    
    double startBal = AccountBalance() - totalPnL - totalDeposit;
    if(startBal < 0) startBal = 0;
    return startBal;
}

//==========================================================================
// 获取某时间段内的出入金总额
//==========================================================================
double GetDepositInRange(datetime t1, datetime t2)
{
    double sum = 0;
    for(int i=0; i<g_depositCount; i++)
        if(g_deposits[i].time >= t1 && g_deposits[i].time < t2)
            sum += g_deposits[i].amount;
    return sum;
}

//==========================================================================
// 初始化StatRow
//==========================================================================
void InitRow(StatRow &s)
{
    s.label      = "";
    s.lots       = 0;
    s.minLots    = 1e10;
    s.maxLots    = 0;
    s.count      = 0;
    s.profit     = 0;
    s.rawProfit  = 0;
    s.pct        = 0;
    s.commission = 0;
    s.swap       = 0;
    s.deposit    = 0;
    s.balance    = 0;
    s.maxDD      = 0;
    s.maxDDPct   = 0;
    s.maxProfit  = 0;
    s.maxProfitPct = 0;
    s.minDuration = 0x7FFFFFFF;
    s.avgDuration = 0;
    s.maxDuration = 0;
    s.winCount   = 0;
    s.winCountW  = 0;
    s.winProfit  = 0;
    s.lossProfit = 0;
    s.winRate    = 0;
    s.plRatio    = 0;
}

void AccumTrade(StatRow &s, TradeRec &r)
{
    s.count++;
    s.lots      += r.lots;
    if(r.lots < s.minLots) s.minLots = r.lots;
    if(r.lots > s.maxLots) s.maxLots = r.lots;
    
    double net = r.profit + r.commission + r.swap;
    s.profit     += net;
    s.rawProfit  += r.profit;
    s.commission += r.commission;
    s.swap       += r.swap;
    
    if(r.profit > 0) { s.winCount++; s.winProfit += r.profit; }
    else             { s.lossProfit += r.profit; }
    if(net > 0) s.winCountW++;
    
    if(r.closeTime > 0 && r.openTime > 0)
    {
        int dur = (int)(r.closeTime - r.openTime);
        if(dur < s.minDuration) s.minDuration = dur;
        if(dur > s.maxDuration) s.maxDuration = dur;
        s.avgDuration += dur;
    }
}

void FinalizeRow(StatRow &s, double startBal)
{
    if(s.count == 0)
    {
        s.minLots = 0;
        s.minDuration = 0;
        s.avgDuration = 0;
        return;
    }
    if(s.minLots >= 1e9) s.minLots = 0;
    s.avgDuration = s.avgDuration / s.count;
    if(s.minDuration == 0x7FFFFFFF) s.minDuration = 0;
    
    if(startBal > 0)
        s.pct = s.profit / startBal;
    else
        s.pct = 0;
    
    if(s.count > 0)
        s.winRate = (double)s.winCountW / s.count;
    
    double avgWin  = (s.winCount > 0) ? s.winProfit / s.winCount : 0;
    double lossN   = s.count - s.winCount;
    double avgLoss = (lossN > 0) ? MathAbs(s.lossProfit / lossN) : 0;
    s.plRatio = (avgLoss > 0) ? avgWin / avgLoss : 0;
}

//==========================================================================
// 时间分组辅助
//==========================================================================
string DayKey(datetime t)   { return StringFormat("%04d%02d%02d", TimeYear(t), TimeMonth(t), TimeDay(t)); }
string WeekKey(datetime t)
{
    // ISO周：周一为第一天
    int dow = TimeDayOfWeek(t); // 0=Sun
    if(dow == 0) dow = 7;
    datetime mon = t - (datetime)((dow-1)*86400);
    mon = mon - mon % 86400;
    return StringFormat("%04d%02d%02d", TimeYear(mon), TimeMonth(mon), TimeDay(mon));
}
string MonthKey(datetime t) { return StringFormat("%04d%02d", TimeYear(t), TimeMonth(t)); }
string QuarterKey(datetime t)
{
    int q = (TimeMonth(t)-1)/3 + 1;
    return StringFormat("%04dQ%d", TimeYear(t), q);
}
string YearKey(datetime t)  { return StringFormat("%04d", TimeYear(t)); }

string DayLabel(datetime t)   { return StringFormat("%04d.%02d.%02d", TimeYear(t), TimeMonth(t), TimeDay(t)); }
string WeekLabel(datetime t)
{
    int dow = TimeDayOfWeek(t);
    if(dow == 0) dow = 7;
    datetime mon = t - (datetime)((dow-1)*86400);
    mon = mon - mon % 86400;
    datetime sun = mon + (datetime)(6*86400);
    return StringFormat("%04d.%02d.%02d~%04d.%02d.%02d",
        TimeYear(mon),TimeMonth(mon),TimeDay(mon),
        TimeYear(sun),TimeMonth(sun),TimeDay(sun));
}
string MonthLabel(datetime t) { return StringFormat("%04d.%02d", TimeYear(t), TimeMonth(t)); }
string QuarterLabel(datetime t)
{
    int q = (TimeMonth(t)-1)/3+1;
    int sm = (q-1)*3+1, em = q*3;
    return StringFormat("%04d.%02d~%04d.%02d", TimeYear(t), sm, TimeYear(t), em);
}
string YearLabel(datetime t)  { return StringFormat("%04d", TimeYear(t)); }

//==========================================================================
// 通用分组统计（按key分组）
//==========================================================================
void CalcGroupStats(StatRow &outArr[], int &outCount, int maxCount,
                    bool showEmpty, string mode)
{
    outCount = 0;
    ArrayResize(outArr, MAX_STATS);
    
    // 收集所有key（升序）
    string keys[];
    datetime keyTimes[]; // 该key的代表时间
    int kCount = 0;
    ArrayResize(keys, MAX_STATS);
    ArrayResize(keyTimes, MAX_STATS);
    
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        string k = "";
        if(mode=="day")     k = DayKey(g_trades[i].closeTime);
        else if(mode=="week")  k = WeekKey(g_trades[i].closeTime);
        else if(mode=="month") k = MonthKey(g_trades[i].closeTime);
        else if(mode=="quarter") k = QuarterKey(g_trades[i].closeTime);
        else if(mode=="year")  k = YearKey(g_trades[i].closeTime);
        if(k == "") continue;
        
        bool found = false;
        for(int j=0; j<kCount; j++)
            if(keys[j] == k) { found = true; break; }
        if(!found && kCount < MAX_STATS)
        {
            keys[kCount] = k;
            keyTimes[kCount] = g_trades[i].closeTime;
            kCount++;
        }
    }
    
    // 升序排序
    for(int i=0; i<kCount-1; i++)
        for(int j=i+1; j<kCount; j++)
            if(keys[i] > keys[j])
            {
                string tk = keys[i]; keys[i]=keys[j]; keys[j]=tk;
                datetime tt = keyTimes[i]; keyTimes[i]=keyTimes[j]; keyTimes[j]=tt;
            }
    
    // 计算运行余额（升序）
    double startBal = CalcStartBalance();
    double runBal = startBal;
    double endBals[];
    double depAmts[];
    ArrayResize(endBals, kCount);
    ArrayResize(depAmts, kCount);
    
    for(int ki=0; ki<kCount; ki++)
    {
        // 该期出入金
        datetime t1, t2;
        GetPeriodRange(mode, keyTimes[ki], t1, t2);
        double dep = GetDepositInRange(t1, t2);
        depAmts[ki] = dep;
        runBal += dep;
        
        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            string k = "";
            if(mode=="day")     k = DayKey(g_trades[i].closeTime);
            else if(mode=="week")  k = WeekKey(g_trades[i].closeTime);
            else if(mode=="month") k = MonthKey(g_trades[i].closeTime);
            else if(mode=="quarter") k = QuarterKey(g_trades[i].closeTime);
            else if(mode=="year")  k = YearKey(g_trades[i].closeTime);
            if(k != keys[ki]) continue;
            runBal += g_trades[i].profit + g_trades[i].commission + g_trades[i].swap;
        }
        endBals[ki] = runBal;
    }
    
    // 降序输出（最新在前）
    for(int i=0; i<kCount-1; i++)
        for(int j=i+1; j<kCount; j++)
            if(keys[i] < keys[j])
            {
                string tk=keys[i]; keys[i]=keys[j]; keys[j]=tk;
                datetime tt=keyTimes[i]; keyTimes[i]=keyTimes[j]; keyTimes[j]=tt;
                double td=endBals[i]; endBals[i]=endBals[j]; endBals[j]=td;
                double tda=depAmts[i]; depAmts[i]=depAmts[j]; depAmts[j]=tda;
            }
    
    int limit = (maxCount > 0 && kCount > maxCount) ? maxCount : kCount;
    
    for(int ki=0; ki<limit; ki++)
    {
        StatRow s;
        InitRow(s);
        
        if(mode=="day")     s.label = DayLabel(keyTimes[ki]);
        else if(mode=="week")  s.label = WeekLabel(keyTimes[ki]);
        else if(mode=="month") s.label = MonthLabel(keyTimes[ki]);
        else if(mode=="quarter") s.label = QuarterLabel(keyTimes[ki]);
        else if(mode=="year")  s.label = YearLabel(keyTimes[ki]);
        
        s.deposit = depAmts[ki];
        
        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            string k = "";
            if(mode=="day")     k = DayKey(g_trades[i].closeTime);
            else if(mode=="week")  k = WeekKey(g_trades[i].closeTime);
            else if(mode=="month") k = MonthKey(g_trades[i].closeTime);
            else if(mode=="quarter") k = QuarterKey(g_trades[i].closeTime);
            else if(mode=="year")  k = YearKey(g_trades[i].closeTime);
            if(k != keys[ki]) continue;
            AccumTrade(s, g_trades[i]);
        }
        
        if(s.count == 0 && !showEmpty) continue;
        
        s.balance = endBals[ki];
        double periodStartBal = endBals[ki] - s.profit - s.deposit;
        if(periodStartBal <= 0) periodStartBal = 1;
        FinalizeRow(s, periodStartBal);
        
        outArr[outCount] = s;
        outCount++;
    }
}

void GetPeriodRange(string mode, datetime repTime, datetime &t1, datetime &t2)
{
    if(mode == "day")
    {
        t1 = repTime - repTime % 86400;
        t2 = t1 + 86400;
    }
    else if(mode == "week")
    {
        int dow = TimeDayOfWeek(repTime);
        if(dow == 0) dow = 7;
        t1 = repTime - (datetime)((dow-1)*86400);
        t1 = t1 - t1 % 86400;
        t2 = t1 + 7*86400;
    }
    else if(mode == "month")
    {
        int y = TimeYear(repTime), m = TimeMonth(repTime);
        t1 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", y, m));
        int nm = m+1, ny = y;
        if(nm > 12) { nm=1; ny++; }
        t2 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", ny, nm));
    }
    else if(mode == "quarter")
    {
        int y = TimeYear(repTime), m = TimeMonth(repTime);
        int qs = ((m-1)/3)*3+1;
        t1 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", y, qs));
        int qe = qs+3, qy = y;
        if(qe > 12) { qe -= 12; qy++; }
        t2 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", qy, qe));
    }
    else // year
    {
        int y = TimeYear(repTime);
        t1 = StringToTime(StringFormat("%04d.01.01 00:00:00", y));
        t2 = StringToTime(StringFormat("%04d.01.01 00:00:00", y+1));
    }
}

//==========================================================================
// 计算分组统计（品种/Magic/备注）
//==========================================================================
void CalcGroupByField(StatRow &outArr[], int &outCount, string field)
{
    outCount = 0;
    ArrayResize(outArr, MAX_STATS);
    
    string keys[];
    int kCount = 0;
    ArrayResize(keys, MAX_STATS);
    
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;
    
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        string k = "";
        if(field == "symbol")  k = g_trades[i].symbol;
        else if(field == "magic")   k = IntegerToString(g_trades[i].magic);
        else if(field == "comment") k = g_trades[i].comment;
        
        bool found = false;
        for(int j=0; j<kCount; j++)
            if(keys[j] == k) { found = true; break; }
        if(!found && kCount < MAX_STATS)
        {
            keys[kCount] = k;
            kCount++;
        }
    }
    
    for(int ki=0; ki<kCount; ki++)
    {
        StatRow s;
        InitRow(s);
        s.label = keys[ki];
        
        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            string k = "";
            if(field == "symbol")  k = g_trades[i].symbol;
            else if(field == "magic")   k = IntegerToString(g_trades[i].magic);
            else if(field == "comment") k = g_trades[i].comment;
            if(k != keys[ki]) continue;
            AccumTrade(s, g_trades[i]);
        }
        
        FinalizeRow(s, baseBalance);
        outArr[outCount] = s;
        outCount++;
    }
}

//==========================================================================
// 计算持仓汇总
//==========================================================================
void CalcHoldingStats()
{
    InitRow(g_holdingSum); g_holdingSum.label = "持仓";
    InitRow(g_buySum);     g_buySum.label = "多单Buy";
    InitRow(g_sellSum);    g_sellSum.label = "空单Sell";
    
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime != 0) continue;
        AccumTrade(g_holdingSum, g_trades[i]);
        if(g_trades[i].type == OP_BUY)
            AccumTrade(g_buySum, g_trades[i]);
        else
            AccumTrade(g_sellSum, g_trades[i]);
    }
    g_holdingSum.balance = AccountBalance();
    FinalizeRow(g_holdingSum, AccountBalance());
    FinalizeRow(g_buySum, AccountBalance());
    FinalizeRow(g_sellSum, AccountBalance());
}

//==========================================================================
// 计算综合汇总（本周/月/季/年）
//==========================================================================
void CalcSummaryStats()
{
    datetime now = TimeCurrent();
    
    // 本周开始
    int dow = TimeDayOfWeek(now);
    if(dow == 0) dow = 7;
    datetime weekStart = now - (datetime)((dow-1)*86400);
    weekStart = weekStart - weekStart % 86400;
    
    // 本月开始
    datetime monthStart = StringToTime(StringFormat("%04d.%02d.01 00:00:00", TimeYear(now), TimeMonth(now)));
    
    // 本季开始
    int qs = ((TimeMonth(now)-1)/3)*3+1;
    datetime quarterStart = StringToTime(StringFormat("%04d.%02d.01 00:00:00", TimeYear(now), qs));
    
    // 本年开始
    datetime yearStart = StringToTime(StringFormat("%04d.01.01 00:00:00", TimeYear(now)));
    
    InitRow(g_weekSum);    g_weekSum.label    = "本周盈亏";
    InitRow(g_monthSum);   g_monthSum.label   = "本月盈亏";
    InitRow(g_quarterSum); g_quarterSum.label = "本季盈亏";
    InitRow(g_yearSum);    g_yearSum.label    = "本年盈亏";
    InitRow(g_totalSum);   g_totalSum.label   = "账户持仓汇总，Magic=";
    
    double bal = AccountBalance();
    
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        datetime ct = g_trades[i].closeTime;
        if(ct >= weekStart)    AccumTrade(g_weekSum, g_trades[i]);
        if(ct >= monthStart)   AccumTrade(g_monthSum, g_trades[i]);
        if(ct >= quarterStart) AccumTrade(g_quarterSum, g_trades[i]);
        if(ct >= yearStart)    AccumTrade(g_yearSum, g_trades[i]);
        AccumTrade(g_totalSum, g_trades[i]);
    }
    
    // 出入金
    g_weekSum.deposit    = GetDepositInRange(weekStart, now+86400);
    g_monthSum.deposit   = GetDepositInRange(monthStart, now+86400);
    g_quarterSum.deposit = GetDepositInRange(quarterStart, now+86400);
    g_yearSum.deposit    = GetDepositInRange(yearStart, now+86400);
    
    FinalizeRow(g_weekSum,    bal);
    FinalizeRow(g_monthSum,   bal);
    FinalizeRow(g_quarterSum, bal);
    FinalizeRow(g_yearSum,    bal);
    FinalizeRow(g_totalSum,   bal);
}

//==========================================================================
// 刷新所有数据
//==========================================================================
void RefreshAll()
{
    g_tradeCount   = 0;
    g_depositCount = 0;
    ArrayResize(g_trades,   MAX_TRADES);
    ArrayResize(g_deposits, MAX_DEPOSITS);
    
    // 1. 先从CSV加载历史数据
    LoadFromCSV();
    
    // 2. 再从MT4加载（去重）
    LoadFromMT4();
    
    // 3. 按时间排序
    SortTradesByCloseTime();
    
    // 4. 计算各维度统计
    CalcGroupStats(g_dayStat,     g_dayCount,     Day_Count,     Day_ShowEmpty,     "day");
    CalcGroupStats(g_weekStat,    g_weekCount,    Week_Count,    Week_ShowEmpty,    "week");
    CalcGroupStats(g_monthStat,   g_monthCount,   Month_Count,   Month_ShowEmpty,   "month");
    CalcGroupStats(g_quarterStat, g_quarterCount, Quarter_Count, Quarter_ShowEmpty, "quarter");
    CalcGroupStats(g_yearStat,    g_yearCount,    Year_Count,    Year_ShowEmpty,    "year");
    
    CalcGroupByField(g_symbolStat,  g_symbolCount,  "symbol");
    CalcGroupByField(g_magicStat,   g_magicCount,   "magic");
    CalcGroupByField(g_commentStat, g_commentCount, "comment");
    
    CalcHoldingStats();
    CalcSummaryStats();
    
    // 5. 构建曲线数据（月度余额）
    BuildCurveData();
    
    // 6. 自动保存CSV
    datetime now = TimeCurrent();
    if(CSV_AutoSave && now - g_lastSave >= 300) // 每5分钟
    {
        SaveToCSV();
        g_lastSave = now;
    }
    
    g_lastRefresh = now;
}

//==========================================================================
// 构建收益曲线数据（使用月度余额）
//==========================================================================
void BuildCurveData()
{
    // 使用月统计的余额数据（已按降序排列，需要反转为升序）
    g_curveCount = g_monthCount;
    if(g_curveCount > MAX_STATS) g_curveCount = MAX_STATS;
    ArrayResize(g_curveVals,   g_curveCount);
    ArrayResize(g_curveLabels, g_curveCount);
    
    // monthStat是降序，需要反转
    for(int i=0; i<g_curveCount; i++)
    {
        int idx = g_curveCount - 1 - i;
        g_curveVals[i]   = g_monthStat[idx].balance;
        g_curveLabels[i] = g_monthStat[idx].label;
    }
}

//==========================================================================
// UI对象辅助函数
//==========================================================================
void DelObj(string name)
{
    if(ObjectFind(0, name) >= 0) ObjectDelete(0, name);
}

void MakeRect(string name, int x, int y, int w, int h, color clr, int border=0)
{
    if(ObjectFind(0, name) < 0)
        ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, name, OBJPROP_XSIZE, w);
    ObjectSetInteger(0, name, OBJPROP_YSIZE, h);
    ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, border);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, name, OBJPROP_BACK, false);
    ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
}

void MakeLabel(string name, int x, int y, string text, color clr, int fs=0, string fn="")
{
    if(fs == 0) fs = FontSize;
    if(fn == "") fn = FontName;
    if(ObjectFind(0, name) < 0)
        ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    ObjectSetString(0,  name, OBJPROP_TEXT, text);
    ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE, fs);
    ObjectSetString(0,  name, OBJPROP_FONT, fn);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, name, OBJPROP_BACK, false);
    ObjectSetInteger(0, name, OBJPROP_ZORDER, 10);
}

void UpdateLabel(string name, string text, color clr)
{
    if(ObjectFind(0, name) >= 0)
    {
        ObjectSetString(0, name, OBJPROP_TEXT, text);
        ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    }
}

// 删除所有本指标对象
void DeleteAllObjects()
{
    for(int i=ObjectsTotal(0)-1; i>=0; i--)
    {
        string name = ObjectName(0, i);
        if(StringFind(name, g_prefix) == 0)
            ObjectDelete(0, name);
    }
}

//==========================================================================
// 列宽初始化
//==========================================================================
void InitColWidths()
{
    // 列：日期/标签, 总手数, 最小大手数, 次数, 盈亏金额, 百分比%, 手续费, 库存费, 出入金, 余额, 最大浮亏, 最大浮亏比例, 最大浮盈金额, 最大浮盈比例, 最小平均最大持仓时间, 胜率, 盈亏比
    int w[COL_WIDTHS_COUNT];
    w[0]  = 100; // 日期
    w[1]  = 55;  // 总手数
    w[2]  = 80;  // 最小|大手数
    w[3]  = 40;  // 次数
    w[4]  = 75;  // 盈亏金额
    w[5]  = 65;  // 百分比%
    w[6]  = 60;  // 手续费
    w[7]  = 55;  // 库存费
    w[8]  = 65;  // 出入金
    w[9]  = 75;  // 余额
    w[10] = 65;  // 最大浮亏
    w[11] = 75;  // 最大浮亏比例
    w[12] = 75;  // 最大浮盈金额
    w[13] = 75;  // 最大浮盈比例
    w[14] = 200; // 最小平均最大持仓时间
    w[15] = 55;  // 胜率
    w[16] = 45;  // 盈亏比
    w[17] = 0;   // 备用
    for(int i=0; i<COL_WIDTHS_COUNT; i++) g_colW[i] = w[i];
}

//==========================================================================
// 绘制表头
//==========================================================================
void DrawHeader(int x, int y, string labelCol)
{
    string headers[17];
    headers[0]="日期"; headers[1]="总手数"; headers[2]="最小大手数"; headers[3]="次数";
    headers[4]="盈亏金额"; headers[5]="百分比%"; headers[6]="手续费"; headers[7]="库存费";
    headers[8]="出入金"; headers[9]="余额"; headers[10]="最大浮亏"; headers[11]="最大浮亏比例";
    headers[12]="最大浮盈金额"; headers[13]="最大浮盈比例"; headers[14]="最小平均最大持仓时间";
    headers[15]="胜率"; headers[16]="盈亏比";
    headers[0] = labelCol;
    int cx = x;
    for(int i=0; i<17; i++)
    {
        string nm = g_prefix + "hdr_" + IntegerToString(i);
        MakeLabel(nm, cx+2, y+1, headers[i], ColorHeader, FontSize-1);
        cx += g_colW[i];
    }
}

//==========================================================================
// 绘制统计行
//==========================================================================
int DrawStatRow(string rowId, int x, int y, StatRow &s, bool isHolding)
{
    int cx = x;
    color lc = (s.profit >= 0) ? ColorProfit : ColorLoss;
    if(isHolding) lc = clrAqua;
    
    string nm;
    
    // 0: 标签
    nm = g_prefix + rowId + "_0";
    MakeLabel(nm, cx+2, y+1, s.label, lc, FontSize);
    cx += g_colW[0];
    
    // 1: 总手数
    nm = g_prefix + rowId + "_1";
    MakeLabel(nm, cx+2, y+1, FormatLots(s.lots), ColorNeutral, FontSize);
    cx += g_colW[1];
    
    // 2: 最小|大手数
    nm = g_prefix + rowId + "_2";
    string lotsStr = FormatLots(s.minLots) + "|" + FormatLots(s.maxLots);
    MakeLabel(nm, cx+2, y+1, lotsStr, ColorNeutral, FontSize);
    cx += g_colW[2];
    
    // 3: 次数
    nm = g_prefix + rowId + "_3";
    MakeLabel(nm, cx+2, y+1, IntegerToString(s.count), ColorNeutral, FontSize);
    cx += g_colW[3];
    
    // 4: 盈亏金额
    nm = g_prefix + rowId + "_4";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.profit), ProfitColor(s.profit), FontSize);
    cx += g_colW[4];
    
    // 5: 百分比%
    nm = g_prefix + rowId + "_5";
    MakeLabel(nm, cx+2, y+1, FormatPct(s.pct), ProfitColor(s.pct), FontSize);
    cx += g_colW[5];
    
    // 6: 手续费
    nm = g_prefix + rowId + "_6";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.commission), ProfitColor(s.commission), FontSize);
    cx += g_colW[6];
    
    // 7: 库存费
    nm = g_prefix + rowId + "_7";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.swap), ProfitColor(s.swap), FontSize);
    cx += g_colW[7];
    
    // 8: 出入金
    nm = g_prefix + rowId + "_8";
    MakeLabel(nm, cx+2, y+1, (s.deposit != 0) ? FormatMoney(s.deposit) : "0.00", ColorNeutral, FontSize);
    cx += g_colW[8];
    
    // 9: 余额
    nm = g_prefix + rowId + "_9";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.balance), ColorNeutral, FontSize);
    cx += g_colW[9];
    
    // 10: 最大浮亏
    nm = g_prefix + rowId + "_10";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.maxDD), ProfitColor(s.maxDD), FontSize);
    cx += g_colW[10];
    
    // 11: 最大浮亏比例
    nm = g_prefix + rowId + "_11";
    MakeLabel(nm, cx+2, y+1, FormatPct(s.maxDDPct), ProfitColor(s.maxDDPct), FontSize);
    cx += g_colW[11];
    
    // 12: 最大浮盈金额
    nm = g_prefix + rowId + "_12";
    MakeLabel(nm, cx+2, y+1, FormatMoney(s.maxProfit), ProfitColor(s.maxProfit), FontSize);
    cx += g_colW[12];
    
    // 13: 最大浮盈比例
    nm = g_prefix + rowId + "_13";
    MakeLabel(nm, cx+2, y+1, FormatPct(s.maxProfitPct), ProfitColor(s.maxProfitPct), FontSize);
    cx += g_colW[13];
    
    // 14: 最小|平均|最大持仓时间
    nm = g_prefix + rowId + "_14";
    MakeLabel(nm, cx+2, y+1, FormatMinMaxDuration(s.minDuration, s.avgDuration, s.maxDuration), ColorNeutral, FontSize);
    cx += g_colW[14];
    
    // 15: 胜率
    nm = g_prefix + rowId + "_15";
    MakeLabel(nm, cx+2, y+1, FormatPct(s.winRate), ProfitColor(s.winRate - 0.5), FontSize);
    cx += g_colW[15];
    
    // 16: 盈亏比
    nm = g_prefix + rowId + "_16";
    MakeLabel(nm, cx+2, y+1, DoubleToString(s.plRatio, 2), ProfitColor(s.plRatio - 1.0), FontSize);
    
    return ROW_H;
}

//==========================================================================
// 绘制收益曲线（像素坐标，仅用于非综合tab）
//==========================================================================
void DrawEquityCurve(int x, int y, int w, int h)
{
    // 清除旧曲线
    for(int i=ObjectsTotal(0)-1; i>=0; i--)
    {
        string nm = ObjectName(0, i);
        if(StringFind(nm, g_prefix+"curve_") == 0)
            ObjectDelete(0, nm);
    }
    
    if(g_curveCount < 2 || h < 10) return;
    
    // 找最大最小值
    double minV = g_curveVals[0], maxV = g_curveVals[0];
    for(int i=1; i<g_curveCount; i++)
    {
        if(g_curveVals[i] < minV) minV = g_curveVals[i];
        if(g_curveVals[i] > maxV) maxV = g_curveVals[i];
    }
    double range = maxV - minV;
    if(range < 1) range = 1;
    
    int margin = 5;
    int drawH = h - 2*margin;
    int drawW = w - 2*margin;
    
    // 绘制曲线线段（用细矩形近似）
    int prevPx = -1, prevPy = -1;
    for(int i=0; i<g_curveCount; i++)
    {
        int px = x + margin + (int)((double)i / (g_curveCount-1) * drawW);
        int py = y + margin + (int)((maxV - g_curveVals[i]) / range * drawH);
        
        if(prevPx >= 0)
        {
            // 在两点之间绘制线段（用小矩形点）
            int dx = px - prevPx;
            int dy = py - prevPy;
            int steps = MathMax(MathAbs(dx), MathAbs(dy));
            if(steps < 1) steps = 1;
            for(int s=0; s<=steps; s++)
            {
                int lx = prevPx + (int)((double)s/steps * dx);
                int ly = prevPy + (int)((double)s/steps * dy);
                string nm = g_prefix + "curve_" + IntegerToString(i) + "_" + IntegerToString(s);
                MakeRect(nm, lx, ly, 1, 1, ColorCurve);
            }
        }
        prevPx = px;
        prevPy = py;
    }
    
    // 绘制起止日期标签
    if(g_curveCount > 0)
    {
        MakeLabel(g_prefix+"curve_lbl_l", x+margin, y+h-12, g_curveLabels[0], ColorLabel, FontSize-1);
        MakeLabel(g_prefix+"curve_lbl_r", x+w-60, y+h-12, g_curveLabels[g_curveCount-1], ColorLabel, FontSize-1);
    }
}

//==========================================================================
// 主面板绘制
//==========================================================================
void DrawPanel()
{
    int px = g_panelX;
    int py = g_panelY;
    int pw = Panel_Width;
    
    // 计算总高度
    int totalH;
    if(g_minimized)
        totalH = TITLE_H;
    else
        totalH = TITLE_H + TAB_H + 2000; // 动态，先给大值
    
    // === 标题栏背景 ===
    MakeRect(g_prefix+"bg_title", px, py, pw, TITLE_H, ColorTitle);
    
    // === 折叠按钮（左1）===
    string minBtnText = g_minimized ? "+" : "-";
    MakeRect(g_prefix+"btn_min_bg", px+2, py+2, 16, 16, C'50,50,80');
    MakeLabel(g_prefix+"btn_min", px+4, py+2, minBtnText, clrWhite, FontSize+1);
    
    // === 移动按钮（左2）===
    MakeRect(g_prefix+"btn_move_bg", px+20, py+2, 16, 16, C'50,50,80');
    MakeLabel(g_prefix+"btn_move", px+22, py+2, "+", clrWhite, FontSize+1);
    
    // === 标题文字 ===
    string titleStr = "MT4统计每一笔交易，M=";
    if(Only_Magic != "") titleStr = "MT4统计每一笔交易，M=" + Only_Magic;
    MakeLabel(g_prefix+"lbl_title", px+42, py+3, titleStr, clrLimeGreen, FontSize);
    
    if(g_minimized)
    {
        // 折叠时只显示标题栏
        MakeRect(g_prefix+"bg_main", px, py, pw, TITLE_H, ColorBg);
        MakeRect(g_prefix+"bg_title", px, py, pw, TITLE_H, ColorTitle);
        // 重绘按钮（确保在背景之上）
        MakeRect(g_prefix+"btn_min_bg", px+2, py+2, 16, 16, C'50,50,80');
        MakeLabel(g_prefix+"btn_min", px+4, py+2, "+", clrWhite, FontSize+1);
        MakeRect(g_prefix+"btn_move_bg", px+20, py+2, 16, 16, C'50,50,80');
        MakeLabel(g_prefix+"btn_move", px+22, py+2, "+", clrWhite, FontSize+1);
        MakeLabel(g_prefix+"lbl_title", px+42, py+3, titleStr, clrLimeGreen, FontSize);
        return;
    }
    
    // === 标签栏 ===
        string tabs[11];
        tabs[0]="综"; tabs[1]="日"; tabs[2]="周"; tabs[3]="月"; tabs[4]="季";
        tabs[5]="年"; tabs[6]="币"; tabs[7]="M"; tabs[8]="备"; tabs[9]="账户"; tabs[10]="轨迹";
        int tabCount = 11;
        int tabW = 35;
        int tabX = px;
        int tabY = py + TITLE_H;
    
    MakeRect(g_prefix+"bg_tabs", px, tabY, pw, TAB_H, ColorTab);
    
    for(int i=0; i<tabCount; i++)
    {
        string tnm = g_prefix + "tab_" + tabs[i];
        color tbg = (tabs[i] == g_activeTab) ? ColorTabActive : ColorTab;
        int tw = (tabs[i] == "账户" || tabs[i] == "轨迹") ? 45 : tabW;
        MakeRect(tnm+"_bg", tabX, tabY, tw, TAB_H, tbg);
        MakeLabel(tnm, tabX+3, tabY+3, tabs[i], (tabs[i]==g_activeTab)?clrWhite:clrSilver, FontSize);
        tabX += tw;
    }
    
    // === 内容区 ===
    int contentY = tabY + TAB_H;
    int contentH = 0;
    
    bool showCurve = (g_activeTab != "综" && g_activeTab != "账户" && g_activeTab != "轨迹");
    int curveH = showCurve ? CHART_H_FULL : 0;
    
    // 曲线背景
    if(showCurve)
    {
        MakeRect(g_prefix+"bg_curve", px, contentY, pw, curveH, C'10,10,20');
        DrawEquityCurve(px, contentY, pw, curveH);
        contentH += curveH;
    }
    else
    {
        // 删除旧曲线
        for(int i=ObjectsTotal(0)-1; i>=0; i--)
        {
            string nm = ObjectName(0, i);
            if(StringFind(nm, g_prefix+"curve_") == 0)
                ObjectDelete(0, nm);
        }
    }
    
    int dataY = contentY + curveH;
    int rowsDrawn = 0;
    
    if(g_activeTab == "综")
        rowsDrawn = DrawSummaryTab(px, dataY);
    else if(g_activeTab == "日")
        rowsDrawn = DrawTimeTab(px, dataY, g_dayStat, g_dayCount, "日期");
    else if(g_activeTab == "周")
        rowsDrawn = DrawTimeTab(px, dataY, g_weekStat, g_weekCount, "周");
    else if(g_activeTab == "月")
        rowsDrawn = DrawTimeTab(px, dataY, g_monthStat, g_monthCount, "月份");
    else if(g_activeTab == "季")
        rowsDrawn = DrawTimeTab(px, dataY, g_quarterStat, g_quarterCount, "季度");
    else if(g_activeTab == "年")
        rowsDrawn = DrawTimeTab(px, dataY, g_yearStat, g_yearCount, "年份");
    else if(g_activeTab == "币")
        rowsDrawn = DrawTimeTab(px, dataY, g_symbolStat, g_symbolCount, "品种");
    else if(g_activeTab == "M")
        rowsDrawn = DrawTimeTab(px, dataY, g_magicStat, g_magicCount, "Magic");
    else if(g_activeTab == "备")
        rowsDrawn = DrawTimeTab(px, dataY, g_commentStat, g_commentCount, "备注");
    else if(g_activeTab == "账户")
        rowsDrawn = DrawAccountTab(px, dataY);
    else if(g_activeTab == "轨迹")
        rowsDrawn = DrawTrailTab(px, dataY);
    
    contentH += rowsDrawn * ROW_H + ROW_H + 4; // +header row
    totalH = TITLE_H + TAB_H + contentH + 10;
    
    // 主背景（在最底层）
    MakeRect(g_prefix+"bg_main", px, py, pw, totalH, ColorBg);
    // 重绘标题栏（确保在背景之上）
    MakeRect(g_prefix+"bg_title", px, py, pw, TITLE_H, ColorTitle);
    MakeRect(g_prefix+"btn_min_bg", px+2, py+2, 16, 16, C'50,50,80');
    MakeLabel(g_prefix+"btn_min", px+4, py+2, minBtnText, clrWhite, FontSize+1);
    MakeRect(g_prefix+"btn_move_bg", px+20, py+2, 16, 16, C'50,50,80');
    MakeLabel(g_prefix+"btn_move", px+22, py+2, "+", clrWhite, FontSize+1);
    MakeLabel(g_prefix+"lbl_title", px+42, py+3, titleStr, clrLimeGreen, FontSize);
}

//==========================================================================
// 绘制时间/分组统计标签页
//==========================================================================
int DrawTimeTab(int x, int y, StatRow &arr[], int cnt, string labelCol)
{
    int cy = y;
    
    // 表头行背景
    MakeRect(g_prefix+"hdr_bg", x, cy, Panel_Width, ROW_H, C'30,30,50');
    DrawHeader(x, cy, labelCol);
    cy += ROW_H;
    
    // 数据行
    int drawn = 0;
    for(int i=0; i<cnt; i++)
    {
        color rowBg = (i%2==0) ? C'15,15,25' : C'20,20,35';
        MakeRect(g_prefix+"row_bg_"+IntegerToString(i), x, cy, Panel_Width, ROW_H, rowBg);
        DrawStatRow("row_"+IntegerToString(i), x, cy, arr[i], false);
        cy += ROW_H;
        drawn++;
    }
    
    // 合计行
    if(cnt > 0)
    {
        StatRow total;
        InitRow(total);
        total.label = "合计";
        for(int i=0; i<cnt; i++)
        {
            total.lots       += arr[i].lots;
            total.count      += arr[i].count;
            total.profit     += arr[i].profit;
            total.commission += arr[i].commission;
            total.swap       += arr[i].swap;
            total.deposit    += arr[i].deposit;
            total.winCount   += arr[i].winCount;
            total.winCountW  += arr[i].winCountW;
            total.winProfit  += arr[i].winProfit;
            total.lossProfit += arr[i].lossProfit;
            if(arr[i].minLots < total.minLots) total.minLots = arr[i].minLots;
            if(arr[i].maxLots > total.maxLots) total.maxLots = arr[i].maxLots;
            if(arr[i].minDuration < total.minDuration) total.minDuration = arr[i].minDuration;
            if(arr[i].maxDuration > total.maxDuration) total.maxDuration = arr[i].maxDuration;
            total.avgDuration += arr[i].avgDuration;
        }
        if(cnt > 0) total.avgDuration /= cnt;
        if(total.minLots >= 1e9) total.minLots = 0;
        total.balance = AccountBalance();
        FinalizeRow(total, AccountBalance());
        
        MakeRect(g_prefix+"row_bg_total", x, cy, Panel_Width, ROW_H, C'40,40,60');
        DrawStatRow("row_total", x, cy, total, false);
        drawn++;
    }
    
    return drawn;
}

//==========================================================================
// 绘制综合标签页
//==========================================================================
int DrawSummaryTab(int x, int y)
{
    int cy = y;
    
    // 日期标题
    MakeRect(g_prefix+"sum_date_bg", x, cy, Panel_Width, ROW_H, C'25,25,40');
    string dateStr = TimeToStr(TimeCurrent(), TIME_DATE);
    MakeLabel(g_prefix+"sum_date", x+5, cy+2, dateStr, clrAqua, FontSize);
    cy += ROW_H;
    
    // 表头
    MakeRect(g_prefix+"hdr_bg", x, cy, Panel_Width, ROW_H, C'30,30,50');
    DrawHeader(x, cy, "日期");
    cy += ROW_H;
    
    // 持仓行
    MakeRect(g_prefix+"row_bg_h", x, cy, Panel_Width, ROW_H, C'15,15,25');
    DrawStatRow("row_h", x, cy, g_holdingSum, true);
    cy += ROW_H;
    
    // 近N天日统计（最多显示Day_Count条，但综合视图只显示最近7天）
    int showDays = MathMin(g_dayCount, 7);
    for(int i=0; i<showDays; i++)
    {
        color rowBg = (i%2==0) ? C'15,15,25' : C'20,20,35';
        MakeRect(g_prefix+"row_bg_d"+IntegerToString(i), x, cy, Panel_Width, ROW_H, rowBg);
        DrawStatRow("row_d"+IntegerToString(i), x, cy, g_dayStat[i], false);
        cy += ROW_H;
    }
    
    // 本周/月/季/年汇总
    MakeRect(g_prefix+"row_bg_ws", x, cy, Panel_Width, ROW_H, C'20,20,35');
    DrawStatRow("row_ws", x, cy, g_weekSum, false);
    cy += ROW_H;
    
    MakeRect(g_prefix+"row_bg_ms", x, cy, Panel_Width, ROW_H, C'15,15,25');
    DrawStatRow("row_ms", x, cy, g_monthSum, false);
    cy += ROW_H;
    
    MakeRect(g_prefix+"row_bg_qs", x, cy, Panel_Width, ROW_H, C'20,20,35');
    DrawStatRow("row_qs", x, cy, g_quarterSum, false);
    cy += ROW_H;
    
    MakeRect(g_prefix+"row_bg_ys", x, cy, Panel_Width, ROW_H, C'15,15,25');
    DrawStatRow("row_ys", x, cy, g_yearSum, false);
    cy += ROW_H;
    
    // 账户持仓汇总
    MakeRect(g_prefix+"row_bg_ts", x, cy, Panel_Width, ROW_H, C'30,30,50');
    DrawStatRow("row_ts", x, cy, g_totalSum, false);
    cy += ROW_H;
    
    // 多空单汇总
    cy += 4;
    string buyStr = "多单Buy  单数: " + IntegerToString(g_buySum.count) +
                    "  手数: " + FormatLots(g_buySum.lots) +
                    "  盈亏: " + FormatMoney(g_buySum.profit);
    MakeLabel(g_prefix+"lbl_buy", x+5, cy, buyStr, ColorProfit, FontSize);
    cy += ROW_H;
    
    string sellStr = "空单Sell  单数: " + IntegerToString(g_sellSum.count) +
                     "  手数: " + FormatLots(g_sellSum.lots) +
                     "  盈亏: " + FormatMoney(g_sellSum.profit);
    MakeLabel(g_prefix+"lbl_sell", x+5, cy, sellStr, ColorLoss, FontSize);
    cy += ROW_H;
    
    return (cy - y) / ROW_H + 2;
}

//==========================================================================
// 绘制账户信息标签页
//==========================================================================
int DrawAccountTab(int x, int y)
{
    int cy = y + 5;
    int lineH = ROW_H + 2;
    int col1x = x + 5;
    int col2x = x + 300;
    int col3x = x + 600;
    color lc = ColorLabel;
    color vc = ColorNeutral;
    
    // 账户基本信息
    MakeLabel(g_prefix+"acc_0", col1x, cy, "账号="+IntegerToString(AccountNumber()), vc, FontSize);
    MakeLabel(g_prefix+"acc_1", col2x, cy, "姓名="+AccountName(), vc, FontSize);
    MakeLabel(g_prefix+"acc_2", col3x, cy, "公司="+AccountCompany(), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_3", col1x, cy, "服务器="+AccountServer(), vc, FontSize);
    MakeLabel(g_prefix+"acc_4", col2x, cy, "货币="+AccountCurrency(), vc, FontSize);
    MakeLabel(g_prefix+"acc_5", col3x, cy, "杠杆=1:"+IntegerToString(AccountLeverage()), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_6", col1x, cy, "余额="+DoubleToString(AccountBalance(),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_7", col2x, cy, "净值="+DoubleToString(AccountEquity(),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_8", col3x, cy, "可用="+DoubleToString(AccountFreeMargin(),2), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_9",  col1x, cy, "保证金="+DoubleToString(AccountMargin(),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_10", col2x, cy, "浮动盈亏="+DoubleToString(AccountEquity()-AccountBalance(),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_11", col3x, cy, "信用="+DoubleToString(AccountCredit(),2), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_12", col1x, cy, "止损比例="+DoubleToString(AccountStopoutLevel(),0)+"%", vc, FontSize);
    MakeLabel(g_prefix+"acc_13", col2x, cy, "止损模式="+IntegerToString(AccountStopoutMode()), vc, FontSize);
    MakeLabel(g_prefix+"acc_14", col3x, cy, "本地时间="+TimeToStr(TimeLocal(), TIME_DATE|TIME_MINUTES), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_15", col1x, cy, "服务器时间="+TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES), vc, FontSize);
    MakeLabel(g_prefix+"acc_16", col2x, cy, "持仓单数="+IntegerToString(OrdersTotal()), vc, FontSize);
    MakeLabel(g_prefix+"acc_17", col3x, cy, "历史记录数="+IntegerToString(OrdersHistoryTotal()), vc, FontSize);
    cy += lineH;
    
    // 当前品种信息
    cy += 5;
    MakeLabel(g_prefix+"acc_sym_hdr", col1x, cy, "--- 当前品种: "+Symbol()+" ---", ColorHeader, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_s0", col1x, cy, "点差="+IntegerToString((int)MarketInfo(Symbol(),MODE_SPREAD)), vc, FontSize);
    MakeLabel(g_prefix+"acc_s1", col2x, cy, "最小手数="+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_s2", col3x, cy, "最大手数="+DoubleToString(MarketInfo(Symbol(),MODE_MAXLOT),2), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_s3", col1x, cy, "手数步长="+DoubleToString(MarketInfo(Symbol(),MODE_LOTSTEP),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_s4", col2x, cy, "合约大小="+DoubleToString(MarketInfo(Symbol(),MODE_LOTSIZE),0), vc, FontSize);
    MakeLabel(g_prefix+"acc_s5", col3x, cy, "点值="+DoubleToString(MarketInfo(Symbol(),MODE_TICKVALUE),4), vc, FontSize);
    cy += lineH;
    
    MakeLabel(g_prefix+"acc_s6", col1x, cy, "保证金="+DoubleToString(MarketInfo(Symbol(),MODE_MARGINREQUIRED),2), vc, FontSize);
    MakeLabel(g_prefix+"acc_s7", col2x, cy, "隔夜利息多="+DoubleToString(MarketInfo(Symbol(),MODE_SWAPLONG),4), vc, FontSize);
    MakeLabel(g_prefix+"acc_s8", col3x, cy, "隔夜利息空="+DoubleToString(MarketInfo(Symbol(),MODE_SWAPSHORT),4), vc, FontSize);
    cy += lineH;
    
    return (cy - y) / ROW_H + 2;
}

//==========================================================================
// 绘制轨迹标签页
//==========================================================================
int DrawTrailTab(int x, int y)
{
    MakeLabel(g_prefix+"trail_info", x+5, y+5,
        "轨迹功能：点击日/周/月等统计行可在图表上标注该期间的开平仓轨迹",
        ColorLabel, FontSize);
    return 3;
}

//==========================================================================
// 指标初始化
//==========================================================================
int OnInit()
{
    g_panelX = Panel_X;
    g_panelY = Panel_Y;
    g_activeTab = Default_Tab;
    
    ParseMagicFilter();
    g_filterSymbol = Only_Symbol;
    
    InitColWidths();
    
    // 启用鼠标事件
    ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);
    ChartSetInteger(0, CHART_EVENT_OBJECT_CREATE, true);
    
    // 初始加载数据
    RefreshAll();
    
    // 绘制面板
    DeleteAllObjects();
    DrawPanel();
    ChartRedraw();
    
    return INIT_SUCCEEDED;
}

//==========================================================================
// 指标卸载
//==========================================================================
void OnDeinit(const int reason)
{
    DeleteAllObjects();
    ChartRedraw();
}

//==========================================================================
// 主计算函数
//==========================================================================
int OnCalculate(const int rates_total, const int prev_calculated,
                const datetime &time[], const double &open[],
                const double &high[], const double &low[],
                const double &close[], const long &tick_volume[],
                const long &volume[], const int &spread[])
{
    // 每60秒刷新一次
    datetime now = TimeCurrent();
    if(now - g_lastRefresh >= 60)
    {
        RefreshAll();
        DeleteAllObjects();
        DrawPanel();
        ChartRedraw();
    }
    return rates_total;
}

//==========================================================================
// 图表事件处理
//==========================================================================
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    // 记录鼠标位置（用于拖动）
    if(id == CHARTEVENT_MOUSE_MOVE)
    {
        int mx = (int)lparam;
        int my = (int)dparam;
        g_lastMouseX = mx;
        g_lastMouseY = my;
        
        if(g_dragging)
        {
            // 计算新位置
            int newX = g_dragPanelX + (mx - g_dragStartX);
            int newY = g_dragPanelY + (my - g_dragStartY);
            if(newX < 0) newX = 0;
            if(newY < 0) newY = 0;
            
            if(newX != g_panelX || newY != g_panelY)
            {
                g_panelX = newX;
                g_panelY = newY;
                DeleteAllObjects();
                DrawPanel();
                ChartRedraw();
            }
        }
        return;
    }
    
    // 鼠标左键释放 - 停止拖动
    if(id == CHARTEVENT_KEYDOWN)
    {
        g_dragging = false;
        return;
    }
    
    // 对象点击事件
    if(id == CHARTEVENT_OBJECT_CLICK)
    {
        string name = sparam;
        
        // 折叠/展开按钮
        if(name == g_prefix+"btn_min" || name == g_prefix+"btn_min_bg")
        {
            g_minimized = !g_minimized;
            DeleteAllObjects();
            DrawPanel();
            ChartRedraw();
            return;
        }
        
        // 移动按钮 - 开始拖动
        if(name == g_prefix+"btn_move" || name == g_prefix+"btn_move_bg")
        {
            g_dragging = !g_dragging;
            if(g_dragging)
            {
                // 使用MOUSE_MOVE事件记录的最新鼠标坐标
                g_dragStartX = g_lastMouseX;
                g_dragStartY = g_lastMouseY;
                g_dragPanelX = g_panelX;
                g_dragPanelY = g_panelY;
            }
            return;
        }
        
        // 标签页切换
        string tabs[11];
        tabs[0]="综"; tabs[1]="日"; tabs[2]="周"; tabs[3]="月"; tabs[4]="季";
        tabs[5]="年"; tabs[6]="币"; tabs[7]="M"; tabs[8]="备"; tabs[9]="账户"; tabs[10]="轨迹";
        for(int i=0; i<11; i++)
        {
            if(name == g_prefix+"tab_"+tabs[i] || name == g_prefix+"tab_"+tabs[i]+"_bg")
            {
                g_activeTab = tabs[i];
                DeleteAllObjects();
                DrawPanel();
                ChartRedraw();
                return;
            }
        }
    }
    
    // 鼠标点击（用于拖动时的坐标更新）
    if(id == CHARTEVENT_CLICK)
    {
        if(g_dragging)
        {
            // 点击确认新位置，停止拖动
            g_dragging = false;
        }
    }
}
