# Technical Indicator calls

Page: 76

---

Technical Indicator calls
Accelerator Oscillator - iAC()
Accumulation/Distribution - iAD()
Alligator - iAlligator()
Average Directional Movement Index - iADX()
Average True Range - iATR()
Awesome Oscillator - iAO()
Bears Power - iBearsPower()
Bollinger Bands - iBands()
Bollinger Bands on buffer - iBandsOnArray()
Bulls Power - iBullsPower()
Commodity Channel Index - iCCI()
Commodity Channel Index on buffer - iCCIOnArray()
Custom Indicator - iCustom()
DeMarker - iDeMarker()
Envelopes - iEnvelopes()
Envelopes on buffer - iEnvelopesOnArray()
Force Index - iForce()

Fractals - iFractals()
Gator Oscillator - iGator()
Ichimoku Kinko Hyo - iIchimoku()
Market Facilitation Index (Bill Williams) - iBWMFI()
Momentum - iMomentum()
Momentum on buffer - iMomentumOnArray()
Money Flow Index - iMFI()
Moving Average - iMA()
Moving Average on buffer - iMAOnArray()
Moving Average of Oscillator - iOsMA()
Moving Averages Convergence/Divergence - iMACD()
On Balance Volume - iOBV()
Parabolic SAR - iSAR()
Relative Strength Index - iRSI()
Relative Strength Index on buffer - iRSIOnArray()
Relative Vigor Index - iRVI()
Standard Deviation - iStdDev()
Standard Deviation on buffer - iStdDevOnArray()
Stochastic Oscillator - iStochastic()
William's Percent Range - iWPR()
iBars()
iBarShift()
iClose()
iHigh()
iLow()
iOpen()
iTime()
iVolume()
Highest()
Lowest()
double iAC(string symbol, int timeframe, int shift)
Calculates the Bill Williams' Accelerator/Decelerator oscillator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double result=iAC(NULL, 0, 1);
double iAD(string symbol, int timeframe, int shift)
Calculates the Accumulation/Distribution indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double result=iAD(NULL, 0, 1);
double 
iAlligator(
string symbol, int timeframe, int jaw_period, int jaw_shift, 
int teeth_period, int teeth_shift, int lips_period, int lips_shift, 
int ma_method, int applied_price, int mode, int shift)
Calculates the Bill Williams' Alligator and returns its value.
Parameters

symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
jaw_period
  -  Jaw period.
jaw_shift
  -  Jaw line shift.
teeth_period
  -  Teeth period.
teeth_shift
  -  Teeth line shift.
lips_period
  -  Lips period.
lips_shift
  -  Lips line shift.
ma_method
  -  MA method. It can be any of Moving Average method enumeration value.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
mode
  -  Source of data. It can be any of the following values:
MODE_GATORJAW - Gator Jaw (blue) balance line,
MODE_GATORTEETH - Gator Teeth (red) balance line,
MODE_GATORLIPS - Gator Lips (green) balance line.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double jaw_val=iAlligator(NULl, 0, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, 
MODE_GATORJAW, 1);
double 
iADX(
string symbol, int timeframe, int period, int applied_price, int mode, 
int shift)
Calculates the Movement directional index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
mode
  -  Indicator line array index. It can be any of the Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iADX(NULL,0,14,PRICE_HIGH,MODE_MAIN,0)>iADX(NULL,0,14,PRICE_HIGH,MODE_PLUSDI,0)) 
return(0);
double iATR(string symbol, int timeframe, int period, int shift)
Calculates the Indicator of the average true range and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iATR(NULL,0,12,0)>iATR(NULL,0,20,0)) return(0);
double iAO(string symbol, int timeframe, int shift)
Calculates the Bill Williams' Awesome oscillator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iAO(NULL, 0, 2);

double 
iBearsPower(
string symbol, int timeframe, int period, int applied_price, 
int shift)
Calculates the Bears Power indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iBearsPower(NULL, 0, 13,PRICE_CLOSE,0);
double 
iBands(
string symbol, int timeframe, int period, int deviation, int bands_shift, 
int applied_price, int mode, int shift)
Calculates the Bollinger bands indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
deviation
  -  Deviation.
