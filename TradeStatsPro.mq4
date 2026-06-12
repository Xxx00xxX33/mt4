//+------------------------------------------------------------------+
//|                                              TradeStatsPro.mq4   |
//|                          MT4收益统计指标 - 每笔交易统计专业版      |
//|                  支持CSV持久化，历史数据不依赖MT4客户端记录         |
//+------------------------------------------------------------------+
#property copyright   "TradeStatsPro"
#property link        ""
#property version     "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1  clrBlack

//--- 指标缓冲区（虚拟，用于触发重绘）
double DummyBuffer[];

//==========================================================================
// 输入参数
//==========================================================================

// 面板位置
input string  _sep0_              = "___________面板位置___________";
input int     PanelStartX         = 100;       // 面板_X默认值
input int     PanelStartY         = 0;         // 面板_Y默认值
input string  CustomTitle         = "MT4统计每一笔交易"; // 自定义title

// 刷新与统计时间
input string  _sep1_              = "___________刷新与时间___________";
input int     RefreshMinutes      = 5;         // 刷新UI界面时间间隔(分钟)
input datetime StartTime          = 0;         // 开始统计时间(0=不限)
input datetime EndTime            = 0;         // 结束统计时间(0=不限)

// 过滤条件
input string  _sep2_              = "___________过滤条件___________";
input string  FilterSymbols       = "";        // 只统计品种(逗号分隔，空=全部)
input string  FilterMagic         = "";        // 只统计magic(逗号分隔，空=全部)
input string  FilterComment       = "";        // 只统计备注包含文字
input int     FilterOrderType     = 0;         // 只统计订单类型: 0=ALL, 1=BUY, 2=SELL

// CSV持久化
input string  _sep3_              = "___________CSV持久化___________";
input int     CSV_DaysBack        = 1;         // 写入多少天前的数据(默认1=昨天)
input bool    CSV_AutoSave        = true;      // 自动保存CSV
input string  CSV_FileName        = "TradeStats_History.csv"; // CSV文件名

// 显示列控制
input string  _sep4_              = "___________UI显示列选择___________";
input bool    Show_Lots           = true;      // 显示_手数
input bool    Show_MaxLots        = true;      // 显示_最大手数
input bool    Show_Count          = true;      // 显示_交易次数
input bool    Show_Profit         = true;      // 显示_盈亏金额
input bool    Show_ProfitPct      = true;      // 显示_盈亏百分比
input bool    Show_Commission     = true;      // 显示_手续费
input bool    Show_Swap           = true;      // 显示_库存费
input bool    Show_Deposit        = true;      // 显示_出入金
input bool    Show_Balance        = true;      // 显示_余额
input bool    Show_MaxDD          = true;      // 显示_最大浮亏
input bool    Show_MaxDDPct       = true;      // 显示_最大浮亏比例
input bool    Show_MaxFloat       = true;      // 显示_最大浮盈金额
input bool    Show_MaxFloatPct    = true;      // 显示_最大浮盈比例
input bool    Show_HoldTime       = true;      // 显示_平均最大持仓时间
input bool    Show_WinRate        = true;      // 显示_胜率
input bool    Show_ProfitFactor   = true;      // 显示_盈亏比
input bool    Show_TrailButton    = true;      // 显示路径按钮可用
input bool    ForceShowPath       = false;     // 载入时_强制_显示路径
input bool    ForceMinimize       = false;     // 载入时_强制_最小化状态

// 字体与颜色
input string  _sep5_              = "___________字体与颜色___________";
input int     FontSize            = 8;         // 字体大小
input color   ColorGreen          = clrSpringGreen;  // 颜色_文字_绿色
input color   ColorRed            = clrRed;          // 颜色_文字_红色
input color   ColorGray           = clrLightSteelBlue; // 颜色_文字_灰白
input color   ColorDimGray        = clrDimGray;      // 颜色_文字_深灰
input color   ColorBG             = C'20,20,30';     // 背景颜色
input color   ColorBorder         = C'50,50,70';     // 边框颜色
input color   ColorHeader         = C'30,30,50';     // 表头颜色
input color   ColorRowOdd         = C'15,15,25';     // 奇数行颜色
input color   ColorRowEven        = C'20,20,35';     // 偶数行颜色
input color   ColorEquityLine     = clrDodgerBlue;   // 净值曲线颜色

// 综合视图参数
input string  _sep6_              = "___________综合视图___________";
input string  DefaultTab          = "综";      // 默认打开TAB页
input int     Summary_DayCount    = 7;         // 综合中显示中DAY显示N天
input bool    Summary_ShowOpen    = true;      // 综合中显示多空汇总

// 各维度统计数量
input string  _sep7_              = "___________各维度统计数量___________";
input int     Day_Count           = 100;       // DAY统计N天
input bool    Day_ShowEmpty       = false;     // DAY无交易记录也是否显示
input int     Week_Count          = 200;       // WEEK统计N周
input bool    Week_ShowEmpty      = false;     // WEEK无交易记录也是否显示
input int     Month_Count         = 100;       // MONTH统计N个月
input bool    Month_ShowEmpty     = false;     // MONTH无交易记录也是否显示
input int     Quarter_Count       = 100;       // QUARTER统计N个季度
input bool    Quarter_ShowEmpty   = false;     // QUARTER无交易记录也是否显示
input int     Year_Count          = 20;        // YEAR统计N年
input bool    Year_ShowEmpty      = false;     // YEAR无交易记录也是否显示

// 路径颜色
input string  _sep8_              = "___________路径颜色___________";
input color   TrailColor_Buy      = clrRoyalBlue;    // 路径颜色_buy
input color   TrailColor_BuyAvg   = clrGoldenrod;    // 路径颜色_buy平仓箭头
input color   TrailColor_Sell     = clrRed;          // 路径颜色_sell开仓和线段
input color   TrailColor_SellAvg  = clrViolet;       // 路径颜色_sell平仓箭头
input color   TrailColor_Pending  = clrGray;         // 路径颜色_未成交的挂单

// 其他
input bool    UseSound            = false;     // 使用声音提示

//==========================================================================
// 全局变量
//==========================================================================

// 面板状态
int    g_panelX        = 0;
int    g_panelY        = 0;
bool   g_minimized     = false;
string g_currentTab    = "综";
datetime g_lastRefresh = 0;
int    g_chartW        = 0;
int    g_chartH        = 0;

// 面板拖拽状态
bool   g_dragging      = false;
int    g_dragOffsetX   = 0;
int    g_dragOffsetY   = 0;

// 当前选中的行（用于轨迹显示）
int    g_selectedRow   = -1;
string g_selectedPeriod = "";

// 对象名称前缀
string PREFIX = "TSP_";

// 面板尺寸
int PANEL_W    = 900;
int PANEL_H    = 400;
int TITLE_H    = 22;
int TAB_H      = 20;
int HEADER_H   = 18;
int ROW_H      = 16;
int CHART_H    = 120;
int BOTTOM_H   = 40;

// Tab列表
string TABS[] = {"综","日","周","月","季","年","币","M","备","账户","轨迹"};
int    TAB_COUNT = 11;

//==========================================================================
// 数据结构
//==========================================================================

// 单笔交易记录
struct TradeRecord
{
    int      ticket;
    string   symbol;
    int      type;       // 0=buy, 1=sell
    double   lots;
    datetime openTime;
    double   openPrice;
    datetime closeTime;
    double   closePrice;
    double   profit;
    double   commission;
    double   swap;
    double   stopLoss;
    double   takeProfit;
    int      magic;
    string   comment;
    double   maxProfit;  // 持仓期间最大浮盈
    double   maxLoss;    // 持仓期间最大浮亏
};

// 统计汇总结构
struct StatSummary
{
    string   label;          // 标签（日期/周/月等）
    double   totalLots;      // 总手数
    double   minLots;        // 最小手数
    double   maxLots;        // 最大手数
    int      count;          // 交易次数
    double   profit;         // 盈亏金额
    double   profitPct;      // 盈亏百分比
    double   commission;     // 手续费
    double   swap;           // 库存费
    double   deposit;        // 出入金（净）
    double   balance;        // 余额
    double   maxDD;          // 最大浮亏
    double   maxDDPct;       // 最大浮亏比例
    double   maxFloat;       // 最大浮盈
    double   maxFloatPct;    // 最大浮盈比例
    int      winCount;       // 盈利次数
    int      lossCount;      // 亏损次数
    double   totalWin;       // 总盈利
    double   totalLoss;      // 总亏损
    double   minHoldSec;     // 最小持仓时间(秒)
    double   avgHoldSec;     // 平均持仓时间(秒)
    double   maxHoldSec;     // 最大持仓时间(秒)
    double   winRate;        // 胜率
    double   profitFactor;   // 盈亏比
    bool     isOpen;         // 是否为持仓行
};

// 最大数组大小
#define MAX_TRADES    5000
#define MAX_STATS     500
#define MAX_CSV_ROWS  10000

// 全局交易数组
TradeRecord g_trades[];
int         g_tradeCount = 0;

// CSV已保存的交易（按ticket）
int         g_csvTickets[];
int         g_csvTicketCount = 0;

// 各维度统计结果
StatSummary g_dayStat[];
int         g_dayCount = 0;
StatSummary g_weekStat[];
int         g_weekCount = 0;
StatSummary g_monthStat[];
int         g_monthCount = 0;
StatSummary g_quarterStat[];
int         g_quarterCount = 0;
StatSummary g_yearStat[];
int         g_yearCount = 0;
StatSummary g_symbolStat[];
int         g_symbolCount = 0;
StatSummary g_magicStat[];
int         g_magicCount = 0;
StatSummary g_commentStat[];
int         g_commentCount = 0;

// 净值曲线数据
double g_equityCurve[];
datetime g_equityTime[];
int    g_equityCount = 0;

//==========================================================================
// 辅助函数：字符串分割
//==========================================================================
int StringSplit(string str, string sep, string &result[])
{
    int count = 0;
    string s = str;
    while(StringLen(s) > 0)
    {
        int pos = StringFind(s, sep);
        if(pos < 0)
        {
            if(StringLen(StringTrimLeft(StringTrimRight(s))) > 0)
            {
                ArrayResize(result, count+1);
                result[count] = StringTrimLeft(StringTrimRight(s));
                count++;
            }
            break;
        }
        string part = StringSubstr(s, 0, pos);
        if(StringLen(StringTrimLeft(StringTrimRight(part))) > 0)
        {
            ArrayResize(result, count+1);
            result[count] = StringTrimLeft(StringTrimRight(part));
            count++;
        }
        s = StringSubstr(s, pos + StringLen(sep));
    }
    return count;
}

//==========================================================================
// 辅助函数：检查过滤条件
//==========================================================================
bool PassFilter(string symbol, int magic, string comment, int orderType)
{
    // 品种过滤
    if(StringLen(FilterSymbols) > 0)
    {
        string syms[];
        int n = StringSplit(FilterSymbols, ",", syms);
        bool found = false;
        for(int i=0; i<n; i++)
            if(syms[i] == symbol) { found = true; break; }
        if(!found) return false;
    }
    // Magic过滤
    if(StringLen(FilterMagic) > 0)
    {
        string mags[];
        int n = StringSplit(FilterMagic, ",", mags);
        bool found = false;
        for(int i=0; i<n; i++)
            if(StrToInteger(mags[i]) == magic) { found = true; break; }
        if(!found) return false;
    }
    // 备注过滤
    if(StringLen(FilterComment) > 0)
        if(StringFind(comment, FilterComment) < 0) return false;
    // 订单类型过滤
    if(FilterOrderType == 1 && orderType != OP_BUY) return false;
    if(FilterOrderType == 2 && orderType != OP_SELL) return false;
    return true;
}

