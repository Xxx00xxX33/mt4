# Common functions

Page: 24

---

Common functions
Alert()
ClientTerminalName()
CompanyName()
Comment()
GetLastError()
GetTickCount()
HideTestIndicators()
IsConnected()
IsDemo()
IsDllsAllowed()
IsLibrariesAllowed()
IsStopped()
IsTesting()
IsTradeAllowed()
MarketInfo()
MessageBox()
Period()
PlaySound()
Print()
RefreshRates()
SendMail()
ServerAddress()
Sleep()
SpeechText()
Symbol()
UninitializeReason()

void Alert(... )
Displays a dialog box containing the user-defined data. Parameters can be of any type. Arrays cannot be passed to the Alert 
function. Data of double type printed with 4 decimal digits after point. To print with more precision use DoubleToStr() function. 
Data of bool, datetime and color types will be printed as its numeric presentation. To print values of datetime type as string 
convert it by TimeToStr() function.
See also: Comment() and Print() functions. 
Parameters
...   -  Any values, separated by commas.
Sample
  if(Close[0]>SignalLevel)
    Alert("Close price coming ", Close[0],"!!!");
string ClientTerminalName()
Returns Client Terminal Name.
Sample
  Print("Terminal name is ",ClientTerminalName());
string CompanyName()
Returns Company name
Sample
  Print("Company name is ",CompanyName());
void Comment(... )
Prints some message to the left top corner of the chart. Parameters can be of any type. Arrays cannot be passed to the 
Comment() function. Arrays should be output elementwise. Data of double type printed with 4 decimal digits after point. To print 
with more precision use DoubleToStr() function. Data of bool, datetime and color types will be printed as its numeric presentation. 
To
 
print
 
values
 
of
 
datetime
 
type
 
as
 
string
 
convert
 
it
 
by
 TimeToStr() 
