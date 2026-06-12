# Trading functions

Page: 89

---

Trading functions
HistoryTotal()
OrderClose()
OrderCloseBy()
OrderClosePrice()
OrderCloseTime()
OrderComment()
OrderCommission()
OrderDelete()
OrderExpiration()
OrderLots()
OrderMagicNumber()
OrderModify()
OrderOpenPrice()
OrderOpenTime()
OrderPrint()
OrderProfit()
OrderSelect()
OrderSend()
OrderStopLoss()

OrdersTotal()
OrderSwap()
OrderSymbol()
OrderTakeProfit()
OrderTicket()
OrderType()
int HistoryTotal()
Returns the number of closed orders in the account history loaded into the terminal. To get the detailed error information, call 
GetLastError() function. 
Sample
  // retrieving info from trade history
  int i,hstTotal=HistoryTotal();
  for(i=0;i<hstTotal;i++)
    {
     //---- check selection result
     if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
       {
        Print("Access to history failed with error (",GetLastError(),")");
        break;
       }
     // some work with order
    }
bool 
OrderClose(
int ticket, double lots, double price, int slippage, 
color Color=CLR_NONE)
Closes opened order. If the function succeeds, the return value is true. If the function fails, the return value is false. To get the 
detailed error information, call GetLastError(). 
Parameters
ticket
  -  Unique number of the order ticket.
lots
  -  Number of lots.
price
  -  Preferred closing price.
slippage   -  Value of the maximum price slippage in points.
Color
  -  Color of the closing arrow on the chart.If the parameter is absent or has CLR_NONE value closing arrow will not be drawn on 
the chart.
Sample
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)>75)
    {
     OrderClose(order_id,1,Ask,3,Red);
     return(0);
    }
bool OrderCloseBy(int ticket, int opposite, color Color=CLR_NONE)
Closes opened order by another opposite opened order. If the function succeeds, the return value is true. If the function fails, the 
return value is false. To get the detailed error information, call GetLastError(). 
Parameters
ticket
  -  Unique number of the order ticket.
opposite   -  Unique number of the opposite order ticket.
Color
  -  Color of the closing arrow on the chart.If the parameter is absent or has CLR_NONE value closing arrow will not be drawn on 
the chart.
Sample
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)>75)
    {

     OrderCloseBy(order_id,opposite_id);
     return(0);
    }
double OrderClosePrice()
Returns
 
close
 
price
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(ticket,SELECT_BY_POS)==true)
    Print("Close price for the order ",ticket," = ",OrderClosePrice());
  else
    Print("OrderSelect failed error code is",GetLastError());
datetime OrderCloseTime()
Returns close time for the currently selected order. If order close time is not 0 then the order selected and has been closed and 
retrieved
 
from
 
the
 
account
 
history.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10,SELECT_BY_POS,MODE_HISTORY)==true)
    {
     datetime ctm=OrderOpenTime();
     if(ctm>0) Print("Open time for the order 10 ", ctm);
     ctm=OrderCloseTime();
     if(ctm>0) Print("Close time for the order 10 ", ctm);
    }
  else
    Print("OrderSelect failed error code is",GetLastError());
string OrderComment()
Returns
 
comment
 
for
 
the
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  string comment;
  if(OrderSelect(10,SELECT_BY_TICKET)==false)
    {
     Print("OrderSelect failed error code is",GetLastError());
     return(0);
    }
  comment = OrderComment();
  // ...
double OrderCommission()
Returns
 
calculated
 
commission
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10,SELECT_BY_POS)==true)
    Print("Commission for the order 10 ",OrderCommission());
  else
    Print("OrderSelect failed error code is",GetLastError());

bool OrderDelete(int ticket)
Deletes previously opened pending order. If the function succeeds, the return value is true. If the function fails, the return value is 
false. To get the detailed error information, call GetLastError(). 
Parameters
ticket   -  Unique number of the order ticket.
Sample
  if(Ask>var1)
    {
     OrderDelete(order_ticket);
     return(0);
    }
datetime OrderExpiration()
Returns
 
