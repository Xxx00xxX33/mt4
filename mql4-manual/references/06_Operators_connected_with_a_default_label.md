# Operators connected with a default label are executed if non

Page: 11

---

Operators connected with a default label are executed if none of the constants in case operators equals the 
expression value. The default variant is not obligatory final. If none of the constants resembles the expression value 
and the default variant is absent, no actions are executed. The keyword case and the constant are just labels and if 
operators are executed for some variant of case the program will further execute the operators of all following 
variants until it hits a break operator. It allows linking one succession of operators with several variants. A constant 
expression is calculated during compilation. 
None of two constants in one switch operator can have the same values.
Example:
switch(x)
  {
   case 'A':
      Print("CASE A\n");
      break;
   case 'B':
   case 'C':
      Print("CASE B or C\n");
 break;
   default:
      Print("NOT A, B or C\n");

      break;
  }
Cycle operator while
   while (expression)
     operator;
If the expression is true, the operator is executed till the expression becomes false. If the expression is false, the 
control will be given to the next operator.
Note: An expression value has been defined before the operator is executed. Therefore, if the expression is false 
from the very beginning, the operator is not executed at all.
Example:
while(k<n)
  {
   y=y*x;
   k++;
  }
Cycle operator for
   for (expression1; expression2; expression3)
    operator;
Expression1 describes the initialization of the cycle. Expression2 is the cycle termination check. If it is true, the loop 
body operator will be executed, Expression3 is executed. The cycle is repeated until Expression2 becomes false. If it 
is not false, the cycle is terminated, and the control is given to the next operator. Expression3 is calculated after each 
iteration. The 'for' operator is equivalent to the following succession of operators:
   expression1;
   while (expression2)
     {
      operator;
      expression3;
     };
Example:
for(x=1;x<=7;x++)
  Print(MathPower(x,2));
Any of the three or all three expressions can be absent in the FOR operator, but you should not omit the semicolons 
(;) that separate them.
If Expression2 is omitted, it is considered constantly true. The FOR (;;) operator is a continuous cycle equivalent to 
the WHILE(l) operator.
Each of the expressions 1 to 3 can consist of several expressions united by a comma operator ','.
Example:
//
for(i=0,j=n-l;i<n;i++,j--)
   a[i]=a[j];