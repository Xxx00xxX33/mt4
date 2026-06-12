# Operations of relation

Page: 6

---

Operations of relation
The logical value false is represented with an integer zero value, while the logical value true is represented with any 
value differing from zero.
The value of expressions containing operations of relation or logical operations is 0 (false) or 1 (true).
True if a equals b                          a == b;
True if a does not equal b                  a != b;
True if a is less than b                    a < b;
True if a is greater than b                 a > b;
True if a is less than or equals b          a <= b;
True if a is greater than or equals b       a >= b;
Two unnormalized floating-point numbers cannot be linked by == or != operations. That is why it is necessary to 
subtract one from another, and the normalized outcome needs to be compared to null.
Boolean operations
The operand of negation NOT (!) must be of arithmetic type; the result equals 1 if the operand value is 0; the result 
equals 0 if the operand differs from 0.
// True if a is false.
if(!a)
  Print("not 'a'");
The logical operation OR (||) of values k and 1. The value k is checked first, the value 1 is checked only if k value is 
false. The value of this expression is true if the value of k or 1 is true.
Example:
if(x<k || x>l)
  Print("out of range");
The logical operation AND (&&) of values x and y. The value x is checked first; the value y is checked only if k value 

is true. The value of this expression is true if the values of both x and y are true.
Example:
if(p!=x && p>y)
  Print("true");
n++;
Bitwise operations
One's complement of values of variables. The value of the expression contains 1 in all digits where n contains 0; the 
value of the expression contains 0 in all digits where n contains 1.
b = ~n;
Binary-coded representation of x is shifted to the right by y digits. The right shift is logical shift, that is the freed left-
side bits will be filled with zeros.
Example:
x = x >> y;
The binary-coded representation of x is shifted to the right by y digits; the free digits on the right will be filled with 
zeroes. 
Example:
x = x << y;
Bitwise operation AND of binary-coded x and y representations. The value of the expression contains 1 (true) in all 
digits where both x and y are not equal to zero; the value of the expression contains 0 (false) in all other digits.
Example:
b = ((x & y) != 0);
Bitwise operation OR of binary-coded x and y representations. The expression contains 1 in all digits where x and y 
not equals 0; the value of the expression contains 0 in all other digits.
Example:
b = x | y;
Bitwise operation EXCLUSIVE OR of binary-coded x and y representations. The expression contains 1 in all digits 
where x and y have different binary values; the value of the expression contains 0 in all other digits.
Example:
b = x ^ y;
Note: Bitwise operations are executed with integers only.
Other operations
Indexing. At addressing to i element of array, the value of the expression equals the value of the variable numbered 
as i.
Example:
array[i] = 3;
//Assign the value of 3 to array element with index i.
//Mind that the first array element
//is described with the expression array [0].
The call of function with x1,x2,...,xn arguments. The expression accepts the value returned by the function. If the 
returned value is of the void type, you cannot place such function call on the right in the assignment operation. Mind 
that the expressions x1,x2,...,xn are surely executed in this order.
Example:
double SL=Ask-25*Point;
double TP=Ask+25*Point;
int    ticket=OrderSend(Symbol(),OP_BUY,1,Ask,3,SL,TP,
                        "My comment",123,0,Red);
The "comma" operation is executed from left to right. A pair of expressions separated by a comma is calculated from 
left to right with a subsequent deletion of the left expression value. All side effects of left expression calculation can 
appear before we calculate the right expression. The result type and value coincide with the type and value of the 
right expression. 

Precedence rules
Each group of operations in the table has the same priority. The higher the priority is, the higher the position of the 
group in the table is. 
The execution order determines the grouping of operations and operands.
()     Function call                  From left to right
[]     Array element selection
!      Negation                       From left to right
~      Bitwise negation
-      Sign changing operation
*      Multiplication                 From left to right
/      Division
%      Module division
+      Addition                       From left to right
-      Subtraction
<<     Left shift                     From left to right
>>     Right shift
<      Less than                      From left to right
<=     Less than or equals
>      Greater than
>=     Greater than or equals
==     Equals                         From left to right
!=     Not equal
&      Bitwise AND operation          From left to right
^      Bitwise exclusive OR           From left to right
|      Bitwise OR operation           From left to right
&&     Logical AND                    From left to right
||     Logical OR                     From left to right
=      Assignment                     From right to left
+=     Assignment addition
-=     Assignment subtraction
*=     Assignment multiplication
/=     Assignment division
%=     Assignment module
>>=    Assignment right shift
<<=    Assignment left shift
&=     Assignment bitwise AND
|=     Assignment bitwise OR
^=     Assignment exclusive OR
,      Comma                          From left to right
Use parentheses to change the execution order of the operations.