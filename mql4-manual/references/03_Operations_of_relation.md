# Operations of relation

Page: 5

---

Operations of relation
Boolean operations
Bitwise operations
Other operations
Precedence rules
Expressions
An expression consists of one or more operands and operation characters. An expression can be written in several 
lines.
Example:
a++; b = 10; x = (y*z)/w;
Note: An expression that ends with a semicolon is an operator.
Arithmetical operations
Sum of values                           i = j + 2;
Difference of values                    i = j - 3;
Changing the operation sign             x = - x;
Product of values                       z = 3 * x;
Division quotient                       i = j / 5;
Division remainder                      minutes = time % 60;
Adding 1 to the variable value          i++;
Subtracting 1 from the variable value   k--;

The operations of adding/subtracting 1 cannot be implemented in expressions.
Example:
int a=3;
a++;              // valid expression
int b=(a++)*3;    // invalid expression
The operation of assignment
Note: The value of the expression that includes this operation is the value of the left operand following the bind 
character.
Assigning the y value to the x variable                   y = x;
Adding x to the y variable                                y += x;
Subtracting x from the y variable                         y -= x;
Multiplying the y variable by x                           y *= x;
Dividing the y variable by x                              y /= x;
Module x value of y                                       y %= x;
Logical shift of y representation to the right by x bit   y >>= x;
Logical shift of y representation to the left by x bit    y <<= x;
Bitwise operation AND                                     y &= x;
Bitwise operation OR                                      y |= x;
Bitwise operation exclusive OR                            y ^= x;
Note: There can be only one operation of assignment in the expression. You can implement bitwise operations with 
integer numbers only. The logical shift operation uses values of x less than 5 binary digits. The greater digits are 
rejected, so the shift is for the range of 0-31 bit. By %= operation a result sign is equal to the sign of divided 
number.