//==========================================================================
// 辅助函数：格式化时间为字符串
//==========================================================================
string FormatTime(double seconds)
{
    int s = (int)seconds;
    int h = s / 3600;
    int m = (s % 3600) / 60;
    int sec = s % 60;
    return StringFormat("%d:%02d:%02d", h, m, sec);
}

string FormatDate(datetime t)
{
    return TimeToStr(t, TIME_DATE);
}

string FormatDateTime(datetime t)
{
    return TimeToStr(t, TIME_DATE|TIME_MINUTES|TIME_SECONDS);
}

//==========================================================================
// 辅助函数：颜色值
//==========================================================================
color GetProfitColor(double val)
{
    if(val > 0) return ColorGreen;
    if(val < 0) return ColorRed;
    return ColorGray;
}

//==========================================================================
// CSV文件路径
//==========================================================================
string GetCSVPath()
{
    return TerminalPath() + "\\MQL4\\Files\\" + CSV_FileName;
}

//==========================================================================
// 初始化空的StatSummary
//==========================================================================
void InitStat(StatSummary &s)
{
    s.label        = "";
    s.totalLots    = 0;
    s.minLots      = 999999;
    s.maxLots      = 0;
    s.count        = 0;
    s.profit       = 0;
    s.profitPct    = 0;
    s.commission   = 0;
    s.swap         = 0;
    s.deposit      = 0;
    s.balance      = 0;
    s.maxDD        = 0;
    s.maxDDPct     = 0;
    s.maxFloat     = 0;
    s.maxFloatPct  = 0;
    s.winCount     = 0;
    s.lossCount    = 0;
    s.totalWin     = 0;
    s.totalLoss    = 0;
    s.minHoldSec   = 999999999;
    s.avgHoldSec   = 0;
    s.maxHoldSec   = 0;
    s.winRate      = 0;
    s.profitFactor = 0;
    s.isOpen       = false;
}

//==========================================================================
// 将一笔交易累加到统计结构
//==========================================================================
void AccumTrade(StatSummary &s, TradeRecord &t, double baseBalance)
{
    s.count++;
    s.totalLots += t.lots;
    if(t.lots < s.minLots) s.minLots = t.lots;
    if(t.lots > s.maxLots) s.maxLots = t.lots;
    s.profit     += t.profit;
    s.commission += t.commission;
    s.swap       += t.swap;

    if(t.profit > 0) { s.winCount++; s.totalWin += t.profit; }
    else if(t.profit < 0) { s.lossCount++; s.totalLoss += MathAbs(t.profit); }

    double holdSec = (double)(t.closeTime - t.openTime);
    if(holdSec < s.minHoldSec) s.minHoldSec = holdSec;
    if(holdSec > s.maxHoldSec) s.maxHoldSec = holdSec;
    s.avgHoldSec += holdSec;

    if(t.maxLoss < s.maxDD) s.maxDD = t.maxLoss;
    if(t.maxProfit > s.maxFloat) s.maxFloat = t.maxProfit;
}

//==========================================================================
// 完成统计结构计算（在所有交易累加后调用）
//==========================================================================
void FinalizeStat(StatSummary &s, double baseBalance)
{
    if(s.count > 0)
    {
        s.avgHoldSec /= s.count;
        s.winRate = (s.winCount + s.lossCount > 0) ?
            (double)s.winCount / (s.winCount + s.lossCount) * 100.0 : 0;
        s.profitFactor = (s.totalLoss > 0) ? s.totalWin / s.totalLoss : 0;
        if(s.minLots >= 999999) s.minLots = 0;
        if(s.minHoldSec >= 999999999) s.minHoldSec = 0;
    }
    if(baseBalance > 0)
    {
        s.profitPct = s.profit / baseBalance * 100.0;
        if(s.maxDD < 0) s.maxDDPct = s.maxDD / baseBalance * 100.0;
        if(s.maxFloat > 0) s.maxFloatPct = s.maxFloat / baseBalance * 100.0;
    }
}


//==========================================================================
// CSV 持久化：读取已保存的交易记录
//==========================================================================
void CSV_LoadHistory()
{
    g_tradeCount = 0;
    ArrayResize(g_trades, MAX_TRADES);
    g_csvTicketCount = 0;
    ArrayResize(g_csvTickets, MAX_CSV_ROWS);

    int fh = FileOpen(CSV_FileName, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh == INVALID_HANDLE) return;

    // 跳过表头
    if(!FileIsEnding(fh)) FileReadString(fh); // ticket
    if(!FileIsEnding(fh)) FileReadString(fh); // symbol
    if(!FileIsEnding(fh)) FileReadString(fh); // type
    if(!FileIsEnding(fh)) FileReadString(fh); // lots
    if(!FileIsEnding(fh)) FileReadString(fh); // openTime
    if(!FileIsEnding(fh)) FileReadString(fh); // openPrice
    if(!FileIsEnding(fh)) FileReadString(fh); // closeTime
    if(!FileIsEnding(fh)) FileReadString(fh); // closePrice
    if(!FileIsEnding(fh)) FileReadString(fh); // profit
    if(!FileIsEnding(fh)) FileReadString(fh); // commission
    if(!FileIsEnding(fh)) FileReadString(fh); // swap
    if(!FileIsEnding(fh)) FileReadString(fh); // stopLoss
    if(!FileIsEnding(fh)) FileReadString(fh); // takeProfit
    if(!FileIsEnding(fh)) FileReadString(fh); // magic
    if(!FileIsEnding(fh)) FileReadString(fh); // comment
    if(!FileIsEnding(fh)) FileReadString(fh); // maxProfit
    if(!FileIsEnding(fh)) FileReadString(fh); // maxLoss

    while(!FileIsEnding(fh) && g_tradeCount < MAX_TRADES)
    {
        string sTicket     = FileReadString(fh);
        if(FileIsEnding(fh) || StringLen(sTicket) == 0) break;
        string sSymbol     = FileReadString(fh);
        string sType       = FileReadString(fh);
        string sLots       = FileReadString(fh);
        string sOpenTime   = FileReadString(fh);
        string sOpenPrice  = FileReadString(fh);
        string sCloseTime  = FileReadString(fh);
        string sClosePrice = FileReadString(fh);
        string sProfit     = FileReadString(fh);
        string sComm       = FileReadString(fh);
        string sSwap       = FileReadString(fh);
        string sSL         = FileReadString(fh);
        string sTP         = FileReadString(fh);
        string sMagic      = FileReadString(fh);
        string sComment    = FileReadString(fh);
        string sMaxProfit  = FileReadString(fh);
        string sMaxLoss    = FileReadString(fh);

        TradeRecord tr;
        tr.ticket     = (int)StringToInteger(sTicket);
        tr.symbol     = sSymbol;
        tr.type       = (int)StringToInteger(sType);
        tr.lots       = StringToDouble(sLots);
        tr.openTime   = (datetime)StringToInteger(sOpenTime);
        tr.openPrice  = StringToDouble(sOpenPrice);
        tr.closeTime  = (datetime)StringToInteger(sCloseTime);
        tr.closePrice = StringToDouble(sClosePrice);
        tr.profit     = StringToDouble(sProfit);
        tr.commission = StringToDouble(sComm);
        tr.swap       = StringToDouble(sSwap);
        tr.stopLoss   = StringToDouble(sSL);
        tr.takeProfit = StringToDouble(sTP);
        tr.magic      = (int)StringToInteger(sMagic);
        tr.comment    = sComment;
        tr.maxProfit  = StringToDouble(sMaxProfit);
        tr.maxLoss    = StringToDouble(sMaxLoss);

        g_trades[g_tradeCount] = tr;
        g_tradeCount++;

        // 记录已保存的ticket
        g_csvTickets[g_csvTicketCount] = tr.ticket;
        g_csvTicketCount++;
    }
    FileClose(fh);
    Print("CSV加载完成，共", g_tradeCount, "条记录");
}

//==========================================================================
// 检查ticket是否已在CSV中
//==========================================================================
bool CSV_HasTicket(int ticket)
{
    for(int i=0; i<g_csvTicketCount; i++)
        if(g_csvTickets[i] == ticket) return true;
    return false;
}

//==========================================================================
// CSV 持久化：增量写入新的交易记录
// 写入 CSV_DaysBack 天前（及更早）已平仓的交易
//==========================================================================
void CSV_SaveIncremental()
{
    if(!CSV_AutoSave) return;

    datetime cutoff = TimeCurrent() - (datetime)(CSV_DaysBack * 86400);
    // 向前取到当天凌晨0点
    cutoff = cutoff - cutoff % 86400;

    // 检查是否有新记录需要写入
    bool hasNew = false;
    int total = OrdersHistoryTotal();
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        if(OrderType() != OP_BUY && OrderType() != OP_SELL) continue;
        if(OrderCloseTime() >= cutoff) continue;
        if(!PassFilter(OrderSymbol(), OrderMagicNumber(), OrderComment(), OrderType())) continue;
        if(!CSV_HasTicket(OrderTicket())) { hasNew = true; break; }
    }
    if(!hasNew) return;

    // 检查文件是否存在（用于判断是否需要写表头）
    bool fileExists = false;
    int fhCheck = FileOpen(CSV_FileName, FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fhCheck != INVALID_HANDLE) { fileExists = true; FileClose(fhCheck); }

    // 追加写入
    int fh = FileOpen(CSV_FileName, FILE_WRITE|FILE_READ|FILE_CSV|FILE_ANSI, ',');
    if(fh == INVALID_HANDLE)
    {
        Print("无法打开CSV文件写入: ", CSV_FileName);
        return;
    }

    // 如果文件不存在，写表头
    if(!fileExists)
    {
        FileWrite(fh,
            "ticket","symbol","type","lots",
            "openTime","openPrice","closeTime","closePrice",
            "profit","commission","swap","stopLoss","takeProfit",
            "magic","comment","maxProfit","maxLoss");
    }
    else
    {
        // 移到文件末尾
        FileSeek(fh, 0, SEEK_END);
    }

    int newCount = 0;
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        if(OrderType() != OP_BUY && OrderType() != OP_SELL) continue;
        if(OrderCloseTime() >= cutoff) continue;
        if(!PassFilter(OrderSymbol(), OrderMagicNumber(), OrderComment(), OrderType())) continue;
        if(CSV_HasTicket(OrderTicket())) continue;

        // 写入一行
        FileWrite(fh,
            IntegerToString(OrderTicket()),
            OrderSymbol(),
            IntegerToString(OrderType()),
            DoubleToString(OrderLots(), 2),
            IntegerToString((int)OrderOpenTime()),
            DoubleToString(OrderOpenPrice(), 5),
            IntegerToString((int)OrderCloseTime()),
            DoubleToString(OrderClosePrice(), 5),
            DoubleToString(OrderProfit(), 2),
            DoubleToString(OrderCommission(), 2),
            DoubleToString(OrderSwap(), 2),
            DoubleToString(OrderStopLoss(), 5),
            DoubleToString(OrderTakeProfit(), 5),
            IntegerToString(OrderMagicNumber()),
            OrderComment(),
            "0.00",  // maxProfit（无法从历史获取，填0）
            "0.00"   // maxLoss
        );

        // 同时加入内存数组
        if(g_tradeCount < MAX_TRADES)
        {
            TradeRecord tr;
            tr.ticket     = OrderTicket();
            tr.symbol     = OrderSymbol();
            tr.type       = OrderType();
            tr.lots       = OrderLots();
            tr.openTime   = OrderOpenTime();
            tr.openPrice  = OrderOpenPrice();
            tr.closeTime  = OrderCloseTime();
            tr.closePrice = OrderClosePrice();
            tr.profit     = OrderProfit();
            tr.commission = OrderCommission();
            tr.swap       = OrderSwap();
            tr.stopLoss   = OrderStopLoss();
            tr.takeProfit = OrderTakeProfit();
            tr.magic      = OrderMagicNumber();
            tr.comment    = OrderComment();
            tr.maxProfit  = 0;
            tr.maxLoss    = 0;
            g_trades[g_tradeCount] = tr;
            g_tradeCount++;
        }

        // 记录ticket
        if(g_csvTicketCount < MAX_CSV_ROWS)
        {
            g_csvTickets[g_csvTicketCount] = OrderTicket();
            g_csvTicketCount++;
        }
        newCount++;
    }
    FileClose(fh);
    if(newCount > 0)
        Print("CSV增量写入完成，新增", newCount, "条记录");
}

