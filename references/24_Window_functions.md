# Window functions

Page: 96

---

Window functions
BarsPerWindow()
FirstVisibleBar()
PriceOnDropped()
TimeOnDropped()
WindowFind()
WindowHandle()
WindowIsVisible
WindowOnDropped()
WindowsTotal()
WindowXOnDropped()
WindowYOnDropped()
int BarsPerWindow()
Function returns the amount of bars visible on the chart. 
Sample

   // work with visible bars.
   int bars_count=BarsPerWindow();
   int bar=FirstVisibleBar();
   for(int i=0; i<bars_count; i++,bar--)
     {
      // ...
     }
int FirstVisibleBar()
Function returns index of the first visible bar. 
Sample
   // work with visible bars.
   int bars_count=BarsPerWindow();
   int bar=FirstVisibleBar();
   for(int i=0; i<bars_count; i++,bar--)
     {
      // ...
     }
int FirstVisibleBar()
Function returns index of the first visible bar. 
Sample
   // work with visible bars.
   int bars_count=BarsPerWindow();
   int bar=FirstVisibleBar();
   for(int i=0; i<bars_count; i++,bar--)
     {
      // ...
     }
datetime TimeOnDropped()
Returns time part of dropped point where expert or script was dropped. This value is valid when expert or script dropped by 
mouse.
Note: For custom indicators this value is undefined. 
Sample
  double   drop_price=PriceOnDropped();
  datetime drop_time=TimeOnDropped();
  //---- may be undefined (zero)
  if(drop_time>0)
    {
     ObjectCreate("Dropped price line", OBJ_HLINE, 0, drop_price);
     ObjectCreate("Dropped time line", OBJ_VLINE, 0, drop_time);
    }
int WindowFind(string name)
If  indicator  with  name found  returns  the  window  index  containing  specified  indicator,  otherwise  returns  -1.
Note: WindowFind() returns -1 if ñustom indicator searches itself when init() function works. 
Parameters
name   -  Indicator short name.
Sample

  int win_idx=WindowFind("MACD(12,26,9)");
int WindowHandle(string symbol, int timeframe)
If chart of symbol and timeframe is currently opened returns the window handle, otherwise returns 0.
Parameters
symbol
  -  symbol name.
timeframe   -  Time frame. It can be any of Time frame enumeration values.
Sample
  int win_handle=WindowHandle("USDX",PERIOD_H1);
  if(win_handle!=0)
    Print("Window with USDX,H1 detected. Rates array will be copied immediately.");
bool WindowIsVisible(int index)
Returns true if the chart subwindow is visible, otherwise returns false.
Parameters
index   -  Chart subwindow index.
Sample
  int maywin=WindowFind("MyMACD");
  if(maywin>-1 && WindowIsVisible(maywin)==true)
    Print("window of MyMACD is visible");
  else
    Print("window of MyMACD not found or is not visible");
int WindowOnDropped()
Returns window index where expert, custom indicator or script was dropped. This value is valid when expert, custom indicator or 
script
 
dropped
 
by
 
mouse.
Note: For custom indicators this index is undefined when init() function works and returning index is window index where custom 
indicator works (may be different from dropping window index, because custom indicator can create its own new window). See 
also WindowXOnDropped(), WindowYOnDropped() 
Sample
  if(WindowOnDropped()!=0)
    {
     Print("Indicator 'MyIndicator' must be applied to main chart window!");
     return(false);
    }
int WindowsTotal()
Returns count of indicator windows on the chart (including main chart).
Sample
  Print("Windows count = ", WindowsTotal());
int WindowXOnDropped()
Returns  x-axis  coordinate  in  pixels  were  expert  or  script  dropped  to  the  chart.  See  also WindowYOnDropped(), 
WindowOnDropped() 
Sample
  Print("Expert dropped point x=",WindowXOnDropped()," y=",WindowYOnDropped());

int WindowYOnDropped()
Returns  y-axis  coordinate  in  pixels  were  expert  or  script  dropped  to  the  chart.  See  also WindowYOnDropped(), 
WindowOnDropped() 
Sample
  Print("Expert dropped point x=",WindowXOnDropped()," y=",WindowYOnDropped());
Include Files
//+------------------------------------------------------------------+
//|                                                     stderror.mqh |
//|                 Copyright © 2004-2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
//---- errors returned from trade server
#define ERR_NO_ERROR                                  0
#define ERR_NO_RESULT                                 1
#define ERR_COMMON_ERROR                              2
#define ERR_INVALID_TRADE_PARAMETERS                  3
#define ERR_SERVER_BUSY                               4
#define ERR_OLD_VERSION                               5
#define ERR_NO_CONNECTION                             6
#define ERR_NOT_ENOUGH_RIGHTS                         7
#define ERR_TOO_FREQUENT_REQUESTS                     8
#define ERR_MALFUNCTIONAL_TRADE                       9
#define ERR_ACCOUNT_DISABLED                         64
#define ERR_INVALID_ACCOUNT                          65
#define ERR_TRADE_TIMEOUT                           128
#define ERR_INVALID_PRICE                           129
#define ERR_INVALID_STOPS                           130
#define ERR_INVALID_TRADE_VOLUME                    131
#define ERR_MARKET_CLOSED                           132
#define ERR_TRADE_DISABLED                          133
#define ERR_NOT_ENOUGH_MONEY                        134
#define ERR_PRICE_CHANGED                           135
#define ERR_OFF_QUOTES                              136
#define ERR_BROKER_BUSY                             137
#define ERR_REQUOTE                                 138
#define ERR_ORDER_LOCKED                            139
#define ERR_LONG_POSITIONS_ONLY_ALLOWED             140
#define ERR_TOO_MANY_REQUESTS                       141
#define ERR_TRADE_MODIFY_DENIED                     145
#define ERR_TRADE_CONTEXT_BUSY                      146
//---- mql4 run time errors
#define ERR_NO_MQLERROR                            4000
#define ERR_WRONG_FUNCTION_POINTER                 4001
#define ERR_ARRAY_INDEX_OUT_OF_RANGE               4002
#define ERR_NO_MEMORY_FOR_FUNCTION_CALL_STACK      4003
#define ERR_RECURSIVE_STACK_OVERFLOW               4004
#define ERR_NOT_ENOUGH_STACK_FOR_PARAMETER         4005
#define ERR_NO_MEMORY_FOR_PARAMETER_STRING         4006
#define ERR_NO_MEMORY_FOR_TEMP_STRING              4007
#define ERR_NOT_INITIALIZED_STRING                 4008
#define ERR_NOT_INITIALIZED_ARRAYSTRING            4009
#define ERR_NO_MEMORY_FOR_ARRAYSTRING              4010
#define ERR_TOO_LONG_STRING                        4011
#define ERR_REMAINDER_FROM_ZERO_DIVIDE             4012
#define ERR_ZERO_DIVIDE                            4013
#define ERR_UNKNOWN_COMMAND                        4014
#define ERR_WRONG_JUMP                             4015
#define ERR_NOT_INITIALIZED_ARRAY                  4016
#define ERR_DLL_CALLS_NOT_ALLOWED                  4017
#define ERR_CANNOT_LOAD_LIBRARY                    4018
#define ERR_CANNOT_CALL_FUNCTION                   4019

#define ERR_EXTERNAL_EXPERT_CALLS_NOT_ALLOWED      4020
#define ERR_NOT_ENOUGH_MEMORY_FOR_RETURNED_STRING  4021
#define ERR_SYSTEM_BUSY                            4022
#define ERR_INVALID_FUNCTION_PARAMETERS_COUNT      4050
#define ERR_INVALID_FUNCTION_PARAMETER_VALUE       4051
#define ERR_STRING_FUNCTION_INTERNAL_ERROR         4052
#define ERR_SOME_ARRAY_ERROR                       4053
#define ERR_INCORRECT_SERIES_ARRAY_USING           4054
#define ERR_CUSTOM_INDICATOR_ERROR                 4055
#define ERR_INCOMPATIBLE_ARRAYS                    4056
#define ERR_GLOBAL_VARIABLES_PROCESSING_ERROR      4057
#define ERR_GLOBAL_VARIABLE_NOT_FOUND              4058
#define ERR_FUNCTION_NOT_ALLOWED_IN_TESTING_MODE   4059
#define ERR_FUNCTION_NOT_CONFIRMED                 4060
#define ERR_SEND_MAIL_ERROR                        4061
#define ERR_STRING_PARAMETER_EXPECTED              4062
#define ERR_INTEGER_PARAMETER_EXPECTED             4063
#define ERR_DOUBLE_PARAMETER_EXPECTED              4064
#define ERR_ARRAY_AS_PARAMETER_EXPECTED            4065
#define ERR_HISTORY_WILL_UPDATED                   4066
#define ERR_END_OF_FILE                            4099
#define ERR_SOME_FILE_ERROR                        4100
#define ERR_WRONG_FILE_NAME                        4101
#define ERR_TOO_MANY_OPENED_FILES                  4102
#define ERR_CANNOT_OPEN_FILE                       4103
#define ERR_INCOMPATIBLE_ACCESS_TO_FILE            4104
#define ERR_NO_ORDER_SELECTED                      4105
#define ERR_UNKNOWN_SYMBOL                         4106
#define ERR_INVALID_PRICE_PARAM                    4107
#define ERR_INVALID_TICKET                         4108
#define ERR_TRADE_NOT_ALLOWED                      4109
#define ERR_LONGS__NOT_ALLOWED                     4110
#define ERR_SHORTS_NOT_ALLOWED                     4111
#define ERR_OBJECT_ALREADY_EXISTS                  4200
#define ERR_UNKNOWN_OBJECT_PROPERTY                4201
#define ERR_OBJECT_DOES_NOT_EXIST                  4202
#define ERR_UNKNOWN_OBJECT_TYPE                    4203
#define ERR_NO_OBJECT_NAME                         4204
#define ERR_OBJECT_COORDINATES_ERROR               4205
#define ERR_NO_SPECIFIED_SUBWINDOW                 4206
//+------------------------------------------------------------------+
//|                                                       stdlib.mqh |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#import "stdlib.ex4"
string ErrorDescription(int error_code);
int    RGB(int red_value,int green_value,int blue_value);
bool   CompareDoubles(double number1,double number2);
string DoubleToStrMorePrecision(double number,int precision);
string IntegerToHexString(int integer_number);
//+------------------------------------------------------------------+
//|                                                    WinUser32.mqh |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#define   copyright "Copyright © 2004, MetaQuotes Software Corp."
#define   link      "http://www.metaquotes.net/"
#import "user32.dll"
   //---- messages

   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
   int      SendNotifyMessageA(int hWnd,int Msg,int wParam,int lParam);
   int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
   void     keybd_event(int bVk,int bScan,int dwFlags,int dwExtraInfo);
   void     mouse_event(int dwFlags,int dx,int dy,int dwData,int dwExtraInfo);
   //---- windows
   int      FindWindowA(string lpClassName ,string lpWindowName);
   int      SetWindowTextA(int hWnd,string lpString);
   int      GetWindowTextA(int hWnd,string lpString,int nMaxCount);
   int      GetWindowTextLengthA(int hWnd);
   int      GetWindow(int hWnd,int uCmd);
   int      UpdateWindow(int hWnd);
   int      EnableWindow(int hWnd,int bEnable);
   int      DestroyWindow(int hWnd);
   int      ShowWindow(int hWnd,int nCmdShow);
   int      SetActiveWindow(int hWnd);
   int      AnimateWindow(int hWnd,int dwTime,int dwFlags);
   int      FlashWindow(int hWnd,int dwFlags /*bInvert*/);
   int      CloseWindow(int hWnd);
   int      MoveWindow(int hWnd,int X,int Y,int nWidth,int nHeight,int bRepaint);
   int      SetWindowPos(int hWnd,int hWndInsertAfter ,int X,int Y,int cx,int cy,int 
uFlags);
   int      IsWindowVisible(int hWnd);
   int      IsIconic(int hWnd);
   int      IsZoomed(int hWnd);
   int      SetFocus(int hWnd);
   int      GetFocus();
   int      GetActiveWindow();
   int      IsWindowEnabled(int hWnd);
   //---- miscelaneouse
   int      MessageBoxA(int hWnd ,string lpText,string lpCaption,int uType);
   int      MessageBoxExA(int hWnd ,string lpText,string lpCaption,int uType,int 
wLanguageId);
   int      MessageBeep(int uType);
   int      GetSystemMetrics(int nIndex);
   int      ExitWindowsEx(int uFlags,int dwReserved);
   int      SwapMouseButton(int fSwap);
#import
//---- Window Messages
#define WM_NULL                        0x0000
#define WM_CREATE                      0x0001
#define WM_DESTROY                     0x0002
#define WM_MOVE                        0x0003
#define WM_SIZE                        0x0005
#define WM_ACTIVATE                    0x0006
#define WM_SETFOCUS                    0x0007
#define WM_KILLFOCUS                   0x0008
#define WM_ENABLE                      0x000A
#define WM_SETREDRAW                   0x000B
#define WM_SETTEXT                     0x000C
#define WM_GETTEXT                     0x000D
#define WM_GETTEXTLENGTH               0x000E
#define WM_PAINT                       0x000F
#define WM_CLOSE                       0x0010
#define WM_QUERYENDSESSION             0x0011
#define WM_QUIT                        0x0012
#define WM_QUERYOPEN                   0x0013
#define WM_ERASEBKGND                  0x0014
#define WM_SYSCOLORCHANGE              0x0015
#define WM_ENDSESSION                  0x0016
#define WM_SHOWWINDOW                  0x0018
#define WM_WININICHANGE                0x001A
#define WM_SETTINGCHANGE               0x001A // WM_WININICHANGE
#define WM_DEVMODECHANGE               0x001B
#define WM_ACTIVATEAPP                 0x001C