bands_shift
  -  Bands shift.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
mode
  -  Indicator line array index. It can be any of the Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iBands(NULL,0,20,2,0,PRICE_LOW,MODE_LOWER,0)>Low[0]) return(0);
double 
iBandsOnArray(
double array[], int total, int period, double deviation, 
int bands_shift, int mode, int shift)
Calculates the Bollinger bands indicator and returns its value.
Parameters
array[]
  -  Array with data.
total
  -  The number of items to be counted.
period
  -  Number of periods for calculation.
deviation
  -  Deviation.
bands_shift   -  Bands shift.
mode
  -  Series array identifier. It can be any of the Series array identifier enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iBands(ExtBuffer,total,2,0,MODE_LOWER,0)>Low[0]) return(0);
double 
iBullsPower(
string symbol, int timeframe, int period, int applied_price, 
int shift)
Calculates the Bulls Power indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iBullsPower(NULL, 0, 13,PRICE_CLOSE,0);

double iCCI(string symbol, int timeframe, int period, int applied_price, int shift)
Calculates the Commodity channel index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iCCI(NULL,0,12,0)>iCCI(NULL,0,20,0)) return(0);
double iCCIOnArray(double array[], int total, int period, int shift)
Calculates the Commodity channel index and returns its value.
Parameters
array[]   -  Array with data.
total
  -  The number of items to be counted.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iCCIOnArray(ExtBuffer,total,12,0)>iCCI(NULL,0,20,PRICE_OPEN, 0)) return(0);
double iCustom(string symbol, int timeframe, string name, ... , int mode, int shift)
Calculates the Custom indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
name
  -  Custom indicator compiled program name.
...
  -  Parameters set (if needed).
mode
  -  Line index. Can be from 0 to 7.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iCustom(NULL, 0, "SampleInd",13,1,0);
double iDeMarker(string symbol, int timeframe, int period, int shift)
Calculates the DeMarker indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iDeMarker(NULL, 0, 13, 1);
double 
iEnvelopes(
string symbol, int timeframe, int ma_period, int ma_method, 
int ma_shift, int applied_price, double deviation, int mode, int shift)
Calculates the Envelopes indicator and returns its value.
Parameters

symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
ma_period
  -  Number of periods for calculation.
ma_method
  -  MA method. It can be any of Moving Average method enumeration value.
ma_shift
  -  MA shift. Indicator line offset relate to the chart by timeframe.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
deviation
  -  Deviation.
mode
  -  Indicator line array index. It can be any of Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iEnvelopes(NULL, 0, 13,MODE_SMA,10,PRICE_CLOSE,0.2,MODE_UPPER,0);
double 
iEnvelopesOnArray(
double array[], int total, int ma_period, int ma_method, 
int ma_shift, double deviation, int mode, int shift)
Calculates the Envelopes indicator counted on buffer and returns its value.
Parameters
array[]
  -  Array with data.
total
  -  The number of items to be counted.
ma_period
  -  Number of periods for calculation.
ma_method   -  MA method. It can be any of Moving Average method enumeration value.
ma_shift
  -  MA shift. Indicator line offset relate to the chart by timeframe.
deviation
  -  Deviation.
mode
  -  Indicator line array index. It can be any of Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iEnvelopesOnArray(ExtBuffer, 0, 13, MODE_SMA, 0.2, MODE_UPPER,0 );
double 
iForce(
string symbol, int timeframe, int period, int ma_method, 
int applied_price, int shift)
Calculates the Force index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
ma_method
  -  MA method. It can be any of Moving Average method enumeration value.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iForce(NULL, 0, 13,MODE_SMA,PRICE_CLOSE,0);
double iFractals(string symbol, int timeframe, int mode, int shift)
Calculates the Fractals and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
mode
  -  Indicator line array index. It can be any of the Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iFractals(NULL, 0, MODE_UPPER,0);
