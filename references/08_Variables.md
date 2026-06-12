# Variables

Page: 13

---

Variables
Definitions
Defining local variables
Static variables

Defining global variables
Defining extern variables
Initializing variables
External function definition
Definitions
Definitions are used to define variables and to declare types of variables and functions defined somewhere else. A 
definition is not an operator. Variables must be declared before being used. Only constants can be used to initialize 
variables.
The basic types are:
•
string - a string of characters; 
•
int - an integer; 
•
double - a floating-point number (double precision); 
•
bool - a boolean number "true" or "false". 
Example:
string MessageBox;
int    Orders;
double SymbolPrice;
bool   bLog;
The additional types are:
•
datetime is date and time, unsigned integer, containing seconds since 0 o'clock on January, 1, 1970. 
•
color - integer reflecting a collection of three color components. 
The additional data types make sense only at the declaration of input data for more convenient their representation 
in a property sheet.
Example:
extern datetime tBegin_Data   = D'2004.01.01 00:00';
extern color    cModify_Color = C'0x44,0xB9,0xE6';
Arrays
Array is the indexed sequence of the identical-type data.
Example:
int    a[50];       //A one-dimensional array of 50 integers.
double m[7][50];    //Two-dimensional array of seven arrays,
                    //each of them consisting of 50 integers.
Only an integer can be an array index. No more than four-dimensional arrays can be declared.
Defining local variables
The variable declared inside any function is local. The scope of a local variable is limited to limits of the function 
inside which it is declared. The local variable can be initialized by outcome of any expression. Every call of function 
execute the initialization of local variables. Local variables are stored in memory area of corresponding function.
Formal parameters
Examples:
void func(int x, double y, bool z)
  {
   ...
  }
Formal parameters are local. Scope is the block of the function. Formal parameters must have names differing from 
those of external variables and local variables defined within one function. In the block of the function to the formal 
parameters some values can be assigned. Formal parameters can be initialized by constants. In this case, the 
initializing value is considered as a default value. The parameters following the initialized parameter should be 

initialized, as well.
By calling this function the initialized parameters can be omitted, instead of them defaults will be substituted.
Example:
func(123, 0.5);
Parameters are passed by value. These are modifications of a corresponding local variable inside the called function 
will not be reflected in any way in the calling function. It is possible to pass arrays as parameters. However, for an 
array passed as parameter, it is impossible to change the array elements.
There is a possibility to pass parameters by reference. In this case, modification of such parameters will be reflected 
on corresponded variables in the called function. To point, that the parameter is passed by reference, after a data 
type, it is necessary to put the modifier &.
Example:
void func(int& x, double& y, double& z[])
  {
   ...
  }
Arrays also can be passed by reference, all modifications will be reflected in the initial array. The parameters that 
passed by reference, cannot be initialized by default values.
Static variables
The memory class "static" defines a static variable. The specifier "static" is declared before a data type. 
Example:
  {
   static int flag
  }
Static variables are constant ones since their values are not lost when the function is exited. Any variables in a block, 
except the formal parameters of the function, can be defined as static. The static variable can be initialized by 
corresponded type constant, as against a simple local variable which can be initialized by any expression. If there is 
no explicit initialization, the static variable is initialized with zero. Static variables are initialized only once before 
calling "init()" function. That is at exit from the function inside which the static variable is declared, the value of this 
variable being not lost.
Defining global variables
They are defined on the same level as functions, i.e. they are not local in any block.
Example:
int Global_flag;
int start()
  {
   ...
  }
Scope of global variables is the whole program. Global variables are accessible from all functions defined in the 
program. They are initialized with zero if no other initial value is explicitly defined. The global variable can be 
initialized only by corresponded type constant. Initialization of global variables is made only once before execution of 
"init()" function. 
Note: it is not necessary to confuse the variables declared at a global level, to global variables of Client Terminal, 
access to which is carried out by GlobalVariable...() function.
Defining extern variables
The memory class "extern" defines an extern variable. The specifier "extern" is declared before a data type. 
Example:
extern double InputParameter1 = 1.0;
int init()

  {
   ...
  }
