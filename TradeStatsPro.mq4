//+------------------------------------------------------------------+
//|                                            TradeStatsPro.mq4     |
//|                        MT4统计每一笔交易 - 收益统计指标            |
//|  功能：多维度统计(综/日/周/月/季/年/币/M/备/账户/轨迹)            |
//|        每日增量写入CSV，历史数据从CSV读取，不依赖MT4历史记录        |
//+------------------------------------------------------------------+
#property copyright "TradeStatsPro"
#property version   "1.00"
#property indicator_chart_window
#property indicator_plots 0

//--- 输入参数
input string   InpTitle          = "MT4统计每一笔交易";  // 自定义标题
input string   InpOnlyMagic      = "";                   // 只统计magic(逗号分隔,空=全部)
input string   InpOnlySymbol     = "";                   // 只统计品种(逗号分隔,空=全部)
input string   InpOnlyComment    = "";                   // 只统计备注包含文字
input int      InpDefaultTab     = 0;                    // 默认TAB(0=综,1=日,2=周,3=月,4=季,5=年,6=币,7=M,8=备,9=账户,10=轨迹)
input int      InpDayCount       = 100;                  // DAY统计N天
input int      InpWeekCount      = 200;                  // WEEK统计N周
input int      InpMonthCount     = 100;                  // MONTH统计N个月
input int      InpQuarterCount   = 100;                  // QUARTER统计N个季度
input int      InpYearCount      = 20;                   // YEAR统计N年
input int      InpSummaryDays    = 7;                    // 综合页显示最近N天
input bool     InpShowEmptyDay   = false;                // 无交易日是否显示
input int      InpFontSize       = 8;                    // 字体大小
input int      InpPanelX         = 100;                  // 面板X默认值
input int      InpPanelY         = 0;                    // 面板Y默认值
input bool     InpCSVAutoSave    = true;                 // 启用CSV自动保存
input int      InpCSVDaysBack    = 1;                    // 写入几天前的数据(1=昨天)
// 列显示开关
input bool     InpShowLots       = true;                 // 显示手数
input bool     InpShowCount      = true;                 // 显示交易次数
input bool     InpShowProfit     = true;                 // 显示盈亏金额
input bool     InpShowPct        = true;                 // 显示盈亏百分比
input bool     InpShowComm       = true;                 // 显示手续费
input bool     InpShowSwap       = true;                 // 显示库存费
input bool     InpShowDeposit    = true;                 // 显示出入金
input bool     InpShowBalance    = true;                 // 显示余额
input bool     InpShowMaxDD      = true;                 // 显示最大浮亏
input bool     InpShowMaxDDPct   = true;                 // 显示最大浮亏比例
input bool     InpShowMaxProfit  = true;                 // 显示最大浮盈金额
input bool     InpShowMaxProfPct = true;                 // 显示最大浮盈比例
input bool     InpShowDuration   = true;                 // 显示持仓时间
input bool     InpShowWinRate    = true;                 // 显示胜率
input bool     InpShowProfitFactor= true;                // 显示盈亏比
// 颜色
input color    InpColorGreen     = C'0,255,127';         // 绿色文字(SpringGreen)
input color    InpColorRed       = clrRed;               // 红色文字
input color    InpColorGray      = C'176,196,222';       // 浅色文字(LightSteelBlue)
input color    InpColorDimGray   = clrDimGray;           // 深灰文字
input color    InpColorBg        = C'13,17,23';          // 背景色
input color    InpColorHeader    = C'25,35,50';          // 表头背景
input color    InpColorTabActive = C'30,50,80';          // 激活Tab背景
input color    InpColorBorder    = C'40,60,90';          // 边框色

//--- 常量
#define MAX_TRADES    20000
#define MAX_DEPOSITS  2000
#define TITLE_H       18
#define TAB_H         16
#define ROW_H         14
#define COL_LABEL_W   80
#define PREFIX        "TSP_"

//--- 数据结构
struct TradeRec
{
    int      ticket;
    string   symbol;
    int      type;        // 0=buy,1=sell
    double   lots;
    datetime openTime;
    datetime closeTime;
    double   openPrice;
    double   closePrice;
    double   profit;
    double   commission;
    double   swap;
    int      magic;
    string   comment;
    double   maxDD;       // 最大浮亏(负数)
    double   maxProfit;   // 最大浮盈
    bool     isOpen;      // 是否持仓中
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
    double   profit;
    double   pct;
    double   commission;
    double   swap;
    double   deposit;
    double   balance;
    double   maxDD;
    double   maxDDPct;
    double   maxProfit;
    double   maxProfitPct;
    int      minDur;
    int      avgDur;
    int      maxDur;
    int      winCount;
    double   winProfit;
    double   lossProfit;
    bool     isOpen;      // 是否是持仓行
};

//--- 全局数据
TradeRec   g_trades[];
int        g_tradeCount = 0;
DepositRec g_deposits[];
int        g_depositCount = 0;

//--- UI状态
int    g_curTab      = 0;
bool   g_minimized   = false;
int    g_panelX      = 100;
int    g_panelY      = 0;
bool   g_dragging    = false;
int    g_dragOffX    = 0;
int    g_dragOffY    = 0;
int    g_lastMouseX  = 0;
int    g_lastMouseY  = 0;
datetime g_lastRefresh = 0;
datetime g_lastCSVSave = 0;

//--- 统计数据缓存
StatRow g_dayStats[];
int     g_dayCount = 0;
StatRow g_weekStats[];
int     g_weekCount = 0;
StatRow g_monthStats[];
int     g_monthCount = 0;
StatRow g_quarterStats[];
int     g_quarterCount = 0;
StatRow g_yearStats[];
int     g_yearCount = 0;

//--- 分组统计
StatRow g_symbolStats[];
int     g_symbolCount = 0;
StatRow g_magicStats[];
int     g_magicCount = 0;
StatRow g_commentStats[];
int     g_commentCount = 0;

//--- 综合页
StatRow g_summaryDays[];
int     g_summaryDayCount = 0;
double  g_thisWeekProfit  = 0;
double  g_thisMonthProfit = 0;
double  g_thisQuarterProfit = 0;
double  g_thisYearProfit  = 0;

//--- 过滤器
int    g_filterMagics[];
int    g_filterMagicCount = 0;
string g_filterSymbols[];
int    g_filterSymbolCount = 0;

//+------------------------------------------------------------------+
//| 初始化StatRow                                                      |
//+------------------------------------------------------------------+
void InitRow(StatRow &r)
{
    r.label       = "";
    r.lots        = 0;
    r.minLots     = 1e9;
    r.maxLots     = 0;
    r.count       = 0;
    r.profit      = 0;
    r.pct         = 0;
    r.commission  = 0;
    r.swap        = 0;
    r.deposit     = 0;
    r.balance     = 0;
    r.maxDD       = 0;
    r.maxDDPct    = 0;
    r.maxProfit   = 0;
    r.maxProfitPct= 0;
    r.minDur      = 2147483647;
    r.avgDur      = 0;
    r.maxDur      = 0;
    r.winCount    = 0;
    r.winProfit   = 0;
    r.lossProfit  = 0;
    r.isOpen      = false;
}

//+------------------------------------------------------------------+
//| 累加一条交易到StatRow                                              |
//+------------------------------------------------------------------+
void AccumTrade(StatRow &r, const TradeRec &t)
{
    r.lots       += t.lots;
    if(t.lots < r.minLots) r.minLots = t.lots;
    if(t.lots > r.maxLots) r.maxLots = t.lots;
    r.count++;
    r.profit     += t.profit;
    r.commission += t.commission;
    r.swap       += t.swap;
    if(t.maxDD < r.maxDD) r.maxDD = t.maxDD;
    if(t.maxProfit > r.maxProfit) r.maxProfit = t.maxProfit;
    if(t.profit > 0) { r.winCount++; r.winProfit += t.profit; }
    else              { r.lossProfit += t.profit; }
    if(!t.isOpen && t.closeTime > t.openTime)
    {
        int dur = (int)(t.closeTime - t.openTime);
        if(dur < r.minDur) r.minDur = dur;
        if(dur > r.maxDur) r.maxDur = dur;
        r.avgDur += dur;
    }
}

//+------------------------------------------------------------------+
//| 完成StatRow计算(百分比、胜率等)                                    |
//+------------------------------------------------------------------+
void FinalizeRow(StatRow &r, double startBal)
{
    if(r.minLots >= 1e9) r.minLots = 0;
    if(r.count > 0) r.avgDur = r.avgDur / r.count;
    if(r.minDur == 2147483647) r.minDur = 0;
    if(startBal != 0) r.pct = r.profit / startBal * 100.0;
    if(r.balance != 0)
    {
        if(r.maxDD != 0) r.maxDDPct = r.maxDD / r.balance * 100.0;
        if(r.maxProfit != 0) r.maxProfitPct = r.maxProfit / r.balance * 100.0;
    }
}

//+------------------------------------------------------------------+
//| 解析过滤器                                                         |
//+------------------------------------------------------------------+
void ParseFilters()
{
    g_filterMagicCount = 0;
    g_filterSymbolCount = 0;
    ArrayResize(g_filterMagics, 0);
    ArrayResize(g_filterSymbols, 0);
    
    if(StringLen(InpOnlyMagic) > 0)
    {
        string parts[];
        int n = StringSplit(InpOnlyMagic, ',', parts);
        ArrayResize(g_filterMagics, n);
        for(int i = 0; i < n; i++)
        {
            StringTrimLeft(parts[i]);
            StringTrimRight(parts[i]);
            if(StringLen(parts[i]) > 0)
            {
                g_filterMagics[g_filterMagicCount] = (int)StringToInteger(parts[i]);
                g_filterMagicCount++;
            }
        }
    }
    
    if(StringLen(InpOnlySymbol) > 0)
    {
        string parts2[];
        int n2 = StringSplit(InpOnlySymbol, ',', parts2);
        ArrayResize(g_filterSymbols, n2);
        for(int i2 = 0; i2 < n2; i2++)
        {
            StringTrimLeft(parts2[i2]);
            StringTrimRight(parts2[i2]);
            if(StringLen(parts2[i2]) > 0)
            {
                g_filterSymbols[g_filterSymbolCount] = parts2[i2];
                g_filterSymbolCount++;
            }
        }
    }
}

//+------------------------------------------------------------------+
//| 检查是否通过过滤器                                                  |
//+------------------------------------------------------------------+
bool PassFilter(int magic, string symbol, string comment)
{
    if(g_filterMagicCount > 0)
    {
        bool found = false;
        for(int i = 0; i < g_filterMagicCount; i++)
            if(g_filterMagics[i] == magic) { found = true; break; }
        if(!found) return false;
    }
    if(g_filterSymbolCount > 0)
    {
        bool found2 = false;
        for(int i2 = 0; i2 < g_filterSymbolCount; i2++)
            if(g_filterSymbols[i2] == symbol) { found2 = true; break; }
        if(!found2) return false;
    }
    if(StringLen(InpOnlyComment) > 0)
    {
        if(StringFind(comment, InpOnlyComment) < 0) return false;
    }
    return true;
}