expiration
 
date
 
for
 
the
 
selected
 
pending
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10, SELECT_BY_TICKET)==true)
    Print("Order expiration for the order #10 is ",OrderExpiration());
  else
    Print("OrderSelect failed error code is",GetLastError());
double OrderLots()
Returns
 
lots
 
value
 
for
 
the
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10,SELECT_BY_POS)==true)
    Print("lots for the order 10 ",OrderLots());
  else
    Print("OrderSelect failed error code is",GetLastError());
int OrderMagicNumber()
Returns
 
magic
 
number
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10,SELECT_BY_POS)==true)
    Print("Magic number for the order 10 ", OrderMagicNumber());
  else
    Print("OrderSelect failed error code is",GetLastError());
bool 
OrderModify(
int ticket, double price, double stoploss, double takeprofit, 
datetime expiration, color arrow_color=CLR_NONE)
Modification of characteristics for the previously opened position or a pending order. If the function succeeds, the return value is 
true. If the function fails, the return value is false. To get the detailed error information, call GetLastError(). 
Parameters

ticket
  -  Unique number of the order ticket.
price
  -  New price (for pending orders only).
stoploss
  -  New stoploss level.
takeprofit
  -  New profit-taking level.
expiration
  -  Order expiration server date/time (for pending orders only).
arrow_color   -  Arrow color of the pictogram on the chart.If the parameter is absent or has CLR_NONE value arrow will not be drawn on 
the chart.
Sample
  if(TrailingStop>0)
    {
     SelectOrder(12345,SELECT_BY_TICKET);
     if(Bid-OrderOpenPrice()>Point*TrailingStop)
       {
        if(OrderStopLoss()<Bid-Point*TrailingStop)
          {
           OrderModify(OrderTicket(),Ask-10*Point,Ask-
35*Point,OrderTakeProfit(),0,Blue);
           return(0);
          }
       }
    }
double OrderOpenPrice()
Returns
 
open
 
price
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("open price for the order 10 ",OrderOpenPrice());
  else
    Print("OrderSelect failed error code is",GetLastError());
datetime OrderOpenTime()
Returns
 
open
 
time
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("open time for the order 10 ",OrderOpenTime());
  else
    Print("OrderSelect failed error code is",GetLastError());
void OrderPrint()
Prints
 
selected
 
order
 
data
 
to
 
the
 
log
 
for
 
the
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10, SELECT_BY_TICKET)==true)
    OrderPrint();
  else
    Print("OrderSelect failed error code is",GetLastError());
double OrderProfit()
Returns
 
profit
 
for
 
the
 
currently
 
selected
 
order.

Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("Profit for the order 10 ",OrderProfit());
  else
    Print("OrderSelect failed error code is",GetLastError());
bool OrderSelect(int index, int select, int pool=MODE_TRADES)
Selects order by index or ticket to further processing. If the function fails, the return value will be false. To get the extended error 
information, call GetLastError(). 
Parameters
index
  -  Order index or order ticket depending from second parameter.
select   -  Selecting flags. It can be any of the following values:
SELECT_BY_POS - index in the order pool,
SELECT_BY_TICKET - index is order ticket.
pool
  -  Optional order pool index. Used when select parameter is SELECT_BY_POS.It can be any of the following values:
MODE_TRADES (default)- order selected from trading pool(opened and pending orders),
MODE_HISTORY - order selected from history pool (closed and canceled order).
Sample
  if(OrderSelect(12470, SELECT_BY_TICKET)==true)
    {
     Print("order #12470 open price is ", OrderOpenPrice());
     Print("order #12470 close price is ", OrderClosePrice());
    }
  else
    Print("OrderSelect failed error code is",GetLastError());
int 
OrderSend(
string symbol, int cmd, double volume, double price, int slippage, 
double stoploss, double takeprofit, string comment=NULL, int magic=0, 
datetime expiration=0, color arrow_color=CLR_NONE)
Main function used to open a position or set a pending order. Returns ticket of the placed order or -1 if failed. To check error code 
use GetLastError() function. 
Parameters
symbol
  -  Symbol for trading.