double 
iGator(
string symbol, int timeframe, int jaw_period, int jaw_shift, 
int teeth_period, int teeth_shift, int lips_period, int lips_shift, 
int ma_method, int applied_price, int mode, int shift)

Calculates the Gator Oscillator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
jaw_period
  -  Jaw period.
jaw_shift
  -  Jaw line shift.
teeth_period
  -  Teeth period.
teeth_shift
  -  Teeth line shift.
lips_period
  -  Lips period.
lips_shift
  -  Lips line shift.
ma_method
  -  MA method. It can be any of Moving Average method enumeration value.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
mode
  -  Indicator line array index. It can be any of Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double jaw_val=iGator(NULL, 0, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, 
MODE_UPPER, 1);
double 
iIchimoku(
string symbol, int timeframe, int tenkan_sen, int kijun_sen, 
int senkou_span_b, int mode, int shift)
Calculates the Ichimoku Kinko Hyo and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
tenkan_sen
  -  Tenkan Sen.
kijun_sen
  -  Kijun Sen.
senkou_span_b   -  Senkou SpanB.
mode
  -  Source of data. It can be one of the Ichimoku Kinko Hyo mode enumeration.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double tenkan_sen=iIchimoku(NULL, 0, 9, 26, 52, MODE_TENKANSEN, 1);
double iBWMFI(string symbol, int timeframe, int shift)
Calculates the Bill Williams Market Facilitation index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iBWMFI(NULL, 0, 0);
double 
iMomentum(
string symbol, int timeframe, int period, int applied_price, 
int shift)
Calculates the Momentum indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator.NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iMomentum(NULL,0,12,PRICE_CLOSE,0)>iMomentum(NULL,0,20,PRICE_CLOSE,0)) 

return(0);
double iMomentumOnArray(double array[], int total, int period, int shift)
Calculates the Momentum indicator counted on buffer and returns its value.
Parameters
array[]   -  Array with data.
total
  -  The number of items to be counted.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iMomentumOnArray(mybuffer,100,12,0)>iMomentumOnArray(mubuffer,100,20,0)) 
return(0);
double iMFI(string symbol, int timeframe, int period, int shift)
Calculates the Money flow index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iMFI(NULL,0,14,0)>iMFI(NULL,0,14,1)) return(0);
double 
iMA(
string symbol, int timeframe, int period, int ma_shift, int ma_method, 
int applied_price, int shift)
Calculates the Moving average indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
ma_shift
  -  MA shift. Indicators line offset relate to the chart by timeframe.
ma_method
  -  MA method. It can be any of the Moving Average method enumeration value.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  AlligatorJawsBuffer[i]=iMA(NULL,0,13,8,MODE_SMMA,PRICE_MEDIAN,i);
double 
iMAOnArray(
double array[], int total, int period, int ma_shift, int ma_method, 
int shift)
Calculates the Moving average counted on buffer and returns its value.
Parameters
array[]
  -  Array with data.
total
  -  The number of items to be counted. 0 means whole array.
period
  -  Number of periods for calculation.
ma_shift
  -  MA shift
ma_method   -  MA method. It can be any of the Moving Average method enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
   double macurrent=iMAOnArray(ExtBuffer,0,5,0,MODE_LWMA,0);
   double macurrentslow=iMAOnArray(ExtBuffer,0,10,0,MODE_LWMA,0);

   double maprev=iMAOnArray(ExtBuffer,0,5,0,MODE_LWMA,1);
   double maprevslow=iMAOnArray(ExtBuffer,0,10,0,MODE_LWMA,1);
   //----
   if(maprev<maprevslow && macurrent>=macurrentslow)
     Alert("crossing up");
double 
iOsMA(
string symbol, int timeframe, int fast_ema_period, int slow_ema_period, 
int signal_period, int applied_price, int shift)
Calculates the Moving Average of Oscillator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
fast_ema_period
  -  Number of periods for fast moving average calculation.
