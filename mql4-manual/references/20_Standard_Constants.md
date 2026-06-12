# Standard Constants

Page: 63

---

Standard Constants
Applied price enumeration
Drawing shape style enumeration
Error codes
Ichimoku Kinko Hyo modes enumeration
Indicators line identifiers
Market information identifiers
MessageBox return codes
MessageBox behavior flags
Moving Average method enumeration
Object properties enumeration
Object type enumeration
Object visibility enumeration
Predefined Arrow codes enumeration
Series array identifier
Special constants
Time frame enumeration
Trade operation enumeration

Uninitialize reason codes
Wingdings symbols
Web colors table
Applied price enumeration
Applied price constants. It can be any of the following values:
Constant
Value
Description
PRICE_CLOSE
0
Close price.
PRICE_OPEN
1
Open price.
PRICE_HIGH
2
High price.
PRICE_LOW
3
Low price.
PRICE_MEDIAN
4
Median price, (high+low)/2.
PRICE_TYPICAL
5
Typical price, (high+low+close)/3.
PRICE_WEIGHTED
6
Weighted close price, (high+low+close+close)/4.
Drawing shape style enumeration
Drawing shape style enumeration for SetIndexStyle() function.
It can be any of the following values:
Constant
Value
Description
DRAW_LINE
0
Drawing line.
DRAW_SECTION
1
Drawing sections.
DRAW_HISTOGRAM
2
Drawing histogram.
DRAW_ARROW
3
Drawing arrows (symbols).
DRAW_NONE
12
No drawing.
Drawing  style.  Valid  when  width=1.  It  can  be  any  of  the 
following values:
Constant
Value
Description
STYLE_SOLID
0
The pen is solid.
STYLE_DASH
1
The pen is dashed.
STYLE_DOT
2
The pen is dotted.
STYLE_DASHDOT
3
The pen has alternating dashes and dots.
STYLE_DASHDOTDOT 4
The pen has alternating dashes and double dots.
Error codes
The GetLastError() function return codes. Error code constants defined at stderror.mqh file. To print text messages 
use ErrorDescription() function defined at stdlib.mqh file.
#include <stdlib.mqh>
void SendMyMessage(string text)
  {
   int check;
   SendMail("some subject", text);
   check=GetLastError();
   if(check!=ERR_NO_MQLERROR) Print("Cannot send message, error: 
",ErrorDescription(check));
  }
Error codes returned from trade server.

Constant
Value
Description
ERR_NO_ERROR
0
No error returned.
ERR_NO_RESULT
1
No error returned, but the result is unknown.
ERR_COMMON_ERROR
2
Common error.
ERR_INVALID_TRADE_PARAMETERS
3
Invalid trade parameters.
ERR_SERVER_BUSY
4
Trade server is busy.
ERR_OLD_VERSION
5
Old version of the client terminal.
ERR_NO_CONNECTION
6
No connection with trade server.
ERR_NOT_ENOUGH_RIGHTS
7
Not enough rights.
ERR_TOO_FREQUENT_REQUESTS
8
Too frequent requests.
ERR_MALFUNCTIONAL_TRADE
9
Malfunctional trade operation.
ERR_ACCOUNT_DISABLED
64
Account disabled.
ERR_INVALID_ACCOUNT
65
Invalid account.
ERR_TRADE_TIMEOUT
128
Trade timeout.
ERR_INVALID_PRICE
129
Invalid price.
ERR_INVALID_STOPS
130
Invalid stops.
ERR_INVALID_TRADE_VOLUME
131
Invalid trade volume.
ERR_MARKET_CLOSED
132
Market is closed.
ERR_TRADE_DISABLED
133
Trade is disabled.
ERR_NOT_ENOUGH_MONEY
134
Not enough money.
ERR_PRICE_CHANGED
135
Price changed.
ERR_OFF_QUOTES
136
Off quotes.
ERR_BROKER_BUSY
137
Broker is busy.
ERR_REQUOTE
138
Requote.
ERR_ORDER_LOCKED
139
Order is locked.
ERR_LONG_POSITIONS_ONLY_ALLOWED 140
Long positions only allowed.
ERR_TOO_MANY_REQUESTS
141
Too many requests.
ERR_TRADE_MODIFY_DENIED
145
Modification denied because order too close to market.
ERR_TRADE_CONTEXT_BUSY
146
Trade context is busy.
MQL4 run time error codes

Constant
Value
Description
ERR_NO_MQLERROR
4000
No error.
ERR_WRONG_FUNCTION_POINTER
4001
Wrong function pointer.
ERR_ARRAY_INDEX_OUT_OF_RANGE
4002
Array index is out of range.
ERR_NO_MEMORY_FOR_FUNCTION_CALL_STACK
4003
No memory for function call stack.
ERR_RECURSIVE_STACK_OVERFLOW
4004
Recursive stack overflow.
ERR_NOT_ENOUGH_STACK_FOR_PARAMETER
4005
Not enough stack for parameter.
ERR_NO_MEMORY_FOR_PARAMETER_STRING
4006
No memory for parameter string.
ERR_NO_MEMORY_FOR_TEMP_STRING
4007
No memory for temp string.
ERR_NOT_INITIALIZED_STRING
4008
Not initialized string.
ERR_NOT_INITIALIZED_ARRAYSTRING
4009
Not initialized string in array.
ERR_NO_MEMORY_FOR_ARRAYSTRING
4010
No memory for array string.
ERR_TOO_LONG_STRING
4011
Too long string.
ERR_REMAINDER_FROM_ZERO_DIVIDE
4012
Remainder from zero divide.
ERR_ZERO_DIVIDE
4013
Zero divide.
ERR_UNKNOWN_COMMAND
4014
Unknown command.
ERR_WRONG_JUMP
4015
Wrong jump (never generated error).
ERR_NOT_INITIALIZED_ARRAY
4016
Not initialized array.
ERR_DLL_CALLS_NOT_ALLOWED
4017
DLL calls are not allowed.
ERR_CANNOT_LOAD_LIBRARY
4018
Cannot load library.
ERR_CANNOT_CALL_FUNCTION
4019
Cannot call function.
ERR_EXTERNAL_EXPERT_CALLS_NOT_ALLOWED
4020
Expert function calls are not allowed.
ERR_NOT_ENOUGH_MEMORY_FOR_RETURNED_STRING 4021
Not enough memory for temp string returned from function.
ERR_SYSTEM_BUSY
4022
System is busy (never generated error).
ERR_INVALID_FUNCTION_PARAMETERS_COUNT
4050
Invalid function parameters count.
ERR_INVALID_FUNCTION_PARAMETER_VALUE
4051
Invalid function parameter value.
ERR_STRING_FUNCTION_INTERNAL_ERROR
4052
String function internal error.
ERR_SOME_ARRAY_ERROR
4053
Some array error.
ERR_INCORRECT_SERIES_ARRAY_USING
4054
Incorrect series array using.
ERR_CUSTOM_INDICATOR_ERROR
4055
Custom indicator error.
ERR_INCOMPATIBLE_ARRAYS
4056
Arrays are incompatible.
ERR_GLOBAL_VARIABLES_PROCESSING_ERROR
4057
Global variables processing error.
ERR_GLOBAL_VARIABLE_NOT_FOUND
4058
Global variable not found.
ERR_FUNCTION_NOT_ALLOWED_IN_TESTING_MODE
4059
Function is not allowed in testing mode.
ERR_FUNCTION_NOT_CONFIRMED
4060
Function is not confirmed.
ERR_SEND_MAIL_ERROR
4061
Send mail error.
ERR_STRING_PARAMETER_EXPECTED
4062
String parameter expected.
ERR_INTEGER_PARAMETER_EXPECTED
4063
Integer parameter expected.
ERR_DOUBLE_PARAMETER_EXPECTED
4064
Double parameter expected.
ERR_ARRAY_AS_PARAMETER_EXPECTED
4065
Array as parameter expected.
ERR_HISTORY_WILL_UPDATED
4066
Requested history data in updating state.
ERR_END_OF_FILE
4099
End of file.
ERR_SOME_FILE_ERROR
4100
Some file error.
ERR_WRONG_FILE_NAME
4101
Wrong file name.
ERR_TOO_MANY_OPENED_FILES
4102
Too many opened files.
ERR_CANNOT_OPEN_FILE
4103
Cannot open file.

Ichimoku Kinko Hyo modes enumeration
Ichimoku
 
Kinko
 
Hyo
 
source
 
of
 
data.
 
Used
 
in
 iIchimoku() 
indicators.
It can be one of the following values:
Constant
Value
Description
MODE_TENKANSEN
1
Tenkan-sen.
MODE_KIJUNSEN
2
Kijun-sen.
MODE_SENKOUSPANA 3
Senkou Span A.
MODE_SENKOUSPANB 4
Senkou Span B.
MODE_CHINKOUSPAN
5
Chinkou Span.
Indicators line identifiers
Indicator
 
line
 
identifiers
 
used
 
in
 iMACD(),
 iRVI() 
and
 iStochastic() 
indicators.
It can be one of the following values:
Constant
Value
Description
MODE_MAIN
0
Base indicator line.
MODE_SIGNAL
1
Signal line.
Indicator line identifiers used in iADX() indicator.
Constant
Value
Description
MODE_MAIN
0
Base indicator line.
MODE_PLUSDI
1
+DI indicator line.
MODE_MINUSDI
2
-DI indicator line.
Indicator  line  identifiers  used  in
 iBands(),
 iEnvelopes(), 
iEnvelopesOnArray(), iFractals() and iGator() indicators.
Constant
Value
Description
MODE_UPPER
1
Upper line.
MODE_LOWER
2
Lower line.
Market information identifiers
Market
 
information
 
identifiers,
 
used
 
with
 MarketInfo() 
function.
It can be any of the following values:

Constant
Value
Description
MODE_LOW
1
Low day price.
MODE_HIGH
2
High day price.
MODE_TIME
5
The last incoming quotation time.
MODE_BID
9
Last incoming bid price.
MODE_ASK
10
Last incoming ask price.
MODE_POINT
11
Point size.
MODE_DIGITS
12
Digits after decimal point.
MODE_SPREAD
13
Spread value in points.
MODE_STOPLEVEL
14
Stop level in points.
MODE_LOTSIZE
15
Lot size in the base currency.
MODE_TICKVALUE
16
Tick value.
MODE_TICKSIZE
17
Tick size.
MODE_SWAPLONG
18
Swap of the long position.
MODE_SWAPSHORT
19
Swap of the short position.
MODE_STARTING
20
Market starting date (usually used for future markets).
MODE_EXPIRATION
21
Market expiration date (usually used for future markets).
MODE_TRADEALLOWED 22
Trade is allowed for the symbol.
MODE_MINLOT
22
The minimum lot size in points.
MODE_LOTSTEP
22
Step for changing lots in points.
MessageBox return codes
The MessageBox() function return codes.
If a message box has a Cancel button, the function returns the IDCANCEL value if either the ESC key is pressed or 
the Cancel button is selected. If the message box has no Cancel button, pressing ESC has no effect.
Note: MessageBox return codes defined in the WinUser32.mqh file
Constant
Value
Description
IDOK
1
OK button was selected.
IDCANCEL
2
Cancel button was selected.
IDABORT
3
Abort button was selected.
IDRETRY
4
Retry button was selected.
IDIGNORE
5
Ignore button was selected.
IDYES
6
Yes button was selected.
IDNO
7
No button was selected.
IDTRYAGAIN
10
Try Again button was selected.
IDCONTINUE
11
Continue button was selected.
MessageBox behavior flags
The MessageBox function flags specify the contents and behavior of the dialog box. This value can be a 
combination of flags from the following groups of flags.
Note: MessageBox return codes defined in the WinUser32.mqh file
To indicate the buttons displayed in the message box, specify one of the following values.

Constant
Value
Description
MB_OK
0x00000000 The message box contains one push button: OK. This is the default.
MB_OKCANCEL
0x00000001 The message box contains two push buttons: OK and Cancel.
MB_ABORTRETRYIGNORE
0x00000002 The message box contains three push buttons: Abort, Retry, and Ignore.
MB_YESNOCANCEL
0x00000003 The message box contains three push buttons: Yes, No, and Cancel.
MB_YESNO
0x00000004 The message box contains two push buttons: Yes and No.
MB_RETRYCANCEL
0x00000005 The message box contains two push buttons: Retry and Cancel.
MB_CANCELTRYCONTINUE 0x00000006 Windows 2000: The message box contains three push buttons: Cancel, Try Again, 
Continue. Use this message box type instead of MB_ABORTRETRYIGNORE.
To display an icon in the message box, specify one of the following values.
Constant
Value
Description
MB_ICONSTOP, MB_ICONERROR, MB_ICONHAND 0x00000010 A stop-sign icon appears in the message box.
MB_ICONQUESTION
0x00000020 A question-mark icon appears in the message box.
MB_ICONEXCLAMATION, MB_ICONWARNING
0x00000030 An exclamation-point icon appears in the message box.
MB_ICONINFORMATION, MB_ICONASTERISK
0x00000040 An icon consisting of a lowercase letter i in a circle appears in 
the message box.
To indicate the default button, specify one of the following values.
Constant
Value
Description
MB_DEFBUTTON1
0x00000000 The first button is the default button. MB_DEFBUTTON1 is the default unless 
MB_DEFBUTTON2, MB_DEFBUTTON3, or MB_DEFBUTTON4 is specified.
MB_DEFBUTTON2
0x00000100 The second button is the default button.
MB_DEFBUTTON3
0x00000200 The third button is the default button.
MB_DEFBUTTON4
0x00000300 The fourth button is the default button.
Moving Average method enumeration
Moving Average calculation method. used with iAlligator(), iEnvelopes(), iEnvelopesOnArray, iForce(), iGator(), iMA(), 
iMAOnArray(),
 iStdDev(),
 iStdDevOnArray(),
 iStochastic() 
indicators.
It can be any of the following values:
Constant
Value
Description
MODE_SMA
0
Simple moving average,
MODE_EMA
1
Exponential moving average,
MODE_SMMA
2
Smoothed moving average,
MODE_LWMA
3
Linear weighted moving average.
Object properties enumeration
Object value index used with ObjectGet() and ObjectSet() functions. It can be any of the following values:

Constant
Value
Description
OBJPROP_TIME1
0
Datetime value to set/get first coordinate time part.
OBJPROP_PRICE1
1
Double value to set/get first coordinate price part.
OBJPROP_TIME2
2
Datetime value to set/get second coordinate time part.
OBJPROP_PRICE2
3
Double value to set/get second coordinate price part.
OBJPROP_TIME3
4
Datetime value to set/get third coordinate time part.
OBJPROP_PRICE3
5
Double value to set/get third coordinate price part.
OBJPROP_COLOR
6
Color value to set/get object color.
OBJPROP_STYLE
7
Value is one of STYLE_SOLID, STYLE_DASH, STYLE_DOT, STYLE_DASHDOT, 
STYLE_DASHDOTDOT constants to set/get object line style.
OBJPROP_WIDTH
8
Integer value to set/get object line width. Can be from 1 to 5.
OBJPROP_BACK
9
Boolean value to set/get background drawing flag for object.
OBJPROP_RAY
10
Boolean value to set/get ray flag of object.
OBJPROP_ELLIPSE
11
Boolean value to set/get ellipse flag for fibo arcs.
OBJPROP_SCALE
12
Double value to set/get scale object property.
OBJPROP_ANGLE
13
Double value to set/get angle object property in degrees.
OBJPROP_ARROWCODE
14
Integer value or arrow enumeration to set/get arrow code object property.
OBJPROP_TIMEFRAMES
15
Value can be one or combination (bitwise addition) of object visibility constants to set/get 
timeframe object property.
OBJPROP_DEVIATION
16
Double value to set/get deviation property for Standard deviation objects.
OBJPROP_FONTSIZE
100
Integer value to set/get font size for text objects.
OBJPROP_CORNER
101
Integer value to set/get anchor corner property for label objects. Must be from 0-3.
OBJPROP_XDISTANCE
102
Integer value to set/get anchor X distance object property in pixels.
OBJPROP_YDISTANCE
103
Integer value is to set/get anchor Y distance object property in pixels.
OBJPROP_FIBOLEVELS
200
Integer value to set/get Fibonacci object level count. Can be from 0 to 32.
OBJPROP_FIRSTLEVEL+n
210
Fibonacci object level index, where n is level index to set/get. Can be from 0 to 31.
Object type enumeration
Object type identifier constants used with ObjectCreate(), ObjectsDeleteAll() and ObjectType() functions. It can be 
any
 
of
 
the
 
following
 
values:
Objects can have 1-3 coordinates related to type. 

Constant
Value
Description
OBJ_VLINE
0
Vertical line. Uses time part of first coordinate.
OBJ_HLINE
1
Horizontal line. Uses price part of first coordinate.
OBJ_TREND
2
Trend line. Uses 2 coordinates.
OBJ_TRENDBYANGLE
3
Trend by angle. Uses 1 coordinate. To set angle of line use ObjectSet() function.
OBJ_REGRESSION
4
Regression. Uses time parts of first two coordinates.
OBJ_CHANNEL
5
Channel. Uses 3 coordinates.
OBJ_STDDEVCHANNEL
6
Standard deviation channel. Uses time parts of first two coordinates.
OBJ_GANNLINE
7
Gann line. Uses 2 coordinate, but price part of second coordinate ignored.
OBJ_GANNFAN
8
Gann fan. Uses 2 coordinate, but price part of second coordinate ignored.
OBJ_GANNGRID
9
Gann grid. Uses 2 coordinate, but price part of second coordinate ignored.
OBJ_FIBO
10
Fibonacci retracement. Uses 2 coordinates.
OBJ_FIBOTIMES
11
Fibonacci time zones. Uses 2 coordinates.
OBJ_FIBOFAN
12
Fibonacci fan. Uses 2 coordinates.
OBJ_FIBOARC
13
Fibonacci arcs. Uses 2 coordinates.
OBJ_EXPANSION
14
Fibonacci expansions. Uses 3 coordinates.
OBJ_FIBOCHANNEL
15
Fibonacci channel. Uses 3 coordinates.
OBJ_RECTANGLE
16
Rectangle. Uses 2 coordinates.
OBJ_TRIANGLE
17
Triangle. Uses 3 coordinates.
OBJ_ELLIPSE
18
Ellipse. Uses 2 coordinates.
OBJ_PITCHFORK
19
Andrews pitchfork. Uses 3 coordinates.
OBJ_CYCLES
20
Cycles. Uses 2 coordinates.
OBJ_TEXT
21
Text. Uses 1 coordinate.
OBJ_ARROW
22
Arrows. Uses 1 coordinate.
OBJ_LABEL
23
Text label. Uses 1 coordinate in pixels.
Object visibility enumeration
Time frames where object may be shown. Used in ObjectSet() function to set OBJPROP_TIMEFRAMES property.
Constant
Value
Description
OBJ_PERIOD_M1
0x0001
Object shown is only on 1-minute charts.
OBJ_PERIOD_M5
0x0002
Object shown is only on 5-minute charts.
OBJ_PERIOD_M15
0x0004
Object shown is only on 15-minute charts.
OBJ_PERIOD_M30
0x0008
Object shown is only on 30-minute charts.
OBJ_PERIOD_H1
0x0010
Object shown is only on 1-hour charts.
OBJ_PERIOD_H4
0x0020
Object shown is only on 4-hour charts.
OBJ_PERIOD_D1
0x0040
Object shown is only on daily charts.
OBJ_PERIOD_W1
0x0080
Object shown is only on weekly charts.
OBJ_PERIOD_MN1
0x0100
Object shown is only on monthly charts.
OBJ_ALL_PERIODS
0x01FF
Object shown is on all timeframes.
NULL
0
Object shown is on all timeframes.
EMPTY
-1
Hidden object on all timeframes.
Predefined Arrow codes enumeration
Predefined Arrow codes enumeration. Arrows code constants. It can be one of the following values:

Constant
Value
Description
SYMBOL_THUMBSUP
67
Thumb up symbol ().
SYMBOL_THUMBSDOWN
68
Thumb down symbol ().
SYMBOL_ARROWUP
241
Arrow up symbol ().
SYMBOL_ARROWDOWN
242
Arrow down symbol ().
SYMBOL_STOPSIGN
251
Stop sign symbol ().
SYMBOL_CHECKSIGN
252
Check sign symbol ().
Special Arrow codes that exactly points to price and time. 
It can be one of the following values:
Constant
Value
Description
1
Upwards arrow with tip rightwards (↱).
2
Downwards arrow with tip rightwards (↳).
3
Left pointing triangle (◄).
4
En Dash symbol (–).
SYMBOL_LEFTPRICE
5
Left sided price label.
SYMBOL_RIGHTPRICE
6
Right sided price label.
Series array identifier
Series  array  identifier  used  with
 ArrayCopySeries(),
 Highest() 
and
 Lowest() 
functions.
It can be any of the following values:
Constant
Value
Description
MODE_OPEN
0
Open price.
MODE_LOW
1
Low price.
MODE_HIGH
2
High price.
MODE_CLOSE
3
Close price.
MODE_VOLUME
4
Volume, used in Lowest() and Highest() functions.
MODE_TIME
5
Bar open time, used in ArrayCopySeries() function.
Special constants
Special constants used to indicate parameters and variables states. It can be one of the following values:
Constant
value
Description
NULL
0
Indicates empty state of the string.
EMPTY
-1
Indicates empty state of the parameter.
EMPTY_VALUE
0x7FFFFFFF Default custom indicator empty value.
CLR_NONE
0xFFFFFFFF Indicates empty state of colors.
WHOLE_ARRAY
0
Used with array functions. Indicates that all array elements will be processed.
Time frame enumeration
Time frame on the chart. It can be any of the following values:

Constant
Value
Description
PERIOD_M1
1
1 minute.
PERIOD_M5
5
5 minutes.
PERIOD_M15
15
15 minutes.
PERIOD_M30
30
30 minutes.
PERIOD_H1
60
1 hour.
PERIOD_H4
240
4 hour.
PERIOD_D1
1440
Daily.
PERIOD_W1
10080
Weekly.
PERIOD_MN1
43200
Monthly.
0 (zero)
0
Time frame used on the chart.
Trade operation enumeration
Operation type for the OrderSend() function. It can be any of the following values:
Constant
Value
Description
OP_BUY
0
Buying position.
OP_SELL
1
Selling position.
OP_BUYLIMIT
2
Buy limit pending position.
OP_SELLLIMIT
3
Sell limit pending position.
OP_BUYSTOP
4
Buy stop pending position.
OP_SELLSTOP
5
Sell stop pending position.
Uninitialize reason codes
Uninitialize reason codes returned by UninitializeReason() function. It can be any one of the following values:
Constant
Value
Description
REASON_REMOVE
1
Expert removed from chart.
REASON_RECOMPILE
2
Expert recompiled.
REASON_CHARTCHANGE 3
symbol or timeframe changed on the chart.
REASON_CHARTCLOSE
4
Chart closed.
REASON_PARAMETERS
5
Inputs parameters was changed by user.
REASON_ACCOUNT
6
Other account activated.
Wingdings symbols
Wingdings font symbols used with Arrow objects.

32 33 34 35 36 37 38 
39 40 41 42 43 44 45 46 47
48 49 
50 
51 
52 
53 
54 55 56 57 58 
59 60 61 
62 
63
64 
65 
66 
67 
68 69 70 
71 
72 73 74 
75 76 77 
78 
79
80 
81 82 
83 
84 
85 
86 
87 
88 89 90 
91 92 93 94 
95
96 97 98 
99 
10
0
10
1
10
2
10
3
10
4
10
5
10
6
10
7

10
8
10
9

11
0

11
1
11
2

11
3
11
4

11
5

11
6
11
7

11
8

11
9
12
0
12
1
12
2

12
3
12
4

12
5

12
6

12
7
12
8

12
9
13
0

13
1

13
2
…
13
3

13
4
13
5
13
6
‰13
7
13
8

13
9
14
0
14
1

14
2

14
3
14
4
‘
14
5
’
14
6
“
14
7
”
14
8

14
9
–
15
0
— 15
1
15
2
15
3
15
4
15
5
15
6
15
7

15
8

15
9

16
0

16
1
16
2

16
3

16
4

16
5
16
6

16
7
16
8
16
9
17
0

17
1
17
2
- 17
3

17
4

17
5
17
6

17
7
17
8

17
9

18
0

18
1

18
2
18
3
18
4
18
5
18
6

18
7
18
8
18
9

19
0

19
1
19
2

19
3
19
4

19
5

19
6

19
7

19
8
19
9
20
0
20
1
20
2
20
3
20
4
20
5

20
6

20
7
20
8
20
9
21
0
21
1
21
2
21
3
21
4
21
5
21
6
21
7
21
8

21
9
22
0
22
1

22
2

22
3
22
4

22
5
22
6

22
7

22
8

22
9

23
0
23
1
23
2
23
3
23
4

23
5
23
6
23
7

23
8

23
9
24
0

24
1
24
2
24
3

24
4

24
5

24
6
24
7
24
8

24
9

25
0

25
1

25
2
25
3

25
4

25
5
Web colors table
Black
DarkGreen
DarkSlateGray
Olive
Green
Teal
Navy
Purple
Maroon
Indigo
MidnightBlue
DarkBlue
DarkOliveGreen
SaddleBrown
ForestGreen
OliveDrab
SeaGreen
DarkGoldenrod
DarkSlateBlue
Sienna
MediumBlue
Brown
DarkTurquoise
DimGray
LightSeaGreen
DarkViolet
FireBrick
MediumVioletRed
MediumSeaGreen
Chocolate
Crimson
SteelBlue
Goldenrod
MediumSpringGreen
LawnGreen
CadetBlue
DarkOrchid
YellowGreen
LimeGreen
OrangeRed
DarkOrange
Orange
Gold
Yellow
Chartreuse
Lime
SpringGreen
Aqua
DeepSkyBlue
Blue
Magenta
Red
Gray
SlateGray
Peru
BlueViolet
LightSlateGray
DeepPink
MediumTurquoise
DodgerBlue
Turquoise
RoyalBlue
SlateBlue
DarkKhaki
IndianRed
MediumOrchid
GreenYellow
MediumAquamarine
DarkSeaGreen
Tomato
RosyBrown
Orchid
MediumPurple
PaleVioletRed
Coral
CornflowerBlue
DarkGray
SandyBrown
MediumSlateBlue
Tan
DarkSalmon
BurlyWood
HotPink
Salmon
Violet
LightCoral
SkyBlue
LightSalmon
Plum
Khaki
LightGreen
Aquamarine
Silver
LightSkyBlue
LightSteelBlue
LightBlue
PaleGreen
Thistle
PowderBlue
PaleGoldenrod
PaleTurquoise
LightGray
Wheat
NavajoWhite
Moccasin
LightPink
Gainsboro
PeachPuff
Pink
Bisque
LightGoldenRod
BlanchedAlmond
LemonChiffon
Beige
AntiqueWhite
PapayaWhip
Cornsilk
LightYellow
LightCyan
Linen
Lavender
MistyRose
OldLace
WhiteSmoke
Seashell
Ivory
Honeydew
AliceBlue
LavenderBlush
MintCream
Snow
White