//+------------------------------------------------------------------+
//| 获取CSV文件路径                                                     |
//+------------------------------------------------------------------+
string GetCSVPath()
{
    return "TradeStats_" + IntegerToString(AccountNumber()) + ".csv";
}

//+------------------------------------------------------------------+
//| 从CSV加载历史数据                                                   |
//+------------------------------------------------------------------+
void LoadFromCSV()
{
    string fname = GetCSVPath();
    int fh = FileOpen(fname, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh == INVALID_HANDLE) return;
    
    // 跳过表头
    if(!FileIsEnding(fh)) FileReadString(fh); // ticket
    if(!FileIsEnding(fh)) FileReadString(fh); // symbol
    // 读完整行头部
    while(!FileIsLineEnding(fh) && !FileIsEnding(fh)) FileReadString(fh);
    
    while(!FileIsEnding(fh))
    {
        string sTicket = FileReadString(fh);
        if(FileIsEnding(fh) || StringLen(sTicket) == 0) break;
        
        TradeRec r;
        r.ticket     = (int)StringToInteger(sTicket);
        r.symbol     = FileReadString(fh);
        r.type       = (int)StringToInteger(FileReadString(fh));
        r.lots       = StringToDouble(FileReadString(fh));
        r.openTime   = (datetime)StringToInteger(FileReadString(fh));
        r.closeTime  = (datetime)StringToInteger(FileReadString(fh));
        r.openPrice  = StringToDouble(FileReadString(fh));
        r.closePrice = StringToDouble(FileReadString(fh));
        r.profit     = StringToDouble(FileReadString(fh));
        r.commission = StringToDouble(FileReadString(fh));
        r.swap       = StringToDouble(FileReadString(fh));
        r.magic      = (int)StringToInteger(FileReadString(fh));
        r.comment    = FileReadString(fh);
        r.maxDD      = StringToDouble(FileReadString(fh));
        r.maxProfit  = StringToDouble(FileReadString(fh));
        r.isOpen     = false;
        
        // 跳过行尾
        while(!FileIsLineEnding(fh) && !FileIsEnding(fh)) FileReadString(fh);
        
        if(r.ticket <= 0) continue;
        if(!PassFilter(r.magic, r.symbol, r.comment)) continue;
        if(g_tradeCount >= MAX_TRADES) break;
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
    }
    FileClose(fh);
}

//+------------------------------------------------------------------+
//| 从MT4历史加载数据(全部,去重)                                        |
//+------------------------------------------------------------------+
void LoadFromMT4()
{
    int histTotal = OrdersHistoryTotal();
    
    // 加载已平仓交易
    for(int i = 0; i < histTotal; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        int otype = OrderType();
        if(otype != OP_BUY && otype != OP_SELL) continue;
        
        int ticket = OrderTicket();
        if(!PassFilter(OrderMagicNumber(), OrderSymbol(), OrderComment())) continue;
        
        // 去重
        bool dup = false;
        for(int j = 0; j < g_tradeCount; j++)
            if(g_trades[j].ticket == ticket) { dup = true; break; }
        if(dup) continue;
        
        if(g_tradeCount >= MAX_TRADES) break;
        
        TradeRec r;
        r.ticket     = ticket;
        r.symbol     = OrderSymbol();
        r.type       = otype;
        r.lots       = OrderLots();
        r.openTime   = OrderOpenTime();
        r.closeTime  = OrderCloseTime();
        r.openPrice  = OrderOpenPrice();
        r.closePrice = OrderClosePrice();
        r.profit     = OrderProfit();
        r.commission = OrderCommission();
        r.swap       = OrderSwap();
        r.magic      = OrderMagicNumber();
        r.comment    = OrderComment();
        r.maxDD      = 0;
        r.maxProfit  = 0;
        r.isOpen     = false;
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
    }
    
    // 加载出入金记录
    g_depositCount = 0;
    for(int id = 0; id < histTotal; id++)
    {
        if(!OrderSelect(id, SELECT_BY_POS, MODE_HISTORY)) continue;
        int dtype = OrderType();
        if(dtype != 6 && dtype != 7) continue; // OP_BALANCE=6, OP_CREDIT=7
        if(g_depositCount >= MAX_DEPOSITS) break;
        g_deposits[g_depositCount].time   = OrderCloseTime();
        g_deposits[g_depositCount].amount = OrderProfit();
        g_deposits[g_depositCount].ticket = OrderTicket();
        g_depositCount++;
    }
    
    // 加载持仓订单
    int openTotal = OrdersTotal();
    for(int io = 0; io < openTotal; io++)
    {
        if(!OrderSelect(io, SELECT_BY_POS, MODE_TRADES)) continue;
        int otype2 = OrderType();
        if(otype2 != OP_BUY && otype2 != OP_SELL) continue;
        if(!PassFilter(OrderMagicNumber(), OrderSymbol(), OrderComment())) continue;
        if(g_tradeCount >= MAX_TRADES) break;
        
        TradeRec r;
        r.ticket     = OrderTicket();
        r.symbol     = OrderSymbol();
        r.type       = otype2;
        r.lots       = OrderLots();
        r.openTime   = OrderOpenTime();
        r.closeTime  = 0;
        r.openPrice  = OrderOpenPrice();
        r.closePrice = OrderClosePrice();
        r.profit     = OrderProfit();
        r.commission = OrderCommission();
        r.swap       = OrderSwap();
        r.magic      = OrderMagicNumber();
        r.comment    = OrderComment();
        r.maxDD      = 0;
        r.maxProfit  = 0;
        r.isOpen     = true;
        
        g_trades[g_tradeCount] = r;
        g_tradeCount++;
    }
}

//+------------------------------------------------------------------+
//| 按时间排序(冒泡,数量不大时够用)                                     |
//+------------------------------------------------------------------+
void SortTradesByTime()
{
    for(int i = 0; i < g_tradeCount - 1; i++)
    {
        for(int j = 0; j < g_tradeCount - 1 - i; j++)
        {
            datetime t1 = g_trades[j].isOpen   ? g_trades[j].openTime   : g_trades[j].closeTime;
            datetime t2 = g_trades[j+1].isOpen ? g_trades[j+1].openTime : g_trades[j+1].closeTime;
            if(t1 > t2)
            {
                TradeRec tmp = g_trades[j];
                g_trades[j]  = g_trades[j+1];
                g_trades[j+1] = tmp;
            }
        }
    }
}

//+------------------------------------------------------------------+
//| 计算起始余额(当前余额 - 所有已平仓盈亏 - 所有出入金)               |
//+------------------------------------------------------------------+
double CalcStartBalance()
{
    double bal = AccountBalance();
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(!g_trades[i].isOpen)
            bal -= (g_trades[i].profit + g_trades[i].commission + g_trades[i].swap);
    }
    for(int id = 0; id < g_depositCount; id++)
        bal -= g_deposits[id].amount;
    return bal;
}

//+------------------------------------------------------------------+
//| 获取某时间点之前的累计出入金                                        |
//+------------------------------------------------------------------+
double GetDepositBefore(datetime t)
{
    double sum = 0;
    for(int i = 0; i < g_depositCount; i++)
        if(g_deposits[i].time <= t) sum += g_deposits[i].amount;
    return sum;
}

//+------------------------------------------------------------------+
//| 获取时间区间内的出入金                                              |
//+------------------------------------------------------------------+
double GetDepositInRange(datetime t1, datetime t2)
{
    double sum = 0;
    for(int i = 0; i < g_depositCount; i++)
        if(g_deposits[i].time >= t1 && g_deposits[i].time < t2)
            sum += g_deposits[i].amount;
    return sum;
}

//+------------------------------------------------------------------+
//| 时间辅助函数                                                        |
//+------------------------------------------------------------------+
string FormatDate(datetime t)
{
    return StringFormat("%04d.%02d.%02d", TimeYear(t), TimeMonth(t), TimeDay(t));
}

string FormatDuration(int secs)
{
    if(secs <= 0) return "0:00:00";
    int h = secs / 3600;
    int m = (secs % 3600) / 60;
    int s = secs % 60;
    return StringFormat("%d:%02d:%02d", h, m, s);
}

datetime GetDayStart(datetime t)
{
    int y = TimeYear(t), mo = TimeMonth(t), d = TimeDay(t);
    return StringToTime(StringFormat("%04d.%02d.%02d 00:00:00", y, mo, d));
}

datetime GetWeekStart(datetime t)
{
    int dow = TimeDayOfWeek(t);
    if(dow == 0) dow = 7;
    return GetDayStart(t - (dow - 1) * 86400);
}

datetime GetMonthStart(datetime t)
{
    return StringToTime(StringFormat("%04d.%02d.01 00:00:00", TimeYear(t), TimeMonth(t)));
}

string GetQuarterKey(datetime t)
{
    int y = TimeYear(t);
    int mo = TimeMonth(t);
    int q = (mo - 1) / 3 + 1;
    return StringFormat("%04d.Q%d", y, q);
}

string GetYearKey(datetime t)
{
    return StringFormat("%04d", TimeYear(t));
}

//+------------------------------------------------------------------+
//| 写入CSV(增量,只写入N天前的已平仓数据)                               |
//+------------------------------------------------------------------+
void SaveToCSV()
{
    if(!InpCSVAutoSave) return;
    
    string fname = GetCSVPath();
    datetime cutoff = GetDayStart(TimeCurrent()) - InpCSVDaysBack * 86400;
    
    // 读取已存在的ticket集合
    int existTickets[];
    int existCount = 0;
    ArrayResize(existTickets, MAX_TRADES);
    
    int fhr = FileOpen(fname, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fhr != INVALID_HANDLE)
    {
        // 跳过表头行
        while(!FileIsLineEnding(fhr) && !FileIsEnding(fhr)) FileReadString(fhr);
        while(!FileIsEnding(fhr))
        {
            string st = FileReadString(fhr);
            if(FileIsEnding(fhr) || StringLen(st) == 0) break;
            int tk = (int)StringToInteger(st);
            if(tk > 0 && existCount < MAX_TRADES)
            {
                existTickets[existCount] = tk;
                existCount++;
            }
            while(!FileIsLineEnding(fhr) && !FileIsEnding(fhr)) FileReadString(fhr);
        }
        FileClose(fhr);
    }
    
    // 追加新记录
    bool needHeader = (existCount == 0);
    int fhw = FileOpen(fname, FILE_WRITE|FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fhw == INVALID_HANDLE) return;
    FileSeek(fhw, 0, SEEK_END);
    
    if(needHeader)
    {
        FileWrite(fhw, "ticket","symbol","type","lots","openTime","closeTime",
                  "openPrice","closePrice","profit","commission","swap",
                  "magic","comment","maxDD","maxProfit");
    }
    
    int written = 0;
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(g_trades[i].isOpen) continue;
        if(g_trades[i].closeTime >= cutoff) continue;
        
        // 检查是否已存在
        bool dup = false;
        for(int j = 0; j < existCount; j++)
            if(existTickets[j] == g_trades[i].ticket) { dup = true; break; }
        if(dup) continue;
        
        FileWrite(fhw,
            IntegerToString(g_trades[i].ticket),
            g_trades[i].symbol,
            IntegerToString(g_trades[i].type),
            DoubleToStr(g_trades[i].lots, 2),
            IntegerToString((int)g_trades[i].openTime),
            IntegerToString((int)g_trades[i].closeTime),
            DoubleToStr(g_trades[i].openPrice, 5),
            DoubleToStr(g_trades[i].closePrice, 5),
            DoubleToStr(g_trades[i].profit, 2),
            DoubleToStr(g_trades[i].commission, 2),
            DoubleToStr(g_trades[i].swap, 2),
            IntegerToString(g_trades[i].magic),
            g_trades[i].comment,
            DoubleToStr(g_trades[i].maxDD, 2),
            DoubleToStr(g_trades[i].maxProfit, 2)
        );
        written++;
    }
    FileClose(fhw);
}