#define WM_FONTCHANGE                  0x001D
#define WM_TIMECHANGE                  0x001E
#define WM_CANCELMODE                  0x001F
#define WM_SETCURSOR                   0x0020
#define WM_MOUSEACTIVATE               0x0021
#define WM_CHILDACTIVATE               0x0022
#define WM_QUEUESYNC                   0x0023
#define WM_GETMINMAXINFO               0x0024
#define WM_PAINTICON                   0x0026
#define WM_ICONERASEBKGND              0x0027
#define WM_NEXTDLGCTL                  0x0028
#define WM_SPOOLERSTATUS               0x002A
#define WM_DRAWITEM                    0x002B
#define WM_MEASUREITEM                 0x002C
#define WM_DELETEITEM                  0x002D
#define WM_VKEYTOITEM                  0x002E
#define WM_CHARTOITEM                  0x002F
#define WM_SETFONT                     0x0030
#define WM_GETFONT                     0x0031
#define WM_SETHOTKEY                   0x0032
#define WM_GETHOTKEY                   0x0033
#define WM_QUERYDRAGICON               0x0037
#define WM_COMPAREITEM                 0x0039
#define WM_GETOBJECT                   0x003D
#define WM_COMPACTING                  0x0041
#define WM_WINDOWPOSCHANGING           0x0046
#define WM_WINDOWPOSCHANGED            0x0047
#define WM_COPYDATA                    0x004A
#define WM_CANCELJOURNAL               0x004B
#define WM_NOTIFY                      0x004E
#define WM_INPUTLANGCHANGEREQUEST      0x0050
#define WM_INPUTLANGCHANGE             0x0051
#define WM_TCARD                       0x0052
#define WM_HELP                        0x0053
#define WM_USERCHANGED                 0x0054
#define WM_NOTIFYFORMAT                0x0055
#define WM_CONTEXTMENU                 0x007B
#define WM_STYLECHANGING               0x007C
#define WM_STYLECHANGED                0x007D
#define WM_DISPLAYCHANGE               0x007E
#define WM_GETICON                     0x007F
#define WM_SETICON                     0x0080
#define WM_NCCREATE                    0x0081
#define WM_NCDESTROY                   0x0082
#define WM_NCCALCSIZE                  0x0083
#define WM_NCHITTEST                   0x0084
#define WM_NCPAINT                     0x0085
#define WM_NCACTIVATE                  0x0086
#define WM_GETDLGCODE                  0x0087
#define WM_SYNCPAINT                   0x0088
#define WM_NCMOUSEMOVE                 0x00A0
#define WM_NCLBUTTONDOWN               0x00A1
#define WM_NCLBUTTONUP                 0x00A2
#define WM_NCLBUTTONDBLCLK             0x00A3
#define WM_NCRBUTTONDOWN               0x00A4
#define WM_NCRBUTTONUP                 0x00A5
#define WM_NCRBUTTONDBLCLK             0x00A6
#define WM_NCMBUTTONDOWN               0x00A7
#define WM_NCMBUTTONUP                 0x00A8
#define WM_NCMBUTTONDBLCLK             0x00A9
#define WM_KEYFIRST                    0x0100
#define WM_KEYDOWN                     0x0100
#define WM_KEYUP                       0x0101
#define WM_CHAR                        0x0102
#define WM_DEADCHAR                    0x0103
#define WM_SYSKEYDOWN                  0x0104
#define WM_SYSKEYUP                    0x0105

#define WM_SYSCHAR                     0x0106
#define WM_SYSDEADCHAR                 0x0107
#define WM_KEYLAST                     0x0108
#define WM_INITDIALOG                  0x0110
#define WM_COMMAND                     0x0111
#define WM_SYSCOMMAND                  0x0112
#define WM_TIMER                       0x0113
#define WM_HSCROLL                     0x0114
#define WM_VSCROLL                     0x0115
#define WM_INITMENU                    0x0116
#define WM_INITMENUPOPUP               0x0117
#define WM_MENUSELECT                  0x011F
#define WM_MENUCHAR                    0x0120
#define WM_ENTERIDLE                   0x0121
#define WM_MENURBUTTONUP               0x0122
#define WM_MENUDRAG                    0x0123
#define WM_MENUGETOBJECT               0x0124
#define WM_UNINITMENUPOPUP             0x0125
#define WM_MENUCOMMAND                 0x0126
#define WM_CTLCOLORMSGBOX              0x0132
#define WM_CTLCOLOREDIT                0x0133
#define WM_CTLCOLORLISTBOX             0x0134
#define WM_CTLCOLORBTN                 0x0135
#define WM_CTLCOLORDLG                 0x0136
#define WM_CTLCOLORSCROLLBAR           0x0137
#define WM_CTLCOLORSTATIC              0x0138
#define WM_MOUSEFIRST                  0x0200
#define WM_MOUSEMOVE                   0x0200
#define WM_LBUTTONDOWN                 0x0201
#define WM_LBUTTONUP                   0x0202
#define WM_LBUTTONDBLCLK               0x0203
#define WM_RBUTTONDOWN                 0x0204
#define WM_RBUTTONUP                   0x0205
#define WM_RBUTTONDBLCLK               0x0206
#define WM_MBUTTONDOWN                 0x0207
#define WM_MBUTTONUP                   0x0208
#define WM_MBUTTONDBLCLK               0x0209
#define WM_PARENTNOTIFY                0x0210
#define WM_ENTERMENULOOP               0x0211
#define WM_EXITMENULOOP                0x0212
#define WM_NEXTMENU                    0x0213
#define WM_SIZING                      0x0214
#define WM_CAPTURECHANGED              0x0215
#define WM_MOVING                      0x0216
#define WM_DEVICECHANGE                0x0219
#define WM_MDICREATE                   0x0220
#define WM_MDIDESTROY                  0x0221
#define WM_MDIACTIVATE                 0x0222
#define WM_MDIRESTORE                  0x0223
#define WM_MDINEXT                     0x0224
#define WM_MDIMAXIMIZE                 0x0225
#define WM_MDITILE                     0x0226
#define WM_MDICASCADE                  0x0227
#define WM_MDIICONARRANGE              0x0228
#define WM_MDIGETACTIVE                0x0229
#define WM_MDISETMENU                  0x0230
#define WM_ENTERSIZEMOVE               0x0231
#define WM_EXITSIZEMOVE                0x0232
#define WM_DROPFILES                   0x0233
#define WM_MDIREFRESHMENU              0x0234
#define WM_MOUSEHOVER                  0x02A1
#define WM_MOUSELEAVE                  0x02A3
#define WM_CUT                         0x0300
#define WM_COPY                        0x0301
#define WM_PASTE                       0x0302
#define WM_CLEAR                       0x0303
#define WM_UNDO                        0x0304

#define WM_RENDERFORMAT                0x0305
#define WM_RENDERALLFORMATS            0x0306
#define WM_DESTROYCLIPBOARD            0x0307
#define WM_DRAWCLIPBOARD               0x0308
#define WM_PAINTCLIPBOARD              0x0309
#define WM_VSCROLLCLIPBOARD            0x030A
#define WM_SIZECLIPBOARD               0x030B
#define WM_ASKCBFORMATNAME             0x030C
#define WM_CHANGECBCHAIN               0x030D
#define WM_HSCROLLCLIPBOARD            0x030E
#define WM_QUERYNEWPALETTE             0x030F
#define WM_PALETTEISCHANGING           0x0310
#define WM_PALETTECHANGED              0x0311
#define WM_HOTKEY                      0x0312
#define WM_PRINT                       0x0317
#define WM_PRINTCLIENT                 0x0318
#define WM_HANDHELDFIRST               0x0358
#define WM_HANDHELDLAST                0x035F
#define WM_AFXFIRST                    0x0360
#define WM_AFXLAST                     0x037F
#define WM_PENWINFIRST                 0x0380
#define WM_PENWINLAST                  0x038F
#define WM_APP                         0x8000
 
//---- keybd_event routines
#define KEYEVENTF_EXTENDEDKEY          0x0001
#define KEYEVENTF_KEYUP                0x0002
//---- mouse_event routines
#define MOUSEEVENTF_MOVE               0x0001 // mouse move
#define MOUSEEVENTF_LEFTDOWN           0x0002 // left button down
#define MOUSEEVENTF_LEFTUP             0x0004 // left button up
#define MOUSEEVENTF_RIGHTDOWN          0x0008 // right button down
#define MOUSEEVENTF_RIGHTUP            0x0010 // right button up
#define MOUSEEVENTF_MIDDLEDOWN         0x0020 // middle button down
#define MOUSEEVENTF_MIDDLEUP           0x0040 // middle button up
#define MOUSEEVENTF_WHEEL              0x0800 // wheel button rolled
#define MOUSEEVENTF_ABSOLUTE           0x8000 // absolute move
//---- GetSystemMetrics() codes
#define SM_CXSCREEN                    0
#define SM_CYSCREEN                    1
#define SM_CXVSCROLL                   2
#define SM_CYHSCROLL                   3
#define SM_CYCAPTION                   4
#define SM_CXBORDER                    5
#define SM_CYBORDER                    6
#define SM_CXDLGFRAME                  7
#define SM_CYDLGFRAME                  8
#define SM_CYVTHUMB                    9
#define SM_CXHTHUMB                    10
#define SM_CXICON                      11
#define SM_CYICON                      12
#define SM_CXCURSOR                    13
#define SM_CYCURSOR                    14
#define SM_CYMENU                      15
#define SM_CXFULLSCREEN                16
#define SM_CYFULLSCREEN                17
#define SM_CYKANJIWINDOW               18
#define SM_MOUSEPRESENT                19
#define SM_CYVSCROLL                   20
#define SM_CXHSCROLL                   21
#define SM_DEBUG                       22
#define SM_SWAPBUTTON                  23
#define SM_RESERVED1                   24
#define SM_RESERVED2                   25
#define SM_RESERVED3                   26
#define SM_RESERVED4                   27

#define SM_CXMIN                       28
#define SM_CYMIN                       29
#define SM_CXSIZE                      30
#define SM_CYSIZE                      31
#define SM_CXFRAME                     32
#define SM_CYFRAME                     33
#define SM_CXMINTRACK                  34
#define SM_CYMINTRACK                  35
#define SM_CXDOUBLECLK                 36
#define SM_CYDOUBLECLK                 37
#define SM_CXICONSPACING               38
#define SM_CYICONSPACING               39
#define SM_MENUDROPALIGNMENT           40
#define SM_PENWINDOWS                  41
#define SM_DBCSENABLED                 42
#define SM_CMOUSEBUTTONS               43
#define SM_SECURE                      44
#define SM_CXEDGE                      45
#define SM_CYEDGE                      46
#define SM_CXMINSPACING                47
#define SM_CYMINSPACING                48
#define SM_CXSMICON                    49
#define SM_CYSMICON                    50
#define SM_CYSMCAPTION                 51
#define SM_CXSMSIZE                    52
#define SM_CYSMSIZE                    53
#define SM_CXMENUSIZE                  54
#define SM_CYMENUSIZE                  55
#define SM_ARRANGE                     56
#define SM_CXMINIMIZED                 57
#define SM_CYMINIMIZED                 58
#define SM_CXMAXTRACK                  59
#define SM_CYMAXTRACK                  60
#define SM_CXMAXIMIZED                 61
#define SM_CYMAXIMIZED                 62
#define SM_NETWORK                     63
#define SM_CLEANBOOT                   67
#define SM_CXDRAG                      68
#define SM_CYDRAG                      69
#define SM_SHOWSOUNDS                  70
#define SM_CXMENUCHECK                 71 // Use instead of 
GetMenuCheckMarkDimensions()!
#define SM_CYMENUCHECK                 72
#define SM_SLOWMACHINE                 73
#define SM_MIDEASTENABLED              74
#define SM_MOUSEWHEELPRESENT           75
#define SM_XVIRTUALSCREEN              76
#define SM_YVIRTUALSCREEN              77
#define SM_CXVIRTUALSCREEN             78
#define SM_CYVIRTUALSCREEN             79
#define SM_CMONITORS                   80
#define SM_SAMEDISPLAYFORMAT           81
//---- GetWindow() Constants
#define GW_HWNDFIRST                   0
#define GW_HWNDLAST                    1
#define GW_HWNDNEXT                    2
#define GW_HWNDPREV                    3
#define GW_OWNER                       4
#define GW_CHILD                       5
//---- AnimateWindow() Commands
#define AW_HOR_POSITIVE                0x00000001
#define AW_HOR_NEGATIVE                0x00000002
#define AW_VER_POSITIVE                0x00000004
#define AW_VER_NEGATIVE                0x00000008
#define AW_CENTER                      0x00000010

#define AW_HIDE                        0x00010000
#define AW_ACTIVATE                    0x00020000
#define AW_SLIDE                       0x00040000
#define AW_BLEND                       0x00080000
//---- MessageBox() Flags
#define MB_OK                       
0x00000000
#define MB_OKCANCEL                 
0x00000001
#define MB_ABORTRETRYIGNORE         
0x00000002
#define MB_YESNOCANCEL              
0x00000003
#define MB_YESNO                    
0x00000004
#define MB_RETRYCANCEL              
0x00000005
#define MB_ICONHAND                 
0x00000010
#define MB_ICONQUESTION             
0x00000020
#define MB_ICONEXCLAMATION          
0x00000030
#define MB_ICONASTERISK             
0x00000040
#define MB_USERICON                 
0x00000080
#define MB_ICONWARNING              
MB_ICONEXCLAMATION
#define MB_ICONERROR                
MB_ICONHAND
#define MB_ICONINFORMATION          
MB_ICONASTERISK
#define MB_ICONSTOP                 
MB_ICONHAND
#define MB_DEFBUTTON1               
0x00000000
#define MB_DEFBUTTON2               
0x00000100
#define MB_DEFBUTTON3               
0x00000200
#define MB_DEFBUTTON4               
0x00000300
#define MB_APPLMODAL                
0x00000000
#define MB_SYSTEMMODAL              
0x00001000
#define MB_TASKMODAL                
0x00002000
#define MB_HELP                     
0x00004000 // Help Button
#define MB_NOFOCUS                  
0x00008000
#define MB_SETFOREGROUND            
0x00010000
#define MB_DEFAULT_DESKTOP_ONLY     
0x00020000
#define MB_TOPMOST                  
0x00040000
#define MB_RIGHT                    
0x00080000
#define MB_RTLREADING               
0x00100000
//---- Dialog Box Command IDs
#define IDOK                           1
#define IDCANCEL                       2
#define IDABORT                        3
#define IDRETRY                        4
#define IDIGNORE                       5
#define IDYES                          6
#define IDNO                           7
#define IDCLOSE                        8
#define IDHELP                         9
//+------------------------------------------------------------------+
Scripts
//+------------------------------------------------------------------+
//|                                             Period_Converter.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
#property show_inputs
#include <WinUser32.mqh>
extern int ExtPeriodMultiplier=3; // new period multiplier factor
int        ExtHandle=-1;
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+