slow_ema_period   -  Nmber of periods for slow moving average calculation.
signal_period
  -  Number of periods for signal moving average calculation.
applied_price
  -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iOsMA(NULL,0,12,26,9,PRICE_OPEN,1)>iOsMA(NULL,0,12,26,9,PRICE_OPEN,0)) 
return(0);
double 
iMACD(
string symbol, int timeframe, int fast_ema_period, int slow_ema_period, 
int signal_period, int applied_price, int mode, int shift)
Calculates the Moving averages convergence/divergence and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
fast_ema_period
  -  Number of periods for fast moving average calculation.
slow_ema_period   -  Number of periods for slow moving average calculation.
signal_period
  -  Number of periods for signal moving average calculation.
applied_price
  -  Applied price. It can be any of Applied price enumeration values.
mode
  -  Indicator line array index. It can be any of the Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0)>iMACD(NULL,0,12,26,9,PRICE_CLOSE,M
ODE_SIGNAL,0)) return(0);
double iOBV(string symbol, int timeframe, int applied_price, int shift)
Calculates the On Balance Volume indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iOBV(NULL, 0, PRICE_CLOSE, 1);
double iSAR(string symbol, int timeframe, double step, double maximum, int shift)
Calculates the Parabolic Sell and Reverse system and returns its value.
Parameters

symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
step
  -  Increment, usually 0.02.
maximum
  -  Maximum value, usually 0.2.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iSAR(NULL,0,0.02,0.2,0)>Close[0]) return(0);
double iRSI(string symbol, void timeframe, int period, int applied_price, int shift)
Calculates the Relative strength index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iRSI(NULL,0,14,PRICE_CLOSE,0)>iRSI(NULL,0,14,PRICE_CLOSE,1)) return(0);
double iRSIOnArray(double array[], int total, int period, int shift)
Calculates the Relative strength index counted on buffer and returns its value.
Parameters
array[]   -  Array with data.
total
  -  The number of items to be counted.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iRSIOnBuffer(ExtBuffer,1000,14,0)>iRSI(NULL,0,14,PRICE_CLOSE,1)) return(0);
double iRVI(string symbol, int timeframe, int period, int mode, int shift)
Calculates the Relative Vigor index and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
mode
  -  Indicator line array index. It can be any of Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iRVI(NULL, 0, 10,MODE_MAIN,0);
double 
iStdDev(
string symbol, int timeframe, int ma_period, int ma_method, int ma_shift, 
int applied_price, int shift)
Calculates the Standard Deviation indicator and returns its value.
Parameters

symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe
  -  Time frame. It can be any of Time frame enumeration values.
ma_period
  -  MA period.
ma_method
  -  MA method. It can be any of Moving Average method enumeration value.
ma_shift
  -  MA shift.
applied_price   -  Applied price. It can be any of Applied price enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iStdDev(NULL,0,10,MODE_EMA,0,PRICE_CLOSE,0);
double 
iStdDevOnArray(
double array[], int total, int ma_period, int ma_method, 
int ma_shift, int shift)
Calculates the Standard Deviation counted on buffer and returns its value.
Parameters
array[]
  -  Array with data.
total
  -  The number of items to be counted.
ma_period
  -  MA period.
ma_method   -  MA method. It can be any of Moving Average method enumeration value.
ma_shift
  -  iMA shift.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  double val=iStdDevOnArray(ExtBuffer,100,10,MODE_EMA,0,0);
double 
iStochastic(
string symbol, int timeframe, int %Kperiod, int %Dperiod, int slowing, 
int method, int price_field, int mode, int shift)
Calculates the Stochastic oscillator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
%Kperiod
  -  %K line period.
%Dperiod
  -  %D line period.
slowing
  -  Slowing value.
method
  -  MA method. It can be any ofMoving Average method enumeration value.
