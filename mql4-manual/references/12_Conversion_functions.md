# Conversion functions

Page: 30

---

Conversion functions
CharToStr()
DoubleToStr()
NormalizeDouble()
StrToDouble()
StrToInteger()
StrToTime()
TimeToStr()
string CharToStr(int char_code)
Returns string with one symbol that have specified code
Parameters
char_code   -  ASCII char code.
Sample
  string str="WORL" + CharToStr(44); // 44 is code for 'D'
  // resulting string will be WORLD

string DoubleToStr(double value, int digits)
Returns text string with the specified numerical value transformed into the specified precision format. 
Parameters
value   -  Numerical value.
digits   -  Precision format, number of digits after decimal point (0-8).
Sample
  string value=DoubleToStr(1.28473418, 5);
  // value is 1.28473
double NormalizeDouble(double value, int digits)
Rounds floating point number to specified decimal places.
Parameters
value   -  Floating point value.
digits   -  Precision format, number of digits after decimal point (0-8).
Sample
  double var1=0.123456789;
  Print(NormalizeDouble(var1,5));
  // output: 0.12346
double StrToDouble(string value)
Converts string representation of number to type double.
Parameters
value   -  String containing value in fixed number format.
Sample
  double var=StrToDouble("103.2812");
int StrToInteger(string value)
Converts string representation of number to type integer.
Parameters
value   -  String containing integer number.
Sample
  int var1=StrToInteger("1024");
datetime StrToTime(string value)
Converts string in the format "yyyy.mm.dd hh:mi" to type datetime.
Parameters
value   -  String value of date/time format such as "yyyy.mm.dd hh:mi".
Sample
  datetime var1;
  var1=StrToTime("2003.8.12 17:35");
  var1=StrToTime("17:35");      // returns with current date
  var1=StrToTime("2003.8.12");  // returns with midnight time "00:00"
string TimeToStr(datetime value, int mode=TIME_DATE|TIME_MINUTES)
Returns time as string in the format "yyyy.mm.dd hh:mi".
Parameters

value   -  Positive number of seconds from 00:00 January 1, 1970.
mode   -  Optional data output mode can be one or combination of:
TIME_DATE get result in form "yyyy.mm.dd",
TIME_MINUTES get result in form "hh:mi",
TIME_SECONDS get result in form "hh:mi:ss".
Sample
  strign var1=TimeToStr(CurTime(),TIME_DATE|TIME_SECONDS);