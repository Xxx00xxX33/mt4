# Custom Indicator functions

Page: 32

---

Custom Indicator functions
IndicatorBuffers()
IndicatorCounted()
IndicatorDigits()
IndicatorShortName()
SetIndexArrow()
SetIndexBuffer()
SetIndexDrawBegin()
SetIndexEmptyValue()
SetIndexLabel()
SetIndexShift()
SetIndexStyle()
SetLevelStyle()
SetLevelValue()
void IndicatorBuffers(int count)
Allocates memory for buffers used for custom indicator calculations. Cannot be greater than 8 and less than indicator_buffers 
property. If custom indicator requires additional buffers for counting then use this function for pointing common buffers count. 
Parameters
count   -  Buffers count to allocate. Should be up to 8 buffers.
Sample
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  Silver
//---- indicator parameters
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;
//---- indicator buffers
double     ind_buffer1[];
double     ind_buffer2[];
double     ind_buffer3[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,3);
   SetIndexDrawBegin(0,SignalSMA);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+2);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ind_buffer1);
   SetIndexBuffer(1,ind_buffer2);
   SetIndexBuffer(2,ind_buffer3);

//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
int IndicatorCounted()
Returns bars count that does not changed after last indicator launch. In most cases same count of index values do not need for 
recalculation. Used for optimizing calculations. 
Sample
  int start()
    {
     int limit;
     int counted_bars=IndicatorCounted();
  //---- check for possible errors
     if(counted_bars<0) return(-1);
  //---- last counted bar will be recounted
     if(counted_bars>0) counted_bars--;
     limit=Bars-counted_bars;
  //---- main loop
     for(int i=0; i<limit; i++)
       {
        //---- ma_shift set to 0 because SetIndexShift called abowe
        ExtBlueBuffer[i]=iMA(NULL,0,JawsPeriod,0,MODE_SMMA,PRICE_MEDIAN,i);
        ExtRedBuffer[i]=iMA(NULL,0,TeethPeriod,0,MODE_SMMA,PRICE_MEDIAN,i);
        ExtLimeBuffer[i]=iMA(NULL,0,LipsPeriod,0,MODE_SMMA,PRICE_MEDIAN,i);
       }
  //---- done
     return(0);
    }
void IndicatorDigits(int digits)
Sets default precision format for indicators visualization.
Parameters
digits   -  Precision format, number of digits after decimal point.
Sample
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  Silver
//---- indicator parameters
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;
//---- indicator buffers
double     ind_buffer1[];
double     ind_buffer2[];
double     ind_buffer3[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 2 additional buffers are used for counting.

   IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,3);
   SetIndexDrawBegin(0,SignalSMA);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+2);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ind_buffer1);
   SetIndexBuffer(1,ind_buffer2);
   SetIndexBuffer(2,ind_buffer3);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
void IndicatorShortName(string name)
Sets indicator short name for showing on the chart subwindow.
Parameters
name   -  New short name.
Sample
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  Silver
//---- indicator parameters
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;
//---- indicator buffers
double     ind_buffer1[];
double     ind_buffer2[];
double     ind_buffer3[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,3);
   SetIndexDrawBegin(0,SignalSMA);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+2);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ind_buffer1);
   SetIndexBuffer(1,ind_buffer2);
   SetIndexBuffer(2,ind_buffer3);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
void SetIndexArrow(int index, int code)

Sets arrow symbol for indicators that draws some lines as arrow.
Parameters
index   -  Line index. Should be from 0 to 7.
code
  -  Symbol code from Wingdings font or Array constants.
Sample
  SetIndexArrow(0, 217);
bool SetIndexBuffer(int index, double array[])
Sets buffer for calculating line. The indicated array bound with previously allocated custom indicator buffer. If the function 
succeeds, the return value is true. If the function fails, the return value is false. To get the detailed error information, call 
GetLastError(). 
Parameters
index
  -  Line index. Should be from 0 to 7.
array[]   -  Array that stores calculated indicator values.
Sample
  double ExtBufferSilver[];
  int init()
    {
      SetIndexBuffer(0, ExtBufferSilver); // set buffer for first line
      // ...
    }
void SetIndexDrawBegin(int index, int begin)
Sets first bar from what index will be drawn. Index values before draw begin are not significant and does not drawn and not show 
in the DataWindow. 
Parameters
index   -  Line index. Should be from 0 to 7.
begin   -  First drawing bar position number.
Sample
#property  indicator_separate_window
#property  indicator_buffers 1
#property  indicator_color1  Silver
//---- indicator parameters
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;
//---- indicator buffers
double     ind_buffer1[];
double     ind_buffer2[];
double     ind_buffer3[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,3);
   SetIndexDrawBegin(0,SignalSMA);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+2);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ind_buffer1);

   SetIndexBuffer(1,ind_buffer2);
   SetIndexBuffer(2,ind_buffer3);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
void SetIndexEmptyValue(int index, double value)
Sets drawing line empty value. By default, empty value line is EMPTY_VALUE. Empty values are not drawn and not show in the 
DataWindow. 
Parameters
index   -  Line index. Should be from 0 to 7.
value   -  New empty value.
Sample
  SetIndexEmptyValue(6,0.0001);
