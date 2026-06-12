# Date & Time functions

Page: 38

---

Date & Time functions
CurTime()
Day()
DayOfWeek()
DayOfYear()
Hour()
LocalTime()
Minute()
Month()
Seconds()
TimeDay()
TimeDayOfWeek()
TimeDayOfYear()
TimeHour()
TimeMinute()
TimeMonth()
TimeSeconds()
TimeYear()
Year()

datetime CurTime()
Returns the last known server time, number of seconds elapsed from 00:00 January 1, 1970.
Sample
  if(CurTime()-OrderOpenTime()<360) return(0);
int Day()
Returns the current day of the month.
Sample
  if(Day()<5) return(0);
int DayOfWeek()
Returns the current zero based day of the week (0-Sunday,1,2,3,4,5,6).
Sample
  // do not work on holidays.
  if(DayOfWeek()==0 || DayOfWeek()==6) return(0);
int DayOfYear()
Returns the current day of the year (1-1 january,..,365(6) - 31 december).
Sample
  if(DayOfYear()==245)
    return(true);
int Hour()
Returns current hour (0,1,2,..23)
Sample
  bool is_siesta=false;
  if(Hour()>=12 || Hour()<17)
     is_siesta=true;
datetime LocalTime()
Returns local computer time, number of seconds elapsed from 00:00 January 1, 1970.
Sample
  if(LocalTime()-OrderOpenTime()<360) return(0);
int Minute()
Returns current minute (0,1,2,..59).
Sample
  if(Minute()<=15)
    return("first quarter");
int Month()
Returns current month as number (1-January,2,3,4,5,6,7,8,9,10,11,12).
Sample

  if(Month()<=5)
    return("first half of year");
int Seconds()
Returns current second (0,1,2,..59).
Sample
  if(Seconds()<=15)
    return(0);
int TimeDay(datetime date)
Returns day of month (1 - 31) for specified date.
Parameters
date   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int day=TimeDay(D'2003.12.31');
  // day is 31
int TimeDayOfWeek(datetime date)
Returns zero based day of week (0-Sunday,1,2,3,4,5,6) for specified date.
Parameters
date   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int weekday=TimeDayOfWeek(D'2004.11.2');
  // day is 2 - tuesday
int TimeDayOfYear(datetime date)
Returns day (1-1 january,..,365(6) - 31 december) of year for specified date.
Parameters
date   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int day=TimeDayOfYear(CurTime());
int TimeHour(datetime time)
Returns hour for specified time.
Parameters
time   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int h=TimeHour(CurTime());
int TimeMinute(datetime time)
Returns minute for specified time.
Parameters
time   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int m=TimeMinute(CurTime());

int TimeMonth(datetime time)
Returns month for specified time.
Parameters
time   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int m=TimeMonth(CurTime());
int TimeSeconds(datetime time)
Returns seconds after minute (0 – 59) for specified time.
Parameters
time   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int m=TimeSeconds(CurTime());
int TimeYear(datetime time)
Returns year for specified date. Return values can be in range 1970-2037.
Parameters
time   -  Datetime is the number of seconds elapsed since midnight (00:00:00), January 1, 1970.
Sample
  int y=TimeYear(CurTime());
int Year()
Returns current year.
Sample
  // return if date before 1 May 2002
  if(Year()==2002 && Month()<5)
    return(0);