int start()
  {
   int    i, start_pos, i_time, time0, last_fpos, periodseconds;
   double d_open, d_low, d_high, d_close, d_volume, last_volume;
   int    hwnd=0,cnt=0;
//---- History header
   int    version=400;
   string c_copyright;
   string c_symbol=Symbol();
   int    i_period=Period()*ExtPeriodMultiplier;
   int    i_digits=Digits;
   int    i_unused[13];
//----  
   ExtHandle=FileOpenHistory(c_symbol+i_period+".hst", FILE_BIN|FILE_WRITE);
   if(ExtHandle < 0) return(-1);
//---- write history file header
   c_copyright="(C)opyright 2003, MetaQuotes Software Corp.";
   FileWriteInteger(ExtHandle, version, LONG_VALUE);
   FileWriteString(ExtHandle, c_copyright, 64);
   FileWriteString(ExtHandle, c_symbol, 12);
   FileWriteInteger(ExtHandle, i_period, LONG_VALUE);
   FileWriteInteger(ExtHandle, i_digits, LONG_VALUE);
   FileWriteInteger(ExtHandle, 0, LONG_VALUE);       //timesign
   FileWriteInteger(ExtHandle, 0, LONG_VALUE);       //last_sync
   FileWriteArray(ExtHandle, i_unused, 0, 13);
//---- write history file
   periodseconds=i_period*60;
   start_pos=Bars-1;
   d_open=Open[start_pos];
   d_low=Low[start_pos];
   d_high=High[start_pos];
   d_volume=Volume[start_pos];
   //---- normalize open time
   i_time=Time[start_pos]/periodseconds;
   i_time*=periodseconds;
   for(i=start_pos-1;i>=0; i--)
     {
      time0=Time[i];
      if(time0>=i_time+periodseconds || i==0)
        {
         if(i==0 && time0<i_time+periodseconds)
           {
            d_volume+=Volume[0];
            if (Low[0]<d_low)   d_low=Low[0];
            if (High[0]>d_high) d_high=High[0];
            d_close=Close[0];
           }
         last_fpos=FileTell(ExtHandle);
         last_volume=Volume[i];
         FileWriteInteger(ExtHandle, i_time, LONG_VALUE);
         FileWriteDouble(ExtHandle, d_open, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_low, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_high, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_close, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_volume, DOUBLE_VALUE);
         FileFlush(ExtHandle);
         cnt++;
         if(time0>=i_time+periodseconds)
           {
            i_time=time0/periodseconds;
            i_time*=periodseconds;
            d_open=Open[i];
            d_low=Low[i];
            d_high=High[i];
            d_close=Close[i];
            d_volume=last_volume;
           }

        }
       else
        {
         d_volume+=Volume[i];
         if (Low[i]<d_low)   d_low=Low[i];
         if (High[i]>d_high) d_high=High[i];
         d_close=Close[i];
        }
     } 
   FileFlush(ExtHandle);
   Print(cnt," record(s) written");
//---- collect incoming ticks
   int last_time=LocalTime()-5;
   while(true)
     {
      int cur_time=LocalTime();
      //---- check for new rates
      if(RefreshRates())
        {
         time0=Time[0];
         FileSeek(ExtHandle,last_fpos,SEEK_SET);
         //---- is there current bar?
         if(time0<i_time+periodseconds)
           {
            d_volume+=Volume[0]-last_volume;
            last_volume=Volume[0]; 
            if (Low[0]<d_low) d_low=Low[0];
            if (High[0]>d_high) d_high=High[0];
            d_close=Close[0];
           }
         else
           {
            //---- no, there is new bar
            d_volume+=Volume[1]-last_volume;
            if (Low[1]<d_low) d_low=Low[1];
            if (High[1]>d_high) d_high=High[1];
            //---- write previous bar remains
            FileWriteInteger(ExtHandle, i_time, LONG_VALUE);
            FileWriteDouble(ExtHandle, d_open, DOUBLE_VALUE);
            FileWriteDouble(ExtHandle, d_low, DOUBLE_VALUE);
            FileWriteDouble(ExtHandle, d_high, DOUBLE_VALUE);
            FileWriteDouble(ExtHandle, d_close, DOUBLE_VALUE);
            FileWriteDouble(ExtHandle, d_volume, DOUBLE_VALUE);
            last_fpos=FileTell(ExtHandle);
            //----
            i_time=time0/periodseconds;
            i_time*=periodseconds;
            d_open=Open[0];
            d_low=Low[0];
            d_high=High[0];
            d_close=Close[0];
            d_volume=Volume[0];
            last_volume=d_volume;
           }
         //----
         FileWriteInteger(ExtHandle, i_time, LONG_VALUE);
         FileWriteDouble(ExtHandle, d_open, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_low, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_high, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_close, DOUBLE_VALUE);
         FileWriteDouble(ExtHandle, d_volume, DOUBLE_VALUE);
         FileFlush(ExtHandle);
         //----
         if(hwnd==0)
           {
            hwnd=WindowHandle(Symbol(),i_period);
            if(hwnd!=0) Print("Chart window detected");

           }
         //---- refresh window not frequently than 1 time in 2 seconds
         if(hwnd!=0 && cur_time-last_time>=2)
           {
            PostMessageA(hwnd,WM_COMMAND,33324,0);
            last_time=cur_time;
           }
        } 
     }      
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   if(ExtHandle>=0) { FileClose(ExtHandle); ExtHandle=-1; }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  rotate_text.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#include <stdlib.mqh>
string line_name="rotating_line";
string object_name1="rotating_text";
void init()
  {
   Print("point = ", Point,"   bars=",Bars);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   ObjectDelete(line_name);
   ObjectDelete(object_name1);
   ObjectsRedraw();
  }
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
   int    time2;
   int    error,index,fontsize=10;
   double price,price1,price2;
   double angle=0.0;
//----
   price2=High[10]+Point*10;
   ObjectCreate(line_name, OBJ_TRENDBYANGLE, 0, Time[10], price2);
   index=20;
   ObjectCreate(object_name1, OBJ_TEXT, 0, Time[index], Low[index]-Point*100);
   ObjectSetText(object_name1, "rotating_text", fontsize);
   while(IsStopped()==false)
     {
      index++;
      price=ObjectGet(object_name1, OBJPROP_PRICE1)+Point;
      error=GetLastError();
      if(error!=0)

        {
         Print(object_name1," : ",ErrorDescription(error));
         break;
        }
      ObjectMove(object_name1, 0, Time[index], price);
      ObjectSet(object_name1, OBJPROP_ANGLE, angle*2);
      ObjectSet(object_name1, OBJPROP_FONTSIZE, fontsize);
      ObjectSet(line_name, OBJPROP_WIDTH, angle/18.0);
      double line_angle=360.0-angle;
      if(line_angle==90.0)  ObjectSet(line_name, OBJPROP_PRICE2, price2+Point*50);
      if(line_angle==270.0) ObjectSet(line_name, OBJPROP_PRICE2, price2-Point*50);
      time2=ObjectGet(line_name,OBJPROP_TIME2);
      if(line_angle>90.0 && line_angle<270.0) time2=Time[index+10];
      else                                    time2=Time[0];
      ObjectSet(line_name, OBJPROP_TIME2, time2);
      ObjectSet(line_name, OBJPROP_ANGLE, line_angle);
      ObjectsRedraw();
      angle+=3.0;
      if(angle>=360.0) angle=360.0-angle;
      fontsize++;
      if(fontsize>48) fontsize=6;
      Sleep(500);
      price1=ObjectGetValueByShift(line_name, index);
      if(GetLastError()==0)
        {
         if(MathAbs(price1-price) < Point*50)
           {
            Print("price=",price,"  price1=", price1);
            ObjectSetText(object_name1, "REMOVED", 48, "Arial", RGB(255,215,0));
            ObjectsRedraw();
            Sleep(5000);
//            ObjectDelete(object_name1);
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                        trade.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#include <stdlib.mqh>
#include <WinUser32.mqh>
//+------------------------------------------------------------------+
//| script "trading for all money"                                   |
//+------------------------------------------------------------------+
int start()
  {
//----
   if(MessageBox("Do you really want to BUY 1.00 "+Symbol()+" at ASK price?    ",
                 "Script",MB_YESNO|MB_ICONQUESTION)!=IDYES) return(1);
//----
   int ticket=OrderSend(Symbol(),OP_BUY,1.0,Ask,3,0,0,"expert comment",255,0,CLR_NONE);
   if(ticket<1)
     {
      int error=GetLastError();
      Print("Error = ",ErrorDescription(error));
      return;
     }
//----
   OrderPrint();

   return(0);
  }
//+------------------------------------------------------------------+
Templates
<expert>
type=INDICATOR_ADVISOR
description=Accelerator Oscilator
separate_window=1
used_buffers=4
<ind>
color=Green
type=DRAW_HISTOGRAM
</ind>
<ind>
color=Red
type=DRAW_HISTOGRAM
</ind>
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#indicator_properties#
#extern_variables#
#mapping_buffers#
//---- indicator buffers
double ExtGreenBuffer[];
double ExtRedBuffer[];
double ExtMABuffer[];
double ExtBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#;
//---- indicator buffers mapping
   SetIndexBuffer(0, ExtGreenBuffer);
   SetIndexBuffer(1, ExtRedBuffer);
   SetIndexBuffer(2, ExtMABuffer);
   SetIndexBuffer(3, ExtBuffer);
//---- drawing settings
   #indicators_init#
//----
   IndicatorDigits(6);
   SetIndexDrawBegin(0,38);
   SetIndexDrawBegin(1,38);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("AC");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Accelerator/Decelerator Oscillator                               |
//+------------------------------------------------------------------+
int start()
  {
   int    limit;
   int    counted_bars=IndicatorCounted();
   double prev,current;
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;

   limit=Bars-counted_bars;
//---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++)
      ExtMABuffer[i]=iMA(NULL,0,5,0,MODE_SMA,PRICE_MEDIAN,i)-
iMA(NULL,0,34,0,MODE_SMA,PRICE_MEDIAN,i);
//---- signal line counted in the 2-nd additional buffer
   for(i=0; i<limit; i++)
      ExtBuffer[i]=iMAOnArray(ExtMABuffer,Bars,5,0,MODE_SMA,i);
//---- dispatch values between 2 buffers
   bool up=true;
   for(i=limit-1; i>=0; i--)
     {
      current=ExtMABuffer[i]-ExtBuffer[i];
      prev=ExtMABuffer[i+1]-ExtBuffer[i+1];
      if(current>prev) up=true;
      if(current<prev) up=false;
      if(!up)
        {
         ExtRedBuffer[i]=current;
         ExtGreenBuffer[i]=0.0;
        }
      else
        {
         ExtGreenBuffer[i]=current;
         ExtRedBuffer[i]=0.0;
        }
     }
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
<expert>
type=INDICATOR_ADVISOR
description=
used_buffers=3
<param>
name=JawsPeriod
type=int
value=13
</param>
<param>
name=JawsShift
type=int
value=8
</param>
<param>
name=TeethPeriod
type=int
value=8
</param>
<param>
name=TeethShift
type=int
value=5
</param>
<param>
name=LipsPeriod
type=int
value=5
</param>
<param>
name=LipsShift
type=int
value=3
</param>
<ind>

color=Blue
</ind>
<ind>
color=Red
</ind>
<ind>
color=Lime
</ind>
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#indicator_properties#
#extern_variables#
#mapping_buffers#
//---- indicator buffers
double ExtBlueBuffer[];
double ExtRedBuffer[];
double ExtLimeBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#
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
   #indicators_init#
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Bill Williams' Alligator                                         |
//+------------------------------------------------------------------+
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

//+------------------------------------------------------------------+
<expert>
type=INDICATOR_ADVISOR
description=Awesome Oscilator
separate_window=1
used_buffers=3;
<ind>
color=Green
type=DRAW_HISTOGRAM
</ind>
<ind>
color=Red
type=DRAW_HISTOGRAM
</ind>
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#indicator_properties#
#extern_variables#
#mapping_buffers#
//---- indicator buffers
double ExtGreenBuffer[];
double ExtRedBuffer[];
double ExtMABuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#
//---- drawing settings
   #indicators_init#
   IndicatorDigits(5);
   SetIndexDrawBegin(0,34);
   SetIndexDrawBegin(1,34);
//---- indicator buffers mapping
   SetIndexBuffer(0, ExtGreenBuffer);
   SetIndexBuffer(1, ExtRedBuffer);
   SetIndexBuffer(2, ExtMABuffer);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("AO");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Awesome Oscillator                                               |
//+------------------------------------------------------------------+
int start()
  {
   int    limit;
   int    counted_bars=IndicatorCounted();
   double prev,current;
//---- check for possible errors
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++)
      ExtMABuffer[i]=iMA(NULL,0,5,0,MODE_SMA,PRICE_MEDIAN,i)-
iMA(NULL,0,34,0,MODE_SMA,PRICE_MEDIAN,i);
//---- dispatch values between 2 buffers
   bool up=true;
   for(i=limit-1; i>=0; i--)

     {
      current=ExtMABuffer[i];
      prev=ExtMABuffer[i+1];
      if(current>prev) up=true;
      if(current<prev) up=false;
      if(!up)
        {
         ExtRedBuffer[i]=current;
         ExtGreenBuffer[i]=0.0;
        }
      else
        {
         ExtGreenBuffer[i]=current;
         ExtRedBuffer[i]=0.0;
        }
     }
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
<expert>
  type=EXPERT_ADVISOR
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#extern_variables#
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
<expert>
type=INDICATOR_ADVISOR
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"

#indicator_properties#
#extern_variables#
#mapping_buffers#
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#
//---- indicators
   #indicators_init#
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
<expert>
type=INDICATOR_ADVISOR
separate_window=1
used_buffers=2
<param>
type=int
name=FastEMA
value=12
</param>
<param>
type=int
name=SlowEMA
value=26
</param>
<param>
type=int
name=SignalSMA
value=9
</param>
<ind>
color=Silver
type=DRAW_HISTOGRAM
</ind>
<ind>
color=Red
</ind>
</expert>
#header#
#property copyright "#copyright#"

#property link      "#link#"
#indicator_properties#
#extern_variables#
#mapping_buffers#
//---- indicator buffers
double ExtSilverBuffer[];
double ExtRedBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#;
//---- drawing settings
   #indicators_init#
//----
   SetIndexDrawBegin(1,SignalSMA);
   IndicatorDigits(5);
//---- indicator buffers mapping
   SetIndexBuffer(0, ExtSilverBuffer);
   SetIndexBuffer(1, ExtRedBuffer);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("MACD("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st buffer
   for(int i=0; i<limit; i++)
      ExtSilverBuffer[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//---- signal line counted in the 2-nd buffer
   for(i=0; i<limit; i++)
      ExtRedBuffer[i]=iMAOnArray(ExtSilverBuffer,Bars,SignalSMA,0,MODE_SMA,i);
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
<expert>
type=INDICATOR_ADVISOR
separate_window=1
used_buffers=3
<param>
name=FastEMA
type=int
value=12
</param>
<param>
name=SlowEMA
type=int
value=26
</param>
<param>

name=SignalSMA
type=int
value=9
</param>
<ind>
type=DRAW_HISTOGRAM
color=Silver
</ind>
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#indicator_properties#
#extern_variables#
#mapping_buffers#
//---- indicator buffers
double ExtSilverBuffer[];
double ExtMABuffer[];
double ExtBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   #buffers_used#;
//---- drawing settings
   #indicators_init#
//----
   SetIndexDrawBegin(0,SignalSMA);
   IndicatorDigits(6);
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtSilverBuffer);
   SetIndexBuffer(1,ExtMABuffer);
   SetIndexBuffer(2,ExtBuffer);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Moving Average of Oscillator                                     |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++)
      ExtMABuffer[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//---- signal line counted in the 2-nd additional buffer
   for(i=0; i<limit; i++)
      ExtBuffer[i]=iMAOnArray(ExtMABuffer,Bars,SignalSMA,0,MODE_SMA,i);
//---- main loop
   for(i=0; i<limit; i++)
      ExtSilverBuffer[i]=ExtMABuffer[i]-ExtBuffer[i];
//---- done
   return(0);
  }
//+------------------------------------------------------------------+

<expert>
type=SCRIPT_ADVISOR
</expert>
#header#
#property copyright "#copyright#"
#property link      "#link#"
#extern_variables#
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
Library
//+------------------------------------------------------------------+
//|                                                       stdlib.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property library
/*
int init()
  {
   Print("Init function defined as feature sample");
  }
int deinit()
  {
   Print("Deinit function defined as feature sample too");
  }
*/
//+------------------------------------------------------------------+
//| return error description                                         |
//+------------------------------------------------------------------+
string ErrorDescription(int error_code)
  {
   string error_string;
//----
   switch(error_code)
     {
      //---- codes returned from trade server
      case 0:
      case 1:   error_string="no error"; 
break;
      case 2:   error_string="common error"; 
break;
      case 3:   error_string="invalid trade parameters"; 
break;
      case 4:   error_string="trade server is busy"; 
break;
      case 5:   error_string="old version of the client terminal"; 
break;
      case 6:   error_string="no connection with trade server"; 
break;
      case 7:   error_string="not enough rights"; 
break;
      case 8:   error_string="too frequent requests"; 

break;
      case 9:   error_string="malfunctional trade operation"; 
break;
      case 64:  error_string="account disabled"; 
break;
      case 65:  error_string="invalid account"; 
break;
      case 128: error_string="trade timeout"; 
break;
      case 129: error_string="invalid price"; 
break;
      case 130: error_string="invalid stops"; 
break;
      case 131: error_string="invalid trade volume"; 
break;
      case 132: error_string="market is closed"; 
break;
      case 133: error_string="trade is disabled"; 
break;
      case 134: error_string="not enough money"; 
break;
      case 135: error_string="price changed"; 
break;
      case 136: error_string="off quotes"; 
break;
      case 137: error_string="broker is busy"; 
break;
      case 138: error_string="requote"; 
break;
      case 139: error_string="order is locked"; 
break;
      case 140: error_string="long positions only allowed"; 
break;
      case 141: error_string="too many requests"; 
break;
      case 145: error_string="modification denied because order too close to market"; 
break;
      case 146: error_string="trade context is busy"; 
break;
      //---- mql4 errors
      case 4000: error_string="no error"; 
break;
      case 4001: error_string="wrong function pointer"; 
break;
      case 4002: error_string="array index is out of range"; 
break;
      case 4003: error_string="no memory for function call stack"; 
break;
      case 4004: error_string="recursive stack overflow"; 
break;
      case 4005: error_string="not enough stack for parameter"; 
break;
      case 4006: error_string="no memory for parameter string"; 
break;
      case 4007: error_string="no memory for temp string"; 
break;
      case 4008: error_string="not initialized string"; 
break;
      case 4009: error_string="not initialized string in array"; 
break;
      case 4010: error_string="no memory for array\' string"; 
break;
      case 4011: error_string="too long string"; 
break;
      case 4012: error_string="remainder from zero divide"; 
break;
      case 4013: error_string="zero divide"; 

break;
      case 4014: error_string="unknown command"; 
break;
      case 4015: error_string="wrong jump (never generated error)"; 
break;
      case 4016: error_string="not initialized array"; 
break;
      case 4017: error_string="dll calls are not allowed"; 
break;
      case 4018: error_string="cannot load library"; 
break;
      case 4019: error_string="cannot call function"; 
break;
      case 4020: error_string="expert function calls are not allowed"; 
break;
      case 4021: error_string="not enough memory for temp string returned from 
function"; break;
      case 4022: error_string="system is busy (never generated error)"; 
break;
      case 4050: error_string="invalid function parameters count"; 
break;
      case 4051: error_string="invalid function parameter value"; 
break;
      case 4052: error_string="string function internal error"; 
break;
      case 4053: error_string="some array error"; 
break;
      case 4054: error_string="incorrect series array using"; 
break;
      case 4055: error_string="custom indicator error"; 
break;
      case 4056: error_string="arrays are incompatible"; 
break;
      case 4057: error_string="global variables processing error"; 
break;
      case 4058: error_string="global variable not found"; 
break;
      case 4059: error_string="function is not allowed in testing mode"; 
break;
      case 4060: error_string="function is not confirmed"; 
break;
      case 4061: error_string="send mail error"; 
break;
      case 4062: error_string="string parameter expected"; 
break;
      case 4063: error_string="integer parameter expected"; 
break;
      case 4064: error_string="double parameter expected"; 
break;
      case 4065: error_string="array as parameter expected"; 
break;
      case 4066: error_string="requested history data in update state"; 
break;
      case 4099: error_string="end of file"; 
break;
      case 4100: error_string="some file error"; 
break;
      case 4101: error_string="wrong file name"; 
break;
      case 4102: error_string="too many opened files"; 
break;
      case 4103: error_string="cannot open file"; 
break;
      case 4104: error_string="incompatible access to a file"; 
break;
      case 4105: error_string="no order selected"; 
break;

      case 4106: error_string="unknown symbol"; 
break;
      case 4107: error_string="invalid price parameter for trade function"; 
break;
      case 4108: error_string="invalid ticket"; 
break;
      case 4109: error_string="trade is not allowed"; 
break;
      case 4110: error_string="longs are not allowed"; 
break;
      case 4111: error_string="shorts are not allowed"; 
break;
      case 4200: error_string="object is already exist"; 
break;
      case 4201: error_string="unknown object property"; 
break;
      case 4202: error_string="object is not exist"; 
break;
      case 4203: error_string="unknown object type"; 
break;
      case 4204: error_string="no object name"; 
break;
      case 4205: error_string="object coordinates error"; 
break;
      case 4206: error_string="no specified subwindow"; 
break;
      default:   error_string="unknown error";
     }
//----
   return(error_string);
  }
//+------------------------------------------------------------------+
//| convert red, green and blue values to color                      |
//+------------------------------------------------------------------+
int RGB(int red_value,int green_value,int blue_value)
  {
//---- check parameters
   if(red_value<0)     red_value=0;
   if(red_value>255)   red_value=255;
   if(green_value<0)   green_value=0;
   if(green_value>255) green_value=255;
   if(blue_value<0)    blue_value=0;
   if(blue_value>255)  blue_value=255;
//----
   green_value<<=8;
   blue_value<<=16;
   return(red_value+green_value+blue_value);
  }
//+------------------------------------------------------------------+
//| right comparison of 2 doubles                                    |
//+------------------------------------------------------------------+
bool CompareDoubles(double number1,double number2)
  {
   if(NormalizeDouble(number1-number2,8)==0) return(true);
   else return(false);
  }
//+------------------------------------------------------------------+
//| up to 16 digits after decimal point                              |
//+------------------------------------------------------------------+
string DoubleToStrMorePrecision(double number,int precision)
  {
   double rem,integer,integer2;
   double DecimalArray[17]={ 1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 
10000000.0, 100000000.0,
                             1000000000.0, 10000000000.0, 100000000000.0, 
10000000000000.0, 100000000000000.0,
                             1000000000000000.0, 1000000000000000.0, 

10000000000000000.0 };
   string intstring,remstring,retstring;
   bool   isnegative=false;
   int    rem2;
//----
   if(precision<0)  precision=0;
   if(precision>16) precision=16;
//----
   double p=DecimalArray[precision];
   if(number<0.0) { isnegative=true; number=-number; }
   integer=MathFloor(number);
   rem=MathRound((number-integer)*p);
   remstring="";
   for(int i=0; i<precision; i++)
     {
      integer2=MathFloor(rem/10);
      rem2=NormalizeDouble(rem-integer2*10,0);
      remstring=rem2+remstring;
      rem=integer2;
     }
//----
   intstring=DoubleToStr(integer,0);
   if(isnegative) retstring="-"+intstring;
   else           retstring=intstring;
   if(precision>0) retstring=retstring+"."+remstring;
   return(retstring);
  }
//+------------------------------------------------------------------+
//| convert integer to string contained input's hexadecimal notation |
//+------------------------------------------------------------------+
string IntegerToHexString(int integer_number)
  {
   string hex_string="00000000";
   int    value, shift=28;
//   Print("Parameter for IntegerHexToString is ",integer_number);
//----
   for(int i=0; i<8; i++)
     {
      value=(integer_number>>shift)&0x0F;
      if(value<10) hex_string=StringSetChar(hex_string, i, value+'0');
      else         hex_string=StringSetChar(hex_string, i, (value-10)+'A');
      shift-=4;
     }
//----
   return(hex_string);
  }
Indicators
//+------------------------------------------------------------------+
//|                                                          CCI.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 LightSeaGreen
//---- input parameters
extern int CCIPeriod=14;
//---- buffers
double CCIBuffer[];
double RelBuffer[];
double DevBuffer[];

double MovBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 3 additional buffers are used for counting.
   IndicatorBuffers(4);
   SetIndexBuffer(1, RelBuffer);
   SetIndexBuffer(2, DevBuffer);
   SetIndexBuffer(3, MovBuffer);
//---- indicator lines
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,CCIBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="CCI("+CCIPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   SetIndexDrawBegin(0,CCIPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Commodity Channel Index                                          |
//+------------------------------------------------------------------+
int start()
  {
   int    i,k,counted_bars=IndicatorCounted();
   double price,sum,mul;
   if(Bars<=CCIPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
     {
      for(i=1;i<=CCIPeriod;i++) CCIBuffer[Bars-i]=0.0;
      for(i=1;i<=CCIPeriod;i++) DevBuffer[Bars-i]=0.0;
      for(i=1;i<=CCIPeriod;i++) MovBuffer[Bars-i]=0.0;
     }
//---- last counted bar will be recounted
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
//---- moving average
   for(i=0; i<limit; i++)
      MovBuffer[i]=iMA(NULL,0,CCIPeriod,0,MODE_SMA,PRICE_TYPICAL,i);
//---- standard deviations
   i=Bars-CCIPeriod+1;
   if(counted_bars>CCIPeriod-1) i=Bars-counted_bars-1;
   mul=0.015/CCIPeriod;
   while(i>=0)
     {
      sum=0.0;
      k=i+CCIPeriod-1;
      while(k>=i)
       {
         price=(High[k]+Low[k]+Close[k])/3;
         sum+=MathAbs(price-MovBuffer[i]);
         k--;
       }
      DevBuffer[i]=sum*mul;
      i--;
     }
   i=Bars-CCIPeriod+1;
   if(counted_bars>CCIPeriod-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      price=(High[i]+Low[i]+Close[i])/3;

      RelBuffer[i]=price-MovBuffer[i];
      i--;
     }
//---- cci counting
   i=Bars-CCIPeriod+1;
   if(counted_bars>CCIPeriod-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      if(DevBuffer[i]==0.0) CCIBuffer[i]=0.0;
      else CCIBuffer[i]=RelBuffer[i]/DevBuffer[i];
      i--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                     Ichimoku.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 7
#property indicator_color1 Red
#property indicator_color2 Blue
#property indicator_color3 SandyBrown
#property indicator_color4 Thistle
#property indicator_color5 Lime
#property indicator_color6 SandyBrown
#property indicator_color7 Thistle
//---- input parameters
extern int Tenkan=9;
extern int Kijun=26;
extern int Senkou=52;
//---- buffers
double Tenkan_Buffer[];
double Kijun_Buffer[];
double SpanA_Buffer[];
double SpanB_Buffer[];
double Chinkou_Buffer[];
double SpanA2_Buffer[];
double SpanB2_Buffer[];
//----
int a_begin;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
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
   SetIndexLabel(3,NULL);
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
//+------------------------------------------------------------------+
//| Ichimoku Kinko Hyo                                               |
//+------------------------------------------------------------------+
int start()
  {
   int    i,k;
   int    counted_bars=IndicatorCounted();
   double high,low,price;
//----
   if(Bars<=Tenkan || Bars<=Kijun || Bars<=Senkou) return(0);
//---- initial zero
   if(counted_bars<1)
     {
      for(i=1;i<=Tenkan;i++)    Tenkan_Buffer[Bars-i]=0;
      for(i=1;i<=Kijun;i++)     Kijun_Buffer[Bars-i]=0;
      for(i=1;i<=a_begin;i++) { SpanA_Buffer[Bars-i]=0; SpanA2_Buffer[Bars-i]=0; }
      for(i=1;i<=Senkou;i++)  { SpanB_Buffer[Bars-i]=0; SpanB2_Buffer[Bars-i]=0; }
     }
//---- Tenkan Sen
   i=Bars-Tenkan;
   if(counted_bars>Tenkan) i=Bars-counted_bars-1;
   while(i>=0)
     {
      high=High[i]; low=Low[i]; k=i-1+Tenkan;
      while(k>=i)
        {
         price=High[k];
         if(high<price) high=price;
         price=Low[k];
         if(low>price)  low=price;
         k--;
        }
      Tenkan_Buffer[i]=(high+low)/2;
      i--;
     }
//---- Kijun Sen
   i=Bars-Kijun;
   if(counted_bars>Kijun) i=Bars-counted_bars-1;
   while(i>=0)
     {

      high=High[i]; low=Low[i]; k=i-1+Kijun;
      while(k>=i)
        {
         price=High[k];
         if(high<price) high=price;
         price=Low[k];
         if(low>price)  low=price;
         k--;
        }
      Kijun_Buffer[i]=(high+low)/2;
      i--;
     }
//---- Senkou Span A
   i=Bars-a_begin+1;
   if(counted_bars>a_begin-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      price=(Kijun_Buffer[i]+Tenkan_Buffer[i])/2;
      SpanA_Buffer[i]=price;
      SpanA2_Buffer[i]=price;
      i--;
     }
//---- Senkou Span B
   i=Bars-Senkou;
   if(counted_bars>Senkou) i=Bars-counted_bars-1;
   while(i>=0)
     {
      high=High[i]; low=Low[i]; k=i-1+Senkou;
      while(k>=i)
        {
         price=High[k];
         if(high<price) high=price;
         price=Low[k];
         if(low>price)  low=price;
         k--;
        }
      price=(high+low)/2;
      SpanB_Buffer[i]=price;
      SpanB2_Buffer[i]=price;
      i--;
     }
//---- Chinkou Span
   i=Bars-1;
   if(counted_bars>1) i=Bars-counted_bars-1;
   while(i>=0) { Chinkou_Buffer[i]=Close[i]; i--; }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  Custom MACD.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property  copyright "Copyright © 2004, MetaQuotes Software Corp."
#property  link      "http://www.metaquotes.net/"
//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 2
#property  indicator_color1  Silver
#property  indicator_color2  Red
//---- indicator parameters
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;
//---- indicator buffers

double     ind_buffer1[];
double     ind_buffer2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- drawing settings
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,3);
   SetIndexDrawBegin(1,SignalSMA);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+1);
//---- indicator buffers mapping
   if(!SetIndexBuffer(0,ind_buffer1) && !SetIndexBuffer(1,ind_buffer2))
      Print("cannot set indicator buffers!");
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("MACD("+FastEMA+","+SlowEMA+","+SignalSMA+")");
   SetIndexLabel(0,"MACD");
   SetIndexLabel(1,"Signal");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st buffer
   for(int i=0; i<limit; i++)
      ind_buffer1[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//---- signal line counted in the 2-nd buffer
   for(i=0; i<limit; i++)
      ind_buffer2[i]=iMAOnArray(ind_buffer1,Bars,SignalSMA,0,MODE_SMA,i);
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                     Momentum.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 DodgerBlue
//---- input parameters
extern int MomPeriod=14;
//---- buffers
double MomBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- indicator line

   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,MomBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="Mom("+MomPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   SetIndexDrawBegin(0,MomPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Momentum                                                         |
//+------------------------------------------------------------------+
int start()
  {
   int i,counted_bars=IndicatorCounted();
//----
   if(Bars<=MomPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=MomPeriod;i++) MomBuffer[Bars-i]=0.0;
//----
   i=Bars-MomPeriod-1;
   if(counted_bars>=MomPeriod) i=Bars-counted_bars-1;
   while(i>=0)
     {
      MomBuffer[i]=Close[i]*100/Close[i+MomPeriod];
      i--;
     }
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                        Custom Moving Average.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Red
//---- indicator parameters
extern int MA_Period=13;
extern int MA_Shift=0;
extern int MA_Method=0;
//---- indicator buffers
double ExtMapBuffer[];
//----
int ExtCountedBars=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   int    draw_begin;
   string short_name;
//---- drawing settings
   SetIndexStyle(0,DRAW_LINE);
   SetIndexShift(0,MA_Shift);
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
   if(MA_Period<2) MA_Period=13;
   draw_begin=MA_Period-1;
//---- indicator short name

   switch(MA_Method)
     {
      case 1 : short_name="EMA(";  draw_begin=0; break;
      case 2 : short_name="SMMA("; break;
      case 3 : short_name="LWMA("; break;
      default :
         MA_Method=0;
         short_name="SMA(";
     }
   IndicatorShortName(short_name+MA_Period+")");
   SetIndexDrawBegin(0,draw_begin);
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtMapBuffer);
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   if(Bars<=MA_Period) return(0);
   ExtCountedBars=IndicatorCounted();
//---- check for possible errors
   if (ExtCountedBars<0) return(-1);
//---- last counted bar will be recounted
   if (ExtCountedBars>0) ExtCountedBars--;
//----
   switch(MA_Method)
     {
      case 0 : sma();  break;
      case 1 : ema();  break;
      case 2 : smma(); break;
      case 3 : lwma();
     }
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
//| Simple Moving Average                                            |
//+------------------------------------------------------------------+
void sma()
  {
   double sum=0;
   int    i,pos=Bars-ExtCountedBars-1;
//---- initial accumulation
   if(pos<MA_Period) pos=MA_Period;
   for(i=1;i<MA_Period;i++,pos--)
      sum+=Close[pos];
//---- main calculation loop
   while(pos>=0)
     {
      sum+=Close[pos];
      ExtMapBuffer[pos]=sum/MA_Period;
   sum-=Close[pos+MA_Period-1];
 
   pos--;
     }
//---- zero initial bars
   if(ExtCountedBars<1)
      for(i=1;i<MA_Period;i++) ExtMapBuffer[Bars-i]=0;
  }
//+------------------------------------------------------------------+
//| Exponential Moving Average                                       |
//+------------------------------------------------------------------+
void ema()
  {
   double pr=2.0/(MA_Period+1);

   int    pos=Bars-2;
   if(ExtCountedBars>2) pos=Bars-ExtCountedBars-1;
//---- main calculation loop
   while(pos>=0)
     {
      if(pos==Bars-2) ExtMapBuffer[pos+1]=Close[pos+1];
      ExtMapBuffer[pos]=Close[pos]*pr+ExtMapBuffer[pos+1]*(1-pr);
 
   pos--;
     }
  }
//+------------------------------------------------------------------+
//| Smoothed Moving Average                                          |
//+------------------------------------------------------------------+
void smma()
  {
   double sum=0;
   int    i,k,pos=Bars-ExtCountedBars+1;
//---- main calculation loop
   pos=Bars-MA_Period;
   if(pos>Bars-ExtCountedBars) pos=Bars-ExtCountedBars;
   while(pos>=0)
     {
      if(pos==Bars-MA_Period)
        {
         //---- initial accumulation
         for(i=0,k=pos;i<MA_Period;i++,k++)
           {
            sum+=Close[k];
            //---- zero initial bars
            ExtMapBuffer[k]=0;
           }
        }
      else sum=ExtMapBuffer[pos+1]*(MA_Period-1)+Close[pos];
      ExtMapBuffer[pos]=sum/MA_Period;
 
   pos--;
     }
  }
//+------------------------------------------------------------------+
//| Linear Weighted Moving Average                                   |
//+------------------------------------------------------------------+
void lwma()
  {
   double sum=0.0,lsum=0.0;
   double price;
   int    i,weight=0,pos=Bars-ExtCountedBars-1;
//---- initial accumulation
   if(pos<MA_Period) pos=MA_Period;
   for(i=1;i<=MA_Period;i++,pos--)
     {
      price=Close[pos];
      sum+=price*i;
      lsum+=price;
      weight+=i;
     }
//---- main calculation loop
   pos++;
   i=pos+MA_Period;
   while(pos>=0)
     {
      ExtMapBuffer[pos]=sum/weight;
      if(pos==0) break;
      pos--;
      i--;
      price=Close[pos];
      sum=sum-lsum+price*MA_Period;
      lsum-=Close[i];
      lsum+=price;

     }
//---- zero initial bars
   if(ExtCountedBars<1)
      for(i=1;i<MA_Period;i++) ExtMapBuffer[Bars-i]=0;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                         OsMA.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property  copyright "Copyright © 2004, MetaQuotes Software Corp."
#property  link      "http://www.metaquotes.net/"
//---- indicator settings
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
   if(!SetIndexBuffer(0,ind_buffer1) &&
      !SetIndexBuffer(1,ind_buffer2) &&
      !SetIndexBuffer(2,ind_buffer3))
      Print("cannot set indicator buffers!");
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("OsMA("+FastEMA+","+SlowEMA+","+SignalSMA+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Moving Average of Oscillator                                     |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars=IndicatorCounted();
//---- check for possible errors
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++)
      ind_buffer2[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//---- signal line counted in the 2-nd additional buffer
   for(i=0; i<limit; i++)
      ind_buffer3[i]=iMAOnArray(ind_buffer2,Bars,SignalSMA,0,MODE_SMA,i);

//---- main loop
   for(i=0; i<limit; i++)
      ind_buffer1[i]=ind_buffer2[i]-ind_buffer3[i];
//---- done
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                    Parabolic.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Lime
//---- input parameters
extern double    Step=0.02;
extern double    Maximum=0.2;
//---- buffers
double SarBuffer[];
//----
int    save_lastreverse;
bool   save_dirlong;
double save_start;
double save_last_high;
double save_last_low;
double save_ep;
double save_sar;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   IndicatorDigits(Digits);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,159);
   SetIndexBuffer(0,SarBuffer);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SaveLastReverse(int last,int dir,double start,double low,double high,double 
ep,double sar)
  {
   save_lastreverse=last;
   save_dirlong=dir;
   save_start=start;
   save_last_low=low;
   save_last_high=high;
   save_ep=ep;
   save_sar=sar;
  }
//+------------------------------------------------------------------+
//| Parabolic Sell And Reverse system                                |
//+------------------------------------------------------------------+
int start()
  {
   static bool first=true;
   bool   dirlong;
   double start,last_high,last_low;

   double ep,sar,price_low,price_high,price;
   int    i,counted_bars=IndicatorCounted();
//----
   if(Bars<3) return(0);
//---- initial settings
   i=Bars-2;
   if(counted_bars==0 || first)
     {
      first=false;
      dirlong=true;
      start=Step;
      last_high=-10000000.0;
      last_low=10000000.0;
      while(i>0)
        {
         save_lastreverse=i;
         price_low=Low[i];
         if(last_low>price_low)   last_low=price_low;
         price_high=High[i];
         if(last_high<price_high) last_high=price_high;
         if(price_high>High[i+1] && price_low>Low[i+1]) break;
         if(price_high<High[i+1] && price_low<Low[i+1]) { dirlong=false; break; }
         i--;
        }
      //---- initial zero
      int k=i;
      while(k<Bars)
        {
         SarBuffer[k]=0.0;
         k++;
        }
      //---- check further
      if(dirlong) { SarBuffer[i]=Low[i+1]; ep=High[i]; }
      else        { SarBuffer[i]=High[i+1]; ep=Low[i]; }
      i--;
     }
    else
     {
      i=save_lastreverse+1;
      start=save_start;
      dirlong=save_dirlong;
      last_high=save_last_high;
      last_low=save_last_low;
      ep=save_ep;
      sar=save_sar;
     }
//----
   while(i>=0)
     {
      price_low=Low[i];
      price_high=High[i];
      //--- check for reverse
      if(dirlong && price_low<SarBuffer[i+1])
        {
         SaveLastReverse(i,true,start,price_low,last_high,ep,sar);
         start=Step; dirlong=false;
         ep=price_low;  last_low=price_low;
         SarBuffer[i]=last_high;
         i--;
         continue;
        }
      if(!dirlong && price_high>SarBuffer[i+1])
        {
         SaveLastReverse(i,false,start,last_low,price_high,ep,sar);
         start=Step; dirlong=true;
         ep=price_high; last_high=price_high;
         SarBuffer[i]=last_low;

         i--;
         continue;
        }
      //---
      price=SarBuffer[i+1];
      sar=price+start*(ep-price);
      if(dirlong)
        {
         if(ep<price_high && (start+Step)<=Maximum) start+=Step;
         if(price_high<High[i+1] && i==Bars-2)  sar=SarBuffer[i+1];
         price=Low[i+1];
         if(sar>price) sar=price;
         price=Low[i+2];
         if(sar>price) sar=price;
         if(sar>price_low)
           {
            SaveLastReverse(i,true,start,price_low,last_high,ep,sar);
            start=Step; dirlong=false; ep=price_low;
            last_low=price_low;
            SarBuffer[i]=last_high;
            i--;
            continue;
           }
         if(ep<price_high) { last_high=price_high; ep=price_high; }
        }
      else
        {
         if(ep>price_low && (start+Step)<=Maximum) start+=Step;
         if(price_low<Low[i+1] && i==Bars-2)  sar=SarBuffer[i+1];
         price=High[i+1];
         if(sar<price) sar=price;
         price=High[i+2];
         if(sar<price) sar=price;
         if(sar<price_high)
           {
            SaveLastReverse(i,false,start,last_low,price_high,ep,sar);
            start=Step; dirlong=true; ep=price_high;
            last_high=price_high;
            SarBuffer[i]=last_low;
            i--;
            continue;
           }
         if(ep>price_low) { last_low=price_low; ep=price_low; }
        }
      SarBuffer[i]=sar;
      i--;
     }
//   sar=SarBuffer[0];
//   price=iSAR(NULL,0,Step,Maximum,0);
//   if(sar!=price) Print("custom=",sar,"   SAR=",price,"   counted=",counted_bars);
//   if(sar==price) Print("custom=",sar,"   SAR=",price,"   counted=",counted_bars);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                          RSI.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window

#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_buffers 1
#property indicator_color1 DodgerBlue
//---- input parameters
extern int RSIPeriod=14;
//---- buffers
double RSIBuffer[];
double PosBuffer[];
double NegBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(3);
   SetIndexBuffer(1,PosBuffer);
   SetIndexBuffer(2,NegBuffer);
//---- indicator line
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,RSIBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="RSI("+RSIPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   SetIndexDrawBegin(0,RSIPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Relative Strength Index                                          |
//+------------------------------------------------------------------+
int start()
  {
   int    i,counted_bars=IndicatorCounted();
   double rel,negative,positive;
//----
   if(Bars<=RSIPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=RSIPeriod;i++) RSIBuffer[Bars-i]=0.0;
//----
   i=Bars-RSIPeriod-1;
   if(counted_bars>=RSIPeriod) i=Bars-counted_bars-1;
   while(i>=0)
     {
      double sumn=0.0,sump=0.0;
      if(i==Bars-RSIPeriod-1)
        {
         int k=Bars-2;
         //---- initial accumulation
         while(k>=i)
           {
            rel=Close[k]-Close[k+1];
            if(rel>0) sump+=rel;
            else      sumn-=rel;
            k--;
           }
         positive=sump/RSIPeriod;
         negative=sumn/RSIPeriod;
        }
      else
        {
         //---- smoothed moving average

         rel=Close[i]-Close[i+1];
         if(rel>0) sump=rel;
         else      sumn=-rel;
         positive=(PosBuffer[i+1]*(RSIPeriod-1)+sump)/RSIPeriod;
         negative=(NegBuffer[i+1]*(RSIPeriod-1)+sumn)/RSIPeriod;
        }
      PosBuffer[i]=positive;
      NegBuffer[i]=negative;
      if(negative==0.0) RSIBuffer[i]=0.0;
      else RSIBuffer[i]=100.0-100.0/(1+positive/negative);
      i--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                   Stochastic.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_minimum 0
#property indicator_maximum 100
#property indicator_buffers 2
#property indicator_color1 LightSeaGreen
#property indicator_color2 Red
//---- input parameters
extern int KPeriod=5;
extern int DPeriod=3;
extern int Slowing=3;
//---- buffers
double MainBuffer[];
double SignalBuffer[];
double HighesBuffer[];
double LowesBuffer[];
//----
int draw_begin1=0;
int draw_begin2=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(4);
   SetIndexBuffer(2, HighesBuffer);
   SetIndexBuffer(3, LowesBuffer);
//---- indicator lines
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0, MainBuffer);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1, SignalBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="Sto("+KPeriod+","+DPeriod+","+Slowing+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
   SetIndexLabel(1,"Signal");
//----
   draw_begin1=KPeriod+Slowing;
   draw_begin2=draw_begin1+DPeriod;
   SetIndexDrawBegin(0,draw_begin1);

   SetIndexDrawBegin(1,draw_begin2);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Stochastic oscillator                                            |
//+------------------------------------------------------------------+
int start()
  {
   int    i,k;
   int    counted_bars=IndicatorCounted();
   double price;
//----
   if(Bars<=draw_begin2) return(0);
//---- initial zero
   if(counted_bars<1)
     {
      for(i=1;i<=draw_begin1;i++) MainBuffer[Bars-i]=0;
      for(i=1;i<=draw_begin2;i++) SignalBuffer[Bars-i]=0;
     }
//---- minimums counting
   i=Bars-KPeriod;
   if(counted_bars>KPeriod) i=Bars-counted_bars-1;
   while(i>=0)
     {
      double min=1000000;
      k=i+KPeriod-1;
      while(k>=i)
        {
         price=Low[k];
         if(min>price) min=price;
         k--;
        }
      LowesBuffer[i]=min;
      i--;
     }
//---- maximums counting
   i=Bars-KPeriod;
   if(counted_bars>KPeriod) i=Bars-counted_bars-1;
   while(i>=0)
     {
      double max=-1000000;
      k=i+KPeriod-1;
      while(k>=i)
        {
         price=High[k];
         if(max<price) max=price;
         k--;
        }
      HighesBuffer[i]=max;
      i--;
     }
//---- %K line
   i=Bars-draw_begin1;
   if(counted_bars>draw_begin1) i=Bars-counted_bars-1;
   while(i>=0)
     {
      double sumlow=0.0;
      double sumhigh=0.0;
      for(k=(i+Slowing-1);k>=i;k--)
        {
         sumlow+=Close[k]-LowesBuffer[k];
         sumhigh+=HighesBuffer[k]-LowesBuffer[k];
        }
      if(sumhigh==0.0) MainBuffer[i]=100.0;
      else MainBuffer[i]=sumlow/sumhigh*100;
      i--;

     }
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
//---- signal line is simple movimg average
   for(i=0; i<limit; i++)
      SignalBuffer[i]=iMAOnArray(MainBuffer,Bars,DPeriod,0,MODE_SMA,i);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                        Custom Moving Average.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Red
//---- indicator parameters
extern int ExtDepth=12;
extern int ExtDeviation=5;
extern int ExtBackstep=3;
//---- indicator buffers
double ExtMapBuffer[];
double ExtMapBuffer2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(2);
//---- drawing settings
   SetIndexStyle(0,DRAW_SECTION);
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtMapBuffer);
   SetIndexBuffer(1,ExtMapBuffer2);
   SetIndexEmptyValue(0,0.0);
   ArraySetAsSeries(ExtMapBuffer,true);
   ArraySetAsSeries(ExtMapBuffer2,true);
//---- indicator short name
   IndicatorShortName("ZigZag("+ExtDepth+","+ExtDeviation+","+ExtBackstep+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int    shift, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;
   for(shift=Bars-ExtDepth; shift>=0; shift--)
     {
      val=Low[Lowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) val=0.0;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;

         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer[shift+back];
               if((res!=0)&&(res>val)) ExtMapBuffer[shift+back]=0.0; 
              }
           }
        } 
      ExtMapBuffer[shift]=val;
      //--- high
      val=High[Highest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) val=0.0;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer2[shift+back];
               if((res!=0)&&(res<val)) ExtMapBuffer2[shift+back]=0.0; 
              } 
           }
        }
      ExtMapBuffer2[shift]=val;
     }
   // final cutting 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;
   for(shift=Bars-ExtDepth; shift>=0; shift--)
     {
      curlow=ExtMapBuffer[shift];
      curhigh=ExtMapBuffer2[shift];
      if((curlow==0)&&(curhigh==0)) continue;
      //---
      if(curhigh!=0)
        {
         if(lasthigh>0) 
           {
            if(lasthigh<curhigh) ExtMapBuffer2[lasthighpos]=0;
            else ExtMapBuffer2[shift]=0;
           }
         //---
         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=shift;
           }
         lastlow=-1;
        }
      //----
      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) ExtMapBuffer[lastlowpos]=0;
            else ExtMapBuffer[shift]=0;
           }
         //---
         if((curlow<lastlow)||(lastlow<0))
           {
            lastlow=curlow;
            lastlowpos=shift;

           } 
         lasthigh=-1;
        }
     }
  
   for(shift=Bars-1; shift>=0; shift--)
     {
      if(shift>=Bars-ExtDepth) ExtMapBuffer[shift]=0.0;
      else
        {
         res=ExtMapBuffer2[shift];
         if(res!=0.0) ExtMapBuffer[shift]=res;
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                  Accelerator.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property  copyright "Copyright © 2005, MetaQuotes Software Corp."
#property  link      "http://www.metaquotes.net/"
//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 3
#property  indicator_color1  Black
#property  indicator_color2  Green
#property  indicator_color3  Red
//---- indicator buffers
double     ExtBuffer0[];
double     ExtBuffer1[];
double     ExtBuffer2[];
double     ExtBuffer3[];
double     ExtBuffer4[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 2 additional buffers are used for counting.
   IndicatorBuffers(5);
//---- drawing settings
   SetIndexStyle(0,DRAW_NONE);
   SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexStyle(2,DRAW_HISTOGRAM);
   IndicatorDigits(Digits+2);
   SetIndexDrawBegin(0,38);
   SetIndexDrawBegin(1,38);
   SetIndexDrawBegin(2,38);
//---- 4 indicator buffers mapping
   SetIndexBuffer(0,ExtBuffer0);
   SetIndexBuffer(1,ExtBuffer1);
   SetIndexBuffer(2,ExtBuffer2);
   SetIndexBuffer(3,ExtBuffer3);
   SetIndexBuffer(4,ExtBuffer4);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("AC");
   SetIndexLabel(1,NULL);
   SetIndexLabel(2,NULL);
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Accelerator/Decelerator Oscillator                               |
//+------------------------------------------------------------------+
int start()

  {
   int    limit;
   int    counted_bars=IndicatorCounted();
   double prev,current;
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
   //---- macd counted in the 1-st additional buffer
   for(int i=0; i<limit; i++)
      ExtBuffer3[i]=iMA(NULL,0,5,0,MODE_SMA,PRICE_MEDIAN,i)-
iMA(NULL,0,34,0,MODE_SMA,PRICE_MEDIAN,i);
   //---- signal line counted in the 2-nd additional buffer
   for(i=0; i<limit; i++)
      ExtBuffer4[i]=iMAOnArray(ExtBuffer3,Bars,5,0,MODE_SMA,i);
   //---- dispatch values between 2 buffers
   bool up=true;
   for(i=limit-1; i>=0; i--)
     {
      current=ExtBuffer3[i]-ExtBuffer4[i];
      prev=ExtBuffer3[i+1]-ExtBuffer4[i+1];
      if(current>prev) up=true;
      if(current<prev) up=false;
      if(!up)
        {
         ExtBuffer2[i]=current;
         ExtBuffer1[i]=0.0;
        }
      else
        {
         ExtBuffer1[i]=current;
         ExtBuffer2[i]=0.0;
        }
       ExtBuffer0[i]=current;
     }
   //---- done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                          ADX.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 3
#property indicator_color1 LightSeaGreen
#property indicator_color2 YellowGreen
#property indicator_color3 Wheat
//---- input parameters
extern int ADXPeriod=14;
//---- buffers
double ADXBuffer[];
double PlusDiBuffer[];
double MinusDiBuffer[];
double PlusSdiBuffer[];
double MinusSdiBuffer[];
double TempBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 3 additional buffers are used for counting.
   IndicatorBuffers(6);

//---- indicator buffers
   SetIndexBuffer(0,ADXBuffer);
   SetIndexBuffer(1,PlusDiBuffer);
   SetIndexBuffer(2,MinusDiBuffer);
   SetIndexBuffer(3,PlusSdiBuffer);
   SetIndexBuffer(4,MinusSdiBuffer);
   SetIndexBuffer(5,TempBuffer);
//---- name for DataWindow and indicator subwindow label
   IndicatorShortName("ADX("+ADXPeriod+")");
   SetIndexLabel(0,"ADX");
   SetIndexLabel(1,"+DI");
   SetIndexLabel(2,"-DI");
//----
   SetIndexDrawBegin(0,ADXPeriod);
   SetIndexDrawBegin(1,ADXPeriod);
   SetIndexDrawBegin(2,ADXPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Average Directional Movement Index                               |
//+------------------------------------------------------------------+
int start()
  {
   double pdm,mdm,tr;
   double price_high,price_low;
   int    starti,i,counted_bars=IndicatorCounted();
//----
   i=Bars-2;
   PlusSdiBuffer[i+1]=0;
   MinusSdiBuffer[i+1]=0;
   if(counted_bars>=i) i=Bars-counted_bars-1;
   starti=i;
//----
   while(i>=0)
     {
      price_low=Low[i];
      price_high=High[i];
      //----
      pdm=price_high-High[i+1];
      mdm=Low[i+1]-price_low;
      if(pdm<0) pdm=0;  // +DM
      if(mdm<0) mdm=0;  // -DM
      if(pdm==mdm) { pdm=0; mdm=0; }
      else if(pdm<mdm) pdm=0;
           else if(mdm<pdm) mdm=0;
      //---- âû÷èñëÿåì èñòèííûé èíòåðâàë
      double num1=MathAbs(price_high-price_low);
      double num2=MathAbs(price_high-Close[i+1]);
      double num3=MathAbs(price_low-Close[i+1]);
      tr=MathMax(num1,num2);
      tr=MathMax(tr,num3);
      //---- counting plus/minus direction
      if(tr==0) { PlusSdiBuffer[i]=0; MinusSdiBuffer[i]=0; }
      else      { PlusSdiBuffer[i]=100.0*pdm/tr; MinusSdiBuffer[i]=100.0*mdm/tr; }
      //----
      i--;
     }
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
//---- apply EMA to +DI
   for(i=0; i<=limit; i++)
      PlusDiBuffer[i]=iMAOnArray(PlusSdiBuffer,Bars,ADXPeriod,0,MODE_EMA,i);
//---- apply EMA to -DI
   for(i=0; i<=limit; i++)
      MinusDiBuffer[i]=iMAOnArray(MinusSdiBuffer,Bars,ADXPeriod,0,MODE_EMA,i);

//---- Directional Movement (DX)
   i=Bars-2;
   TempBuffer[i+1]=0;
   i=starti;
   while(i>=0)
     {
      double div=MathAbs(PlusDiBuffer[i]+MinusDiBuffer[i]);
      if(div==0.00) TempBuffer[i]=0;
      else TempBuffer[i]=100*(MathAbs(PlusDiBuffer[i]-MinusDiBuffer[i])/div);
      i--;
     }
//---- ADX is exponential moving average on DX
   for(i=0; i<limit; i++)
      ADXBuffer[i]=iMAOnArray(TempBuffer,Bars,ADXPeriod,0,MODE_EMA,i);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                    Alligator.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Lime
//---- input parameters
extern int JawsPeriod=13;
extern int JawsShift=8;
extern int TeethPeriod=8;
extern int TeethShift=5;
extern int LipsPeriod=5;
extern int LipsShift=3;
//---- indicator buffers
double ExtBlueBuffer[];
double ExtRedBuffer[];
double ExtLimeBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
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
//+------------------------------------------------------------------+
//| Bill Williams' Alligator                                         |
//+------------------------------------------------------------------+
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
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                      Awesome.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property  copyright "Copyright © 2005, MetaQuotes Software Corp."
#property  link      "http://www.metaquotes.net/"
//---- indicator settings
#property  indicator_separate_window
#property  indicator_buffers 3
#property  indicator_color1  Black
#property  indicator_color2  Green
#property  indicator_color3  Red
//---- indicator buffers
double     ExtBuffer0[];
double     ExtBuffer1[];
double     ExtBuffer2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   //---- drawing settings
   SetIndexStyle(0,DRAW_NONE);
   SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexStyle(2,DRAW_HISTOGRAM);
   IndicatorDigits(Digits+1);
   SetIndexDrawBegin(0,34);
   SetIndexDrawBegin(1,34);
   SetIndexDrawBegin(2,34);
//---- 3 indicator buffers mapping
   SetIndexBuffer(0,ExtBuffer0);
   SetIndexBuffer(1,ExtBuffer1);
   SetIndexBuffer(2,ExtBuffer2);
//---- name for DataWindow and indicator subwindow label

   IndicatorShortName("AO");
   SetIndexLabel(1,NULL);
   SetIndexLabel(2,NULL);
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Awesome Oscillator                                               |
//+------------------------------------------------------------------+
int start()
  {
   int    limit;
   int    counted_bars=IndicatorCounted();
   double prev,current;
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- macd
   for(int i=0; i<limit; i++)
      ExtBuffer0[i]=iMA(NULL,0,5,0,MODE_SMA,PRICE_MEDIAN,i)-
iMA(NULL,0,34,0,MODE_SMA,PRICE_MEDIAN,i);
//---- dispatch values between 2 buffers
   bool up=true;
   for(i=limit-1; i>=0; i--)
     {
      current=ExtBuffer0[i];
      prev=ExtBuffer0[i+1];
      if(current>prev) up=true;
      if(current<prev) up=false;
      if(!up)
        {
         ExtBuffer2[i]=current;
         ExtBuffer1[i]=0.0;
        }
      else
        {
         ExtBuffer1[i]=current;
         ExtBuffer2[i]=0.0;
        }
     }
//---- done
   return(0);
  }
Samples Includes
#import "ExpertSample.dll"
int    GetIntValue(int);
double GetDoubleValue(double);
string GetStringValue(string);
double GetArrayItemValue(double arr[],int,int);
bool   SetArrayItemValue(double& arr[],int,int,double);
double GetRatesItemValue(double rates[][6],int,int,int);
int    SortStringArray(string& arr[],int);
int    ProcessStringArray(string& arr[],int);
Samples Indicators
//+------------------------------------------------------------------+
//|                                                          ATR.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."

#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 DodgerBlue
//---- input parameters
extern int AtrPeriod=14;
//---- buffers
double AtrBuffer[];
double TempBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 1 additional buffer used for counting.
   IndicatorBuffers(2);
//---- indicator line
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,AtrBuffer);
   SetIndexBuffer(1,TempBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="ATR("+AtrPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   SetIndexDrawBegin(0,AtrPeriod);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Average True Range                                               |
//+------------------------------------------------------------------+
int start()
  {
   int i,counted_bars=IndicatorCounted();
//----
   if(Bars<=AtrPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=AtrPeriod;i++) AtrBuffer[Bars-i]=0.0;
//----
   i=Bars-counted_bars-1;
   while(i>=0)
     {
      double high=High[i];
      double low =Low[i];
      if(i==Bars-1) TempBuffer[i]=high-low;
      else
        {
         double prevclose=Close[i+1];
         TempBuffer[i]=MathMax(high,prevclose)-MathMin(low,prevclose);
        }
      i--;
     }
//----
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
   for(i=0; i<limit; i++)
      AtrBuffer[i]=iMAOnArray(TempBuffer,Bars,AtrPeriod,0,MODE_SMA,i);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//|                                                        Bands.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 LightSeaGreen
#property indicator_color2 LightSeaGreen
#property indicator_color3 LightSeaGreen
//---- indicator parameters
extern int    BandsPeriod=20;
extern int    BandsShift=0;
extern double BandsDeviations=2.0;
//---- buffers
double MovingBuffer[];
double UpperBuffer[];
double LowerBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,MovingBuffer);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,UpperBuffer);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexBuffer(2,LowerBuffer);
//----
   SetIndexDrawBegin(0,BandsPeriod+BandsShift);
   SetIndexDrawBegin(1,BandsPeriod+BandsShift);
   SetIndexDrawBegin(2,BandsPeriod+BandsShift);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Bollinger Bands                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int    i,k,counted_bars=IndicatorCounted();
   double deviation;
   double sum,oldval,newres;
//----
   if(Bars<=BandsPeriod) return(0);
//---- initial zero
   if(counted_bars<1)
      for(i=1;i<=BandsPeriod;i++)
        {
         MovingBuffer[Bars-i]=EMPTY_VALUE;
         UpperBuffer[Bars-i]=EMPTY_VALUE;
         LowerBuffer[Bars-i]=EMPTY_VALUE;
        }
//----
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
   for(i=0; i<limit; i++)
      MovingBuffer[i]=iMA(NULL,0,BandsPeriod,BandsShift,MODE_SMA,PRICE_CLOSE,i);
//----
   i=Bars-BandsPeriod+1;
   if(counted_bars>BandsPeriod-1) i=Bars-counted_bars-1;
   while(i>=0)
     {

      sum=0.0;
      k=i+BandsPeriod-1;
      oldval=MovingBuffer[i];
      while(k>=i)
        {
         newres=Close[k]-oldval;
         sum+=newres*newres;
         k--;
        }
      deviation=BandsDeviations*MathSqrt(sum/BandsPeriod);;
      UpperBuffer[i]=oldval+deviation;
      LowerBuffer[i]=oldval-deviation;
      i--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                        Bears.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 Silver
//---- input parameters
extern int BearsPeriod=13;
//---- buffers
double BearsBuffer[];
double TempBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 1 additional buffer used for counting.
   IndicatorBuffers(2);
   IndicatorDigits(Digits);
//---- indicator line
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(0,BearsBuffer);
   SetIndexBuffer(1,TempBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="Bears("+BearsPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Bears Power                                                      |
//+------------------------------------------------------------------+
int start()
  {
   int i,counted_bars=IndicatorCounted();
//----
   if(Bars<=BearsPeriod) return(0);
//----
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
   for(i=0; i<limit; i++)

      TempBuffer[i]=iMA(NULL,0,BearsPeriod,0,MODE_EMA,PRICE_CLOSE,i);
//----
   i=Bars-counted_bars-1;
   while(i>=0)
     {
      BearsBuffer[i]=Low[i]-TempBuffer[i];
      i--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                        Bulls.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 Silver
//---- input parameters
extern int BullsPeriod=13;
//---- buffers
double BullsBuffer[];
double TempBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- 1 additional buffer used for counting.
   IndicatorBuffers(2);
   IndicatorDigits(Digits);
//---- indicator line
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(0,BullsBuffer);
   SetIndexBuffer(1,TempBuffer);
//---- name for DataWindow and indicator subwindow label
   short_name="Bulls("+BullsPeriod+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Bulls Power                                                      |
//+------------------------------------------------------------------+
int start()
  {
   int i,counted_bars=IndicatorCounted();
//----
   if(Bars<=BullsPeriod) return(0);
//----
   int limit=Bars-counted_bars;
   if(counted_bars>0) limit++;
   for(i=0; i<limit; i++)
      TempBuffer[i]=iMA(NULL,0,BullsPeriod,0,MODE_EMA,PRICE_CLOSE,i);
//----
   i=Bars-counted_bars-1;
   while(i>=0)
     {
      BullsBuffer[i]=High[i]-TempBuffer[i];

      i--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  Heiken Ashi.mq4 |
//|                      Copyright c 2004, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
//| For Heiken Ashi we recommend next chart settings ( press F8 or   |
//| select on menu 'Charts'->'Properties...'):                       |
//|  - On 'Color' Tab select 'Black' for 'Line Graph'                |
//|  - On 'Common' Tab disable 'Chart on Foreground' checkbox and    |
//|    select 'Line Chart' radiobutton                               |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Red
#property indicator_color2 White
#property indicator_color3 Red
#property indicator_color4 White
//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double ExtMapBuffer4[];
//----
int ExtCountedBars=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//|------------------------------------------------------------------|
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_HISTOGRAM, 0, 1, Red);
   SetIndexBuffer(0, ExtMapBuffer1);
   SetIndexStyle(1,DRAW_HISTOGRAM, 0, 1, White);
   SetIndexBuffer(1, ExtMapBuffer2);
   SetIndexStyle(2,DRAW_HISTOGRAM, 0, 3, Red);
   SetIndexBuffer(2, ExtMapBuffer3);
   SetIndexStyle(3,DRAW_HISTOGRAM, 0, 3, White);
   SetIndexBuffer(3, ExtMapBuffer4);
//----
   SetIndexDrawBegin(0,10);
   SetIndexDrawBegin(1,10);
   SetIndexDrawBegin(2,10);
   SetIndexDrawBegin(3,10);
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtMapBuffer1);
   SetIndexBuffer(1,ExtMapBuffer2);
   SetIndexBuffer(2,ExtMapBuffer3);
   SetIndexBuffer(3,ExtMapBuffer4);
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- TODO: add your code here

   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   double haOpen, haHigh, haLow, haClose;
   if(Bars<=10) return(0);
   ExtCountedBars=IndicatorCounted();
//---- check for possible errors
   if (ExtCountedBars<0) return(-1);
//---- last counted bar will be recounted
   if (ExtCountedBars>0) ExtCountedBars--;
   int pos=Bars-ExtCountedBars-1;
   while(pos>=0)
     {
      haOpen=(ExtMapBuffer3[pos+1]+ExtMapBuffer4[pos+1])/2;
      haClose=(Open[pos]+High[pos]+Low[pos]+Close[pos])/4;
      haHigh=MathMax(High[pos], MathMax(haOpen, haClose));
      haLow=MathMin(Low[pos], MathMin(haOpen, haClose));
      if (haOpen<haClose) 
        {
         ExtMapBuffer1[pos]=haLow;
         ExtMapBuffer2[pos]=haHigh;
        } 
      else
        {
         ExtMapBuffer1[pos]=haHigh;
         ExtMapBuffer2[pos]=haLow;
        } 
      ExtMapBuffer3[pos]=haOpen;
      ExtMapBuffer4[pos]=haClose;
 
   pos--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
Samples Scripts
//+------------------------------------------------------------------+
//|                                                        close.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property show_confirm
//+------------------------------------------------------------------+
//| script "close first market order if it is first in the list"     |
//+------------------------------------------------------------------+
int start()
  {
   bool   result;
   double price;
   int    cmd,error;
//----
   if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
     {
      cmd=OrderType();
      //---- first order is buy or sell

      if(cmd==OP_BUY || cmd==OP_SELL)
        {
         while(true)
           {
            if(cmd==OP_BUY) price=Bid;
            else            price=Ask;
            result=OrderClose(OrderTicket(),OrderLots(),price,3,CLR_NONE);
            if(result!=TRUE) { error=GetLastError(); Print("LastError = ",error); }
            else error=0;
            if(error==135) RefreshRates();
            else break;
           }
        }
     }
   else Print( "Error when order select ", GetLastError());
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                               delete_pending.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property show_confirm
//+------------------------------------------------------------------+
//| script "delete first pending order"                              |
//+------------------------------------------------------------------+
int start()
  {
   bool   result;
   int    cmd,total;
//----
   total=OrdersTotal();
//----
   for(int i=0; i<total; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         cmd=OrderType();
         //---- pending orders only are considered
         if(cmd!=OP_BUY && cmd!=OP_SELL)
           {
            //---- print selected order
            OrderPrint();
            //---- delete first pending order
            result=OrderDelete(OrderTicket());
            if(result!=TRUE) Print("LastError = ", GetLastError());
            break;
           }
        }
      else { Print( "Error when order select ", GetLastError()); break; }
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                       modify.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property show_confirm
//+------------------------------------------------------------------+
//| script "modify first market order"                               |
//+------------------------------------------------------------------+
int start()
  {
   bool   result;
   double stop_loss,point;
   int    cmd,total;
//----
   total=OrdersTotal();
   point=MarketInfo(Symbol(),MODE_POINT);
//----
   for(int i=0; i<total; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         //---- print selected order
         OrderPrint();
         cmd=OrderType();
         //---- buy or sell orders are considered
         if(cmd==OP_BUY || cmd==OP_SELL)
           {
            //---- modify first market order
            while(true)
              {
               if(cmd==OP_BUY) stop_loss=Bid-20*point;
               else            stop_loss=Ask+20*point;
               result=OrderModify(OrderTicket(),0,stop_loss,0,0,CLR_NONE);
               if(result!=TRUE) Print("LastError = ", GetLastError());
               if(result==135) RefreshRates();
               else break;
              }
             //---- print modified order (it still selected after modify)
             OrderPrint();
             break;
           }
        }
      else { Print( "Error when order select ", GetLastError()); break; }
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                               modify_pending.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property show_confirm
//+------------------------------------------------------------------+
//| script "modify first pending order"                              |
//+------------------------------------------------------------------+
int start()
  {
   bool   result;
   double price,point;
   int    cmd,total;
   int    expiration;
//----

   total=OrdersTotal();
   point=MarketInfo(Symbol(),MODE_POINT);
//----
   for(int i=0; i<total; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         cmd=OrderType();
         //---- pending orders only are considered
         if(cmd!=OP_BUY && cmd!=OP_SELL)
           {
            //---- print selected order
            OrderPrint();
            //---- modify first pending order
            price=OrderOpenPrice()-10*point;
            expiration=OrderExpiration();
            result=OrderModify(OrderTicket(),price,0,0,expiration,CLR_NONE);
            if(result!=TRUE) Print("LastError = ", GetLastError());
            //---- print modified order (it still selected after modify)
            else OrderPrint();
            break;
           }
        }
      else { Print( "Error when order select ", GetLastError()); break; }
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  rotate_text.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#include <stdlib.mqh>
string line_name="rotating_line";
string object_name1="rotating_text";
void init()
  {
   Print("point = ", Point,"   bars=",Bars);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   ObjectDelete(line_name);
   ObjectDelete(object_name1);
   ObjectsRedraw();
  }
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
   int    time2;
   int    error,index,fontsize=10;
   double price,price1,price2;
   double angle=0.0;
//----
   price2=High[10]+Point*10;
   ObjectCreate(line_name, OBJ_TRENDBYANGLE, 0, Time[10], price2);

   index=20;
   ObjectCreate(object_name1, OBJ_TEXT, 0, Time[index], Low[index]-Point*100);
   ObjectSetText(object_name1, "rotating_text", fontsize);
   while(IsStopped()==false)
     {
      index++;
      price=ObjectGet(object_name1, OBJPROP_PRICE1)+Point;
      error=GetLastError();
      if(error!=0)
        {
         Print(object_name1," : ",ErrorDescription(error));
         break;
        }
      ObjectMove(object_name1, 0, Time[index], price);
      ObjectSet(object_name1, OBJPROP_ANGLE, angle*2);
      ObjectSet(object_name1, OBJPROP_FONTSIZE, fontsize);
      ObjectSet(line_name, OBJPROP_WIDTH, angle/18.0);
      double line_angle=360.0-angle;
      if(line_angle==90.0)  ObjectSet(line_name, OBJPROP_PRICE2, price2+Point*50);
      if(line_angle==270.0) ObjectSet(line_name, OBJPROP_PRICE2, price2-Point*50);
      time2=ObjectGet(line_name,OBJPROP_TIME2);
      if(line_angle>90.0 && line_angle<270.0) time2=Time[index+10];
      else                                    time2=Time[0];
      ObjectSet(line_name, OBJPROP_TIME2, time2);
      ObjectSet(line_name, OBJPROP_ANGLE, line_angle);
      ObjectsRedraw();
      angle+=3.0;
      if(angle>=360.0) angle=360.0-angle;
      fontsize++;
      if(fontsize>48) fontsize=6;
      Sleep(500);
      price1=ObjectGetValueByShift(line_name, index);
      if(GetLastError()==0)
        {
         if(MathAbs(price1-price) < Point*50)
           {
            Print("price=",price,"  price1=", price1);
            ObjectSetText(object_name1, "REMOVED", 48, "Arial", RGB(255,215,0));
            ObjectsRedraw();
            Sleep(5000);
//            ObjectDelete(object_name1);
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                 send_pending.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#property show_confirm
//+------------------------------------------------------------------+
//| script "send pending order with expiration data"                 |
//+------------------------------------------------------------------+
int start()
  {
   int    ticket,expiration;
   double point;
//----
   point=MarketInfo(Symbol(),MODE_POINT);
   expiration=CurTime()+PERIOD_D1*60;

//----
   while(true)
     {
      ticket=OrderSend(Symbol(),OP_SELLSTOP,1.0,Bid-100*point,0,0,0,"some 
comment",16384,expiration,Green);
      if(ticket<=0) Print("Error = ",GetLastError());
      else { Print("ticket = ",ticket); break; }
      //---- 10 seconds wait
      Sleep(10000);
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                        trade.mq4 |
//|                      Copyright © 2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2004, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#include <stdlib.mqh>
#include <WinUser32.mqh>
//+------------------------------------------------------------------+
//| script "trading for all money"                                   |
//+------------------------------------------------------------------+
int start()
  {
//----
   if(MessageBox("Do you really want to BUY 1.00 "+Symbol()+" at ASK price?    ",
                 "Script",MB_YESNO|MB_ICONQUESTION)!=IDYES) return(1);
//----
   int ticket=OrderSend(Symbol(),OP_BUY,1.0,Ask,3,0,0,"expert comment",255,0,CLR_NONE);
   if(ticket<1)
     {
      int error=GetLastError();
      Print("Error = ",ErrorDescription(error));
      return;
     }
//----
   OrderPrint();
   return(0);
  }
//+------------------------------------------------------------------+
Samples Program
//+------------------------------------------------------------------+
//|                                              ExportFunctions.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"
#include <sampledll.mqh>
#define TIME_INDEX   0
#define OPEN_INDEX   1
#define LOW_INDEX    2
#define HIGH_INDEX   3
#define CLOSE_INDEX  4
#define VOLUME_INDEX 5
//+------------------------------------------------------------------+

//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
   double ret,some_value=10.5;
   string sret;
   int    cnt;
   string strarray[6]={ "first", "second", "third", "fourth", "fifth" };
//---- simple dll-functions call
   cnt=GetIntValue(some_value);
   Print("Returned value is ",cnt);
   ret=GetDoubleValue(some_value);
   Print("Returned value is ",ret);
   sret=GetStringValue("some string");
   Print("Returned value is ",sret);
//----
   cnt=SortStringArray(strarray,ArraySize(strarray));
   for(int i=0; i<cnt; i++) Print(i," - ",strarray[i]);
   cnt=ProcessStringArray(strarray,ArraySize(strarray));
   for(i=0; i<cnt; i++) Print(i," - ",strarray[i]);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| array functions call                                             |
//+------------------------------------------------------------------+
int start()
  {
   double price;
   double arr[5]={1.5, 2.6, 3.7, 4.8, 5.9 };
   double rates[][6];
//---- get first item from passed array
   price=GetArrayItemValue(arr,5,0);
   Print("Returned from arr[0] ",price);
//---- change second item in the passed array
   if(SetArrayItemValue(arr,5,1,1234.5)==true)
      Print("Changed to ",arr[1]);
//---- get current close
   ArrayCopyRates(rates);
   price=GetRatesItemValue(rates,Bars,0,CLOSE_INDEX);
   Print("Returned from Close ",price);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                  MACD Sample.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
extern double TakeProfit = 50;
extern double Lots = 0.1;
extern double TrailingStop = 30;
extern double MACDOpenLevel=3;
extern double MACDCloseLevel=2;
extern double MATrendPeriod=26;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   double MacdCurrent, MacdPrevious, SignalCurrent;
   double SignalPrevious, MaCurrent, MaPrevious;
   int cnt, ticket, total;

// initial data checks
// it is important to make sure that the expert works with a normal
// chart and the user did not make any mistakes setting external 
// variables (Lots, StopLoss, TakeProfit, 
// TrailingStop) in our case, we check TakeProfit
// on a chart of less than 100 bars
   if(Bars<100)
     {
      Print("bars less than 100");
      return(0);  
     }
   if(TakeProfit<10)
     {
      Print("TakeProfit less than 10");
      return(0);  // check TakeProfit
     }
// to simplify the coding and speed up access
// data are put into internal variables
   MacdCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0);
   MacdPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   SignalCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,0);
   SignalPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
   MaCurrent=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,0);
   MaPrevious=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,1);
   total=OrdersTotal();
   if(total<1) 
     {
      // no opened orders identified
      if(AccountFreeMargin()<(1000*Lots))
        {
         Print("We have no money. Free Margin = ", AccountFreeMargin());
         return(0);  
        }
      // check for long position (BUY) possibility
      if(MacdCurrent<0 && MacdCurrent>SignalCurrent && MacdPrevious<SignalPrevious &&
         MathAbs(MacdCurrent)>(MACDOpenLevel*Point) && MaCurrent>MaPrevious)
        {
         ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,3,0,Ask+TakeProfit*Point,"macd 
sample",16384,0,Green);
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("BUY order 
opened : ",OrderOpenPrice());
           }
         else Print("Error opening BUY order : ",GetLastError()); 
         return(0); 
        }
      // check for short position (SELL) possibility
      if(MacdCurrent>0 && MacdCurrent<SignalCurrent && MacdPrevious>SignalPrevious && 
         MacdCurrent>(MACDOpenLevel*Point) && MaCurrent<MaPrevious)
        {
         ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,0,Bid-TakeProfit*Point,"macd 
sample",16384,0,Red);
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("SELL order 
opened : ",OrderOpenPrice());
           }
         else Print("Error opening SELL order : ",GetLastError()); 
         return(0); 
        }
      return(0);
     }
   // it is important to enter the market correctly, 
   // but it is more important to exit it correctly...   
   for(cnt=0;cnt<total;cnt++)

     {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      if(OrderType()<=OP_SELL &&   // check for opened position 
         OrderSymbol()==Symbol())  // check for symbol
        {
         if(OrderType()==OP_BUY)   // long position is opened
           {
            // should it be closed?
            if(MacdCurrent>0 && MacdCurrent<SignalCurrent && 
MacdPrevious>SignalPrevious &&
               MacdCurrent>(MACDCloseLevel*Point))
                {
                 OrderClose(OrderTicket(),OrderLots(),Bid,3,Violet); // close position
                 return(0); // exit
                }
            // check for trailing stop
            if(TrailingStop>0)  
              {                 
               if(Bid-OrderOpenPrice()>Point*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-Point*TrailingStop)
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-
Point*TrailingStop,OrderTakeProfit(),0,Green);
                     return(0);
                    }
                 }
              }
           }
         else // go to short position
           {
            // should it be closed?
            if(MacdCurrent<0 && MacdCurrent>SignalCurrent &&
               MacdPrevious<SignalPrevious && 
MathAbs(MacdCurrent)>(MACDCloseLevel*Point))
              {
               OrderClose(OrderTicket(),OrderLots(),Ask,3,Violet); // close position
               return(0); // exit
              }
            // check for trailing stop
            if(TrailingStop>0)  
              {                 
               if((OrderOpenPrice()-Ask)>(Point*TrailingStop))
                 {
                  if((OrderStopLoss()>(Ask+Point*TrailingStop)) || 
(OrderStopLoss()==0))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,
OrderTakeProfit(),0,Red);
                     return(0);
                    }
                 }
              }
           }
        }
     }
   return(0);
  }
// the end.
//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#define MAGICMA  20050610

extern double Lots               = 0.1;
extern double MaximumRisk        = 0.02;
extern double DecreaseFactor     = 3;
extern double MovingPeriod       = 12;
extern double MovingShift        = 6;
//+------------------------------------------------------------------+
//| Calculate open positions                                         |
//+------------------------------------------------------------------+
int CalculateCurrentOrders(string symbol)
  {
   int buys=0,sells=0;
//----
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICMA)
        {
         if(OrderType()==OP_BUY)  buys++;
         if(OrderType()==OP_SELL) sells++;
        }
     }
//---- return orders volume
   if(buys>0) return(buys);
   else       return(-sells);
  }
//+------------------------------------------------------------------+
//| Calculate optimal lot size                                       |
//+------------------------------------------------------------------+
double LotsOptimized()
  {
   double lot=Lots;
   int    orders=HistoryTotal();     // history orders total
   int    losses=0;                  // number of losses orders without a break
//---- select lot size
   lot=NormalizeDouble(AccountFreeMargin()*MaximumRisk/1000.0,1);
//---- calcuulate number of losses orders without a break
   if(DecreaseFactor>0)
     {
      for(int i=orders-1;i>=0;i--)
        {
         if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false) { Print("Error in 
history!"); break; }
         if(OrderSymbol()!=Symbol() || OrderType()>OP_SELL) continue;
         //----
         if(OrderProfit()>0) break;
         if(OrderProfit()<0) losses++;
        }
      if(losses>1) lot=NormalizeDouble(lot-lot*losses/DecreaseFactor,1);
     }
//---- return lot size
   if(lot<0.1) lot=0.1;
   return(lot);
  }
//+------------------------------------------------------------------+
//| Check for open order conditions                                  |
//+------------------------------------------------------------------+
void CheckForOpen()
  {
   double ma;
   int    res;
//---- go trading only for first tiks of new bar
   if(Volume[0]>1) return;
//---- get Moving Average 
   ma=iMA(NULL,0,MovingPeriod,MovingShift,MODE_SMA,PRICE_CLOSE,0);
//---- sell conditions
   if(Open[1]>ma && Close[1]<ma)  
     {

      res=OrderSend(Symbol(),OP_SELL,LotsOptimized(),Bid,3,0,0,"",MAGICMA,0,Red);
      return;
     }
//---- buy conditions
   if(Open[1]<ma && Close[1]>ma)  
     {
      res=OrderSend(Symbol(),OP_BUY,LotsOptimized(),Ask,3,0,0,"",MAGICMA,0,Blue);
      return;
     }
//----
  }
//+------------------------------------------------------------------+
//| Check for close order conditions                                 |
//+------------------------------------------------------------------+
void CheckForClose()
  {
   double ma;
//---- go trading only for first tiks of new bar
   if(Volume[0]>1) return;
//---- get Moving Average 
   ma=iMA(NULL,0,MovingPeriod,MovingShift,MODE_SMA,PRICE_CLOSE,0);
//----
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)        break;
      if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
      //---- check order type 
      if(OrderType()==OP_BUY)
        {
         if(Open[1]>ma && Close[1]<ma) 
OrderClose(OrderTicket(),OrderLots(),Bid,3,White);
         break;
        }
      if(OrderType()==OP_SELL)
        {
         if(Open[1]<ma && Close[1]>ma) 
OrderClose(OrderTicket(),OrderLots(),Ask,3,White);
         break;
        }
     }
//----
  }
//+------------------------------------------------------------------+
//| Start function                                                   |
//+------------------------------------------------------------------+
void start()
  {
//---- check for history and trading
   if(Bars<100 || IsTradeAllowed()==false) return;
//---- calculate open orders by current symbol
   if(CalculateCurrentOrders(Symbol())==0) CheckForOpen();
   else                                    CheckForClose();
//----
  }
//+------------------------------------------------------------------+