cmd
  -  Operation type. It can be any of the Trade operation enumeration.
volume
  -  Number of lots.
price
  -  Preferred price of the trade.
slippage
  -  Maximum price slippage for buy or sell orders.
stoploss
  -  Stop loss level.
takeprofit
  -  Take profit level.
comment
  -  Order comment text. Last part of the comment may be changed by server.
magic
  -  Order magic number. May be used as user defined identifier.
expiration
  -  Order expiration time (for pending orders only).
arrow_color   -  Color of the opening arrow on the chart. If parameter is absent or has CLR_NONE value opening arrow is not drawn on the 
chart.
Sample
  int ticket;
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)<25)
    {
     ticket=OrderSend(Symbol(),OP_BUY,1,Ask,3,Ask-25*Point,Ask+25*Point,"My order 
#2",16384,0,Green);
     if(ticket<0)
       {
        Print("OrderSend failed with error #",GetLastError());
        return(0);

       }
    }
double OrderStopLoss()
Returns
 
stop
 
loss
 
value
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(ticket,SELECT_BY_POS)==true)
    Print("Stop loss value for the order 10 ", OrderStopLoss());
  else
    Print("OrderSelect failed error code is",GetLastError());
int OrdersTotal()
Returns market and pending orders count.
Sample
  int handle=FileOpen("OrdersReport.csv",FILE_WRITE|FILE_CSV,"\t");
  if(handle<0) return(0);
  // write header
  FileWrite(handle,"#","open price","open time","symbol","lots");
  int total=OrdersTotal();
  // write open orders
  for(int pos=0;pos<total;pos++)
    {
     if(OrderSelect(pos,SELECT_BY_POS)==false) continue;
     FileWrite(handle,OrderTicket(),OrderOpenPrice(),OrderOpenTime(),OrderSymbol(),Or
derLots());
    }
  FileClose(handle);
double OrderSwap()
Returns
 
swap
 
value
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(order_id, SELECT_BY_TICKET)==true)
    Print("Swap for the order #", order_id, " ",OrderSwap());
  else
    Print("OrderSelect failed error code is",GetLastError());
string OrderSymbol()
Returns
 
the
 
order
 
symbol
 
value
 
for
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(12, SELECT_BY_POS)==true)
    Print("symbol of order #", OrderTicket(), " is ", OrderSymbol());
  else
    Print("OrderSelect failed error code is",GetLastError());
double OrderTakeProfit()
Returns
 
take
 
profit
 
value
 
for
 
the
 
currently
 
selected
 
order.

Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(12, SELECT_BY_POS)==true)
    Print("Order #",OrderTicket()," profit: ", OrderTakeProfit());
  else
    Print("OrderSelect() 忮痦箅 铠栳牦 - ",GetLastError());
int OrderTicket()
Returns
 
ticket
 
number
 
for
 
the
 
currently
 
selected
 
order.
Note: Order must be selected by OrderSelect() function. 
Sample
  if(OrderSelect(12, SELECT_BY_POS)==true)
    order=OrderTicket();
  else
    Print("OrderSelect failed error code is",GetLastError());
int OrderType()
Returns  order  operation  type  for  the  currently  selected  order.  It  can  be  any  of  the  following  values:
OP_BUY
 
-
 
buying
 
position,
OP_SELL
 
-
 
selling
 
position,
OP_BUYLIMIT
 
-
 
buy
 
limit
 
pending
 
position,
OP_BUYSTOP
 
-
 
buy
 
stop
 
pending
 
position,
OP_SELLLIMIT
 
-
 
sell
 
limit
 
pending
 
position,
OP_SELLSTOP
 
-
 
sell
 
stop
 
pending
 
position.
Note: Order must be selected by OrderSelect() function. 
Sample
  int order_type;
  if(OrderSelect(12, SELECT_BY_POS)==true)
    {
     order_type=OrderType();
     // ...
    }
  else
    Print("OrderSelect() returned error - ",GetLastError());