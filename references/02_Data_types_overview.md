# Data types overview

Page: 3

---

Data types overview
The main data types are: 
•
Integer (int)
  
 
•
Boolean (bool)
  
 
•
Literals (char)
  
 
•
String (string)
  
 
•
Floating-point number (double)
  
 
•
Color (color)
  
 
•
Datetime (datetime)
  
 
We need the Color and Datetime types only to facilitate visualization and entering those parameters that we set from 
expert advisor property tab or custom indicator "Input parameters" tab. The data of Color and Datetime types are 
represented as integer values.
We use implicit type transformation. The priority of types at a transformation in ascending order is the following:
int  (bool,color,datetime);
double;
string;
Before operations (except for the assignment ones) are performed, the data have been transferred to the maximum 
precision type. Before assignment operations are performed, the data have been transferred to the integer type. 
Integer constants
Decimal: numbers from 0 to 9; Zero should not be the first number.
Examples:
12, 111, -956 1007
Hexadecimal: numbers from 0 to 9, letters a-f or A-F to represent the values 10-15; they start with 0x or 0X.
Examples:
0x0A, 0x12, 0X12, 0x2f, 0xA3, 0Xa3, 0X7C7
Integer constants can assume values from -2147483648 to 2147483647. If a constant exceeds this range, the result 
will not be defined.
Literal constants
Any single character enclosed in single quotes or a hexadecimal ASCII-code of a character looking like '\x10' is a 
character constant of integer type. Some characters like a single quote ('), double quote (") a question mark (?), a 
reverse slash (\) and control characters can be represented as a combination of characters starting with a reverse 
slash (\) according to the table below:
line feed                NL (LF)  \n
horizontal tab           HT       \t
carriage return          CR       \r
reverse slash            \        \\
single quote             '        \'
double quote             "        \"
hexadecimal ASCII-code   hh      \xhh
If a character different from those listed above follows the reverse slash, the result will not be defined.

Examples:
int a = 'A';
int b = '$';
int c = '©'; // code 0xA9
int d = '\xAE';   // symbol code ®
Boolean constants
Boolean constants may have the value of true or false, numeric representation of them is 1 or 0 respectively. We can 
also use synonyms True and TRUE, False and FALSE.
Examples:
bool a = true;
bool b = false;
bool c = 1;
Floating-point number constants
Floating-point constants consist of an integer part, a dot (.) and a fractional part. The integer and the fractional parts 
are a succession of decimal numbers. An unimportant fractional part with the dot can be absent.
Examples:
double a = 12.111;
double b = -956.1007;
double c = 0.0001;
double d = 16;
Floating-point constants can assume values from 2.2e-308 to 1.8e308. If a constant exceeds this range, the result 
will not be defined.
String constants
String constant is a succession of ASCII-code characters enclosed in double quotes: "Character constant".
A string constant is an array of characters enclosed in quotes. It is of the string type. Each string constant, even if it 
is identical to another string constant, is saved in a separate memory space. If you need to insert a double quote (") 
into the line, you must place a reverse slash (\) before it. You can insert any special character constants into the line 
if they have a reverse slash (\) before them. The length of a string constant lies between 0 and 255 characters. If the 
string constant is longer, the superfluous characters on the right are rejected.
Examples:
"This is a character string"
"Copyright symbol \t\xA9"
"this line with LF symbol \n"
"A" "1234567890" "0" "$"
Color constants
Color constants can be represented in three ways: by character representation; by integer representation; by name 
(for concrete Web colors only).
Character representation consists of four parts representing numerical rate values of three main color components - 
red, green, blue. The constant starts with the symbol C and is enclosed in single quotes. Numerical rate values of a 
color component lie in the range from 0 to 255.
Integer-valued representation is written in a form of hexadecimal or a decimal number. A hexadecimal number looks 
like 0x00BBGGRR where RR is the rate of the red color component, GG - of the green one and BB - of the blue one. 
Decimal constants are not directly reflected in RGB. They represent the decimal value of the hexadecimal integer 
representation. 
Specific colors reflect the so-called Web colors set.
Examples:
// symbol constants
C'128,128,128'    // gray

C'0x00,0x00,0xFF' // blue
// named color
Red
Yellow
Black
// integer-valued representation
0xFFFFFF          // white
16777215          // white
0x008000          // green
32768             // green
Datetime constants
Datetime constants can be represented as a character line consisting of 6 parts for value of year, month, date, hour, 
minutes, and seconds. The constant is enclosed in simple quotes and starts with a D character.
Datetime constant can vary from Jan 1, 1970 to Dec 31, 2037.
Examples:
D'2004.01.01 00:00'     // New Year
D'1980.07.19 12:30:27'
D'19.07.1980 12:30:27'
D'19.07.1980 12'        //equal to D'1980.07.19 12:00:00'
D'01.01.2004'           //equal to D'01.01.2004 00:00:00'
D'12:30:27'             //equal to D'[compilation date] 12:30:27'
D''                     //equal to D'[compilation date] 00:00:00'