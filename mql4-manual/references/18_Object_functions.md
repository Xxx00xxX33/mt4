# Object functions

Page: 55

---

Object functions
ObjectCreate()
ObjectDelete()
ObjectDescription()
ObjectFind()
ObjectGet()
ObjectGetFiboDescription()
ObjectGetShiftByValue()
ObjectGetValueByShift()
ObjectGetVisibility()
ObjectMove()
ObjectName()
ObjectsDeleteAll()
ObjectSet()
ObjectSetFiboDescription()
ObjectSetText()
ObjectSetVisibility()
ObjectsRedraw
ObjectsTotal()
ObjectType()
bool 
ObjectCreate(
string name, int type, int window, datetime time1, double price1, 
datetime time2=0, double price2=0, datetime time3=0, double price3=0)
Create object with specified name, type and initial coordinates in the specified window. Count of coordinates related from object 
type (1-3). If the function succeeds, the return value will be true. If the function succeeds, the return value is true. If the function 
fails, the return value is false. To get the detailed error information, call GetLastError(). For objects with type OBJ_LABEL first 
coordinate ignored. To set coordinate for label use ObjectSet() function to set OBJPROP_XDISTANCE and OBJPROP_YDISTANCE 
properties.
Note: Coordinates must be passed with both part - time and price. For example: Object OBJ_VLINE required 1 coordinate part 
time. But function wants also the seconds part of coordinate price. 
Parameters

name
  -  Unique object name.
type
  -  Object type. It can be any of the Object type enumeration values.
window   -  Window index where object will be added. Window index must be greater or equal to 0 and less than WindowsTotal().
time1
  -  Time part of first point.
price1
  -  Price part of first point.
time2
  -  Time part of second point.
price2
  -  Price part of second point.
time3
  -  Time part of third point.
price3
  -  Price part of third point.
Sample
  // new text object
  if(!ObjectCreate("text_object", OBJ_TEXT, 0, D'2004.02.20 12:30', 1.0045))
    {
     Print("error: can't create text_object! code #",GetLastError());
     return(0);
    }
  // new label object
  if(!ObjectCreate("label_object", OBJ_LABEL, 0, 0, 0))
    {
     Print("error: can't create label_object! code #",GetLastError());
     return(0);
    }
  ObjectSet("label_object", OBJPROP_XDISTANCE, 200);
  ObjectSet("label_object", OBJPROP_YDISTANCE, 100);
bool ObjectDelete(string name)
Deletes object with specified name. If the function succeeds, the return value will be true. If the function succeeds, the return 
value is true. If the function fails, the return value is false. To get the detailed error information, call GetLastError(). 
Parameters
name   -  Deleting object name.
Sample
  ObjectDelete("text_object");
string ObjectDescription(string name)
Return object description. To get error information, call GetLastError() function. 
Parameters
name   -  Object name.
Sample
  // writing chart's object list to the file
  int    handle, total;
  string obj_name,fname;
  // file name
  fname="objlist_"+Symbol();
  handle=FileOpen(fname,FILE_CSV|FILE_WRITE);
  if(handle!=false)
    {
     total=ObjectsTotal();
     for(int i=-;i<total;i++)
       {
        obj_name=ObjectName(i);
        FileWrite(handle,"Object "+obj_name+" description= 
"+ObjectDescription(obj_name));
       }

     FileClose(handle);
    }
int ObjectFind(string name)
Return object owner's window index. If the function fails, the return value will be -1. To get the detailed error information, call 
GetLastError() function. 
Parameters
name   -  Object name to check.
Sample
  if(ObjectFind("line_object2")!=win_idx) return(0);
double ObjectGet(string name, int index)
Returns objects property value by index. To check errors, call GetLastError() function. 
Parameters
name   -  Object name.
index   -  Object property index. It can be any of the Object properties enumeration values.
Sample
  color oldColor=ObjectGet("hline12", OBJPROP_COLOR);
string ObjectGetFiboDescription(string name, int index)
Function returns description of Fibonacci level. The amount of Fibonacci levels depends on the object type. The maximum amount 
of
 
Fibonacci
 
levels
 
never
 
exceeds
 
32.
To get the detailed error information, call GetLastError() function. 
Parameters
name   -  Object name.
index   -  Index of the Fibonacci level.
Sample
#include <stdlib.mqh>
  ...
  string text;
  for(int i=0;i<32;i++)
    {
     text=ObjectGetFiboDescription(MyObjectName,i);
     //---- check. may be objects's level count less than 32
     if(GetLastError()!=ERR_NO_ERROR) break;
     Print(MyObjectName,"level: ",i," description: ",text);
    }
int ObjectGetShiftByValue(string name, double value)
Calculates and returns bar index for the indicated price. Calculated by first and second coordinate. Applied to trendlines. To get 
the detailed error information, call GetLastError() function. 
Parameters
name   -  Object name.
value   -  Price value.
Sample
  int shift=ObjectGetShiftByValue("MyTrendLine#123", 1.34);
double ObjectGetValueByShift(string name, int shift)
Calculates and returns price value for the indicated bar. Calculated by first and second coordinate. Applied to trendlines. To get 
the detailed error information, call GetLastError() function. 

Parameters
name   -  Object name
shift
  -  Bar index.
Sample
  double price=ObjectGetValueByShift("MyTrendLine#123", 11);
int ObjectGetVisibility(string name)
Function returns flags of the object visibility on the chart. Value can be single or combined (bitwise addition) of object visibility 
constants. 
Parameters
name   -  Object name.
Sample
   // is object visible on the chart?
   if((ObjectGetVisibility()&OBJ_PERIOD_M5)!=0 && Period()==PERIOD_M5)
     {
      // working with object
     }
bool ObjectMove(string name, int point, datetime time1, double price1)
Moves objects point on the chart. Objects can have from one to three points related to its type. If the function succeeds, the 
return value will be true. If the function fails, the  return value  will be  false.  To get the  detailed error information, call 
GetLastError(). 
Parameters
name
  -  Object name.
point
  -  Coordinate index.
time1
  -  New time value.
price1   -  New price value.
Sample
  ObjectMove("MyTrend", 1, D'2005.02.25 12:30', 1.2345);
string ObjectName(int index)
Returns object name by index.
Parameters
index   -  Object index on the chart. Object index must be greater or equal to 0 and less than ObjectsTotal().
Sample
  int    obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name=ObjectName(i);
     Print(i,"Object name is " + name);
    }
