# Pre-defined Variables

Page: 60

---

Pre-defined Variables
Ask
Bars
Bid
Close
Digits
High
Low
Open
Point
Time
Volume
double Ask
Ask price (the Buyer's price).
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)<25)
    {
     OrderSend(Symbol(),OP_BUY,Lots,Ask,3,Ask-StopLoss*Point,Ask+TakeProfit*Point,
               "My order #2",3,D'2005.10.10 12:30',Red);
     return;
    }

int Bars
Number of bars on the chart.
  int counter=1;
  for(int i=1;i<=Bars;i++)
    {
     Print(Close[i-1]);
    }
double Bid
Bid price (the Seller's price).
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)>75)
    {
     OrderSend("EURUSD",OP_SELL,Lots,Bid,3,Bid+StopLoss*Point,Bid-TakeProfit*Point,
               "My order #2",3,D'2005.10.10 12:30',Red);
     return(0);
    }
double Close[]
Returns the closing price of the bar being referenced.
  int handle, bars=Bars;
  handle=FileOpen("file.csv",FILE_CSV|FILE_WRITE,';');
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // write data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }
int Digits
Number of digits after decimal point for the current symbol.
  Print(DoubleToStr(Close[i-1], Digits));
double High[]

Returns the highest price of the bar referenced.
  int handle, bars=Bars;
  handle=FileOpen("file.csv", FILE_CSV|FILE_WRITE, ';');
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // write data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }
double Low[]
Returns the lowest price of the bar referenced.
  int handle, bars=Bars;
  handle=FileOpen("file.csv", FILE_CSV|FILE_WRITE, ";");
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // write data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }
double Open[]
Returns the opening price of the bar referenced.
  int handle, bars=Bars;
  handle=FileOpen("file.csv", FILE_CSV|FILE_WRITE, ';');
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // write data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }
double Point
Point value for the current chart.

  OrderSend(Symbol(),OP_BUY,Lots,Ask,3,0,Ask+TakeProfit*Point,Red);
datetime Time[]
Open time of the bars. Datetime is the number of seconds elapsed from 00:00 January 1, 1970.
  int handle, bars=Bars;
  handle=FileOpen("file.csv", FILE_CSV|FILE_WRITE, ';');
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // write data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }
double Volume[]
Returns the ticks count for the referenced bar.
  int handle, bars=Bars;
  handle=FileOpen("file.csv", FILE_CSV|FILE_WRITE, ';');
  if(handle>0)
    {
     // write table columns headers
     FileWrite(handle, "Time;Open;High;Low;Close;Volume");
     // erite data
     for(int i=0; i<bars; i++)
       FileWrite(handle, Time[i], Open[i], High[i], Low[i], Close[i], Volume[i]);
     FileClose(handle);
    }