//+------------------------------------------------------------------+
//| 刷新全部数据                                                        |
//+------------------------------------------------------------------+
void RefreshAll()
{
    g_tradeCount   = 0;
    g_depositCount = 0;
    ArrayResize(g_trades, MAX_TRADES);
    ArrayResize(g_deposits, MAX_DEPOSITS);
    
    LoadFromCSV();
    LoadFromMT4();
    SortTradesByTime();
    
    CalcAllStats();
    
    if(InpCSVAutoSave) SaveToCSV();
}


//+------------------------------------------------------------------+
//| 计算所有统计维度                                                    |
//+------------------------------------------------------------------+
void CalcAllStats()
{
    double startBal = CalcStartBalance();
    CalcTimeStats(startBal);
    CalcGroupStats();
    CalcSummaryStats(startBal);
}

//+------------------------------------------------------------------+
//| 计算日/周/月/季/年统计                                              |
//+------------------------------------------------------------------+
void CalcTimeStats(double startBal)
{
    // ---- 日统计 ----
    g_dayCount = 0;
    ArrayResize(g_dayStats, InpDayCount + 2);
    
    datetime today = GetDayStart(TimeCurrent());
    double runBal = startBal;
    
    // 先按日分组
    string dayLabels[];
    ArrayResize(dayLabels, InpDayCount + 2);
    StatRow dayRows[];
    ArrayResize(dayRows, InpDayCount + 2);
    int dayTotal = 0;
    
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(g_trades[i].isOpen) continue;
        datetime ct = g_trades[i].closeTime;
        string lbl = FormatDate(ct);
        bool found = false;
        for(int j = 0; j < dayTotal; j++)
            if(dayLabels[j] == lbl) { AccumTrade(dayRows[j], g_trades[i]); found = true; break; }
        if(!found && dayTotal < InpDayCount + 2)
        {
            InitRow(dayRows[dayTotal]);
            dayRows[dayTotal].label = lbl;
            AccumTrade(dayRows[dayTotal], g_trades[i]);
            dayLabels[dayTotal] = lbl;
            dayTotal++;
        }
    }
    
    // 计算每日余额和百分比
    double dayRunBal = startBal;
    // 先加上所有在第一个交易日之前的出入金
    for(int di = 0; di < dayTotal; di++)
    {
        datetime dayT = StringToTime(dayLabels[di] + " 00:00:00");
        datetime dayEnd = dayT + 86400;
        double dep = GetDepositInRange(dayT, dayEnd);
        dayRows[di].deposit = dep;
        double periodStart = dayRunBal;
        dayRunBal += dayRows[di].profit + dayRows[di].commission + dayRows[di].swap + dep;
        dayRows[di].balance = dayRunBal;
        if(periodStart != 0) dayRows[di].pct = (dayRows[di].profit + dayRows[di].commission + dayRows[di].swap) / periodStart * 100.0;
        if(dayRows[di].minLots >= 1e9) dayRows[di].minLots = 0;
        if(dayRows[di].count > 0) dayRows[di].avgDur = dayRows[di].avgDur / dayRows[di].count;
        if(dayRows[di].minDur == 2147483647) dayRows[di].minDur = 0;
        if(dayRows[di].balance != 0)
        {
            if(dayRows[di].maxDD != 0) dayRows[di].maxDDPct = dayRows[di].maxDD / dayRows[di].balance * 100.0;
            if(dayRows[di].maxProfit != 0) dayRows[di].maxProfitPct = dayRows[di].maxProfit / dayRows[di].balance * 100.0;
        }
    }
    
    // 只取最近N天(倒序)
    int startIdx = dayTotal - InpDayCount;
    if(startIdx < 0) startIdx = 0;
    g_dayCount = 0;
    for(int di2 = dayTotal - 1; di2 >= startIdx; di2--)
    {
        g_dayStats[g_dayCount] = dayRows[di2];
        g_dayCount++;
    }
    
    // ---- 周统计 ----
    g_weekCount = 0;
    ArrayResize(g_weekStats, InpWeekCount + 2);
    
    string weekLabels[];
    ArrayResize(weekLabels, InpWeekCount + 2);
    StatRow weekRows[];
    ArrayResize(weekRows, InpWeekCount + 2);
    int weekTotal = 0;
    
    for(int i2 = 0; i2 < g_tradeCount; i2++)
    {
        if(g_trades[i2].isOpen) continue;
        datetime ws = GetWeekStart(g_trades[i2].closeTime);
        string lbl2 = FormatDate(ws);
        bool found2 = false;
        for(int j2 = 0; j2 < weekTotal; j2++)
            if(weekLabels[j2] == lbl2) { AccumTrade(weekRows[j2], g_trades[i2]); found2 = true; break; }
        if(!found2 && weekTotal < InpWeekCount + 2)
        {
            InitRow(weekRows[weekTotal]);
            weekRows[weekTotal].label = lbl2;
            AccumTrade(weekRows[weekTotal], g_trades[i2]);
            weekLabels[weekTotal] = lbl2;
            weekTotal++;
        }
    }
    
    double wRunBal = startBal;
    for(int wi = 0; wi < weekTotal; wi++)
    {
        datetime wt = StringToTime(weekLabels[wi] + " 00:00:00");
        double dep2 = GetDepositInRange(wt, wt + 7 * 86400);
        weekRows[wi].deposit = dep2;
        double ps2 = wRunBal;
        wRunBal += weekRows[wi].profit + weekRows[wi].commission + weekRows[wi].swap + dep2;
        weekRows[wi].balance = wRunBal;
        if(ps2 != 0) weekRows[wi].pct = (weekRows[wi].profit + weekRows[wi].commission + weekRows[wi].swap) / ps2 * 100.0;
        if(weekRows[wi].minLots >= 1e9) weekRows[wi].minLots = 0;
        if(weekRows[wi].count > 0) weekRows[wi].avgDur = weekRows[wi].avgDur / weekRows[wi].count;
        if(weekRows[wi].minDur == 2147483647) weekRows[wi].minDur = 0;
        if(weekRows[wi].balance != 0)
        {
            if(weekRows[wi].maxDD != 0) weekRows[wi].maxDDPct = weekRows[wi].maxDD / weekRows[wi].balance * 100.0;
            if(weekRows[wi].maxProfit != 0) weekRows[wi].maxProfitPct = weekRows[wi].maxProfit / weekRows[wi].balance * 100.0;
        }
    }
    
    int wStart = weekTotal - InpWeekCount;
    if(wStart < 0) wStart = 0;
    g_weekCount = 0;
    for(int wi2 = weekTotal - 1; wi2 >= wStart; wi2--)
    {
        g_weekStats[g_weekCount] = weekRows[wi2];
        g_weekCount++;
    }
    
    // ---- 月统计 ----
    g_monthCount = 0;
    ArrayResize(g_monthStats, InpMonthCount + 2);
    
    string monthLabels[];
    ArrayResize(monthLabels, InpMonthCount + 2);
    StatRow monthRows[];
    ArrayResize(monthRows, InpMonthCount + 2);
    int monthTotal = 0;
    
    for(int i3 = 0; i3 < g_tradeCount; i3++)
    {
        if(g_trades[i3].isOpen) continue;
        int y3 = TimeYear(g_trades[i3].closeTime);
        int mo3 = TimeMonth(g_trades[i3].closeTime);
        string lbl3 = StringFormat("%04d.%02d", y3, mo3);
        bool found3 = false;
        for(int j3 = 0; j3 < monthTotal; j3++)
            if(monthLabels[j3] == lbl3) { AccumTrade(monthRows[j3], g_trades[i3]); found3 = true; break; }
        if(!found3 && monthTotal < InpMonthCount + 2)
        {
            InitRow(monthRows[monthTotal]);
            monthRows[monthTotal].label = lbl3;
            AccumTrade(monthRows[monthTotal], g_trades[i3]);
            monthLabels[monthTotal] = lbl3;
            monthTotal++;
        }
    }
    
    double mRunBal = startBal;
    for(int mi = 0; mi < monthTotal; mi++)
    {
        int my = (int)StringToInteger(StringSubstr(monthLabels[mi], 0, 4));
        int mm = (int)StringToInteger(StringSubstr(monthLabels[mi], 5, 2));
        datetime mt1 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", my, mm));
        int nm2 = mm + 1; int ny2 = my;
        if(nm2 > 12) { nm2 = 1; ny2++; }
        datetime mt2 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", ny2, nm2));
        double dep3 = GetDepositInRange(mt1, mt2);
        monthRows[mi].deposit = dep3;
        double ps3 = mRunBal;
        mRunBal += monthRows[mi].profit + monthRows[mi].commission + monthRows[mi].swap + dep3;
        monthRows[mi].balance = mRunBal;
        if(ps3 != 0) monthRows[mi].pct = (monthRows[mi].profit + monthRows[mi].commission + monthRows[mi].swap) / ps3 * 100.0;
        if(monthRows[mi].minLots >= 1e9) monthRows[mi].minLots = 0;
        if(monthRows[mi].count > 0) monthRows[mi].avgDur = monthRows[mi].avgDur / monthRows[mi].count;
        if(monthRows[mi].minDur == 2147483647) monthRows[mi].minDur = 0;
        if(monthRows[mi].balance != 0)
        {
            if(monthRows[mi].maxDD != 0) monthRows[mi].maxDDPct = monthRows[mi].maxDD / monthRows[mi].balance * 100.0;
            if(monthRows[mi].maxProfit != 0) monthRows[mi].maxProfitPct = monthRows[mi].maxProfit / monthRows[mi].balance * 100.0;
        }
    }
    
    int mStart = monthTotal - InpMonthCount;
    if(mStart < 0) mStart = 0;
    g_monthCount = 0;
    for(int mi2 = monthTotal - 1; mi2 >= mStart; mi2--)
    {
        g_monthStats[g_monthCount] = monthRows[mi2];
        g_monthCount++;
    }
    
    // ---- 季度统计 ----
    g_quarterCount = 0;
    ArrayResize(g_quarterStats, InpQuarterCount + 2);
    
    string qLabels[];
    ArrayResize(qLabels, InpQuarterCount + 2);
    StatRow qRows[];
    ArrayResize(qRows, InpQuarterCount + 2);
    int qTotal = 0;
    
    for(int i4 = 0; i4 < g_tradeCount; i4++)
    {
        if(g_trades[i4].isOpen) continue;
        string qlbl = GetQuarterKey(g_trades[i4].closeTime);
        bool found4 = false;
        for(int j4 = 0; j4 < qTotal; j4++)
            if(qLabels[j4] == qlbl) { AccumTrade(qRows[j4], g_trades[i4]); found4 = true; break; }
        if(!found4 && qTotal < InpQuarterCount + 2)
        {
            InitRow(qRows[qTotal]);
            qRows[qTotal].label = qlbl;
            AccumTrade(qRows[qTotal], g_trades[i4]);
            qLabels[qTotal] = qlbl;
            qTotal++;
        }
    }
    
    double qRunBal = startBal;
    for(int qi = 0; qi < qTotal; qi++)
    {
        int qy = (int)StringToInteger(StringSubstr(qLabels[qi], 0, 4));
        int qq = (int)StringToInteger(StringSubstr(qLabels[qi], 6, 1));
        int qm1 = (qq - 1) * 3 + 1;
        int qm2 = qm1 + 3;
        int qy2 = qy;
        if(qm2 > 12) { qm2 = 1; qy2++; }
        datetime qt1 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", qy, qm1));
        datetime qt2 = StringToTime(StringFormat("%04d.%02d.01 00:00:00", qy2, qm2));
        double dep4 = GetDepositInRange(qt1, qt2);
        qRows[qi].deposit = dep4;
        double ps4 = qRunBal;
        qRunBal += qRows[qi].profit + qRows[qi].commission + qRows[qi].swap + dep4;
        qRows[qi].balance = qRunBal;
        if(ps4 != 0) qRows[qi].pct = (qRows[qi].profit + qRows[qi].commission + qRows[qi].swap) / ps4 * 100.0;
        if(qRows[qi].minLots >= 1e9) qRows[qi].minLots = 0;
        if(qRows[qi].count > 0) qRows[qi].avgDur = qRows[qi].avgDur / qRows[qi].count;
        if(qRows[qi].minDur == 2147483647) qRows[qi].minDur = 0;
        if(qRows[qi].balance != 0)
        {
            if(qRows[qi].maxDD != 0) qRows[qi].maxDDPct = qRows[qi].maxDD / qRows[qi].balance * 100.0;
            if(qRows[qi].maxProfit != 0) qRows[qi].maxProfitPct = qRows[qi].maxProfit / qRows[qi].balance * 100.0;
        }
    }
    
    int qStart = qTotal - InpQuarterCount;
    if(qStart < 0) qStart = 0;
    g_quarterCount = 0;
    for(int qi2 = qTotal - 1; qi2 >= qStart; qi2--)
    {
        g_quarterStats[g_quarterCount] = qRows[qi2];
        g_quarterCount++;
    }
    
    // ---- 年统计 ----
    g_yearCount = 0;
    ArrayResize(g_yearStats, InpYearCount + 2);
    
    string yLabels[];
    ArrayResize(yLabels, InpYearCount + 2);
    StatRow yRows[];
    ArrayResize(yRows, InpYearCount + 2);
    int yTotal = 0;
    
    for(int i5 = 0; i5 < g_tradeCount; i5++)
    {
        if(g_trades[i5].isOpen) continue;
        string ylbl = GetYearKey(g_trades[i5].closeTime);
        bool found5 = false;
        for(int j5 = 0; j5 < yTotal; j5++)
            if(yLabels[j5] == ylbl) { AccumTrade(yRows[j5], g_trades[i5]); found5 = true; break; }
        if(!found5 && yTotal < InpYearCount + 2)
        {
            InitRow(yRows[yTotal]);
            yRows[yTotal].label = ylbl;
            AccumTrade(yRows[yTotal], g_trades[i5]);
            yLabels[yTotal] = ylbl;
            yTotal++;
        }
    }
    
    double yRunBal = startBal;
    for(int yi = 0; yi < yTotal; yi++)
    {
        int yy = (int)StringToInteger(yLabels[yi]);
        datetime yt1 = StringToTime(StringFormat("%04d.01.01 00:00:00", yy));
        datetime yt2 = StringToTime(StringFormat("%04d.01.01 00:00:00", yy + 1));
        double dep5 = GetDepositInRange(yt1, yt2);
        yRows[yi].deposit = dep5;
        double ps5 = yRunBal;
        yRunBal += yRows[yi].profit + yRows[yi].commission + yRows[yi].swap + dep5;
        yRows[yi].balance = yRunBal;
        if(ps5 != 0) yRows[yi].pct = (yRows[yi].profit + yRows[yi].commission + yRows[yi].swap) / ps5 * 100.0;
        if(yRows[yi].minLots >= 1e9) yRows[yi].minLots = 0;
        if(yRows[yi].count > 0) yRows[yi].avgDur = yRows[yi].avgDur / yRows[yi].count;
        if(yRows[yi].minDur == 2147483647) yRows[yi].minDur = 0;
        if(yRows[yi].balance != 0)
        {
            if(yRows[yi].maxDD != 0) yRows[yi].maxDDPct = yRows[yi].maxDD / yRows[yi].balance * 100.0;
            if(yRows[yi].maxProfit != 0) yRows[yi].maxProfitPct = yRows[yi].maxProfit / yRows[yi].balance * 100.0;
        }
    }
    
    int yStart = yTotal - InpYearCount;
    if(yStart < 0) yStart = 0;
    g_yearCount = 0;
    for(int yi2 = yTotal - 1; yi2 >= yStart; yi2--)
    {
        g_yearStats[g_yearCount] = yRows[yi2];
        g_yearCount++;
    }
}