int ObjectsDeleteAll(int window, int type=EMPTY)
Removes all objects with specified type and on the specified subwindow of the chart. Returns removed objects count.
Parameters
window   -  Window index from objects will be deleted. Window index must be greater or equal to 0 and less than WindowsTotal().
type
  -  Optional object type to delete.It can be any of the Object type enumeration values or EMPTY constant to delete all objects with 
any types.
Sample

  ObjectsDeleteAll(2, OBJ_HLINE); // removes all horizontal line objects from window 
3 (index 2).
bool ObjectSet(string name, int index, double value)
Changes named objects property with new value. If the function succeeds, the return value will be true. If the function fails, the 
return value will be false. To get the detailed error information, call GetLastError(). 
Parameters
name   -  Object name.
index   -  Object value index. It can be any of Object properties enumeration values.
value   -  New value for property.
Sample
  // moving first coord to last bar time
  ObjectSet("MyTrend", OBJPROP_TIME1, Time[0]);
  // setting second fibo level
  ObjectSet("MyFibo", OBJPROP_FIRSTLEVEL+1, 1.234);
  // setting object visibility. object will be shown only on 15 minute and 1 hour 
charts
  ObjectSet("MyObject", OBJPROP_TIMEFRAMES, OBJ_PERIOD_M15 | OBJ_PERIOD_H1);
bool ObjectSetFiboDescription(string name, int index, string text)
Function assigns a new description to a Fibonacci level. The amount of Fibonacci levels depends on the object type. The maximum 
amount
 
of
 
Fibonacci
 
levels
 
never
 
exceeds
 
32.
To get the detailed error information, call GetLastError() function. 
Parameters
name   -  Object name.
index   -  Index of the Fibonacci level (0-31).
text
  -  New description to be assigned to the Fibonacci level.
Sample
  ObjectSetFiboDescription("MyFiboObject,2,"Second line");
bool 
ObjectSetText(
string name, string text, int font_size, string font=NULL, 
color text_color=CLR_NONE)
Sets object description. If the function succeeds, the return value will be true. If the function fails, the return value will be false. 
To get the detailed error information, call GetLastError() function. 
Parameters
name
  -  Object name.
text
  -  Some text.
font_size
  -  Font size in points.
font
  -  Font name.
text_color   -  Text color.
Sample
  ObjectSetText("text_object", "Hello world!", 10, "Times New Roman", Green);
int ObjectSetVisibility(string name, int flag)
Function sets new value to the object visibility property. Function returns previous value. 
Parameters
name   -  Object name.
flag
  -  New value of the object visibility property. Value can be single or combined (bitwise addition) of object visibility constants.
Sample
  // The object will be shown on 1-hour charts only.

  ObjectSetVisibility("MyObj1",OBJ_PERIOD_H1);
void ObjectsRedraw()
Redraws all objects on the char.
Sample
  ObjectsRedraw();
int ObjectsTotal()
Returns total count of objects on the chart.
Sample
  int    obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name=ObjectName(i);
     Print(i,"Object name is for object #",i," is " + name);
    }
int ObjectType(string name)
Returns Object type enumeration value.
Parameters
name   -  Object name.
Sample
  if(ObjectType("line_object2")!=OBJ_HLINE) return(0);