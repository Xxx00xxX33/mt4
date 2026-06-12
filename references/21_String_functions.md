# String functions

Page: 74

---

String functions
StringConcatenate()
StringFind()
StringGetChar()
StringLen()
StringSetChar()
StringSubstr()
StringTrimLeft()
StringTrimRight()
string StringConcatenate(... )
Writes data to the string and returns it. Parameters can be of any type. Arrays cannot be passed to the StringConcatenate() 
function. Arrays should be printed elementwise. Data of double type printed with 4 decimal digits after point. To print with more 
precision use DoubleToStr() function. Data of bool, datetime and color types will be printed as its numeric presentation. To print 
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
StringConcatenate()
 
function
 
work
 
faster
 
than
 
concatenating
 
strings
 
by
 
+
 
operator.
See also: Print(), Alert() and Comment() functions. 

Parameters
...   -  Any values, separated by commas.
Sample
  string text;
  text=StringConcatenate("Account free margin is ", AccountFreeMargin(), "Current 
time is ", TimeToStr(CurTime()));
// slow text="Account free margin is " + AccountFreeMargin() + "Current time is " + 
TimeToStr(CurTime())
  Print(text);
int StringFind(string text, string matched_text, int start=0)
Scans this string for the first match of a substring.
Parameters
text
  -  String to search for.
matched_text   -  String to search for.
start
  -  Starting index in the string.
Sample
  string text="The quick brown dog jumps over the lazy fox";
  int index=StringFind(text, "dog jumps", 0);
  if(index!=16)
    Print("oops!");
int StringGetChar(string text, int pos)
Returns character (code) from specified position in the string.
Parameters
text   -  String where character will be retrieved.
pos
  -  Char zero based position in the string.
Sample
  int char_code=StringGetChar("abcdefgh", 3);
  // char code 'c' is 99
int StringLen(string text)
Returns character count of a string.
Parameters
text   -  String to calculate length.
Sample
  string str="some text";
  if(StringLen(str)<5) return(0);
string StringSetChar(string text, int pos, int value)
Returns string copy with changed character at the indicated position with new value.
Parameters
text
  -  String where character will be changed.
pos
  -  Zero based character position in the string. Can be from 0 to StringLen()-1.
value   -  New char ASCII code.
Sample
  string str="abcdefgh";
  string str1=StringSetChar(str, 3, 'D');
  // str1 is "abcDefgh"

string StringSubstr(string text, int start, int count=EMPTY)
Extracts
 
a
 
substring
 
from
 
text
 
string,
 
starting
 
at
 
position
 
(zero-based).
The function returns a copy of the extracted substring if possible, otherwise returns empty string. 
Parameters
text
  -  String from substring will be extracted.
start
  -  Substring starting index
count   -  Character count.
Sample
  string text="The quick brown dog jumps over the lazy fox";
  string substr=StringSubstr(text, 4, 5);
  // subtracted string is "quick" word
string StringTrimLeft(string text)
Call the function to trim leading white space characters from the string. StringTrimLeft removes new line, space, and tab 
characters. The function returns a copy of the trimmed string if possible, otherwise returns empty string. Returns new string with 
changes. 
Parameters
text   -  String to trim left.
Sample
  string str1="  Hello world   ";
  string str2=StringTrimLeft(str);
  // after trimming the str2 variable will be "Hello World   "
string StringTrimRight(string text)
Call the function to trim leading white space characters from the string. StringTrimRight removes new line, space, and tab 
characters. The function returns a copy of the trimmed string if possible, otherwise return empty string. 
Parameters
text   -  String to trim right.
Sample
  string str1="  Hello world   ";
  string str2=StringTrimRight(str);
  // after trimming the str2 variable will be "  Hello World"