price_field   -  Price field parameter. Can be one of this values: 0 - Low/High or 1 - Close/Close.
mode
  -  Indicator line array index. It can be any of the Indicators line identifiers enumeration value.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,0)>iStochastic(NULL,0,5,3,3,MODE_S
MA,0,MODE_SIGNAL,0))
    return(0);
double iWPR(string symbol, int timeframe, int period, int shift)
Calculates the Larry William's percent range indicator and returns its value.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
period
  -  Number of periods for calculation.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  if(iWPR(NULL,0,14,0)>iWPR(NULL,0,14,1)) return(0);

int iBars(string symbol, int timeframe)
Returns the number of bars on the specified chart.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
Sample
  Print("Bar count on the 'EUROUSD' symbol with PERIOD_H1 
is",iBars("EUROUSD",PERIOD_H1));
int iBarShift(string symbol, int timeframe, datetime time, bool exact=false)
Search for bar by open time. The function returns bar shift with the open time specified. If the bar having the specified open time 
is absent the function will return, depending on the exact parameter, -1 or the nearest bar shift. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
time
  -  value to find (bar's open time).
exact
  -  Return mode when bar not found. false - iBarShift returns nearest. true - iBarShift returns -1.
Sample
  datetime some_time=D'2004.03.21 12:00';
  int      shift=iBarShift("EUROUSD",PERIOD_M1,some_time);
  Print("shift of bar with open time ",TimeToStr(some_time)," is ",shift);
double iClose(string symbol, int timeframe, int shift)
Returns Close value for the bar of indicated symbol with timeframe and shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));
double iHigh(string symbol, int timeframe, int shift)
Returns  High value for the bar of indicated  symbol with  timeframe and  shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol on that data need to calculate indicator. NULL means current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));

double iLow(string symbol, int timeframe, int shift)
Returns  Low value for the bar of indicated  symbol with  timeframe and  shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));
double iOpen(string symbol, int timeframe, int shift)
Returns Open value for the bar of indicated symbol with timeframe and shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));
datetime iTime(string symbol, int timeframe, int shift)
Returns Time value for the bar of indicated symbol with  timeframe and shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.
Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));
double iVolume(string symbol, int timeframe, int shift)
Returns Volume value for the bar of indicated symbol with timeframe and shift. If local history is empty (not loaded), function 
returns 0. 
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
shift
  -  Shift relative to the current bar (number of periods back), where the data should be taken from.

Sample
  Print("Current bar for USDCHF H1: ",iTime("USDCHF",PERIOD_H1,i),", ", 
iOpen("USDCHF",PERIOD_H1,i),", ",
                                      iHigh("USDCHF",PERIOD_H1,i),", ", 
iLow("USDCHF",PERIOD_H1,i),", ",
                                      iClose("USDCHF",PERIOD_H1,i),", ", 
iVolume("USDCHF",PERIOD_H1,i));
int Highest(string symbol, int timeframe, int type, int count=WHOLE_ARRAY, int start=0)
Returns the shift of the maximum value over a specific number of periods depending on type.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
type
  -  Series array identifier. It can be any of the Series array identifier enumeration values.
count
  -  Number of periods (in direction from the start bar to the back one) on which the calculation is carried out.
start
  -  Shift showing the bar, relative to the current bar, that the data should be taken from.
Sample
  double val;
  // calculating the highest value in the range from 5 element to 25 element
  // indicator charts symbol and indicator charts time frame
  val=High[Highest(NULL,0,MODE_HIGH,20,4)];
int Lowest(string symbol, int timeframe, int type, int count=WHOLE_ARRAY, int start=0)
Returns the shift of the least value over a specific number of periods depending on type.
Parameters
symbol
  -  Symbol the data of which should be used to calculate indicator. NULL means the current symbol.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
type
  -  Series array identifier. It can be any of Series array identifier enumeration values.
count
  -  Number of periods (in direction from the start bar to the back one) on which the calculation is carried out.
start
  -  Shift showing the bar, relative to the current bar, that the data should be taken from.
Sample
  double val=Low[Lowest(NULL,0,MODE_LOW,10,10)];