//==========================================================================
// 从MT4历史记录加载近期数据（CSV_DaysBack天内，不写CSV）
//==========================================================================
void LoadRecentFromMT4()
{
    datetime cutoff = TimeCurrent() - (datetime)(CSV_DaysBack * 86400);
    cutoff = cutoff - cutoff % 86400;

    int total = OrdersHistoryTotal();
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
        if(OrderType() != OP_BUY && OrderType() != OP_SELL) continue;
        if(OrderCloseTime() < cutoff) continue;
        if(!PassFilter(OrderSymbol(), OrderMagicNumber(), OrderComment(), OrderType())) continue;
        if(CSV_HasTicket(OrderTicket())) continue;
        if(g_tradeCount >= MAX_TRADES) break;

        TradeRecord tr;
        tr.ticket     = OrderTicket();
        tr.symbol     = OrderSymbol();
        tr.type       = OrderType();
        tr.lots       = OrderLots();
        tr.openTime   = OrderOpenTime();
        tr.openPrice  = OrderOpenPrice();
        tr.closeTime  = OrderCloseTime();
        tr.closePrice = OrderClosePrice();
        tr.profit     = OrderProfit();
        tr.commission = OrderCommission();
        tr.swap       = OrderSwap();
        tr.stopLoss   = OrderStopLoss();
        tr.takeProfit = OrderTakeProfit();
        tr.magic      = OrderMagicNumber();
        tr.comment    = OrderComment();
        tr.maxProfit  = 0;
        tr.maxLoss    = 0;
        g_trades[g_tradeCount] = tr;
        g_tradeCount++;
    }
}

//==========================================================================
// 加载持仓中的订单
//==========================================================================
void LoadOpenOrders()
{
    int total = OrdersTotal();
    for(int i=0; i<total; i++)
    {
        if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
        if(OrderType() != OP_BUY && OrderType() != OP_SELL) continue;
        if(!PassFilter(OrderSymbol(), OrderMagicNumber(), OrderComment(), OrderType())) continue;
        if(g_tradeCount >= MAX_TRADES) break;

        TradeRecord tr;
        tr.ticket     = OrderTicket();
        tr.symbol     = OrderSymbol();
        tr.type       = OrderType();
        tr.lots       = OrderLots();
        tr.openTime   = OrderOpenTime();
        tr.openPrice  = OrderOpenPrice();
        tr.closeTime  = 0;  // 未平仓
        tr.closePrice = 0;
        tr.profit     = OrderProfit();
        tr.commission = OrderCommission();
        tr.swap       = OrderSwap();
        tr.stopLoss   = OrderStopLoss();
        tr.takeProfit = OrderTakeProfit();
        tr.magic      = OrderMagicNumber();
        tr.comment    = OrderComment();
        tr.maxProfit  = 0;
        tr.maxLoss    = 0;
        g_trades[g_tradeCount] = tr;
        g_tradeCount++;
    }
}


