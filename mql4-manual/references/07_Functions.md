# Functions

Page: 12

---

Functions
Function definition
Function call
Special functions init(), deinit() and start()
Function definition

A function is defined by return value type declaration, by formal parameters and a compound operator (block) that 
describes actions the function executes.
Example:
double                                 // type
linfunc (double x, double a, double b) // function name and
                                       // parameters list
  {
                                       // nested operators
   return (a*x + b);                   // returned value
  }
The "return" operator can return the value of the expression included into this operator. In case of a necessity, the 
expression value assumes the type of function result. A function that does not return a value must be of "void" type.
Example:
void errmesg(string s)
  {
   Print("error: "+s);
  }
Function call
   function_name (x1,x2,...,xn)
Arguments (actual parameters) are transferred according to their value. Each expression x1,...,xn is calculated, and 
the value is passed to the function. The order of expressions calculation and the order of values loading are 
guaranteed. During the execution, the system checks the number and type of arguments given to the function. Such 
way of addressing to the function is called a value call. There is also another way: call by link. A function call is an 
expression that assumes the value returned by the function. This function type must correspond with the type of the 
returned value. The function can be declared or described in any part of the program:
int somefunc()
  {
   double a=linfunc(0.3, 10.5, 8);
  }
double linfunc(double x, double a, double b)
  {
   return (a*x + b);
  }
Special functions init(), deinit() and start()
Any program begins its work with the "init()" function. "Init()" function attached to charts is launched also after client 
terminal has started and in case of changing financial symbol and/or charts periodicity.
Every program finishes its work with the "deinit()" function. "deinit()" function is launched also by client terminal 
shutdown, chart window closing, changing financial symbol and/or charts periodicity.
When new quotations are received, the "start()" function of attached expert advisors and custom indicator programs 
is executed. If, when receiving new quotations, the "start()" function triggered on the previous quotations was 
performed, the next calling "start()" function is executed only after "return()" instruction. All new quotations received 
during the program execution are ignored by the program.
Detaching of the program from charts, changing financial symbol and/or charts periodicity, charts closing and also 
client terminal exiting interrupts execution of program.
Execution of scripts does not depend on quotations coming.