//+------------------------------------------------------------------+
//| 计算分组统计(币种/Magic/备注)                                       |
//+------------------------------------------------------------------+
void CalcGroupStats()
{
    // 币种
    g_symbolCount = 0;
    ArrayResize(g_symbolStats, 200);
    string symKeys[];
    ArrayResize(symKeys, 200);
    
    // Magic
    g_magicCount = 0;
    ArrayResize(g_magicStats, 200);
    string magKeys[];
    ArrayResize(magKeys, 200);
    
    // 备注
    g_commentCount = 0;
    ArrayResize(g_commentStats, 200);
    string comKeys[];
    ArrayResize(comKeys, 200);
    
    for(int i = 0; i < g_tradeCount; i++)
    {
        // 币种
        string sk = g_trades[i].symbol;
        bool sf = false;
        for(int si = 0; si < g_symbolCount; si++)
            if(symKeys[si] == sk) { AccumTrade(g_symbolStats[si], g_trades[i]); sf = true; break; }
        if(!sf && g_symbolCount < 200)
        {
            InitRow(g_symbolStats[g_symbolCount]);
            g_symbolStats[g_symbolCount].label = sk;
            AccumTrade(g_symbolStats[g_symbolCount], g_trades[i]);
            symKeys[g_symbolCount] = sk;
            g_symbolCount++;
        }
        
        // Magic
        string mk = IntegerToString(g_trades[i].magic);
        bool mf = false;
        for(int mi = 0; mi < g_magicCount; mi++)
            if(magKeys[mi] == mk) { AccumTrade(g_magicStats[mi], g_trades[i]); mf = true; break; }
        if(!mf && g_magicCount < 200)
        {
            InitRow(g_magicStats[g_magicCount]);
            g_magicStats[g_magicCount].label = mk;
            AccumTrade(g_magicStats[g_magicCount], g_trades[i]);
            magKeys[g_magicCount] = mk;
            g_magicCount++;
        }
        
        // 备注
        string ck = g_trades[i].comment;
        if(StringLen(ck) == 0) ck = "(空)";
        bool cf = false;
        for(int ci = 0; ci < g_commentCount; ci++)
            if(comKeys[ci] == ck) { AccumTrade(g_commentStats[ci], g_trades[i]); cf = true; break; }
        if(!cf && g_commentCount < 200)
        {
            InitRow(g_commentStats[g_commentCount]);
            g_commentStats[g_commentCount].label = ck;
            AccumTrade(g_commentStats[g_commentCount], g_trades[i]);
            comKeys[g_commentCount] = ck;
            g_commentCount++;
        }
    }
    
    // Finalize groups - use current balance as reference
    double curBal = AccountBalance();
    for(int si2 = 0; si2 < g_symbolCount; si2++)
    {
        if(g_symbolStats[si2].minLots >= 1e9) g_symbolStats[si2].minLots = 0;
        if(g_symbolStats[si2].count > 0) g_symbolStats[si2].avgDur = g_symbolStats[si2].avgDur / g_symbolStats[si2].count;
        if(g_symbolStats[si2].minDur == 2147483647) g_symbolStats[si2].minDur = 0;
        if(curBal != 0) g_symbolStats[si2].pct = g_symbolStats[si2].profit / curBal * 100.0;
    }
    for(int mi2 = 0; mi2 < g_magicCount; mi2++)
    {
        if(g_magicStats[mi2].minLots >= 1e9) g_magicStats[mi2].minLots = 0;
        if(g_magicStats[mi2].count > 0) g_magicStats[mi2].avgDur = g_magicStats[mi2].avgDur / g_magicStats[mi2].count;
        if(g_magicStats[mi2].minDur == 2147483647) g_magicStats[mi2].minDur = 0;
        if(curBal != 0) g_magicStats[mi2].pct = g_magicStats[mi2].profit / curBal * 100.0;
    }
    for(int ci2 = 0; ci2 < g_commentCount; ci2++)
    {
        if(g_commentStats[ci2].minLots >= 1e9) g_commentStats[ci2].minLots = 0;
        if(g_commentStats[ci2].count > 0) g_commentStats[ci2].avgDur = g_commentStats[ci2].avgDur / g_commentStats[ci2].count;
        if(g_commentStats[ci2].minDur == 2147483647) g_commentStats[ci2].minDur = 0;
        if(curBal != 0) g_commentStats[ci2].pct = g_commentStats[ci2].profit / curBal * 100.0;
    }
}