void SetIndexLabel(int index, string text)
Sets drawing line description for showing in the DataWindow.
Parameters
index   -  Line index. Should be from 0 to 7.
text
  -  Label text. NULL means that index value does not show in the DataWindow.
Sample
//+------------------------------------------------------------------+
//| Ichimoku Kinko Hyo initialization function                       |
//+------------------------------------------------------------------+
int init()
  {
//----
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,Tenkan_Buffer);
   SetIndexDrawBegin(0,Tenkan-1);
   SetIndexLabel(0,"Tenkan Sen");
//----
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,Kijun_Buffer);
   SetIndexDrawBegin(1,Kijun-1);
   SetIndexLabel(1,"Kijun Sen");
//----
   a_begin=Kijun; if(a_begin<Tenkan) a_begin=Tenkan;
   SetIndexStyle(2,DRAW_HISTOGRAM,STYLE_DOT);
   SetIndexBuffer(2,SpanA_Buffer);
   SetIndexDrawBegin(2,Kijun+a_begin-1);
   SetIndexShift(2,Kijun);
//---- Up Kumo bounding line does not show in the DataWindow
   SetIndexLabel(2,NULL);
   SetIndexStyle(5,DRAW_LINE,STYLE_DOT);
   SetIndexBuffer(5,SpanA2_Buffer);
   SetIndexDrawBegin(5,Kijun+a_begin-1);
   SetIndexShift(5,Kijun);
   SetIndexLabel(5,"Senkou Span A");
//----
   SetIndexStyle(3,DRAW_HISTOGRAM,STYLE_DOT);

   SetIndexBuffer(3,SpanB_Buffer);
   SetIndexDrawBegin(3,Kijun+Senkou-1);
   SetIndexShift(3,Kijun);
//---- Down Kumo bounding line does not show in the DataWindow
   SetIndexLabel(3,NULL);
//----
   SetIndexStyle(6,DRAW_LINE,STYLE_DOT);
   SetIndexBuffer(6,SpanB2_Buffer);
   SetIndexDrawBegin(6,Kijun+Senkou-1);
   SetIndexShift(6,Kijun);
   SetIndexLabel(6,"Senkou Span B");
//----
   SetIndexStyle(4,DRAW_LINE);
   SetIndexBuffer(4,Chinkou_Buffer);
   SetIndexShift(4,-Kijun);
   SetIndexLabel(4,"Chinkou Span");
//----
   return(0);
  }
void SetIndexShift(int index, int shift)
Sets offset for drawing line. Line will be counted on the current bar, but will be drawn shifted. 
Parameters
index   -  Line index. Should be from 0 to 7.
shift
  -  Shitf value in bars.
Sample
//+------------------------------------------------------------------+
//| Alligator initialization function                                |
//+------------------------------------------------------------------+
int init()
  {
//---- line shifts when drawing
   SetIndexShift(0,JawsShift);
   SetIndexShift(1,TeethShift);
   SetIndexShift(2,LipsShift);
//---- first positions skipped when drawing
   SetIndexDrawBegin(0,JawsShift+JawsPeriod);
   SetIndexDrawBegin(1,TeethShift+TeethPeriod);
   SetIndexDrawBegin(2,LipsShift+LipsPeriod);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ExtBlueBuffer);
   SetIndexBuffer(1,ExtRedBuffer);
   SetIndexBuffer(2,ExtLimeBuffer);
//---- drawing settings
   SetIndexStyle(0,DRAW_LINE);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexStyle(2,DRAW_LINE);
//---- index labels
   SetIndexLabel(0,"Gator Jaws");
   SetIndexLabel(1,"Gator Teeth");
   SetIndexLabel(2,"Gator Lips");
//---- initialization done
   return(0);
  }

void 
SetIndexStyle(
int index, int type, int style=EMPTY, int width=EMPTY, 
color clr=CLR_NONE)
Sets new type, style, width and color for a given indicator line.
Parameters
index   -  Line index. Should be from 0 to 7.
type
  -  Shape style.Can be one of Drawing shape style enumeration.
style
  -  Drawing style. Except STYLE_SOLID style all other styles valid when width is 1 pixel.Can be one of Shape style enumeration. 
EMPTY value indicates that style does not changed.
width   -  Line width. valid values - 1,2,3,4,5. EMPTY value indicates that width does not changed.
clr
  -  Line color.
Sample
  SetIndexStyle(3, DRAW_LINE, EMPTY, 2, Red);
void SetLevelStyle(int draw_style, int line_width, color clr=CLR_NONE)
Function sets new style, width and color of indicator levels. 
Parameters
draw_style   -  Drawing style. Except for STYLE_SOLID, all other styles are valid if the width is 1 pixel.Can be one of Shape style 
constants.EMPTY value indicates that style will not be changed.
line_width
  -  Line width. Valid values are 1,2,3,4,5. EMPTY value indicates that width will not be changed.
clr
  -  Line color.
Sample
//---- show levels as thick red lines
   SetLevelStyle(STYLE_SOLID,2,Red)
int SetLevelValue(int level, double value)
Function sets a new value for the given indicator level. 
Parameters
level
  -  Level index (0-31).
value   -  Value for the given indicator level.
Sample
SetLevelValue(1,3.14);