//==========================================================================
// 统计计算：按日统计
//==========================================================================
void CalcDayStats()
{
    g_dayCount = 0;
    ArrayResize(g_dayStat, MAX_STATS);

    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    // 收集所有日期
    string dates[];
    int dateCount = 0;
    ArrayResize(dates, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue; // 跳过持仓
        string d = TimeToStr(g_trades[i].closeTime, TIME_DATE);
        bool found = false;
        for(int j=0; j<dateCount; j++)
            if(dates[j] == d) { found = true; break; }
        if(!found && dateCount < MAX_STATS)
        {
            dates[dateCount] = d;
            dateCount++;
        }
    }

    // 排序（简单冒泡，降序）
    for(int i=0; i<dateCount-1; i++)
        for(int j=i+1; j<dateCount; j++)
            if(dates[i] < dates[j]) { string tmp=dates[i]; dates[i]=dates[j]; dates[j]=tmp; }

    // 限制数量
    if(dateCount > Day_Count) dateCount = Day_Count;

    for(int di=0; di<dateCount; di++)
    {
        StatSummary s;
        InitStat(s);
        s.label = dates[di];

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            string d = TimeToStr(g_trades[i].closeTime, TIME_DATE);
            if(d != dates[di]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        if(s.count == 0 && !Day_ShowEmpty) continue;
        FinalizeStat(s, baseBalance);
        g_dayStat[g_dayCount] = s;
        g_dayCount++;
    }
}

//==========================================================================
// 统计计算：按周统计
//==========================================================================
string GetWeekLabel(datetime t)
{
    int dow = TimeDayOfWeek(t);
    if(dow == 0) dow = 7;
    datetime monday = t - (datetime)((dow-1)*86400);
    monday = monday - monday % 86400;
    datetime sunday = monday + (datetime)(6*86400);
    return TimeToStr(monday, TIME_DATE) + " ~ " + TimeToStr(sunday, TIME_DATE);
}

datetime GetWeekStart(datetime t)
{
    int dow = TimeDayOfWeek(t);
    if(dow == 0) dow = 7;
    datetime monday = t - (datetime)((dow-1)*86400);
    return monday - monday % 86400;
}

void CalcWeekStats()
{
    g_weekCount = 0;
    ArrayResize(g_weekStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    datetime weekStarts[];
    int wCount = 0;
    ArrayResize(weekStarts, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        datetime ws = GetWeekStart(g_trades[i].closeTime);
        bool found = false;
        for(int j=0; j<wCount; j++)
            if(weekStarts[j] == ws) { found = true; break; }
        if(!found && wCount < MAX_STATS)
        {
            weekStarts[wCount] = ws;
            wCount++;
        }
    }

    // 降序排序
    for(int i=0; i<wCount-1; i++)
        for(int j=i+1; j<wCount; j++)
            if(weekStarts[i] < weekStarts[j]) { datetime tmp=weekStarts[i]; weekStarts[i]=weekStarts[j]; weekStarts[j]=tmp; }

    if(wCount > Week_Count) wCount = Week_Count;

    for(int wi=0; wi<wCount; wi++)
    {
        StatSummary s;
        InitStat(s);
        s.label = GetWeekLabel(weekStarts[wi]);

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            datetime ws = GetWeekStart(g_trades[i].closeTime);
            if(ws != weekStarts[wi]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        if(s.count == 0 && !Week_ShowEmpty) continue;
        FinalizeStat(s, baseBalance);
        g_weekStat[g_weekCount] = s;
        g_weekCount++;
    }
}

//==========================================================================
// 统计计算：按月统计
//==========================================================================
string GetMonthLabel(datetime t)
{
    return StringFormat("%04d.%02d", TimeYear(t), TimeMonth(t));
}

datetime GetMonthStart(datetime t)
{
    // 计算当月第一天
    int y = TimeYear(t);
    int m = TimeMonth(t);
    // 从1970年计算到当月第一天的秒数
    // 简化：当前时间减去当月已过天数
    int d = TimeDay(t); // 1-based
    return t - (datetime)((d-1)*86400) - (t - (datetime)((d-1)*86400)) % 86400;
}

void CalcMonthStats()
{
    g_monthCount = 0;
    ArrayResize(g_monthStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    datetime monthStarts[];
    int mCount = 0;
    ArrayResize(monthStarts, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        datetime ms = GetMonthStart(g_trades[i].closeTime);
        bool found = false;
        for(int j=0; j<mCount; j++)
            if(monthStarts[j] == ms) { found = true; break; }
        if(!found && mCount < MAX_STATS)
        {
            monthStarts[mCount] = ms;
            mCount++;
        }
    }

    for(int i=0; i<mCount-1; i++)
        for(int j=i+1; j<mCount; j++)
            if(monthStarts[i] < monthStarts[j]) { datetime tmp=monthStarts[i]; monthStarts[i]=monthStarts[j]; monthStarts[j]=tmp; }

    if(mCount > Month_Count) mCount = Month_Count;

    for(int mi=0; mi<mCount; mi++)
    {
        StatSummary s;
        InitStat(s);
        s.label = GetMonthLabel(monthStarts[mi]);

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            datetime ms = GetMonthStart(g_trades[i].closeTime);
            if(ms != monthStarts[mi]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        if(s.count == 0 && !Month_ShowEmpty) continue;
        FinalizeStat(s, baseBalance);
        g_monthStat[g_monthCount] = s;
        g_monthCount++;
    }
}

//==========================================================================
// 统计计算：按季度统计
//==========================================================================
string GetQuarterLabel(datetime t)
{
    int y = TimeYear(t);
    int m = TimeMonth(t);
    int q = (m - 1) / 3 + 1;
    int qStartMon = (q-1)*3 + 1;
    int qEndMon   = q*3;
    return StringFormat("%04d.%02d ~ %04d.%02d", y, qStartMon, y, qEndMon);
}

// 返回季度标识符，用于分组比较
string GetQuarterKey(datetime t)
{
    int y = TimeYear(t);
    int m = TimeMonth(t);
    int q = (m - 1) / 3 + 1;
    return StringFormat("%04d_Q%d", y, q);
}

datetime GetQuarterStart(datetime t)
{
    int y = TimeYear(t);
    int m = TimeMonth(t);
    int qStartMon = ((m - 1) / 3) * 3 + 1;
    // 当月第一天
    datetime monthStart = GetMonthStart(t);
    // 往回调整到季度第一个月的第一天
    int monthDiff = m - qStartMon;
    if(monthDiff == 0) return monthStart;
    // 逐月往前调整
    datetime result = monthStart;
    for(int i=0; i<monthDiff; i++)
    {
        // 往前调一天到上个月
        result = result - (datetime)(86400);
        result = GetMonthStart(result);
    }
    return result;
}

void CalcQuarterStats()
{
    g_quarterCount = 0;
    ArrayResize(g_quarterStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    // 用字符串key分组，避免日期运算误差
    string qKeys[];
    datetime qRepTime[]; // 每个季度的代表时间
    int qCount = 0;
    ArrayResize(qKeys, MAX_STATS);
    ArrayResize(qRepTime, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        string qk = GetQuarterKey(g_trades[i].closeTime);
        bool found = false;
        for(int j=0; j<qCount; j++)
            if(qKeys[j] == qk) { found = true; break; }
        if(!found && qCount < MAX_STATS)
        {
            qKeys[qCount] = qk;
            qRepTime[qCount] = g_trades[i].closeTime;
            qCount++;
        }
    }

    // 降序排序（按key字符串降序）
    for(int i=0; i<qCount-1; i++)
        for(int j=i+1; j<qCount; j++)
            if(qKeys[i] < qKeys[j])
            {
                string tmpk = qKeys[i]; qKeys[i] = qKeys[j]; qKeys[j] = tmpk;
                datetime tmpt = qRepTime[i]; qRepTime[i] = qRepTime[j]; qRepTime[j] = tmpt;
            }

    if(qCount > Quarter_Count) qCount = Quarter_Count;

    for(int qi=0; qi<qCount; qi++)
    {
        StatSummary s;
        InitStat(s);
        s.label = GetQuarterLabel(qRepTime[qi]);

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            string qk = GetQuarterKey(g_trades[i].closeTime);
            if(qk != qKeys[qi]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        if(s.count == 0 && !Quarter_ShowEmpty) continue;
        FinalizeStat(s, baseBalance);
        g_quarterStat[g_quarterCount] = s;
        g_quarterCount++;
    }
}

//==========================================================================
// 统计计算：按年统计
//==========================================================================
string GetYearLabel(datetime t)
{
    return StringFormat("%04d", TimeYear(t));
}

datetime GetYearStart(datetime t)
{
    // 先得到当月第一天，再往前逐月调整到当1月
    int m = TimeMonth(t);
    datetime result = GetMonthStart(t);
    // 往前调整 m-1 个月
    for(int i=1; i<m; i++)
    {
        result = result - (datetime)(86400);
        result = GetMonthStart(result);
    }
    return result;
}

void CalcYearStats()
{
    g_yearCount = 0;
    ArrayResize(g_yearStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    datetime yStarts[];
    int yCount = 0;
    ArrayResize(yStarts, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        datetime ys = GetYearStart(g_trades[i].closeTime);
        bool found = false;
        for(int j=0; j<yCount; j++)
            if(yStarts[j] == ys) { found = true; break; }
        if(!found && yCount < MAX_STATS)
        {
            yStarts[yCount] = ys;
            yCount++;
        }
    }

    for(int i=0; i<yCount-1; i++)
        for(int j=i+1; j<yCount; j++)
            if(yStarts[i] < yStarts[j]) { datetime tmp=yStarts[i]; yStarts[i]=yStarts[j]; yStarts[j]=tmp; }

    if(yCount > Year_Count) yCount = Year_Count;

    for(int yi=0; yi<yCount; yi++)
    {
        StatSummary s;
        InitStat(s);
        s.label = GetYearLabel(yStarts[yi]);

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].closeTime == 0) continue;
            datetime ys = GetYearStart(g_trades[i].closeTime);
            if(ys != yStarts[yi]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        if(s.count == 0 && !Year_ShowEmpty) continue;
        FinalizeStat(s, baseBalance);
        g_yearStat[g_yearCount] = s;
        g_yearCount++;
    }
}

//==========================================================================
// 统计计算：按品种统计
//==========================================================================
void CalcSymbolStats()
{
    g_symbolCount = 0;
    ArrayResize(g_symbolStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    string symbols[];
    int sCount = 0;
    ArrayResize(symbols, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        bool found = false;
        for(int j=0; j<sCount; j++)
            if(symbols[j] == g_trades[i].symbol) { found = true; break; }
        if(!found && sCount < MAX_STATS)
        {
            symbols[sCount] = g_trades[i].symbol;
            sCount++;
        }
    }

    for(int si=0; si<sCount; si++)
    {
        StatSummary s;
        InitStat(s);
        s.label = symbols[si];

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].symbol != symbols[si]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        FinalizeStat(s, baseBalance);
        g_symbolStat[g_symbolCount] = s;
        g_symbolCount++;
    }
}

//==========================================================================
// 统计计算：按Magic统计
//==========================================================================
void CalcMagicStats()
{
    g_magicCount = 0;
    ArrayResize(g_magicStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    int magics[];
    int mCount = 0;
    ArrayResize(magics, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        bool found = false;
        for(int j=0; j<mCount; j++)
            if(magics[j] == g_trades[i].magic) { found = true; break; }
        if(!found && mCount < MAX_STATS)
        {
            magics[mCount] = g_trades[i].magic;
            mCount++;
        }
    }

    for(int mi=0; mi<mCount; mi++)
    {
        StatSummary s;
        InitStat(s);
        s.label = IntegerToString(magics[mi]);

        for(int i=0; i<g_tradeCount; i++)
        {
            if(g_trades[i].magic != magics[mi]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        FinalizeStat(s, baseBalance);
        g_magicStat[g_magicCount] = s;
        g_magicCount++;
    }
}

//==========================================================================
// 统计计算：按备注统计
//==========================================================================
void CalcCommentStats()
{
    g_commentCount = 0;
    ArrayResize(g_commentStat, MAX_STATS);
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    string comments[];
    int cCount = 0;
    ArrayResize(comments, MAX_STATS);

    for(int i=0; i<g_tradeCount; i++)
    {
        // 取备注前20字符作为分组键
        string c = StringSubstr(g_trades[i].comment, 0, 20);
        if(StringLen(c) == 0) c = "(无备注)";
        bool found = false;
        for(int j=0; j<cCount; j++)
            if(comments[j] == c) { found = true; break; }
        if(!found && cCount < MAX_STATS)
        {
            comments[cCount] = c;
            cCount++;
        }
    }

    for(int ci=0; ci<cCount; ci++)
    {
        StatSummary s;
        InitStat(s);
        s.label = comments[ci];

        for(int i=0; i<g_tradeCount; i++)
        {
            string c = StringSubstr(g_trades[i].comment, 0, 20);
            if(StringLen(c) == 0) c = "(无备注)";
            if(c != comments[ci]) continue;
            AccumTrade(s, g_trades[i], baseBalance);
        }

        FinalizeStat(s, baseBalance);
        g_commentStat[g_commentCount] = s;
        g_commentCount++;
    }
}

//==========================================================================
// 计算净值曲线
//==========================================================================
void CalcEquityCurve()
{
    g_equityCount = 0;
    ArrayResize(g_equityCurve, MAX_TRADES + 10);
    ArrayResize(g_equityTime, MAX_TRADES + 10);

    // 按平仓时间排序交易（简单插入排序）
    int idx[];
    ArrayResize(idx, g_tradeCount);
    for(int i=0; i<g_tradeCount; i++) idx[i] = i;
    for(int i=0; i<g_tradeCount-1; i++)
        for(int j=i+1; j<g_tradeCount; j++)
        {
            datetime ti = (g_trades[idx[i]].closeTime > 0) ? g_trades[idx[i]].closeTime : g_trades[idx[i]].openTime;
            datetime tj = (g_trades[idx[j]].closeTime > 0) ? g_trades[idx[j]].closeTime : g_trades[idx[j]].openTime;
            if(ti > tj) { int tmp=idx[i]; idx[i]=idx[j]; idx[j]=tmp; }
        }

    // 获取初始余额（从账户历史中找最早的入金记录，简化为当前余额减去所有盈亏）
    double totalProfit = 0;
    for(int i=0; i<g_tradeCount; i++)
        totalProfit += g_trades[i].profit + g_trades[i].commission + g_trades[i].swap;

    double startBalance = AccountBalance() - totalProfit;
    if(startBalance <= 0) startBalance = AccountBalance();

    double runningBalance = startBalance;
    for(int i=0; i<g_tradeCount; i++)
    {
        int ti = idx[i];
        if(g_trades[ti].closeTime == 0) continue; // 跳过持仓
        runningBalance += g_trades[ti].profit + g_trades[ti].commission + g_trades[ti].swap;
        g_equityCurve[g_equityCount] = runningBalance;
        g_equityTime[g_equityCount]  = g_trades[ti].closeTime;
        g_equityCount++;
    }
}

//==========================================================================
// 执行所有统计计算
//==========================================================================
void CalcAllStats()
{
    CalcDayStats();
    CalcWeekStats();
    CalcMonthStats();
    CalcQuarterStats();
    CalcYearStats();
    CalcSymbolStats();
    CalcMagicStats();
    CalcCommentStats();
    CalcEquityCurve();
}


//==========================================================================
// UI 绘制辅助函数
//==========================================================================

// 删除所有指标对象
void DeleteAllObjects()
{
    int total = ObjectsTotal();
    for(int i=total-1; i>=0; i--)
    {
        string name = ObjectName(i);
        if(StringFind(name, PREFIX) == 0)
            ObjectDelete(name);
    }
}

// 创建矩形背景
void CreateRect(string name, int x, int y, int w, int h, color clr, int border=0, color borderClr=clrNONE)
{
    string n = PREFIX + name;
    if(ObjectFind(n) < 0)
        ObjectCreate(0, n, OBJ_RECTANGLE_LABEL, 0, 0, 0);
    ObjectSetInteger(0, n, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, n, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, n, OBJPROP_XSIZE, w);
    ObjectSetInteger(0, n, OBJPROP_YSIZE, h);
    ObjectSetInteger(0, n, OBJPROP_BGCOLOR, clr);
    ObjectSetInteger(0, n, OBJPROP_BORDER_TYPE, BORDER_FLAT);
    ObjectSetInteger(0, n, OBJPROP_COLOR, (borderClr != clrNONE) ? borderClr : clr);
    ObjectSetInteger(0, n, OBJPROP_WIDTH, border);
    ObjectSetInteger(0, n, OBJPROP_BACK, false);
    ObjectSetInteger(0, n, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, n, OBJPROP_SELECTED, false);
    ObjectSetInteger(0, n, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, n, OBJPROP_CORNER, CORNER_LEFT_UPPER);
}

// 创建文本标签
void CreateLabel(string name, int x, int y, string text, color clr, int fontSize=0, string anchor="left")
{
    string n = PREFIX + name;
    if(ObjectFind(n) < 0)
        ObjectCreate(0, n, OBJ_LABEL, 0, 0, 0);
    ObjectSetInteger(0, n, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, n, OBJPROP_YDISTANCE, y);
    ObjectSetString(0, n, OBJPROP_TEXT, text);
    ObjectSetInteger(0, n, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, n, OBJPROP_FONTSIZE, (fontSize > 0) ? fontSize : FontSize);
    ObjectSetString(0, n, OBJPROP_FONT, "Arial");
    ObjectSetInteger(0, n, OBJPROP_BACK, false);
    ObjectSetInteger(0, n, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, n, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, n, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    if(anchor == "right")
        ObjectSetInteger(0, n, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
    else
        ObjectSetInteger(0, n, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
}

// 创建可点击按钮
void CreateButton(string name, int x, int y, int w, int h, string text, color bgClr, color textClr, int fontSize=0)
{
    string n = PREFIX + name;
    if(ObjectFind(n) < 0)
        ObjectCreate(0, n, OBJ_BUTTON, 0, 0, 0);
    ObjectSetInteger(0, n, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, n, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, n, OBJPROP_XSIZE, w);
    ObjectSetInteger(0, n, OBJPROP_YSIZE, h);
    ObjectSetString(0, n, OBJPROP_TEXT, text);
    ObjectSetInteger(0, n, OBJPROP_BGCOLOR, bgClr);
    ObjectSetInteger(0, n, OBJPROP_COLOR, textClr);
    ObjectSetInteger(0, n, OBJPROP_FONTSIZE, (fontSize > 0) ? fontSize : FontSize);
    ObjectSetString(0, n, OBJPROP_FONT, "Arial");
    ObjectSetInteger(0, n, OBJPROP_BACK, false);
    ObjectSetInteger(0, n, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, n, OBJPROP_HIDDEN, true);
    ObjectSetInteger(0, n, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, n, OBJPROP_STATE, false);
}

//==========================================================================
// 计算面板宽度（根据显示列）
//==========================================================================
// 列宽定义
int ColW_Label    = 120;
int ColW_Lots     = 60;
int ColW_MaxLots  = 70;
int ColW_Count    = 45;
int ColW_Profit   = 75;
int ColW_ProfitPct= 65;
int ColW_Comm     = 65;
int ColW_Swap     = 65;
int ColW_Deposit  = 80;
int ColW_Balance  = 80;
int ColW_MaxDD    = 75;
int ColW_MaxDDPct = 75;
int ColW_MaxFloat = 75;
int ColW_MaxFloatPct = 75;
int ColW_HoldTime = 150;
int ColW_WinRate  = 65;
int ColW_PF       = 55;

int GetTotalPanelWidth()
{
    int w = ColW_Label;
    if(Show_Lots)        w += ColW_Lots;
    if(Show_MaxLots)     w += ColW_MaxLots;
    if(Show_Count)       w += ColW_Count;
    if(Show_Profit)      w += ColW_Profit;
    if(Show_ProfitPct)   w += ColW_ProfitPct;
    if(Show_Commission)  w += ColW_Comm;
    if(Show_Swap)        w += ColW_Swap;
    if(Show_Deposit)     w += ColW_Deposit;
    if(Show_Balance)     w += ColW_Balance;
    if(Show_MaxDD)       w += ColW_MaxDD;
    if(Show_MaxDDPct)    w += ColW_MaxDDPct;
    if(Show_MaxFloat)    w += ColW_MaxFloat;
    if(Show_MaxFloatPct) w += ColW_MaxFloatPct;
    if(Show_HoldTime)    w += ColW_HoldTime;
    if(Show_WinRate)     w += ColW_WinRate;
    if(Show_ProfitFactor)w += ColW_PF;
    return w + 10;
}

//==========================================================================
// 绘制表头
//==========================================================================
void DrawTableHeader(int x, int y, int panelW, string labelTitle)
{
    int cx = x + 2;
    CreateRect("hdr_bg", x, y, panelW, HEADER_H, ColorHeader);

    CreateLabel("hdr_label", cx, y+2, labelTitle, ColorGray);
    cx += ColW_Label;

    if(Show_Lots)        { CreateLabel("hdr_lots",    cx, y+2, "总手数",    ColorGray); cx += ColW_Lots; }
    if(Show_MaxLots)     { CreateLabel("hdr_maxlots", cx, y+2, "最小大手数", ColorGray); cx += ColW_MaxLots; }
    if(Show_Count)       { CreateLabel("hdr_count",   cx, y+2, "次数",      ColorGray); cx += ColW_Count; }
    if(Show_Profit)      { CreateLabel("hdr_profit",  cx, y+2, "盈亏金额",  ColorGray); cx += ColW_Profit; }
    if(Show_ProfitPct)   { CreateLabel("hdr_pct",     cx, y+2, "百分比%",   ColorGray); cx += ColW_ProfitPct; }
    if(Show_Commission)  { CreateLabel("hdr_comm",    cx, y+2, "手续费",    ColorGray); cx += ColW_Comm; }
    if(Show_Swap)        { CreateLabel("hdr_swap",    cx, y+2, "库存费",    ColorGray); cx += ColW_Swap; }
    if(Show_Deposit)     { CreateLabel("hdr_dep",     cx, y+2, "出入金",    ColorGray); cx += ColW_Deposit; }
    if(Show_Balance)     { CreateLabel("hdr_bal",     cx, y+2, "余额",      ColorGray); cx += ColW_Balance; }
    if(Show_MaxDD)       { CreateLabel("hdr_maxdd",   cx, y+2, "最大浮亏",  ColorGray); cx += ColW_MaxDD; }
    if(Show_MaxDDPct)    { CreateLabel("hdr_maxddpct",cx, y+2, "最大浮亏比例", ColorGray); cx += ColW_MaxDDPct; }
    if(Show_MaxFloat)    { CreateLabel("hdr_maxfl",   cx, y+2, "最大浮盈金额", ColorGray); cx += ColW_MaxFloat; }
    if(Show_MaxFloatPct) { CreateLabel("hdr_maxflpct",cx, y+2, "最大浮盈比例", ColorGray); cx += ColW_MaxFloatPct; }
    if(Show_HoldTime)    { CreateLabel("hdr_hold",    cx, y+2, "最小平均最大持仓时间", ColorGray); cx += ColW_HoldTime; }
    if(Show_WinRate)     { CreateLabel("hdr_win",     cx, y+2, "胜率",      ColorGray); cx += ColW_WinRate; }
    if(Show_ProfitFactor){ CreateLabel("hdr_pf",      cx, y+2, "盈亏比",    ColorGray); cx += ColW_PF; }
}

//==========================================================================
// 绘制一行统计数据
//==========================================================================
void DrawStatRow(string rowId, int x, int y, int panelW, StatSummary &s, bool isOdd, bool isTotal)
{
    color rowBg = isOdd ? ColorRowOdd : ColorRowEven;
    if(isTotal) rowBg = ColorHeader;
    CreateRect("row_bg_" + rowId, x, y, panelW, ROW_H, rowBg);

    int cx = x + 2;
    color labelClr = isTotal ? ColorGray : (s.isOpen ? clrYellow : ColorGray);
    CreateLabel("row_lbl_" + rowId, cx, y+1, s.label, labelClr);
    cx += ColW_Label;

    color pclr = GetProfitColor(s.profit);

    if(Show_Lots)
    {
        string lotsStr = DoubleToString(s.totalLots, 2);
        CreateLabel("row_lots_" + rowId, cx, y+1, lotsStr, ColorGreen);
        cx += ColW_Lots;
    }
    if(Show_MaxLots)
    {
        string maxLotsStr = DoubleToString(s.minLots, 2) + "|" + DoubleToString(s.maxLots, 2);
        CreateLabel("row_maxlots_" + rowId, cx, y+1, maxLotsStr, ColorGray);
        cx += ColW_MaxLots;
    }
    if(Show_Count)
    {
        CreateLabel("row_cnt_" + rowId, cx, y+1, IntegerToString(s.count), ColorGray);
        cx += ColW_Count;
    }
    if(Show_Profit)
    {
        CreateLabel("row_pft_" + rowId, cx, y+1, DoubleToString(s.profit, 2), pclr);
        cx += ColW_Profit;
    }
    if(Show_ProfitPct)
    {
        string pctStr = DoubleToString(s.profitPct, 2) + " %";
        CreateLabel("row_pct_" + rowId, cx, y+1, pctStr, pclr);
        cx += ColW_ProfitPct;
    }
    if(Show_Commission)
    {
        CreateLabel("row_comm_" + rowId, cx, y+1, DoubleToString(s.commission, 2), ColorRed);
        cx += ColW_Comm;
    }
    if(Show_Swap)
    {
        CreateLabel("row_swap_" + rowId, cx, y+1, DoubleToString(s.swap, 2), ColorRed);
        cx += ColW_Swap;
    }
    if(Show_Deposit)
    {
        CreateLabel("row_dep_" + rowId, cx, y+1, DoubleToString(s.deposit, 2), ColorGray);
        cx += ColW_Deposit;
    }
    if(Show_Balance)
    {
        CreateLabel("row_bal_" + rowId, cx, y+1, DoubleToString(s.balance, 2), ColorGray);
        cx += ColW_Balance;
    }
    if(Show_MaxDD)
    {
        CreateLabel("row_mdd_" + rowId, cx, y+1, DoubleToString(s.maxDD, 2), ColorRed);
        cx += ColW_MaxDD;
    }
    if(Show_MaxDDPct)
    {
        string mddpStr = DoubleToString(s.maxDDPct, 2) + " %";
        CreateLabel("row_mddp_" + rowId, cx, y+1, mddpStr, ColorRed);
        cx += ColW_MaxDDPct;
    }
    if(Show_MaxFloat)
    {
        CreateLabel("row_mfl_" + rowId, cx, y+1, DoubleToString(s.maxFloat, 2), ColorGreen);
        cx += ColW_MaxFloat;
    }
    if(Show_MaxFloatPct)
    {
        string mflpStr = DoubleToString(s.maxFloatPct, 2) + " %";
        CreateLabel("row_mflp_" + rowId, cx, y+1, mflpStr, ColorGreen);
        cx += ColW_MaxFloatPct;
    }
    if(Show_HoldTime)
    {
        string holdStr = FormatTime(s.minHoldSec) + "|" + FormatTime(s.avgHoldSec) + "|" + FormatTime(s.maxHoldSec);
        CreateLabel("row_hold_" + rowId, cx, y+1, holdStr, ColorGray);
        cx += ColW_HoldTime;
    }
    if(Show_WinRate)
    {
        string wrStr = DoubleToString(s.winRate, 2) + " %";
        CreateLabel("row_wr_" + rowId, cx, y+1, wrStr, ColorGreen);
        cx += ColW_WinRate;
    }
    if(Show_ProfitFactor)
    {
        CreateLabel("row_pf_" + rowId, cx, y+1, DoubleToString(s.profitFactor, 2), ColorGreen);
        cx += ColW_PF;
    }
}

//==========================================================================
// 绘制净值曲线（像素坐标系，在面板内部绘制）
//==========================================================================
void DrawEquityCurve(int panelX, int panelY, int panelW)
{
    // 删除旧曲线对象
    int total = ObjectsTotal();
    for(int i=total-1; i>=0; i--)
    {
        string name = ObjectName(i);
        if(StringFind(name, PREFIX + "eq_") == 0)
            ObjectDelete(name);
    }

    if(g_equityCount < 2) return;

    // 找最大最小値
    double maxVal = g_equityCurve[0];
    double minVal = g_equityCurve[0];
    for(int i=1; i<g_equityCount; i++)
    {
        if(g_equityCurve[i] > maxVal) maxVal = g_equityCurve[i];
        if(g_equityCurve[i] < minVal) minVal = g_equityCurve[i];
    }
    if(maxVal == minVal) { maxVal += 1; minVal -= 1; }
    double valRange = maxVal - minVal;

    // 图表区域像素范围
    int chartAreaX = panelX;
    int chartAreaY = panelY + TITLE_H + TAB_H;
    int chartAreaW = panelW;
    int chartAreaH = CHART_H;
    int margin = 5;
    int drawW = chartAreaW - margin * 2;
    int drawH = chartAreaH - margin * 2;

    // 将数据点映射到像素坐标
    int px[];
    int py2[];
    ArrayResize(px, g_equityCount);
    ArrayResize(py2, g_equityCount);

    for(int i=0; i<g_equityCount; i++)
    {
        // X坐标：按时间线性分布
        px[i] = chartAreaX + margin + (int)((double)i / (double)(g_equityCount - 1) * drawW);
        // Y坐标：高值在上，低値在下
        double ratio = (g_equityCurve[i] - minVal) / valRange;
        py2[i] = chartAreaY + margin + drawH - (int)(ratio * drawH);
    }

    // 用细矩形模拟线段（每两个相邻点之间画一条线）
    for(int i=0; i<g_equityCount-1; i++)
    {
        int x1 = px[i],  y1 = py2[i];
        int x2 = px[i+1], y2 = py2[i+1];

        // 用小矩形模拟线段：将线段分解为水平和垂直分量
        string sname = PREFIX + "eq_seg_" + IntegerToString(i);

        int dx = x2 - x1;
        int dy = y2 - y1;
        int steps = MathMax(MathAbs(dx), MathAbs(dy));
        if(steps <= 0) steps = 1;

        // 简化：只绘制水平线段（将线段用一个矩形表示）
        // 使用 OBJ_RECTANGLE_LABEL 画一个细矩形表示线段
        // 对于斜线，用多个小点近似
        int numDots = MathMax(MathAbs(dx), 1);
        for(int d=0; d<numDots; d++)
        {
            int dotX = x1 + (int)((double)d / numDots * dx);
            int dotY = y1 + (int)((double)d / numDots * dy);
            string dname = PREFIX + "eq_dot_" + IntegerToString(i) + "_" + IntegerToString(d);
            if(ObjectFind(dname) < 0)
                ObjectCreate(0, dname, OBJ_RECTANGLE_LABEL, 0, 0, 0);
            ObjectSetInteger(0, dname, OBJPROP_XDISTANCE, dotX);
            ObjectSetInteger(0, dname, OBJPROP_YDISTANCE, dotY);
            ObjectSetInteger(0, dname, OBJPROP_XSIZE, 2);
            ObjectSetInteger(0, dname, OBJPROP_YSIZE, 2);
            ObjectSetInteger(0, dname, OBJPROP_BGCOLOR, ColorEquityLine);
            ObjectSetInteger(0, dname, OBJPROP_BORDER_TYPE, BORDER_FLAT);
            ObjectSetInteger(0, dname, OBJPROP_COLOR, ColorEquityLine);
            ObjectSetInteger(0, dname, OBJPROP_BACK, false);
            ObjectSetInteger(0, dname, OBJPROP_SELECTABLE, false);
            ObjectSetInteger(0, dname, OBJPROP_HIDDEN, true);
            ObjectSetInteger(0, dname, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        }
    }

    // 在曲线两端显示日期标注
    if(g_equityCount >= 2)
    {
        string lname = PREFIX + "eq_lbl_left";
        if(ObjectFind(lname) < 0) ObjectCreate(0, lname, OBJ_LABEL, 0, 0, 0);
        ObjectSetInteger(0, lname, OBJPROP_XDISTANCE, chartAreaX + margin);
        ObjectSetInteger(0, lname, OBJPROP_YDISTANCE, chartAreaY + chartAreaH - FontSize - 2);
        ObjectSetString(0, lname, OBJPROP_TEXT, TimeToStr(g_equityTime[0], TIME_DATE));
        ObjectSetInteger(0, lname, OBJPROP_COLOR, ColorDimGray);
        ObjectSetInteger(0, lname, OBJPROP_FONTSIZE, FontSize - 1);
        ObjectSetString(0, lname, OBJPROP_FONT, "Arial");
        ObjectSetInteger(0, lname, OBJPROP_BACK, false);
        ObjectSetInteger(0, lname, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, lname, OBJPROP_HIDDEN, true);
        ObjectSetInteger(0, lname, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, lname, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);

        string rname = PREFIX + "eq_lbl_right";
        if(ObjectFind(rname) < 0) ObjectCreate(0, rname, OBJ_LABEL, 0, 0, 0);
        ObjectSetInteger(0, rname, OBJPROP_XDISTANCE, chartAreaX + chartAreaW - margin);
        ObjectSetInteger(0, rname, OBJPROP_YDISTANCE, chartAreaY + chartAreaH - FontSize - 2);
        ObjectSetString(0, rname, OBJPROP_TEXT, TimeToStr(g_equityTime[g_equityCount-1], TIME_DATE));
        ObjectSetInteger(0, rname, OBJPROP_COLOR, ColorDimGray);
        ObjectSetInteger(0, rname, OBJPROP_FONTSIZE, FontSize - 1);
        ObjectSetString(0, rname, OBJPROP_FONT, "Arial");
        ObjectSetInteger(0, rname, OBJPROP_BACK, false);
        ObjectSetInteger(0, rname, OBJPROP_SELECTABLE, false);
        ObjectSetInteger(0, rname, OBJPROP_HIDDEN, true);
        ObjectSetInteger(0, rname, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, rname, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
    }
}


//==========================================================================
// 绘制综合视图（综 TAB）
//==========================================================================
void DrawSummaryTab(int px, int py, int panelW)
{
    int y = py + TITLE_H + TAB_H + CHART_H;
    int x = px;

    // 计算综合统计（持仓+最近N天）
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    // 持仓行
    StatSummary openStat;
    InitStat(openStat);
    openStat.label = "持仓";
    openStat.isOpen = true;
    double openProfit = 0;
    double openLots = 0;
    int openBuyCount = 0, openSellCount = 0;
    double openBuyLots = 0, openSellLots = 0;

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime != 0) continue;
        openStat.count++;
        openStat.totalLots += g_trades[i].lots;
        if(g_trades[i].lots < openStat.minLots) openStat.minLots = g_trades[i].lots;
        if(g_trades[i].lots > openStat.maxLots) openStat.maxLots = g_trades[i].lots;
        openStat.profit     += g_trades[i].profit;
        openStat.commission += g_trades[i].commission;
        openStat.swap       += g_trades[i].swap;
        if(g_trades[i].type == OP_BUY)  { openBuyCount++;  openBuyLots  += g_trades[i].lots; }
        else                             { openSellCount++; openSellLots += g_trades[i].lots; }
    }
    if(openStat.minLots >= 999999) openStat.minLots = 0;
    openStat.profitPct = openStat.profit / baseBalance * 100.0;
    openStat.balance   = AccountEquity();

    DrawTableHeader(x, y, panelW, "持仓");
    y += HEADER_H;

    DrawStatRow("open", x, y, panelW, openStat, true, false);
    y += ROW_H;

    // 最近N天
    int showDays = MathMin(Summary_DayCount, g_dayCount);
    for(int di=0; di<showDays; di++)
    {
        bool odd = (di % 2 == 0);
        DrawStatRow("sum_d" + IntegerToString(di), x, y, panelW, g_dayStat[di], odd, false);
        y += ROW_H;
    }

    // 本周/本月/本季/本年盈亏汇总行

    // 本周
    StatSummary weekSum; InitStat(weekSum); weekSum.label = "本周盈亏";
    datetime weekStart = GetWeekStart(TimeCurrent());
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        if(g_trades[i].closeTime < weekStart) continue;
        AccumTrade(weekSum, g_trades[i], baseBalance);
    }
    FinalizeStat(weekSum, baseBalance);
    DrawStatRow("sum_week", x, y, panelW, weekSum, true, false);
    y += ROW_H;

    // 本月
    StatSummary monthSum; InitStat(monthSum); monthSum.label = "本月盈亏";
    datetime monthStart = GetMonthStart(TimeCurrent());
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        if(g_trades[i].closeTime < monthStart) continue;
        AccumTrade(monthSum, g_trades[i], baseBalance);
    }
    FinalizeStat(monthSum, baseBalance);
    DrawStatRow("sum_month", x, y, panelW, monthSum, false, false);
    y += ROW_H;

    // 本季
    StatSummary qSum; InitStat(qSum); qSum.label = "本季盈亏";
    datetime qStart = GetQuarterStart(TimeCurrent());
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        if(g_trades[i].closeTime < qStart) continue;
        AccumTrade(qSum, g_trades[i], baseBalance);
    }
    FinalizeStat(qSum, baseBalance);
    DrawStatRow("sum_q", x, y, panelW, qSum, true, false);
    y += ROW_H;

    // 本年
    StatSummary ySum; InitStat(ySum); ySum.label = "本年盈亏";
    datetime yStart = GetYearStart(TimeCurrent());
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        if(g_trades[i].closeTime < yStart) continue;
        AccumTrade(ySum, g_trades[i], baseBalance);
    }
    FinalizeStat(ySum, baseBalance);
    DrawStatRow("sum_y", x, y, panelW, ySum, false, false);
    y += ROW_H;

    // 账户持仓汇总
    if(Summary_ShowOpen)
    {
        y += 4;
        CreateLabel("sum_magic", x+2, y, "账户持仓汇总，Magic=" + FilterMagic, ColorGray);
        y += ROW_H;
        CreateLabel("sum_buy", x+2, y,
            "多单Buy  单数: " + IntegerToString(openBuyCount) +
            "  手数: " + DoubleToString(openBuyLots, 2) +
            "  盈亏: " + DoubleToString(openStat.profit, 2), ColorGreen);
        y += ROW_H;
        CreateLabel("sum_sell", x+2, y,
            "空单Sell  单数: " + IntegerToString(openSellCount) +
            "  手数: " + DoubleToString(openSellLots, 2), ColorRed);
        y += ROW_H;
    }
}

//==========================================================================
// 绘制时间维度视图（日/周/月/季/年）
//==========================================================================
void DrawTimeTab(int px, int py, int panelW, string tab)
{
    int y = py + TITLE_H + TAB_H + CHART_H;
    int x = px;

    int count = 0;
    string headerLabel = "";

    StatSummary openStat; InitStat(openStat);
    openStat.label = "持仓"; openStat.isOpen = true;
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;

    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime != 0) continue;
        openStat.count++;
        openStat.totalLots += g_trades[i].lots;
        if(g_trades[i].lots < openStat.minLots) openStat.minLots = g_trades[i].lots;
        if(g_trades[i].lots > openStat.maxLots) openStat.maxLots = g_trades[i].lots;
        openStat.profit     += g_trades[i].profit;
        openStat.commission += g_trades[i].commission;
        openStat.swap       += g_trades[i].swap;
    }
    if(openStat.minLots >= 999999) openStat.minLots = 0;
    openStat.profitPct = openStat.profit / baseBalance * 100.0;
    openStat.balance   = AccountEquity();

    if(tab == "日")      { count = g_dayCount;     headerLabel = "日期"; }
    else if(tab == "周") { count = g_weekCount;    headerLabel = "周"; }
    else if(tab == "月") { count = g_monthCount;   headerLabel = "月份"; }
    else if(tab == "季") { count = g_quarterCount; headerLabel = "季度"; }
    else if(tab == "年") { count = g_yearCount;    headerLabel = "年份"; }

    DrawTableHeader(x, y, panelW, headerLabel);
    y += HEADER_H;

    // 持仓行
    DrawStatRow("tt_open", x, y, panelW, openStat, true, false);
    y += ROW_H;

    // 各期数据
    for(int i=0; i<count; i++)
    {
        bool odd = (i % 2 == 0);
        StatSummary rowStat;
        if(tab == "日")      rowStat = g_dayStat[i];
        else if(tab == "周") rowStat = g_weekStat[i];
        else if(tab == "月") rowStat = g_monthStat[i];
        else if(tab == "季") rowStat = g_quarterStat[i];
        else                 rowStat = g_yearStat[i];
        DrawStatRow("tt_" + IntegerToString(i), x, y, panelW, rowStat, odd, false);
        y += ROW_H;
    }

    // 合计行
    StatSummary totalStat; InitStat(totalStat); totalStat.label = "合计";
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        AccumTrade(totalStat, g_trades[i], baseBalance);
    }
    FinalizeStat(totalStat, baseBalance);
    totalStat.balance = AccountBalance();
    DrawStatRow("tt_total", x, y, panelW, totalStat, false, true);
}

//==========================================================================
// 绘制品种/Magic/备注视图
//==========================================================================
void DrawGroupTab(int px, int py, int panelW, string tab)
{
    int y = py + TITLE_H + TAB_H + CHART_H;
    int x = px;

    int count = 0;
    string headerLabel = "";

    if(tab == "币")      { count = g_symbolCount;  headerLabel = "品种"; }
    else if(tab == "M")  { count = g_magicCount;   headerLabel = "Magic"; }
    else if(tab == "备") { count = g_commentCount; headerLabel = "备注"; }

    // 表头（品种视图列略有不同，简化处理）
    DrawTableHeader(x, y, panelW, headerLabel);
    y += HEADER_H;

    for(int i=0; i<count; i++)
    {
        bool odd = (i % 2 == 0);
        StatSummary rowStat;
        if(tab == "币")      rowStat = g_symbolStat[i];
        else if(tab == "M")  rowStat = g_magicStat[i];
        else                 rowStat = g_commentStat[i];
        DrawStatRow("grp_" + IntegerToString(i), x, y, panelW, rowStat, odd, false);
        y += ROW_H;
    }

    // 合计行
    double baseBalance = AccountBalance();
    if(baseBalance <= 0) baseBalance = 1;
    StatSummary totalStat; InitStat(totalStat); totalStat.label = "合计";
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        AccumTrade(totalStat, g_trades[i], baseBalance);
    }
    FinalizeStat(totalStat, baseBalance);
    DrawStatRow("grp_total", x, y, panelW, totalStat, false, true);
}

//==========================================================================
// 绘制账户信息视图
//==========================================================================
void DrawAccountTab(int px, int py, int panelW)
{
    int y = py + TITLE_H + TAB_H + CHART_H;
    int x = px + 5;
    int lineH = 18;
    int col2x = x + 300;

    color lc = ColorGray;
    color vc = ColorGreen;

    CreateLabel("acc_path_lbl",  x, y, "MT4路径=", lc);
    CreateLabel("acc_path_val",  x+80, y, TerminalPath(), vc);
    y += lineH;

    CreateLabel("acc_id_lbl",    x, y, "账户ID=", lc);
    CreateLabel("acc_id_val",    x+80, y, IntegerToString(AccountNumber()), vc);
    CreateLabel("acc_broker_lbl",col2x, y, "经纪商=", lc);
    CreateLabel("acc_broker_val",col2x+80, y, AccountCompany(), vc);
    y += lineH;

    CreateLabel("acc_lev_lbl",   x, y, "账户杠杆=", lc);
    CreateLabel("acc_lev_val",   x+80, y, "1:" + IntegerToString(AccountLeverage()), vc);
    CreateLabel("acc_type_lbl",  col2x, y, "账户类型=", lc);
    string accType = IsDemo() ? "模拟" : "真实";
    CreateLabel("acc_type_val",  col2x+80, y, accType, vc);
    y += lineH;

    CreateLabel("acc_minlot_lbl",x, y, "最小手数=", lc);
    CreateLabel("acc_minlot_val",x+80, y, DoubleToString(MarketInfo(Symbol(), MODE_MINLOT), 2), vc);
    CreateLabel("acc_maxord_lbl",col2x, y, "最大可开单数量=", lc);
    CreateLabel("acc_maxord_val",col2x+120, y, "200 个", vc);
    y += lineH;

    CreateLabel("acc_maxlot_lbl",x, y, "最大手数=", lc);
    CreateLabel("acc_maxlot_val",x+80, y, DoubleToString(MarketInfo(Symbol(), MODE_MAXLOT), 2), vc);
    y += lineH;

    CreateLabel("acc_marg_lbl",  x, y, "强平比例=", lc);
    double marginSO = AccountStopoutLevel();
    CreateLabel("acc_marg_val",  x+80, y, DoubleToString(marginSO, 0) + " % （最低 预付款比例 = 净值/已用保证金，低于此比例会被强平）", vc);
    y += lineH;

    CreateLabel("acc_free_lbl",  x, y, "余额=", lc);
    CreateLabel("acc_free_val",  x+80, y, DoubleToString(AccountBalance(), 2), vc);
    CreateLabel("acc_equity_lbl",col2x, y, "净值=", lc);
    CreateLabel("acc_equity_val",col2x+80, y, DoubleToString(AccountEquity(), 2), vc);
    y += lineH;

    CreateLabel("acc_margin_lbl",x, y, "已用保证金=", lc);
    CreateLabel("acc_margin_val",x+80, y, DoubleToString(AccountMargin(), 2), vc);
    CreateLabel("acc_fmarg_lbl", col2x, y, "可用保证金=", lc);
    CreateLabel("acc_fmarg_val", col2x+80, y, DoubleToString(AccountFreeMargin(), 2), vc);
    y += lineH;

    CreateLabel("acc_cur_lbl",   x, y, "结算货币=", lc);
    CreateLabel("acc_cur_val",   x+80, y, AccountCurrency() + " (美元)", vc);
    CreateLabel("acc_time_lbl",  col2x, y, "本地时间=", lc);
    CreateLabel("acc_time_val",  col2x+80, y, TimeToStr(TimeLocal(), TIME_DATE|TIME_MINUTES|TIME_SECONDS), vc);
    y += lineH;

    CreateLabel("acc_ecn_lbl",   x, y, "是否ECN=", lc);
    // ACCOUNT_TRADE_EXEMODE: 0=instant, 1=request, 2=market, 3=exchange
    // MQL4 does not have a direct ECN check, use AccountStopoutMode as proxy
    string isECN = (AccountStopoutMode() == 0) ? "Yes（每手手续费=6）" : "No";
    CreateLabel("acc_ecn_val",   x+80, y, isECN, vc);
    y += lineH * 2;

    // 当前品种信息
    CreateLabel("acc_sym_hdr",   x, y, "[" + Symbol() + "]", ColorGreen, FontSize+1);
    y += lineH;

    CreateLabel("acc_margin2_lbl",x, y, "手保证金=", lc);
    CreateLabel("acc_margin2_val",x+80, y, DoubleToString(MarketInfo(Symbol(), MODE_MARGINREQUIRED), 2), vc);
    CreateLabel("acc_pts_lbl",   col2x, y, "点差=", lc);
    CreateLabel("acc_pts_val",   col2x+80, y, IntegerToString((int)(MarketInfo(Symbol(), MODE_SPREAD))) + " 点（以价格计=" + DoubleToString(MarketInfo(Symbol(), MODE_SPREAD)*Point, Digits) + "）", vc);
    y += lineH;

    CreateLabel("acc_point_lbl", x, y, "Point=", lc);
    CreateLabel("acc_point_val", x+80, y, DoubleToString(Point, Digits), vc);
    y += lineH;

    CreateLabel("acc_openlot_lbl",x, y, "可开手数=", lc);
    double freeMarg = AccountFreeMargin();
    double margReq  = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
    double maxLotsByMarg = (margReq > 0) ? freeMarg / margReq : 0;
    CreateLabel("acc_openlot_val",x+80, y, DoubleToString(maxLotsByMarg, 2), vc);
    y += lineH;

    CreateLabel("acc_sl_lbl",    x, y, "最小止损间距=", lc);
    CreateLabel("acc_sl_val",    x+80, y, IntegerToString((int)MarketInfo(Symbol(), MODE_STOPLEVEL)) + " 点 (STOPLEVEL)", vc);
    y += lineH;

    CreateLabel("acc_tickval_lbl",x, y, "手均震动额=", lc);
    double tickVal = MarketInfo(Symbol(), MODE_TICKVALUE);
    double tickSize = MarketInfo(Symbol(), MODE_TICKSIZE);
    double lotSize  = MarketInfo(Symbol(), MODE_LOTSIZE);
    CreateLabel("acc_tickval_val",x+80, y, DoubleToString(tickVal * lotSize / tickSize, 2) + " USD", vc);
    y += lineH;

    CreateLabel("acc_cost_lbl",  x, y, "成本占比=", lc);
    double spread = MarketInfo(Symbol(), MODE_SPREAD) * Point;
    double costPct = (Ask > 0) ? spread / Ask * 100.0 : 0;
    CreateLabel("acc_cost_val",  x+80, y, DoubleToString(costPct, 2) + "% (" + IntegerToString((int)MarketInfo(Symbol(), MODE_SPREAD)) + ")", vc);
}

//==========================================================================
// 绘制轨迹视图
//==========================================================================
void DrawTrailTab(int px, int py, int panelW)
{
    int y = py + TITLE_H + TAB_H + CHART_H;
    int x = px + 5;

    CreateLabel("trail_info", x, y, "轨迹功能：点击日/周/月/季/年视图中的行可在图表上显示该期间的交易路径", ColorGray);
    y += ROW_H * 2;

    if(g_selectedRow < 0)
    {
        CreateLabel("trail_hint", x, y, "请在其他标签页点击某行以查看轨迹", ColorDimGray);
        return;
    }

    // 显示选中期间的所有交易路径
    CreateLabel("trail_period", x, y, "当前显示期间: " + g_selectedPeriod, ColorGreen);
    y += ROW_H;

    // 绘制轨迹（在图表上标注开平仓点）
    int trailIdx = 0;
    for(int i=0; i<g_tradeCount; i++)
    {
        if(g_trades[i].closeTime == 0) continue;
        string d = "";
        if(g_currentTab == "日") d = TimeToStr(g_trades[i].closeTime, TIME_DATE);
        else if(g_currentTab == "周") d = GetWeekLabel(g_trades[i].closeTime);
        else if(g_currentTab == "月") d = GetMonthLabel(g_trades[i].closeTime);
        else if(g_currentTab == "季") d = GetQuarterLabel(g_trades[i].closeTime);
        else if(g_currentTab == "年") d = GetYearLabel(g_trades[i].closeTime);

        if(d != g_selectedPeriod) continue;

        // 开仓箭头
        string openName = PREFIX + "trail_open_" + IntegerToString(trailIdx);
        if(ObjectFind(openName) < 0)
            ObjectCreate(0, openName, OBJ_ARROW, 0, g_trades[i].openTime, g_trades[i].openPrice);
        ObjectSetInteger(0, openName, OBJPROP_TIME1, g_trades[i].openTime);
        ObjectSetDouble(0, openName, OBJPROP_PRICE1, g_trades[i].openPrice);
        ObjectSetInteger(0, openName, OBJPROP_ARROWCODE, (g_trades[i].type == OP_BUY) ? 233 : 234);
        ObjectSetInteger(0, openName, OBJPROP_COLOR, (g_trades[i].type == OP_BUY) ? TrailColor_Buy : TrailColor_Sell);
        ObjectSetInteger(0, openName, OBJPROP_WIDTH, 2);
        ObjectSetInteger(0, openName, OBJPROP_BACK, false);
        ObjectSetInteger(0, openName, OBJPROP_SELECTABLE, false);

        // 平仓箭头
        if(g_trades[i].closeTime > 0)
        {
            string closeName = PREFIX + "trail_close_" + IntegerToString(trailIdx);
            if(ObjectFind(closeName) < 0)
                ObjectCreate(0, closeName, OBJ_ARROW, 0, g_trades[i].closeTime, g_trades[i].closePrice);
            ObjectSetInteger(0, closeName, OBJPROP_TIME1, g_trades[i].closeTime);
            ObjectSetDouble(0, closeName, OBJPROP_PRICE1, g_trades[i].closePrice);
            ObjectSetInteger(0, closeName, OBJPROP_ARROWCODE, (g_trades[i].type == OP_BUY) ? 234 : 233);
            ObjectSetInteger(0, closeName, OBJPROP_COLOR, (g_trades[i].type == OP_BUY) ? TrailColor_BuyAvg : TrailColor_SellAvg);
            ObjectSetInteger(0, closeName, OBJPROP_WIDTH, 2);
            ObjectSetInteger(0, closeName, OBJPROP_BACK, false);
            ObjectSetInteger(0, closeName, OBJPROP_SELECTABLE, false);

            // 连线
            string lineName = PREFIX + "trail_line_" + IntegerToString(trailIdx);
            if(ObjectFind(lineName) < 0)
                ObjectCreate(0, lineName, OBJ_TREND, 0, g_trades[i].openTime, g_trades[i].openPrice, g_trades[i].closeTime, g_trades[i].closePrice);
            ObjectSetInteger(0, lineName, OBJPROP_TIME1, g_trades[i].openTime);
            ObjectSetDouble(0, lineName, OBJPROP_PRICE1, g_trades[i].openPrice);
            ObjectSetInteger(0, lineName, OBJPROP_TIME2, g_trades[i].closeTime);
            ObjectSetDouble(0, lineName, OBJPROP_PRICE2, g_trades[i].closePrice);
            ObjectSetInteger(0, lineName, OBJPROP_COLOR, (g_trades[i].type == OP_BUY) ? TrailColor_Buy : TrailColor_Sell);
            ObjectSetInteger(0, lineName, OBJPROP_WIDTH, 1);
            ObjectSetInteger(0, lineName, OBJPROP_STYLE, STYLE_DOT);
            ObjectSetInteger(0, lineName, OBJPROP_BACK, true);
            ObjectSetInteger(0, lineName, OBJPROP_SELECTABLE, false);
            ObjectSetInteger(0, lineName, OBJPROP_RAY_RIGHT, false);
            ObjectSetInteger(0, lineName, OBJPROP_RAY_LEFT, false);
        }
        trailIdx++;
    }
    CreateLabel("trail_count", x, y, "共显示 " + IntegerToString(trailIdx) + " 笔交易路径", ColorGray);
}

//==========================================================================
// 主绘制函数
//==========================================================================
void DrawPanel()
{
    DeleteAllObjects();

    int panelW = GetTotalPanelWidth();
    if(panelW < 400) panelW = 400;
    PANEL_W = panelW;

    int px = g_panelX;
    int py = g_panelY;

    // 计算面板高度
    int contentRows = 0;
    if(g_currentTab == "综")      contentRows = 3 + MathMin(Summary_DayCount, g_dayCount) + 4 + (Summary_ShowOpen ? 3 : 0);
    else if(g_currentTab == "日") contentRows = 2 + g_dayCount + 1;
    else if(g_currentTab == "周") contentRows = 2 + g_weekCount + 1;
    else if(g_currentTab == "月") contentRows = 2 + g_monthCount + 1;
    else if(g_currentTab == "季") contentRows = 2 + g_quarterCount + 1;
    else if(g_currentTab == "年") contentRows = 2 + g_yearCount + 1;
    else if(g_currentTab == "币") contentRows = 2 + g_symbolCount + 1;
    else if(g_currentTab == "M")  contentRows = 2 + g_magicCount + 1;
    else if(g_currentTab == "备") contentRows = 2 + g_commentCount + 1;
    else if(g_currentTab == "账户") contentRows = 20;
    else if(g_currentTab == "轨迹") contentRows = 5;

    int tableH = HEADER_H + contentRows * ROW_H + 10;
    if(tableH < 60) tableH = 60;

    int totalH = TITLE_H + TAB_H + CHART_H + tableH;
    PANEL_H = totalH;

    // 主背景
    CreateRect("bg_main", px, py, panelW, totalH, ColorBG, 1, ColorBorder);

    // 标题栏
    CreateRect("bg_title", px, py, panelW, TITLE_H, ColorHeader);

    // 左侧按钮：折叠按钮（+/-）和移动按钮（⊕）
    int btnSize = TITLE_H - 4;
    // 折叠按钮（第一个）
    CreateButton("btn_min", px + 2, py + 2, btnSize, btnSize, g_minimized ? "+" : "-", C'40,40,60', ColorGray, FontSize+2);
    // 移动按钮（第二个）
    CreateButton("btn_move", px + 2 + btnSize + 2, py + 2, btnSize, btnSize, "+", C'40,40,60', ColorGray, FontSize+2);

    // 标题文字（在按钮右边）
    int titleX = px + 2 + (btnSize + 2) * 2 + 4;
    string titleText = CustomTitle + "，M=" + FilterMagic;
    CreateLabel("lbl_title", titleX, py+3, titleText, ColorGreen, FontSize+1);

    // 右上角链接
    CreateLabel("lbl_link", px + panelW - 5, py+3, "外汇智能指标  https://fxznzb.com/", ColorGray, FontSize);

    if(g_minimized) return;

    // TAB栏
    int tabX = px;
    int tabW = 32;
    for(int i=0; i<TAB_COUNT; i++)
    {
        bool isActive = (TABS[i] == g_currentTab);
        color tabBg = isActive ? C'40,60,80' : ColorHeader;
        color tabFg = isActive ? ColorGreen : ColorGray;
        CreateButton("tab_" + TABS[i], tabX, py + TITLE_H, tabW, TAB_H, TABS[i], tabBg, tabFg, FontSize);
        tabX += tabW + 1;
    }

    // 图表区域背景
    CreateRect("bg_chart", px, py + TITLE_H + TAB_H, panelW, CHART_H, C'10,10,20', 1, ColorBorder);

    // 绘制净值曲线（使用图表对象）
    DrawEquityCurve(px, py, panelW);

    // 内容区域背景
    CreateRect("bg_content", px, py + TITLE_H + TAB_H + CHART_H, panelW, tableH, ColorBG);

    // 根据当前TAB绘制内容
    if(g_currentTab == "综")
        DrawSummaryTab(px, py, panelW);
    else if(g_currentTab == "日" || g_currentTab == "周" || g_currentTab == "月" ||
            g_currentTab == "季" || g_currentTab == "年")
        DrawTimeTab(px, py, panelW, g_currentTab);
    else if(g_currentTab == "币" || g_currentTab == "M" || g_currentTab == "备")
        DrawGroupTab(px, py, panelW, g_currentTab);
    else if(g_currentTab == "账户")
        DrawAccountTab(px, py, panelW);
    else if(g_currentTab == "轨迹")
        DrawTrailTab(px, py, panelW);

    ChartRedraw();
}


//==========================================================================
// 全量刷新数据并重绘
//==========================================================================
void RefreshAll()
{
    // 1. 先从CSV加载历史数据
    CSV_LoadHistory();

    // 2. 增量写入新的历史数据到CSV
    CSV_SaveIncremental();

    // 3. 加载近期（CSV_DaysBack天内）MT4历史数据（不写CSV）
    LoadRecentFromMT4();

    // 4. 加载当前持仓
    LoadOpenOrders();

    // 5. 计算所有统计
    CalcAllStats();

    // 6. 重绘面板
    DrawPanel();

    g_lastRefresh = TimeCurrent();
}

//==========================================================================
// OnInit
//==========================================================================
int OnInit()
{
    // 设置指标缓冲区
    SetIndexBuffer(0, DummyBuffer);
    SetIndexStyle(0, DRAW_NONE);
    SetIndexLabel(0, NULL);

    // 初始化面板位置
    g_panelX = PanelStartX;
    g_panelY = PanelStartY;
    g_minimized = ForceMinimize;
    g_currentTab = DefaultTab;

    // 验证DefaultTab
    bool validTab = false;
    for(int i=0; i<TAB_COUNT; i++)
        if(TABS[i] == g_currentTab) { validTab = true; break; }
    if(!validTab) g_currentTab = "综";

    // 开启鼠标移动事件
    ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, 1);

    // 首次刷新
    RefreshAll();

    // 设置定时器
    EventSetTimer(RefreshMinutes * 60);

    return(INIT_SUCCEEDED);
}

//==========================================================================
// OnDeinit
//==========================================================================
void OnDeinit(const int reason)
{
    EventKillTimer();
    DeleteAllObjects();

    // 删除轨迹对象
    int total = ObjectsTotal();
    for(int i=total-1; i>=0; i--)
    {
        string name = ObjectName(i);
        if(StringFind(name, PREFIX) == 0)
            ObjectDelete(name);
    }
    ChartRedraw();
}

//==========================================================================
// OnCalculate
//==========================================================================
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
    // 检查是否需要刷新（定时刷新）
    if(TimeCurrent() - g_lastRefresh >= RefreshMinutes * 60)
        RefreshAll();

    return(rates_total);
}

//==========================================================================
// OnTimer
//==========================================================================
void OnTimer()
{
    RefreshAll();
}

//==========================================================================
// OnChartEvent - 处理鼠标点击事件
//==========================================================================
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    // 按钮点击事件
    if(id == CHARTEVENT_OBJECT_CLICK)
    {
        string objName = sparam;

        // 最小化按钮
        if(objName == PREFIX + "btn_min")
        {
            g_minimized = !g_minimized;
            ObjectSetInteger(0, objName, OBJPROP_STATE, false);
            DrawPanel();
            return;
        }

        // 移动按钮：开始拖拽
        if(objName == PREFIX + "btn_move")
        {
            // 获取当前鼠标位置（通过ChartGetInteger获取最后鼠标位置）
            int mouseX = (int)ChartGetInteger(0, CHART_MOUSE_X);
            int mouseY = (int)ChartGetInteger(0, CHART_MOUSE_Y);
            g_dragging = true;
            g_dragOffsetX = mouseX - g_panelX;
            g_dragOffsetY = mouseY - g_panelY;
            ObjectSetInteger(0, objName, OBJPROP_STATE, false);
            return;
        }

        // TAB切换
        for(int i=0; i<TAB_COUNT; i++)
        {
            if(objName == PREFIX + "tab_" + TABS[i])
            {
                g_currentTab = TABS[i];
                ObjectSetInteger(0, objName, OBJPROP_STATE, false);
                DrawPanel();
                return;
            }
        }
    }

    // 鼠标移动事件（拖拽面板）
    if(id == CHARTEVENT_MOUSE_MOVE)
    {
        int mouseX = (int)lparam;
        int mouseY = (int)dparam;
        int mouseBtn = (int)StringToInteger(sparam);

        if(g_dragging)
        {
            // 左键松开则停止拖拽
            if((mouseBtn & 1) == 0)
            {
                g_dragging = false;
                // 重置移动按钮状态
                string btnName = PREFIX + "btn_move";
                if(ObjectFind(btnName) >= 0)
                    ObjectSetInteger(0, btnName, OBJPROP_STATE, false);
            }
            else
            {
                // 更新面板位置
                int newX = mouseX - g_dragOffsetX;
                int newY = mouseY - g_dragOffsetY;
                if(newX < 0) newX = 0;
                if(newY < 0) newY = 0;
                g_panelX = newX;
                g_panelY = newY;
                DrawPanel();
            }
        }
    }

}

//==========================================================================
// END OF INDICATOR
//==========================================================================