//+------------------------------------------------------------------+
//| 计算综合页统计                                                      |
//+------------------------------------------------------------------+
void CalcSummaryStats(double startBal)
{
    // 最近N天
    g_summaryDayCount = 0;
    ArrayResize(g_summaryDays, InpSummaryDays + 2);
    
    datetime today = GetDayStart(TimeCurrent());
    
    string sdLabels[];
    ArrayResize(sdLabels, InpSummaryDays + 2);
    StatRow sdRows[];
    ArrayResize(sdRows, InpSummaryDays + 2);
    int sdTotal = 0;
    
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(g_trades[i].isOpen) continue;
        datetime ct = g_trades[i].closeTime;
        datetime ds = GetDayStart(ct);
        if(ds < today - (datetime)(InpSummaryDays * 86400)) continue;
        string lbl = FormatDate(ct);
        bool found = false;
        for(int j = 0; j < sdTotal; j++)
            if(sdLabels[j] == lbl) { AccumTrade(sdRows[j], g_trades[i]); found = true; break; }
        if(!found && sdTotal < InpSummaryDays + 2)
        {
            InitRow(sdRows[sdTotal]);
            sdRows[sdTotal].label = lbl;
            AccumTrade(sdRows[sdTotal], g_trades[i]);
            sdLabels[sdTotal] = lbl;
            sdTotal++;
        }
    }
    
    // 计算余额
    double sdRunBal = startBal;
    // 先累计到第一天之前
    if(sdTotal > 0)
    {
        datetime firstDay = StringToTime(sdLabels[0] + " 00:00:00");
        // 累计所有在第一天之前的已平仓盈亏
        for(int i2 = 0; i2 < g_tradeCount; i2++)
        {
            if(g_trades[i2].isOpen) continue;
            if(g_trades[i2].closeTime < firstDay)
                sdRunBal += g_trades[i2].profit + g_trades[i2].commission + g_trades[i2].swap;
        }
        sdRunBal += GetDepositBefore(firstDay);
    }
    
    for(int di = 0; di < sdTotal; di++)
    {
        datetime dt = StringToTime(sdLabels[di] + " 00:00:00");
        double dep = GetDepositInRange(dt, dt + 86400);
        sdRows[di].deposit = dep;
        double ps = sdRunBal;
        sdRunBal += sdRows[di].profit + sdRows[di].commission + sdRows[di].swap + dep;
        sdRows[di].balance = sdRunBal;
        if(ps != 0) sdRows[di].pct = (sdRows[di].profit + sdRows[di].commission + sdRows[di].swap) / ps * 100.0;
        if(sdRows[di].minLots >= 1e9) sdRows[di].minLots = 0;
        if(sdRows[di].count > 0) sdRows[di].avgDur = sdRows[di].avgDur / sdRows[di].count;
        if(sdRows[di].minDur == 2147483647) sdRows[di].minDur = 0;
    }
    
    // 倒序存入
    g_summaryDayCount = 0;
    for(int di2 = sdTotal - 1; di2 >= 0; di2--)
    {
        g_summaryDays[g_summaryDayCount] = sdRows[di2];
        g_summaryDayCount++;
    }
    
    // 本周/本月/本季/本年盈亏
    datetime weekStart  = GetWeekStart(TimeCurrent());
    datetime monthStart = GetMonthStart(TimeCurrent());
    string   curQKey    = GetQuarterKey(TimeCurrent());
    string   curYKey    = GetYearKey(TimeCurrent());
    
    g_thisWeekProfit    = 0;
    g_thisMonthProfit   = 0;
    g_thisQuarterProfit = 0;
    g_thisYearProfit    = 0;
    
    for(int i3 = 0; i3 < g_tradeCount; i3++)
    {
        if(g_trades[i3].isOpen) continue;
        datetime ct2 = g_trades[i3].closeTime;
        double net = g_trades[i3].profit + g_trades[i3].commission + g_trades[i3].swap;
        if(ct2 >= weekStart)  g_thisWeekProfit    += net;
        if(ct2 >= monthStart) g_thisMonthProfit   += net;
        if(GetQuarterKey(ct2) == curQKey) g_thisQuarterProfit += net;
        if(GetYearKey(ct2)    == curYKey) g_thisYearProfit    += net;
    }
}


//+------------------------------------------------------------------+
//| UI 绘制辅助函数                                                     |
//+------------------------------------------------------------------+
void ObjRect(string name, int x, int y, int w, int h, color bg, color border = clrNONE)
{
    if(ObjectFind(0, name) < 0) ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE,  x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE,  y);
    ObjectSetInteger(0, name, OBJPROP_XSIZE,      w);
    ObjectSetInteger(0, name, OBJPROP_YSIZE,      h);
    ObjectSetInteger(0, name, OBJPROP_BGCOLOR,    bg);
    ObjectSetInteger(0, name, OBJPROP_COLOR,      border == clrNONE ? bg : border);
    ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
    ObjectSetInteger(0, name, OBJPROP_CORNER,     CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_BACK,       false);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN,     true);
}

void ObjLabel(string name, int x, int y, string text, color clr, int fontSize = -1, string font = "Arial")
{
    if(fontSize < 0) fontSize = InpFontSize;
    if(ObjectFind(0, name) < 0) ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE,  x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE,  y);
    ObjectSetString(0,  name, OBJPROP_TEXT,       text);
    ObjectSetInteger(0, name, OBJPROP_COLOR,      clr);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE,   fontSize);
    ObjectSetString(0,  name, OBJPROP_FONT,       font);
    ObjectSetInteger(0, name, OBJPROP_CORNER,     CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_ANCHOR,     ANCHOR_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_BACK,       false);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN,     true);
}

void ObjButton(string name, int x, int y, int w, int h, string text, color bg, color textClr, int fontSize = -1)
{
    if(fontSize < 0) fontSize = InpFontSize;
    if(ObjectFind(0, name) < 0) ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE,  x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE,  y);
    ObjectSetInteger(0, name, OBJPROP_XSIZE,      w);
    ObjectSetInteger(0, name, OBJPROP_YSIZE,      h);
    ObjectSetString(0,  name, OBJPROP_TEXT,       text);
    ObjectSetInteger(0, name, OBJPROP_BGCOLOR,    bg);
    ObjectSetInteger(0, name, OBJPROP_COLOR,      textClr);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE,   fontSize);
    ObjectSetInteger(0, name, OBJPROP_CORNER,     CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_BACK,       false);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN,     true);
}

void DeleteAllPanelObjects()
{
    int total = ObjectsTotal();
    for(int i = total - 1; i >= 0; i--)
    {
        string nm = ObjectName(i);
        if(StringFind(nm, PREFIX) == 0) ObjectDelete(0, nm);
    }
}

//+------------------------------------------------------------------+
//| 计算面板宽度(根据显示列)                                            |
//+------------------------------------------------------------------+
int CalcPanelWidth()
{
    int w = COL_LABEL_W; // 标签列
    if(InpShowLots)        w += 80;  // 总手数+最小/最大
    if(InpShowCount)       w += 40;  // 次数
    if(InpShowProfit)      w += 75;  // 盈亏金额
    if(InpShowPct)         w += 60;  // 百分比
    if(InpShowComm)        w += 60;  // 手续费
    if(InpShowSwap)        w += 60;  // 库存费
    if(InpShowDeposit)     w += 75;  // 出入金
    if(InpShowBalance)     w += 80;  // 余额
    if(InpShowMaxDD)       w += 70;  // 最大浮亏
    if(InpShowMaxDDPct)    w += 70;  // 最大浮亏比例
    if(InpShowMaxProfit)   w += 70;  // 最大浮盈
    if(InpShowMaxProfPct)  w += 70;  // 最大浮盈比例
    if(InpShowDuration)    w += 160; // 最小/平均/最大持仓时间
    if(InpShowWinRate)     w += 55;  // 胜率
    if(InpShowProfitFactor)w += 50;  // 盈亏比
    return w;
}

//+------------------------------------------------------------------+
//| 绘制表头行                                                          |
//+------------------------------------------------------------------+
void DrawTableHeader(int x, int y, int w, bool isTimeTab)
{
    ObjRect(PREFIX+"hdr_bg", x, y, w, ROW_H, InpColorHeader);
    int cx = x + 2;
    int fs = InpFontSize - 1;
    color hc = InpColorGray;
    
    string firstCol = isTimeTab ? "日期" : "分组";
    ObjLabel(PREFIX+"hdr_lbl", cx, y+1, firstCol, hc, fs); cx += COL_LABEL_W;
    
    if(InpShowLots)        { ObjLabel(PREFIX+"hdr_lots",  cx, y+1, "总手数", hc, fs); cx += 80; }
    if(InpShowCount)       { ObjLabel(PREFIX+"hdr_cnt",   cx, y+1, "次数",   hc, fs); cx += 40; }
    if(InpShowProfit)      { ObjLabel(PREFIX+"hdr_pnl",   cx, y+1, "盈亏金额", hc, fs); cx += 75; }
    if(InpShowPct)         { ObjLabel(PREFIX+"hdr_pct",   cx, y+1, "百分比%", hc, fs); cx += 60; }
    if(InpShowComm)        { ObjLabel(PREFIX+"hdr_comm",  cx, y+1, "手续费",  hc, fs); cx += 60; }
    if(InpShowSwap)        { ObjLabel(PREFIX+"hdr_swap",  cx, y+1, "库存费",  hc, fs); cx += 60; }
    if(InpShowDeposit)     { ObjLabel(PREFIX+"hdr_dep",   cx, y+1, "出入金",  hc, fs); cx += 75; }
    if(InpShowBalance)     { ObjLabel(PREFIX+"hdr_bal",   cx, y+1, "余额",    hc, fs); cx += 80; }
    if(InpShowMaxDD)       { ObjLabel(PREFIX+"hdr_mdd",   cx, y+1, "最大浮亏", hc, fs); cx += 70; }
    if(InpShowMaxDDPct)    { ObjLabel(PREFIX+"hdr_mddp",  cx, y+1, "最大浮亏比例", hc, fs); cx += 70; }
    if(InpShowMaxProfit)   { ObjLabel(PREFIX+"hdr_mpr",   cx, y+1, "最大浮盈金额", hc, fs); cx += 70; }
    if(InpShowMaxProfPct)  { ObjLabel(PREFIX+"hdr_mprp",  cx, y+1, "最大浮盈比例", hc, fs); cx += 70; }
    if(InpShowDuration)    { ObjLabel(PREFIX+"hdr_dur",   cx, y+1, "最小|平均|最大持仓时间", hc, fs); cx += 160; }
    if(InpShowWinRate)     { ObjLabel(PREFIX+"hdr_wr",    cx, y+1, "胜率",    hc, fs); cx += 55; }
    if(InpShowProfitFactor){ ObjLabel(PREFIX+"hdr_pf",    cx, y+1, "盈亏比",  hc, fs); cx += 50; }
}