function.
See also: Alert() and Print() functions. 
Parameters
...   -  Any values, separated by commas.
Sample
  double free=AccountFreeMargin();
  Comment("Account free margin is ",DoubleToStr(free,2),"\n","Current time is 
",TimeToStr(CurTime()));
int GetLastError()
Returns last occurred error after an operation and sets internal last error value to zero. 
Sample
  int err;
  int handle=FileOpen("somefile.dat", FILE_READ|FILE_BIN);
  if(handle<1)
    {
     err=GetLastError();
     Print("error(",err,"): ",ErrorDescription(err));
     return(0);
    }

int GetTickCount()
The GetTickCount() function retrieves the number of milliseconds that have elapsed since the system was started. It is limited to 
the resolution of the system timer. 
Sample
  int start=GetTickCount();
  // do some hard calculation...
  Print("Calculation time is ", GetTickCount()-start, " milliseconds.");
void HideTestIndicators(bool hide)
The function sets a flag hiding indicators called by the Expert Advisor. After the chart has been tested and opened the flagged 
indicators will not be drawn on the testing chart. Every indicator called will first be flagged with the current hiding flag. 
Parameters
hide   -  TRUE - if indicators must be hidden, otherwise, FALSE.
Sample
  HideTestIndicators(true);
bool IsConnected()
Returns true if client terminal has opened connection to the server, otherwise returns false.
Sample
  if(!IsConnected())
    {
     Print("Connection is broken!");
     return(0);
    }
  // Expert body that need opened connection
  // ...
bool IsDemo()
Returns true if expert runs on demo account, otherwise returns false.
Sample
  if(IsDemo()) Print("I am working on demo account");
  else Print("I am working on real account");
bool IsDllsAllowed()
Returns  true  if  DLL  function  call  is  allowed  for  the  expert,  otherwise  returns  false.  See  also IsLibrariesAllowed(), 
IsTradeAllowed(). 
Sample
  #import "user32.dll"
     int     MessageBoxA(int hWnd ,string szText, string szCaption,int nType);
  ...
  ...
  if(IsDllsAllowed()==false)
    {
     Print("DLL call is not allowed. Experts cannot run.");
     return(0);
    }
  // expert body that calls external DLL functions
  MessageBoxA(0,"an message","Message",MB_OK);

bool IsLibrariesAllowed()
Returns true if expert can call library function, otherwise returns false. See also IsDllsAllowed(), IsTradeAllowed(). 
Sample
  #import "somelibrary.ex4"
     int somefunc();
  ...
  ...
  if(IsLibrariesAllowed()==false)
    {
     Print("Library call is not allowed. Experts cannot run.");
     return(0);
    }
  // expert body that calls external DLL functions
  somefunc();
bool IsStopped()
Returns true if expert in the stopping state, otherwise returns false. This function can be used in the cycles to determine expert 
unloading. 
Sample
  while(expr!=false)
    {
     if(IsStopped()==true) return(0);
     // long time procesing cycle
     // ...
    }
bool IsTesting()
Returns true if expert runs in the testing mode, otherwise returns false.
Sample
  if(IsTesting()) Print("I am testing now");
bool IsTradeAllowed()
Returns true if trade is allowed for the expert, otherwise returns false. See also IsDllsAllowed(), IsLibrariesAllowed(). 
Sample
  if(IsTradeAllowed()) Print("Trade allowed");
double MarketInfo(string symbol, int type)
Returns value from Market watch window.
Parameters
symbol   -  Instrument symbol.
type
  -  Returning data type index. It can be any of Market information identifiers value.
Sample
  double var;
  var=MarketInfo("EURUSD",MODE_BID);
int MessageBox(string text=NULL, string caption=NULL, int flags=EMPTY)
The MessageBox function creates, displays, and operates a message box. The message box contains an application-defined 

message
 
and
 
title,
 
plus
 
any
 
combination
 
of
 
predefined
 
icons
 
and
 
push
 
buttons.
If the function succeeds, the return value is one of the MessageBox return code values. 
Parameters
text
  -  Optional text that contains the message to be displayed.
caption   -  Optional text that contains the dialog box title.If this parameter is NULL, the title will be name of expert.
flags
  -  Specifies the contents and behavior of the dialog box.This optional parameter can be a combination of flags from the following 
groups of flags.
Sample
  #include <WinUser32.mqh>
  
  if(ObjectCreate("text_object", OBJ_TEXT, 0, D'2004.02.20 12:30', 1.0045)==false)
    {
     int ret=MessageBox("ObjectCreate() fails with code 
"+GetLastError()+"\nContinue?", "Question", MB_YESNO|MB_ICONQUESTION);
     if(ret==IDNO) return(false);
    }
  // continue
int Period()
Returns the number of minutes defining the used period (chart timeframe).
Sample
  Print("Period is ", Period());
void PlaySound(string filename)
Function plays sound file. File must be located at the terminal_dir\sounds directory or its subdirectory.
Parameters
filename   -  Sound file name.
Sample
  if(IsDemo()) PlaySound("alert.wav");
void Print(... )
Prints some message to the experts log. Parameters can be of any type. Arrays cannot be passed to the Print() function. Arrays 
should be printed elementwise. Data of double type printed with 4 decimal digits after point. To print with more precision use 
DoubleToStr() function. Data of bool, datetime and color types will be printed as its numeric presentation. To print values of 
datetime
 
type
 
as
 
string
 
convert
 
it
 
by
 TimeToStr() 
function.
See also: Alert() and Comment() functions. 
Parameters
...   -  Any values, separated by commas.
Sample
  Print("Account free margin is ", AccountFreeMargin());
  Print("Current time is ", TimeToStr(CurTime()));
  double pi=3.141592653589793;
  Print("PI number is ", DoubleToStr(pi,8));
  // Output: PI number is 3.14159265
  // Array printing
  for(int i=0;i<10;i++)
    Print(Close[i]);
bool RefreshRates()
Refreshing data in the built-in variables and series arrays. This function is used when expert advisor calculates for a long time and 
needs refreshing data. Returns true if data are refreshed, otherwise false. 

Sample
   int ticket;
   while(true)
     {
      ticket=OrderSend(Symbol(),OP_BUY,1.0,Ask,3,0,0,"expert 
comment",255,0,CLR_NONE);
      if(ticket<=0)
        {
         int error=GetLastError();
         if(error==134) break;            // not enough money
         if(error==135) RefreshRates();   // prices changed
         break;
        }
      else { OrderPrint(); break; }
      //---- 10 seconds wait
      Sleep(10000);
     }
void SendMail(string subject, string some_text)
Sends mail to address set in the Tools->Options->EMail tab if enabled. Note: Posting e-mail can be denied or address can be 
empty. 
Parameters
subject
  -  Subject text.
some_text   -  Mail body.
Sample
  double lastclose=Close[0];
  if(lastclose<my_signal)
    SendMail("from your expert", "Price dropped down to "+DoubleToStr(lastclose));
string ServerAddress()
Returns connected server address in form of a text string.
Sample
  Print("Server address is ", ServerAddress());
void Sleep(int milliseconds)
The Sleep function suspends the execution of the current expert for a specified interval.
Parameters
milliseconds   -  Sleeping interval in milliseconds.
Sample
   Sleep(5);
void SpeechText(string text, int lang_mode=SPEECH_ENGLISH)
Computer speaks some text.
Parameters
text
  -  Speaking text.
lang_mode   -  SPEECH_ENGLISH (by default) or SPEECH_NATIVE values.
Sample
  double lastclose=Close[0];
  SpeechText("Price dropped down to "+DoubleToStr(lastclose));

string Symbol()
Returns a text string with the name of the current financial instrument.
Sample
   int total=OrdersTotal();
   for(int pos=0;pos<total;pos++)
     {
      // check selection result becouse order may be closed or deleted at this time!
      if(OrderSelect(pos, SELECT_BY_POS)==false) continue;
      if(OrderType()>OP_SELL || OrderSymbol()!=Symbol()) continue;
      // do some orders processing...
     }
int UninitializeReason()
Returns the code of the uninitialization reason for the experts, custom indicators, and scripts. Return values can be one of 
Uninitialize reason codes. 
Sample
  // this is example
  int deinit()
    {
     switch(UninitializeReason())
       {
        case REASON_CHARTCLOSE:
        case REASON_REMOVE:      CleanUp(); break; // clean up and free all expert's 
resources.
        case REASON_RECOMPILE:
        case REASON_CHARTCHANGE:
        case REASON_PARAMETERS:
        case REASON_ACCOUNT:     StoreData(); break;  // prepare to restart
       }
     //...
    }