Extern variables define input data of the program, they are accessible from a property program sheet. It is not 
meaningful to define extern variables in scripts. Arrays cannot represent itself as extern variables. 
Initializing variables
Any variable can be initialized during its definition. Any permanently located variable is initialized with zero (0) if no 
other initial value is explicitly defined. Global and static variables can be initialized only by constant of corresponded 
type. Local variables can be initialized by any expression, and not just a constant. Initialization of global and static 
variables is made only once. Initialization of local variables is made each time by call of corresponded functions.
Basic types 
Examples:
int mt = 1;             // integer initialization
// initialization floating-point number (double precision)
double p = MarketInfo(Symbol(),MODE_POINT);
// string initialization
string s = "hello";
Arrays
Example:
int mta[6] = {1,4,9,16,25,36};
The list of array elements must be enclosed by curly braces. If the array size is defined, the values being not 
explicitly defined equal 0.
External function definition
The type of external functions defined in another component of a program must be explicitly defined. The absence of 
such a definition may result in errors during the compilation, assembling or execution of your program. While 
describing an external object, use the key word #import with the reference to the module.
Examples:
#import "user32.dll"
  int     MessageBoxA(int hWnd ,string szText,
                      string szCaption,int nType);
  int     SendMessageA(int hWnd,int Msg,int wParam,int lParam);
#import "lib.ex4"
  double  round(double value);
#import
Preprocessor
Declaring of constant
Controlling compilation
Including files
Importing functions and other modules
Declaring of constant
If the first character in a program line is #, it means that this line is a compiler command. Such a compiler command 
ends with a carriage-return character.
   #define identifier_value
The identifier of a constant obeys the same rules as variable names. The value can be of any type. Example:
#define ABC          100

#define PI           0.314
#define COMPANY_NAME "MetaQuotes Software Corp."
The compiler will replace each occurrence of an identifier in your source code with the corresponding value.
Controlling compilation
   #property identifier_value
The list of predefined constant identifiers. Example:
#property link        "http://www.metaquotes.net"
#property copyright   "MetaQuotes Software Corp."
#property stacksize   1024
Constant
Type
Description
link
string
a link to the company website
copyright
string
the company name
stacksize
int
stack size
indicator_chart_window
void
show the indicator in the chart window
indicator_separate_window void
show the indicator in a separate window
indicator_buffers
int
the number of buffers for calculation, up to 8
indicator_minimum
int
the bottom border for the chart
indicator_maximum
int
the top border for the chart
indicator_colorN
color
the color for displaying line N, where N lies between 1 and 8
indicator_levelN
double
predefined level N for separate window custom indicator, where N lies 
between 1 and 8
show_confirm
void
before script run message box with confirmation appears
show_inputs
void
before script run its property sheet appears; disables show_confirm 
property
The compiler 
will write the declared values to the settings of the executable module. 
Including files
Note: The #include command line can be placed anywhere in the program, but usually all inclusions are placed at 
the beginning of the source code.
#include <file_name>
Example:
#include <win32.h>
The preprocessor replaces this line with the content of the file win32.h. Angle brackets mean that the file win32.h will 
be taken from the default directory (usually, terminal_directory\experts\include). The current directory is not 
searched.
#include "file_name"
Example:
#include "mylib.h"
The compiler replaces this line with the content of the file mylib.h. Since this name is enclosed in quotes, the search 
is performed in the current directory (where the main file of the source code is located). If the file is not found in the 
current directory, the error will be messaged.
Importing functions and other modules
   #import "file_name"
    func1();
    func2();

   #import
Example:
#import "user32.dll"
   int MessageBoxA(int hWnd,string lpText,string lpCaption,
               int uType);
   int MessageBoxExA(int hWnd,string lpText,string lpCaption,
                 int uType,int wLanguageId);
#import "melib.ex4"
#import "gdi32.dll"
   int      GetDC(int hWnd);
   int      ReleaseDC(int hWnd,int hDC);
#import