//+------------------------------------------------------------------+
//| 绘制一行统计数据                                                    |
//+------------------------------------------------------------------+
void DrawStatRow(string rowId, int x, int y, int w, const StatRow &r, bool isOpen = false)
{
    color rowBg = InpColorBg;
    ObjRect(PREFIX+"row_bg_"+rowId, x, y, w, ROW_H, rowBg);
    
    int cx = x + 2;
    int fs = InpFontSize;
    
    // 标签色
    color lblClr = InpColorGray;
    if(isOpen) lblClr = InpColorGray;
    
    // 盈亏色
    double net = r.profit + r.commission + r.swap;
    color pnlClr = (net > 0) ? InpColorGreen : (net < 0 ? InpColorRed : InpColorGray);
    color pctClr = pnlClr;
    
    ObjLabel(PREFIX+"row_lbl_"+rowId, cx, y+1, r.label, lblClr, fs); cx += COL_LABEL_W;
    
    if(InpShowLots)
    {
        string lotsStr = StringFormat("%.2f", r.lots);
        if(r.count > 0) lotsStr += StringFormat(" %.2f|%.2f", r.minLots, r.maxLots);
        ObjLabel(PREFIX+"row_lots_"+rowId, cx, y+1, lotsStr, InpColorGray, fs);
        cx += 80;
    }
    if(InpShowCount)
    {
        ObjLabel(PREFIX+"row_cnt_"+rowId, cx, y+1, IntegerToString(r.count), InpColorGray, fs);
        cx += 40;
    }
    if(InpShowProfit)
    {
        ObjLabel(PREFIX+"row_pnl_"+rowId, cx, y+1, StringFormat("%.2f", r.profit), pnlClr, fs);
        cx += 75;
    }
    if(InpShowPct)
    {
        ObjLabel(PREFIX+"row_pct_"+rowId, cx, y+1, StringFormat("%.2f %%", r.pct), pctClr, fs);
        cx += 60;
    }
    if(InpShowComm)
    {
        color cc = (r.commission < 0) ? InpColorRed : InpColorGray;
        ObjLabel(PREFIX+"row_comm_"+rowId, cx, y+1, StringFormat("%.2f", r.commission), cc, fs);
        cx += 60;
    }
    if(InpShowSwap)
    {
        color sc = (r.swap < 0) ? InpColorRed : InpColorGray;
        ObjLabel(PREFIX+"row_swap_"+rowId, cx, y+1, StringFormat("%.2f", r.swap), sc, fs);
        cx += 60;
    }
    if(InpShowDeposit)
    {
        color dc = (r.deposit > 0) ? InpColorGreen : (r.deposit < 0 ? InpColorRed : InpColorGray);
        ObjLabel(PREFIX+"row_dep_"+rowId, cx, y+1, StringFormat("%.2f", r.deposit), dc, fs);
        cx += 75;
    }
    if(InpShowBalance)
    {
        ObjLabel(PREFIX+"row_bal_"+rowId, cx, y+1, StringFormat("%.2f", r.balance), InpColorGray, fs);
        cx += 80;
    }
    if(InpShowMaxDD)
    {
        color mdc = (r.maxDD < 0) ? InpColorRed : InpColorGray;
        ObjLabel(PREFIX+"row_mdd_"+rowId, cx, y+1, StringFormat("%.2f", r.maxDD), mdc, fs);
        cx += 70;
    }
    if(InpShowMaxDDPct)
    {
        color mdpc = (r.maxDDPct < 0) ? InpColorRed : InpColorGray;
        ObjLabel(PREFIX+"row_mddp_"+rowId, cx, y+1, StringFormat("%.2f %%", r.maxDDPct), mdpc, fs);
        cx += 70;
    }
    if(InpShowMaxProfit)
    {
        color mpc = (r.maxProfit > 0) ? InpColorGreen : InpColorGray;
        ObjLabel(PREFIX+"row_mpr_"+rowId, cx, y+1, StringFormat("%.2f", r.maxProfit), mpc, fs);
        cx += 70;
    }
    if(InpShowMaxProfPct)
    {
        color mppc = (r.maxProfitPct > 0) ? InpColorGreen : InpColorGray;
        ObjLabel(PREFIX+"row_mprp_"+rowId, cx, y+1, StringFormat("%.2f %%", r.maxProfitPct), mppc, fs);
        cx += 70;
    }
    if(InpShowDuration)
    {
        string durStr = FormatDuration(r.minDur) + "|" + FormatDuration(r.avgDur) + "|" + FormatDuration(r.maxDur);
        ObjLabel(PREFIX+"row_dur_"+rowId, cx, y+1, durStr, InpColorGray, fs);
        cx += 160;
    }
    if(InpShowWinRate)
    {
        double wr = (r.count > 0) ? (double)r.winCount / r.count * 100.0 : 0;
        color wrc = (wr >= 50) ? InpColorGreen : InpColorRed;
        ObjLabel(PREFIX+"row_wr_"+rowId, cx, y+1, StringFormat("%.2f %%", wr), wrc, fs);
        cx += 55;
    }
    if(InpShowProfitFactor)
    {
        double pf = (r.lossProfit != 0) ? MathAbs(r.winProfit / r.lossProfit) : (r.winProfit > 0 ? 999 : 0);
        color pfc = (pf >= 1) ? InpColorGreen : InpColorRed;
        ObjLabel(PREFIX+"row_pf_"+rowId, cx, y+1, StringFormat("%.2f", pf), pfc, fs);
        cx += 50;
    }
}

//+------------------------------------------------------------------+
//| 绘制合计行                                                          |
//+------------------------------------------------------------------+
void DrawTotalRow(string rowId, int x, int y, int w, const StatRow &r)
{
    ObjRect(PREFIX+"tot_bg_"+rowId, x, y, w, ROW_H, InpColorHeader);
    
    int cx = x + 2;
    int fs = InpFontSize;
    color hc = InpColorGray;
    double net = r.profit + r.commission + r.swap;
    color pnlClr = (net > 0) ? InpColorGreen : (net < 0 ? InpColorRed : hc);
    
    ObjLabel(PREFIX+"tot_lbl_"+rowId, cx, y+1, "合计", hc, fs); cx += COL_LABEL_W;
    
    if(InpShowLots)
    {
        ObjLabel(PREFIX+"tot_lots_"+rowId, cx, y+1, StringFormat("%.2f", r.lots), hc, fs); cx += 80;
    }
    if(InpShowCount)
    {
        ObjLabel(PREFIX+"tot_cnt_"+rowId, cx, y+1, IntegerToString(r.count), hc, fs); cx += 40;
    }
    if(InpShowProfit)
    {
        ObjLabel(PREFIX+"tot_pnl_"+rowId, cx, y+1, StringFormat("%.2f", r.profit), pnlClr, fs); cx += 75;
    }
    if(InpShowPct)
    {
        ObjLabel(PREFIX+"tot_pct_"+rowId, cx, y+1, StringFormat("%.2f %%", r.pct), pnlClr, fs); cx += 60;
    }
    if(InpShowComm)
    {
        ObjLabel(PREFIX+"tot_comm_"+rowId, cx, y+1, StringFormat("%.2f", r.commission), InpColorRed, fs); cx += 60;
    }
    if(InpShowSwap)
    {
        ObjLabel(PREFIX+"tot_swap_"+rowId, cx, y+1, StringFormat("%.2f", r.swap), InpColorRed, fs); cx += 60;
    }
    if(InpShowDeposit)
    {
        ObjLabel(PREFIX+"tot_dep_"+rowId, cx, y+1, StringFormat("%.2f", r.deposit), hc, fs); cx += 75;
    }
    if(InpShowBalance)
    {
        ObjLabel(PREFIX+"tot_bal_"+rowId, cx, y+1, StringFormat("%.2f", r.balance), hc, fs); cx += 80;
    }
    if(InpShowMaxDD)
    {
        ObjLabel(PREFIX+"tot_mdd_"+rowId, cx, y+1, StringFormat("%.2f", r.maxDD), InpColorRed, fs); cx += 70;
    }
    if(InpShowMaxDDPct)
    {
        ObjLabel(PREFIX+"tot_mddp_"+rowId, cx, y+1, StringFormat("%.2f %%", r.maxDDPct), InpColorRed, fs); cx += 70;
    }
    if(InpShowMaxProfit)
    {
        ObjLabel(PREFIX+"tot_mpr_"+rowId, cx, y+1, StringFormat("%.2f", r.maxProfit), InpColorGreen, fs); cx += 70;
    }
    if(InpShowMaxProfPct)
    {
        ObjLabel(PREFIX+"tot_mprp_"+rowId, cx, y+1, StringFormat("%.2f %%", r.maxProfitPct), InpColorGreen, fs); cx += 70;
    }
    if(InpShowDuration)
    {
        string durStr = FormatDuration(r.minDur) + "|" + FormatDuration(r.avgDur) + "|" + FormatDuration(r.maxDur);
        ObjLabel(PREFIX+"tot_dur_"+rowId, cx, y+1, durStr, hc, fs); cx += 160;
    }
    if(InpShowWinRate)
    {
        double wr = (r.count > 0) ? (double)r.winCount / r.count * 100.0 : 0;
        color wrc = (wr >= 50) ? InpColorGreen : InpColorRed;
        ObjLabel(PREFIX+"tot_wr_"+rowId, cx, y+1, StringFormat("%.2f %%", wr), wrc, fs); cx += 55;
    }
    if(InpShowProfitFactor)
    {
        double pf = (r.lossProfit != 0) ? MathAbs(r.winProfit / r.lossProfit) : (r.winProfit > 0 ? 999 : 0);
        color pfc = (pf >= 1) ? InpColorGreen : InpColorRed;
        ObjLabel(PREFIX+"tot_pf_"+rowId, cx, y+1, StringFormat("%.2f", pf), pfc, fs); cx += 50;
    }
}


//+------------------------------------------------------------------+
//| 绘制收益曲线(像素坐标)                                              |
//+------------------------------------------------------------------+
void DrawEquityCurve(int x, int y, int w, int h, StatRow &rows[], int rowCount)
{
    if(rowCount < 2 || h < 20) return;
    
    // 收集余额序列(时间升序,即rows倒序)
    double balArr[];
    ArrayResize(balArr, rowCount);
    for(int i = 0; i < rowCount; i++)
        balArr[i] = rows[rowCount - 1 - i].balance;
    
    double minB = balArr[0], maxB = balArr[0];
    for(int i2 = 1; i2 < rowCount; i2++)
    {
        if(balArr[i2] < minB) minB = balArr[i2];
        if(balArr[i2] > maxB) maxB = balArr[i2];
    }
    if(maxB == minB) { maxB = minB + 1; }
    
    double range = maxB - minB;
    int margin = 4;
    int chartH = h - margin * 2;
    int chartW = w - margin * 2;
    
    // 绘制背景
    ObjRect(PREFIX+"curve_bg", x, y, w, h, C'15,20,30');
    
    // 绘制曲线点
    for(int pi = 0; pi < rowCount - 1; pi++)
    {
        double b1 = balArr[pi];
        double b2 = balArr[pi + 1];
        
        int x1 = x + margin + (int)((double)pi / (rowCount - 1) * chartW);
        int y1 = y + margin + chartH - (int)((b1 - minB) / range * chartH);
        int x2 = x + margin + (int)((double)(pi + 1) / (rowCount - 1) * chartW);
        int y2 = y + margin + chartH - (int)((b2 - minB) / range * chartH);
        
        // 用小矩形绘制线段
        int dx = x2 - x1;
        int dy = y2 - y1;
        int steps = MathMax(MathAbs(dx), MathAbs(dy));
        if(steps == 0) steps = 1;
        
        for(int s = 0; s <= steps; s++)
        {
            int px = x1 + (int)((double)s / steps * dx);
            int py = y1 + (int)((double)s / steps * dy);
            string pname = StringFormat("%scurve_pt_%d_%d", PREFIX, pi, s);
            ObjRect(pname, px, py, 2, 2, clrDodgerBlue);
        }
    }
    
    // 日期标注
    if(rowCount > 0)
    {
        string lbl1 = rows[rowCount - 1].label;
        string lbl2 = rows[0].label;
        ObjLabel(PREFIX+"curve_lbl1", x + margin, y + h - InpFontSize - 2, lbl1, InpColorDimGray, InpFontSize - 1);
        ObjLabel(PREFIX+"curve_lbl2", x + w - 80, y + h - InpFontSize - 2, lbl2, InpColorDimGray, InpFontSize - 1);
    }
}

