# Variables

Page: 1

---

Variables
Preprocessor
About MetaQuotes Language 4
MetaQuotes Language 4 (MQL4) is a new built-in language for programming trading strategies. This language allows 
to create your own Expert Advisors that render the trade process management automatic and are perfectly suitable 
for implementing your own trade strategies. Also, with the help of MQL4 you can create your own Custom Indicators, 
Scripts and Libraries of functions.
A large number of functions necessary for the analysis of the current and past quotations, the basic arithmetic and 
logic operations are included in MQL4 structure. There are also basic indicators built in and commands of order 
placement and control.
The MetaEditor 4 text editor that highlights different constructions of MQL4 language is used for writing the program 
code. It helps users to orient in the expert system text quite easily. As an information book for MQL4 language we 
use MetaQuotes Language Dictionary. A brief guide contains functions divided into categories, operations, reserved 
words, and other language constructions and allows finding the description of every element we use.
Programs written in MetaQuotes Language 4 have different features and purposes:
•
Expert Advisors is a mechanical trade system (MTS) linked up to a certain plot. The Advisor can not only 
inform you about a possibility to strike bargains, but also can make deals on the trade account automatically 
and direct them right to the trade server. Like most trade systems, the terminal supports testing strategies 
on historical data with displaying on the chart the spots where trades come in and out.
•
Custom Indicators are an analogue of a technical indicator. In other words, Custom Indicators allow to create 
technical indicators in addition to those already integrated into client terminal. Like built-in indicators, they 
cannot make deals automatically and are aimed only at implementing analytical functions.
•
Scripts are programs intended for single execution of some actions. Unlike Expert Advisors, Scripts are not 
run tick wise and have no access to indicator functions.
•
Libraries are user functions libraries where frequently used blocks of user programs are stored.
Syntax
Format

Comments
Identifiers
Reserved words
Format
Spaces, tabs, line feed/form feed symbols are used as separators. You can use any amount of such symbols instead 
of one. You should use tab symbols to enhance the readability of the text .
Comments
Multi line comments start with /* symbols and end with */ symbols. Such comments cannot be nested. Single 
comments start with // symbols, end with the symbol of a new line and can be nested into multi line comments. 
Comments are allowed where blank spaces are possible and tolerate any number of spaces.
Examples:
// single comment
/*  multi-
    line         // nested single comment
    comment
*/
Identifiers
Identifiers are used as names of variables, functions, and data types. The length of an identifier cannot exceed 31 
characters.
Symbols you can use: the numbers 0-9, Latin capital and small letters a-z, A-Z (recognized as different symbols), the 
symbol of underlining (_). The first symbol cannot be a number. The identifier must not coincide with any reserved 
word.
Examples:
NAME1 namel Total_5 Paper
Reserved words
The identifiers listed below are fixed reserved words. A certain action is assigned to each of them, and they cannot 
be used for other purposes: