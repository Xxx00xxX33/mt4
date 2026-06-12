# Math & Trig

Page: 50

---

Math & Trig
MathAbs()
MathArccos()
MathArcsin()
MathArctan()
MathCeil()
MathCos()
MathExp()
MathFloor()
MathLog()
MathMax()
MathMin()
MathMod()
MathPow()
MathRand()
MathRound()
MathSin()
MathSqrt()
MathSrand()
MathTan()
double MathAbs(double value)
Returns the absolute value (modulus) of the specified numeric value.
Parameters
value   -  Numeric value.
Sample

  double dx=-3.141593, dy;
  // calc MathAbs
  dy=MathAbs(dx);
  Print("The absolute value of ",dx," is ",dy);
  // Output: The absolute value of -3.141593 is 3.141593
double MathArccos(double x)
The MathArccos function returns the arccosine of x in the range 0 to π radians. If x is less than -1 or greater than 1, MathArccos 
returns an indefinite (same as a quiet NaN). 
Parameters
x   -  Value between -1 and 1 arc cosine of which should be calculated.
Sample
  double x=0.32696, y;
  y=asin(x);
  Print("Arcsine of ",x," = ",y);
  y=acos(x);
  Print("Arccosine of ",x," = ",y);
  //Output: Arcsine   of 0.326960=0.333085
  //Output: Arccosine of 0.326960=1.237711
double MathArcsin(double x)
The MathArcsin function returns the arcsine of x in the range -π/2 to π/2 radians. If x is less than -1 or greater than 1, arcsine 
returns an indefinite (same as a quiet NaN). 
Parameters
x   -  Value the arcsine of which should be calculated
Sample
  double x=0.32696, y;
  y=MathArcsin(x);
  Print("Arcsine of ",x," = ",y);
  y=acos(x);
  Print("Arccosine of ",x," = ",y);
  //Output: Arcsine   of 0.326960=0.333085
  //Output: Arccosine of 0.326960=1.237711
double MathArctan(double x)
The MathArctan returns the arctangent of x. If x is 0, MathArctan returns 0. MathArctan returns a value in the range -π/2 to π/2 
radians. 
Parameters
x   -  A number representing a tangent.
Sample
  double x=-862.42, y;
  y=MathArctan(x);
  Print("Arctangent of ",x," is ",y);
  //Output: Arctangent of -862.42 is -1.5696
double MathCeil(double x)
The MathCeil function returns a numeric value representing the smallest integer that is greater than or equal to x. 
Parameters
x   -  Numeric value.
Sample
  double y;

  y=MathCeil(2.8);
  Print("The ceil of 2.8 is ",y);
  y=MathCeil(-2.8);
  Print("The ceil of -2.8 is ",y);
  /*Output:
    The ceil of 2.8 is 3
    The ceil of -2.8 is -2*/
double MathCos(double value)
Returns the cosine of the specified angle.
Parameters
value   -  An angle, measured in radians.
Sample
  double pi=3.1415926535;
  double x, y;
  x=pi/2;
  y=MathSin(x);
  Print("MathSin(",x,") = ",y);
  y=MathCos(x);
  Print("MathCos(",x,") = ",y);
  //Output: MathSin(1.5708)=1
  //        MathCos(1.5708)=0
double MathExp(double d)
Returns value the number e raised to the power d. On overflow, the function returns INF (infinite) and on underflow, MathExp 
returns 0. 
Parameters
d   -  A number specifying a power.
Sample
  double x=2.302585093,y;
  y=MathExp(x);
  Print("MathExp(",x,") = ",y);
  //Output: MathExp(2.3026)=10
double MathFloor(double x)
The MathFloor function returns a numeric value representing the largest integer that is less than or equal to x. 
Parameters
x   -  Numeric value.
Sample
  double y;
  y=MathFloor(2.8);
  Print("The floor of 2.8 is ",y);
  y=MathFloor(-2.8);
  Print("The floor of -2.8 is ",y);
  /*Output:
    The floor of 2.8 is 2
    The floor of -2.8 is -3*/
double MathLog(double x)
The MathLog functions return the logarithm of x if successful. If x is negative, these functions return an indefinite (same as a 

quiet NaN). If x is 0, they return INF (infinite). 
Parameters
x   -  Value whose logarithm is to be found.
Sample
  double x=9000.0,y;
  y=MathLog(x);
  Print("MathLog(",x,") = ", y);
  //Output: MathLog(9000)=9.10498
double MathMax(double value1, double value2)
Returns maximum value of two numeric values.
Parameters
value1   -  First numeric value.
value2   -  Second numeric value.
Sample
  double result=MathMax(1.08,Bid);
double MathMin(double value1, double value2)
Returns minimum value of two numeric values.
Parameters
value1   -  First numeric value.
value2   -  Second numeric value.
Sample
  double result=MathMin(1.08,Ask);
double MathMod(double value, double value2)
Divides two numbers and returns only the remainder.
Parameters
value
  -  Dividend value.
value2   -  Divider value.
Sample
  double x=-10.0,y=3.0,z;
  z=MathMod(x,y);
  Print("The remainder of ",x," / ",y," is ",z);
  //Output: The remainder of -10 / 3 is -1
double MathPow(double base, double exponent)
Returns the value of a base expression taken to a specified power.
Parameters
base
  -  Base value.
exponent   -  Exponent value.
Sample
  double x=2.0,y=3.0,z;
  z=MathPow(x,y);
  Printf(x," to the power of ",y," is ", z);
  //Output: 2 to the power of 3 is 8

int MathRand()
The MathRand function returns a pseudorandom integer in the range 0 to 0x7fff (32767). Use the MathSrand function to seed the 
pseudorandom-number generator before calling rand. 
Sample
  MathSrand(LocalTime());
  // Display 10 numbers.
  for(int i=0;i<10;i++ )
    Print("random value ", MathRand());
double MathRound(double value)
Returns value rounded to the nearest integer of the specified numeric value.
Parameters
value   -  Numeric value to round.
Sample
  double y=MathRound(2.8);
  Print("The round of 2.8 is ",y);
  y=MathRound(2.4);
  Print("The round of -2.4 is ",y);
  //Output: The round of 2.8 is 3
  //        The round of -2.4 is -2
double MathSin(double value)
Returns the sine of the specified angle.
Parameters
value   -  An angle, measured in radians.
Sample
  double pi=3.1415926535;
  double x, y;
  x=pi/2;
  y=MathSin(x);
  Print("MathSin(",x,") = ",y);
  y=MathCos(x);
  Print("MathCos(",x,") = ",y);
  //Output: MathSin(1.5708)=1
  //        MathCos(1.5708)=0
double MathSqrt(double x)
The MathSqrt function returns the square-root of x. If x is negative, MathSqrt returns an indefinite (same as a quiet NaN). 
Parameters
x   -  Positive numeric value.
Sample
  double question=45.35, answer;
  answer=MathSqrt(question);
  if(question<0)
    Print("Error: MathSqrt returns ",answer," answer");
  else
    Print("The square root of ",question," is ", answer);
  //Output: The square root of 45.35 is 6.73
void MathSrand(int seed)
The MathSrand() function sets the starting point for generating a series of pseudorandom integers. To reinitialize the generator, 
use 1 as the seed argument. Any other value for seed sets the generator to a random starting point. MathRand retrieves the 

pseudorandom numbers that are generated. Calling MathRand before any call to MathSrand generates the same sequence as 
calling MathSrand with seed passed as 1. 
Parameters
seed   -  Seed for random-number generation.
Sample
  MathSrand(LocalTime());
  // Display 10 numbers.
  for(int i=0;i<10;i++ )
    Print("random value ", MathRand());
double MathTan(double x)
MathTan returns the tangent of x. If x is greater than or equal to 263, or less than or equal to -263, a loss of significance in the 
result occurs, in which case the function returns an indefinite (same as a quiet NaN). 
Parameters
x   -  Angle in radians.
Sample
  double pi=3.1415926535;
  double x,y;
  x=MathTan(pi/4);
  Print("MathTan(",pi/4," = ",x);
  //Output: MathTan(0.7856)=1