//+------------------------------------------------------------------+
//| 绘制时间维度Tab内容(日/周/月/季/年)                                 |
//+------------------------------------------------------------------+
void DrawTimeTabContent(int x, int y, int w, int panelH, StatRow &rows[], int rowCount, string firstColName)
{
    int CURVE_H = 80;
    
    // 收益曲线
    DrawEquityCurve(x, y, w, CURVE_H, rows, rowCount);
    
    int tableY = y + CURVE_H + 2;
    int tableH = panelH - CURVE_H - 2;
    
    // 表头
    DrawTableHeader(x, tableY, w, true);
    tableY += ROW_H;
    
    // 持仓行
    StatRow openRow;
    InitRow(openRow);
    openRow.label = "持仓";
    openRow.isOpen = true;
    openRow.balance = AccountEquity();
    bool hasOpen = false;
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(g_trades[i].isOpen)
        {
            AccumTrade(openRow, g_trades[i]);
            hasOpen = true;
        }
    }
    if(openRow.minLots >= 1e9) openRow.minLots = 0;
    DrawStatRow("open", x, tableY, w, openRow, true);
    tableY += ROW_H;
    
    // 数据行
    int maxRows = (tableH - ROW_H * 2) / ROW_H;
    int drawn = 0;
    for(int i2 = 0; i2 < rowCount && drawn < maxRows; i2++)
    {
        DrawStatRow(IntegerToString(i2), x, tableY, w, rows[i2]);
        tableY += ROW_H;
        drawn++;
    }
    
    // 合计行
    StatRow total;
    InitRow(total);
    total.label = "合计";
    for(int i3 = 0; i3 < rowCount; i3++)
    {
        total.lots       += rows[i3].lots;
        total.count      += rows[i3].count;
        total.profit     += rows[i3].profit;
        total.commission += rows[i3].commission;
        total.swap       += rows[i3].swap;
        total.deposit    += rows[i3].deposit;
        total.winCount   += rows[i3].winCount;
        total.winProfit  += rows[i3].winProfit;
        total.lossProfit += rows[i3].lossProfit;
        if(rows[i3].maxDD < total.maxDD) total.maxDD = rows[i3].maxDD;
        if(rows[i3].maxProfit > total.maxProfit) total.maxProfit = rows[i3].maxProfit;
        if(rows[i3].minLots < total.minLots && rows[i3].minLots > 0) total.minLots = rows[i3].minLots;
        if(rows[i3].maxLots > total.maxLots) total.maxLots = rows[i3].maxLots;
        if(rows[i3].minDur < total.minDur && rows[i3].minDur > 0) total.minDur = rows[i3].minDur;
        if(rows[i3].maxDur > total.maxDur) total.maxDur = rows[i3].maxDur;
        total.avgDur += rows[i3].avgDur;
    }
    if(rowCount > 0) total.avgDur = total.avgDur / rowCount;
    if(total.minLots >= 1e9) total.minLots = 0;
    if(total.minDur == 2147483647) total.minDur = 0;
    total.balance = AccountBalance();
    double startBal = CalcStartBalance();
    if(startBal != 0) total.pct = total.profit / startBal * 100.0;
    
    DrawTotalRow("main", x, tableY, w, total);
}

//+------------------------------------------------------------------+
//| 绘制分组Tab内容(币/Magic/备注)                                      |
//+------------------------------------------------------------------+
void DrawGroupTabContent(int x, int y, int w, int panelH, StatRow &rows[], int rowCount)
{
    // 表头
    DrawTableHeader(x, y, w, false);
    int tableY = y + ROW_H;
    
    // 数据行
    int maxRows = (panelH - ROW_H * 2) / ROW_H;
    int drawn = 0;
    for(int i = 0; i < rowCount && drawn < maxRows; i++)
    {
        DrawStatRow(IntegerToString(i), x, tableY, w, rows[i]);
        tableY += ROW_H;
        drawn++;
    }
    
    // 合计行
    StatRow total;
    InitRow(total);
    total.label = "合计";
    for(int i2 = 0; i2 < rowCount; i2++)
    {
        total.lots       += rows[i2].lots;
        total.count      += rows[i2].count;
        total.profit     += rows[i2].profit;
        total.commission += rows[i2].commission;
        total.swap       += rows[i2].swap;
        total.winCount   += rows[i2].winCount;
        total.winProfit  += rows[i2].winProfit;
        total.lossProfit += rows[i2].lossProfit;
        if(rows[i2].minLots < total.minLots && rows[i2].minLots > 0) total.minLots = rows[i2].minLots;
        if(rows[i2].maxLots > total.maxLots) total.maxLots = rows[i2].maxLots;
        if(rows[i2].minDur < total.minDur && rows[i2].minDur > 0) total.minDur = rows[i2].minDur;
        if(rows[i2].maxDur > total.maxDur) total.maxDur = rows[i2].maxDur;
        total.avgDur += rows[i2].avgDur;
    }
    if(rowCount > 0) total.avgDur = total.avgDur / rowCount;
    if(total.minLots >= 1e9) total.minLots = 0;
    if(total.minDur == 2147483647) total.minDur = 0;
    
    DrawTotalRow("grp", x, tableY, w, total);
}

//+------------------------------------------------------------------+
//| 绘制综合Tab内容                                                     |
//+------------------------------------------------------------------+
void DrawSummaryTabContent(int x, int y, int w, int panelH)
{
    int cy = y;
    int fs = InpFontSize;
    
    // 持仓汇总
    double openLots = 0, openProfit = 0;
    int openBuy = 0, openSell = 0;
    double openBuyLots = 0, openSellLots = 0;
    
    for(int i = 0; i < g_tradeCount; i++)
    {
        if(!g_trades[i].isOpen) continue;
        openLots   += g_trades[i].lots;
        openProfit += g_trades[i].profit + g_trades[i].commission + g_trades[i].swap;
        if(g_trades[i].type == OP_BUY)  { openBuy++;  openBuyLots  += g_trades[i].lots; }
        else                             { openSell++; openSellLots += g_trades[i].lots; }
    }
    
    // 表头
    DrawTableHeader(x, cy, w, true);
    cy += ROW_H;
    
    // 持仓行
    StatRow openRow;
    InitRow(openRow);
    openRow.label   = "持仓";
    openRow.lots    = openLots;
    openRow.profit  = openProfit;
    openRow.count   = openBuy + openSell;
    openRow.balance = AccountEquity();
    openRow.isOpen  = true;
    for(int io = 0; io < g_tradeCount; io++)
        if(g_trades[io].isOpen) AccumTrade(openRow, g_trades[io]);
    if(openRow.minLots >= 1e9) openRow.minLots = 0;
    DrawStatRow("sum_open", x, cy, w, openRow, true);
    cy += ROW_H;
    
    // 最近N天
    for(int di = 0; di < g_summaryDayCount; di++)
    {
        DrawStatRow("sum_d_"+IntegerToString(di), x, cy, w, g_summaryDays[di]);
        cy += ROW_H;
    }
    
    // 本周/本月/本季/本年汇总行
    double curBal = AccountBalance();
    double startBal = CalcStartBalance();
    
    StatRow wRow; InitRow(wRow); wRow.label = "本周盈亏";
    wRow.profit = g_thisWeekProfit; wRow.balance = curBal;
    if(startBal != 0) wRow.pct = g_thisWeekProfit / startBal * 100.0;
    DrawStatRow("sum_week", x, cy, w, wRow); cy += ROW_H;
    
    StatRow mRow; InitRow(mRow); mRow.label = "本月盈亏";
    mRow.profit = g_thisMonthProfit; mRow.balance = curBal;
    if(startBal != 0) mRow.pct = g_thisMonthProfit / startBal * 100.0;
    DrawStatRow("sum_month", x, cy, w, mRow); cy += ROW_H;
    
    StatRow qRow; InitRow(qRow); qRow.label = "本季盈亏";
    qRow.profit = g_thisQuarterProfit; qRow.balance = curBal;
    if(startBal != 0) qRow.pct = g_thisQuarterProfit / startBal * 100.0;
    DrawStatRow("sum_qtr", x, cy, w, qRow); cy += ROW_H;
    
    StatRow yRow; InitRow(yRow); yRow.label = "本年盈亏";
    yRow.profit = g_thisYearProfit; yRow.balance = curBal;
    if(startBal != 0) yRow.pct = g_thisYearProfit / startBal * 100.0;
    DrawStatRow("sum_year", x, cy, w, yRow); cy += ROW_H;
    
    // 持仓汇总文字
    ObjLabel(PREFIX+"sum_info1", x+2, cy+2, 
        StringFormat("账户持仓汇总, Magic=%s", InpOnlyMagic), InpColorGray, fs);
    cy += ROW_H;
    ObjLabel(PREFIX+"sum_info2", x+2, cy+2,
        StringFormat("多单Buy  单数:%d  手数:%.2f  盈亏:%.2f", openBuy, openBuyLots, openProfit > 0 ? openProfit : 0),
        InpColorGreen, fs);
    cy += ROW_H;
    ObjLabel(PREFIX+"sum_info3", x+2, cy+2,
        StringFormat("空单Sell 单数:%d  手数:%.2f", openSell, openSellLots),
        InpColorRed, fs);
}

