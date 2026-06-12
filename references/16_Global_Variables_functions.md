# Global Variables functions

Page: 48

---

Global Variables functions
GlobalVariableCheck()
GlobalVariableDel()
GlobalVariableGet()
GlobalVariableSet()
GlobalVariableSetOnCondition()
GlobalVariablesDeleteAll()
bool GlobalVariableCheck(string name)
Return logical true if global variable exists, otherwise returns false. To get the detailed error information, call  GetLastError() 
function. 

Parameters
name   -  Global variable name.
Sample
  // check variable before use
  if(!GlobalVariableCheck("g1"))
    GlobalVariableSet("g1",1);
bool GlobalVariableDel(string name)
Deletes global variable. If the function succeeds, the return value will be true. If the function fails, the return value is false. To get 
the detailed error information, call GetLastError(). 
Parameters
name   -  Global variable name.
Sample
  // deleting global variable with name "gvar_1"
  GlobalVariableDel("gvar_1");
double GlobalVariableGet(string name)
Returns global variable value. To check function failure, check error information by calling GetLastError(). 
Parameters
name   -  Global variable name.
Sample
  double v1=GlobalVariableGet("g1");
  //---- check function call result
  if(GetLastError()!=0) return(false);
  //---- continue processing
datetime GlobalVariableSet(string name, double value)
Sets global variable value. If it does not exist, the system creates a new variable. If the function succeeds, the return value is last 
access time. If the function fails, the return value is 0. To get the detailed error information, call GetLastError(). 
Parameters
name   -  Global variable name.
value   -  Numeric value to set.
Sample
  //---- try to set new value
  if(GlobalVariableSet("BarsTotal",Bars)==0)
    return(false);
  //---- continue processing
bool GlobalVariableSetOnCondition(string name, double value, double check_value)
Sets the new value of the global variable if the current value equals to the third parameter check_value. If there is no variable at 
all, the  function  will return false  and set the value of ERR_GLOBAL_VARIABLE_NOT_FOUND constant to LastError.  When 
successfully executed,  the function returns true, otherwise it does  false. To receive  the  information  about the  error, call 
GetLastError() 
function.
The function can be used as a semaphore for the access to common resources. 
Parameters
name
  -  Global variable name.
value
  -  Numeric value to set.
check_value   -  Value to compare with the current global variable value.
Sample
  int init()
    {
     //---- create global variable

     GlobalVariableSet("DATAFILE_SEM",0);
     //...
    }
  
  int start()
    {
     //---- try to lock common resource
     while(!IsStopped())
       {
        //---- locking
        if(GlobalVariableSetOnCondition("DATAFILE_SEM",1,0)==true)  break;
        //---- may be variable deleted?
        if(GetLastError()==ERR_GLOBAL_VARIABLE_NOT_FOUND) return(0);
        //---- sleeping
        Sleep(500);
       }
     //---- resource locked
     // ... do some work
     //---- unlock resource
     GlobalVariableSet("DATAFILE_SEM",0);
    }
void GlobalVariablesDeleteAll()
Deletes all global variables. This function never fails.
Sample
GlobalVariablesDeleteAll();