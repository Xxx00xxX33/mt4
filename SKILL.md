---
name: mql4-manual
description: MetaQuotes Language 4 (MQL4) programming reference for MetaTrader 4 automated trading
globs:
  - "**/*.mq4"
  - "**/*.mqh"
  - "**/*.ex4"
---

# MQL4 Programming Reference Manual

## Overview

This skill provides comprehensive knowledge about MetaQuotes Language 4 (MQL4), the programming language for developing trading strategies and indicators on the MetaTrader 4 platform.

## Source

- **Document**: MQL4 Quick Reference Manual
- **Platform**: MetaTrader 4
- **Topics**: MQL4 programming, Expert Advisors, custom indicators, trading automation

## Key Topics

### Data Types
- Integer (int), Boolean (bool), Literals (char)
- String (string), Floating-point (double)
- Color (color), Datetime (datetime)

### Functions Categories
- **Account Information**: AccountBalance(), AccountEquity(), AccountProfit()
- **Array Functions**: ArraySize(), ArrayCopy(), ArraySort()
- **Common Functions**: Alert(), Comment(), Print()
- **Conversion Functions**: CharToStr(), DoubleToStr(), TimeToStr()
- **Date & Time Functions**: Day(), Hour(), Minute(), TimeCurrent()
- **File Functions**: FileOpen(), FileWrite(), FileClose()
- **Math & Trig**: MathAbs(), MathSqrt(), MathPow()
- **Object Functions**: ObjectCreate(), ObjectDelete(), ObjectSet()
- **String Functions**: StringLen(), StringSubstr(), StringFind()
- **Technical Indicators**: iMA(), iRSI(), iMACD(), iBands()
- **Trading Functions**: OrderSend(), OrderClose(), OrderModify()
- **Window Functions**: WindowHandle(), WindowRedraw()

### Pre-defined Variables
- Ask, Bid - current prices
- Bars - number of bars
- Point - point value
- Digits - decimal places

### Standard Constants
- Order types: OP_BUY, OP_SELL, OP_BUYLIMIT, OP_SELLLIMIT
- Timeframes: PERIOD_M1, PERIOD_H1, PERIOD_D1
- Drawing styles: STYLE_SOLID, STYLE_DASH

## Section Index

1. Variables
2. Data types
3. Data types overview
4. Operations of relation
5. Operations of relation
6. Operators
7. Operators connected with a default label are executed if non
8. Functions
9. Variables
10. Account Information
11. Array Functions
12. Common functions
13. Conversion functions
14. Custom Indicator functions
15. Date & Time functions
16. File functions
17. Global Variables functions
18. Math & Trig
19. Object functions
20. Pre-defined Variables
21. Standard Constants
22. String functions
23. Technical Indicator calls
24. Trading functions
25. Window functions


## Usage Examples

### Basic Expert Advisor Structure
```mql4
//+------------------------------------------------------------------+
//| Expert initialization function                                     |
//+------------------------------------------------------------------+
int init()
{
    // Initialization code
    return(0);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                   |
//+------------------------------------------------------------------+
int deinit()
{
    // Cleanup code
    return(0);
}

//+------------------------------------------------------------------+
//| Expert start function                                              |
//+------------------------------------------------------------------+
int start()
{
    // Main trading logic
    return(0);
}
```

### Opening a Market Order
```mql4
int ticket = OrderSend(
    Symbol(),           // symbol
    OP_BUY,            // order type
    0.1,               // lot size
    Ask,               // price
    3,                 // slippage
    Ask - 50*Point,    // stop loss
    Ask + 100*Point,   // take profit
    "My EA",           // comment
    12345,             // magic number
    0,                 // expiration
    Green              // arrow color
);

if(ticket < 0)
{
    Print("OrderSend failed: ", GetLastError());
}
```

### Using Technical Indicators
```mql4
double ma_fast = iMA(NULL, 0, 10, 0, MODE_SMA, PRICE_CLOSE, 0);
double ma_slow = iMA(NULL, 0, 20, 0, MODE_SMA, PRICE_CLOSE, 0);
double rsi = iRSI(NULL, 0, 14, PRICE_CLOSE, 0);

if(ma_fast > ma_slow && rsi < 70)
{
    // Buy signal
}
```

### Account Information
```mql4
double balance = AccountBalance();
double equity = AccountEquity();
double margin = AccountMargin();
double freeMargin = AccountFreeMargin();

Print("Balance: ", balance, " Equity: ", equity);
```

## Best Practices

1. **Always check for errors** after trading operations using GetLastError()
2. **Use magic numbers** to identify orders from your EA
3. **Implement proper money management** with lot sizing
4. **Test thoroughly** in strategy tester before live trading
5. **Handle requotes and slippage** gracefully
6. **Use comments** to identify orders and track performance

## Differences from MQL5

- MQL4 uses `init()`, `deinit()`, `start()` vs MQL5's `OnInit()`, `OnDeinit()`, `OnTick()`
- MQL4 has simpler order handling (OrderSend) vs MQL5's trade request structure
- MQL4 indicators return values directly vs MQL5's buffer copying

## References

See the `references/` directory for detailed function documentation.