//+------------------------------------------------------------------+
//| 绘制账户Tab内容                                                     |
//+------------------------------------------------------------------+
void DrawAccountTabContent(int x, int y, int w, int panelH)
{
    int cy = y + 4;
    int fs = InpFontSize;
    int colW = w / 2 - 4;
    int cx2 = x + colW + 8;
    color lc = InpColorGray;
    color vc = InpColorGreen;
    
    // 左栏
    ObjLabel(PREFIX+"acc_path",    x+2, cy, "MT4路径: " + TerminalPath(), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_id",      x+2, cy, "账户ID: " + IntegerToString(AccountNumber()), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_lev",     x+2, cy, "账户杠杆: " + IntegerToString(AccountLeverage()) + ":1", lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_minlot",  x+2, cy, "最小手数: " + DoubleToStr(MarketInfo(Symbol(), MODE_MINLOT), 2), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_maxlot",  x+2, cy, "最大手数: " + DoubleToStr(MarketInfo(Symbol(), MODE_MAXLOT), 0), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_bal",     x+2, cy, "余额: " + DoubleToStr(AccountBalance(), 2), vc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_margin",  x+2, cy, "已用保证金: " + DoubleToStr(AccountMargin(), 2), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_curr",    x+2, cy, "结算货币: " + AccountCurrency(), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_ea",      x+2, cy, "平台允许EA: " + (IsExpertEnabled() ? "允许" : "禁止"), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_sym",     x+2, cy, "品种: [" + Symbol() + "]", lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_1lot",    x+2, cy, "1手保证金: " + DoubleToStr(MarketInfo(Symbol(), MODE_MARGINREQUIRED), 2), lc, fs); cy += ROW_H;
    ObjLabel(PREFIX+"acc_point",   x+2, cy, "Point: " + DoubleToStr(MarketInfo(Symbol(), MODE_POINT), 5), lc, fs); cy += ROW_H;
    
    // 右栏
    int ry = y + 4;
    ObjLabel(PREFIX+"acc_broker",  cx2, ry, "经纪商: " + AccountCompany(), lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_type",    cx2, ry, "账户类型: " + (AccountNumber() > 0 ? (IsDemo() ? "模拟" : "真实") : ""), lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_equity",  cx2, ry, "净值: " + DoubleToStr(AccountEquity(), 2), vc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_free",    cx2, ry, "可用保证金: " + DoubleToStr(AccountFreeMargin(), 2), lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_local",   cx2, ry, "本地时间: " + TimeToStr(TimeLocal(), TIME_DATE|TIME_SECONDS), lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_server",  cx2, ry, "平台时间: " + TimeToStr(TimeCurrent(), TIME_DATE|TIME_SECONDS), lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_spread",  cx2, ry, "点差: " + IntegerToString((int)MarketInfo(Symbol(), MODE_SPREAD)) + " 点", lc, fs); ry += ROW_H;
    ObjLabel(PREFIX+"acc_stoplv",  cx2, ry, "挂单最小间距: " + IntegerToString((int)MarketInfo(Symbol(), MODE_STOPLEVEL)) + " 点", lc, fs); ry += ROW_H;
}

//+------------------------------------------------------------------+
//| 主绘制函数                                                          |
//+------------------------------------------------------------------+
void DrawPanel()
{
    DeleteAllPanelObjects();
    
    int px = g_panelX;
    int py = g_panelY;
    int pw = CalcPanelWidth();
    
    // 折叠状态只绘制标题栏
    if(g_minimized)
    {
        ObjRect(PREFIX+"bg_main", px, py, pw, TITLE_H, InpColorBg, InpColorBorder);
        // 折叠按钮(+)
        ObjButton(PREFIX+"btn_min", px+2, py+1, 14, TITLE_H-2, "+", InpColorTabActive, InpColorGreen);
        // 移动按钮
        ObjButton(PREFIX+"btn_move", px+18, py+1, 14, TITLE_H-2, "+", InpColorTabActive, InpColorGray);
        // 标题
        ObjLabel(PREFIX+"lbl_title", px+36, py+2, InpTitle, InpColorGreen, InpFontSize);
        return;
    }
    
    // 计算面板总高度
    int contentRows = 0;
    int CURVE_H = 80;
    
    if(g_curTab == 0)       contentRows = InpSummaryDays + 7;
    else if(g_curTab == 1)  contentRows = MathMin(g_dayCount, 50) + 2;
    else if(g_curTab == 2)  contentRows = MathMin(g_weekCount, 50) + 2;
    else if(g_curTab == 3)  contentRows = MathMin(g_monthCount, 50) + 2;
    else if(g_curTab == 4)  contentRows = MathMin(g_quarterCount, 50) + 2;
    else if(g_curTab == 5)  contentRows = MathMin(g_yearCount, 50) + 2;
    else if(g_curTab == 6)  contentRows = MathMin(g_symbolCount, 50) + 2;
    else if(g_curTab == 7)  contentRows = MathMin(g_magicCount, 50) + 2;
    else if(g_curTab == 8)  contentRows = MathMin(g_commentCount, 50) + 2;
    else if(g_curTab == 9)  contentRows = 15;
    else if(g_curTab == 10) contentRows = 5;
    
    int tableH = contentRows * ROW_H + ROW_H; // +1 for header
    int extraH = (g_curTab >= 1 && g_curTab <= 5) ? CURVE_H + 2 : 0;
    int totalH = TITLE_H + TAB_H + extraH + tableH + 4;
    
    // 主背景
    ObjRect(PREFIX+"bg_main", px, py, pw, totalH, InpColorBg, InpColorBorder);
    
    // 标题栏
    ObjRect(PREFIX+"bg_title", px, py, pw, TITLE_H, InpColorHeader);
    ObjButton(PREFIX+"btn_min",  px+2,  py+1, 14, TITLE_H-2, "-", InpColorTabActive, InpColorGreen);
    ObjButton(PREFIX+"btn_move", px+18, py+1, 14, TITLE_H-2, "+", InpColorTabActive, InpColorGray);
    ObjLabel(PREFIX+"lbl_title", px+36, py+2, InpTitle + "  M=" + InpOnlyMagic, InpColorGreen, InpFontSize);
    
    // Tab栏
    int tabY = py + TITLE_H;
    ObjRect(PREFIX+"bg_tabs", px, tabY, pw, TAB_H, InpColorHeader);
    
    string tabNames[11];
    tabNames[0]  = "综";
    tabNames[1]  = "日";
    tabNames[2]  = "周";
    tabNames[3]  = "月";
    tabNames[4]  = "季";
    tabNames[5]  = "年";
    tabNames[6]  = "币";
    tabNames[7]  = "M";
    tabNames[8]  = "备";
    tabNames[9]  = "账户";
    tabNames[10] = "轨迹";
    
    int tabX = px + 2;
    for(int ti = 0; ti < 11; ti++)
    {
        int tw = (ti < 9) ? 20 : 32;
        color tbg = (ti == g_curTab) ? InpColorTabActive : InpColorHeader;
        color tfc = (ti == g_curTab) ? InpColorGreen : InpColorGray;
        ObjButton(PREFIX+"btn_tab_"+IntegerToString(ti), tabX, tabY+1, tw, TAB_H-2, tabNames[ti], tbg, tfc);
        tabX += tw + 2;
    }
    
    // 内容区
    int contentY = tabY + TAB_H + 2;
    int contentH = totalH - TITLE_H - TAB_H - 4;
    
    if(g_curTab == 0)
        DrawSummaryTabContent(px, contentY, pw, contentH);
    else if(g_curTab == 1)
        DrawTimeTabContent(px, contentY, pw, contentH, g_dayStats, g_dayCount, "日期");
    else if(g_curTab == 2)
        DrawTimeTabContent(px, contentY, pw, contentH, g_weekStats, g_weekCount, "周");
    else if(g_curTab == 3)
        DrawTimeTabContent(px, contentY, pw, contentH, g_monthStats, g_monthCount, "月份");
    else if(g_curTab == 4)
        DrawTimeTabContent(px, contentY, pw, contentH, g_quarterStats, g_quarterCount, "季度");
    else if(g_curTab == 5)
        DrawTimeTabContent(px, contentY, pw, contentH, g_yearStats, g_yearCount, "年份");
    else if(g_curTab == 6)
        DrawGroupTabContent(px, contentY, pw, contentH, g_symbolStats, g_symbolCount);
    else if(g_curTab == 7)
        DrawGroupTabContent(px, contentY, pw, contentH, g_magicStats, g_magicCount);
    else if(g_curTab == 8)
        DrawGroupTabContent(px, contentY, pw, contentH, g_commentStats, g_commentCount);
    else if(g_curTab == 9)
        DrawAccountTabContent(px, contentY, pw, contentH);
    else if(g_curTab == 10)
    {
        ObjLabel(PREFIX+"trail_hint", px+4, contentY+4, "轨迹功能: 在图表上标注交易路径", InpColorGray, InpFontSize);
    }
    
    ChartRedraw();
}


//+------------------------------------------------------------------+
//| 指标初始化                                                          |
//+------------------------------------------------------------------+
int OnInit()
{
    g_curTab  = InpDefaultTab;
    g_panelX  = InpPanelX;
    g_panelY  = InpPanelY;
    g_minimized = false;
    g_dragging  = false;
    
    ParseFilters();
    RefreshAll();
    DrawPanel();
    
    ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);
    EventSetTimer(300); // 5分钟刷新
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| 指标反初始化                                                        |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    EventKillTimer();
    DeleteAllPanelObjects();
    ChartRedraw();
}

//+------------------------------------------------------------------+
//| 指标计算(每根K线调用)                                               |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
    return rates_total;
}

//+------------------------------------------------------------------+
//| 定时器(5分钟刷新数据)                                               |
//+------------------------------------------------------------------+
void OnTimer()
{
    RefreshAll();
    DrawPanel();
}

//+------------------------------------------------------------------+
//| 图表事件处理                                                        |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    // 记录鼠标位置
    if(id == CHARTEVENT_MOUSE_MOVE)
    {
        g_lastMouseX = (int)lparam;
        g_lastMouseY = (int)dparam;
        
        // 拖动中
        if(g_dragging)
        {
            g_panelX = g_lastMouseX - g_dragOffX;
            g_panelY = g_lastMouseY - g_dragOffY;
            if(g_panelX < 0) g_panelX = 0;
            if(g_panelY < 0) g_panelY = 0;
            DrawPanel();
        }
        return;
    }
    
    // 按钮点击
    if(id == CHARTEVENT_OBJECT_CLICK)
    {
        string nm = sparam;
        
        // 折叠/展开
        if(nm == PREFIX+"btn_min")
        {
            g_minimized = !g_minimized;
            ObjectSetInteger(0, nm, OBJPROP_STATE, false);
            DrawPanel();
            return;
        }
        
        // 移动按钮 - 切换拖动状态
        if(nm == PREFIX+"btn_move")
        {
            ObjectSetInteger(0, nm, OBJPROP_STATE, false);
            if(!g_dragging)
            {
                g_dragging = true;
                g_dragOffX = g_lastMouseX - g_panelX;
                g_dragOffY = g_lastMouseY - g_panelY;
            }
            else
            {
                g_dragging = false;
            }
            return;
        }
        
        // Tab切换
        for(int ti = 0; ti < 11; ti++)
        {
            string tabName = PREFIX+"btn_tab_"+IntegerToString(ti);
            if(nm == tabName)
            {
                ObjectSetInteger(0, nm, OBJPROP_STATE, false);
                g_curTab = ti;
                DrawPanel();
                return;
            }
        }
    }
    
    // 键盘事件 - ESC取消拖动
    if(id == CHARTEVENT_KEYDOWN)
    {
        if(lparam == 27) // ESC
        {
            g_dragging = false;
            DrawPanel();
        }
    }
}
//+------------------------------------------------------------------+
