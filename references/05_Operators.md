# Operators

Page: 8

---

Operators
Format and nesting
Compound operator
Expression operator
Break operator
Continue operator
Return operator
Conditional operator if
Conditional operator if-else
Switch operator
Cycle operator while
Cycle operator for

Format and nesting
Format. One operator can occupy one or several lines. Two or more operators can be located in the same line.
Nesting. Execution order control operators (if, if-else, switch, while and for) can be nested into each other.
Compound operator
A compound operator (a block) consists of one or more operators of any type enclosed in braces {}. The closing 
brace should not be followed by a semicolon (;).
Example:
if(x==0)
  {
   x=1; y=2; z=3;
  }
Expression operator
Any expression followed by a semicolon (;) is an operator. Here are some examples of expression operators:
Assignment operator.
   Identifier=expression;
Example:
x=3;
y=x=3; // error
You can use an assignment operator in an expression only once.
Function call operator
   Function_name(argument1,..., argumentN);
Example:
fclose(file);
Null operator
It consists of a semicolon (;) only. We use it to denote a null body of a control operator.
Break operator
A break; operator terminates the execution of the nearest nested outward operator switch, while or for. The control 
is given to the operator that follows the terminated one. One of the purposes of this operator is to finish the looping 
execution when a certain value is assigned to a variable.
Example:
// searching first zero element
for(i=0;i<array_size;i++)
  if((array[i]==0)
    break;
Continue operator
A continue; operator gives control to the beginning of the nearest outward cycle operator while or for, calling the 
next iteration. The purpose of this operator is opposite to that of break.
Example:
// summary of nonzero elements of array
int func(int array[])
  {
   int array_size=ArraySize(array);

   int sum=0;
   for(int i=0;i<array_size; i++)
     {
      if(a[i]==0) continue;
      sum+=a[i];
     }
   return(sum);
  }
Return operator
A return; operator terminates the current function execution and returns the control to the calling program.
A return(expression); operator terminates the current function execution and returns the control to the calling 
program together with the expression value. The operator expression is enclosed in parentheses. The expression 
should not contain an assignment operator.
Example:
return(x+y);
Conditional operator if
   if (expression)
     operator;
If the expression is true, the operator will be executed. If the expression is false, the control will be given to the 
expression following the operator.
Example:
if(a==x)
  temp*=3;
temp=MathAbs(temp);
Conditional operator if-else
   if (expression)
     operator1
   else
     operator2
If the expression is true, operator1 is executed and the control is given to the operator that follows operator2 
(operator2 is not executed). If the expression is false, operator2 is executed.
The "else" part of the "if" operator can be omitted. Thus, a divergence may appear in nested "if" operators with an 
omitted "else" part. If it happens, "else" addresses to the nearest previous operator "if" in the block that has no 
"else" part.
Example:
//   The "else" part refers to the second "if" operator:
if(x>1)
   if(y==2)
      z=5;
   else
      z=6;
//   The "else" part refers to the first "if" operator:
if(x>l)
  {
   if(y==2) z=5;
  }
else

  {
   z=6;
  }
//   Nested operators
if(x=='a')
  {
   y=1;
  }
else if(x=='b')
  {
   y=2;
   z=3;
  }
else if(x=='c')
  {
   y = 4;
  }
else
  {
   Print("ERROR");
  }
Switch operator
   switch (expression)
     {
      case constant1: operators; break;
      case constant2: operators; break;
      ...
      default: operators; break;
     }
It compares the expression value with constants in all variants of case and gives control to the operator that 
resembles the expression value. Each variant of the case can be marked with an integer or character constant or a 
constant expression. The constant expression must not include variables and function calls.
Example:
case 3+4: //valid
case X+Y: //invalid