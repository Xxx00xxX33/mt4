# Array Functions

Page: 19

---

Array Functions
ArrayBsearch()
ArrayCopy()
ArrayCopyRates()
ArrayCopySeries()
ArrayDimension()
ArrayGetAsSeries()

ArrayInitialize()
ArrayIsSeries()
ArrayMaximum()
ArrayMinimum()
ArrayRange()
ArrayResize()
ArraySetAsSeries()
ArraySize()
ArraySort()
int 
ArrayBsearch(
double array[], double value, int count=WHOLE_ARRAY, int start=0, 
int direction=MODE_ASCEND)
Returns the index of the first occurrence of a value in the first dimension of array if possible, or the nearest one, if the occurrence 
is not found.
The function cannot be used with string arrays and serial numeric arrays.
Note: Binary search processes only sorted arrays. To sort numeric arrays use ArraySort() functions. 
Parameters
array[]
  -  The numeric array to search for.
value
  -  The value to search for.
count
  -  Count of elements to search for. By default, it searches in the whole array.
start
  -  Starting index to search for. By default, the search starts on the first element.
direction   -  Search direction. It can be any of the following values:
MODE_ASCEND searching in forward direction,
MODE_DESCEND searching in the backward direction.
Sample
   datetime daytimes[];
   int      shift=10,dayshift;
   // All the Time[] timeseries are sorted in descendant mode
   ArrayCopySeries(daytimes,MODE_TIME,Symbol(),PERIOD_D1);
   if(Time[shift]>=daytimes[0]) dayshift=0;
   else
     {
      dayshift=ArrayBsearch(daytimes,Time[shift],WHOLE_ARRAY,0,MODE_DESCEND);
      if(Period()<PERIOD_D1) dayshift++;
     }
   Print(TimeToStr(Time[shift])," corresponds to ",dayshift," day bar opened at ",
         TimeToStr(daytimes[dayshift]));
int 
ArrayCopy(
object& dest[], object source[], int start_dest=0, int start_source=0, 
int count=WHOLE_ARRAY)
Copies an array to another one. Arrays must be of the same type, but arrays with type double[], int[], datetime[], color[], and 
bool[] can be copied as arrays with same type.
Returns the amount of copied elements. 
Parameters
dest[]
  -  Destination array.
source[]
  -  Source array.
start_dest
  -  Starting index for the destination array. By default, start index is 0.
start_source   -  Starting index for the source array. By default, start index is 0.
count
  -  The count of elements that should be copied. By default, it is WHOLE_ARRAY constant.
Sample
  double array1[][6];
  double array2[10][6];
  // fill array with some data
  ArrayCopyRates(array1);
  ArrayCopy(array2, array1,0,Bars-9,10);
  // now array2 has first 10 bars in the history

int ArrayCopyRates(double& dest_array[], string symbol=NULL, int timeframe=0)
Copies rates to the two-dimensional array from chart RateInfo array, where second dimension has 6 elements:
0 - time,
1 - open,
2 - low,
3 - high,
4 - close,
5 - volume.
Note: Usually retrieved array used to pass large blocks of data to the DLL functions. 
Parameters
dest_array[]   -  Reference to the two-dimensional destination numeric array.
symbol
  -  symbol name, by default, current chart symbol name is used.
timeframe
  -  Time frame, by default, the current chart time frame is used. It can be any of Time frame enumeration values.
Sample
  double array1[][6];
  ArrayCopyRates(array1,"EURUSD", PERIOD_H1);
  Print("Current bar ",TimeToStr(array1[0][0]),"Open", array1[0][1]);
int 
ArrayCopySeries(
double& array[], int series_index, string symbol=NULL, 
int timeframe=0)
Copies a series array to another one and returns the count of copied elements.
Note: If series_index is MODE_TIME, the first parameter must be a datetime array. 
Parameters
array[]
  -  Reference to the destination one-dimensional numeric array.
series_index   -  Series array identifier. It can be any of Series array identifiers enumeration values.
symbol
  -  Symbol name, by default, the current chart symbol name is used.
timeframe
  -  Time frame, by default, the current chart time frame is used. It can be any of Time frame enumeration values.
Sample
  datetime daytimes[];
  int      shift=10,dayshift;
  // All the Time[] timeseries are sorted in descendant mode
  ArrayCopySeries(daytimes,MODE_TIME,Symbol(),PERIOD_D1);
  if(Time[shift]>=daytimes[0]) dayshift=0;
  else
    {
     dayshift=ArrayBsearch(daytimes,Time[shift],WHOLE_ARRAY,0,MODE_DESCEND);
     if(Period()<PERIOD_D1) dayshift++;
    }
  Print(TimeToStr(Time[shift])," corresponds to ",dayshift," day bar opened at ", 
TimeToStr(daytimes[dayshift]));
int ArrayDimension(int array[])
Returns array rank (dimensions count).
Parameters
array[]   -  array to retrieve dimensions count.
Sample
  int num_array[10][5];
  int dim_size;
  dim_size=ArrayDimension(num_array);
  // dim_size is 2

bool ArrayGetAsSeries(object array[])
Returns true if array is organized as a series array (array elements indexed from last to first) otherwise return false. 
Parameters
array[]   -  Array to check.
Sample
  if(ArrayGetAsSeries(array1)==true)
    Print("array1 is indexed as a series array");
  else
    Print("array1 is indexed normally (from left to right)");
int ArrayInitialize(double& array[], double value)
Sets all elements of numeric array to the same value. Returns the count of initialized element.
Note: It is useless to initialize index buffers in the custom indicator init() function. 
Parameters
array[]   -  Numeric array to be initialized.
value
  -  New value to be set.
Sample
  //---- setting all elements of array to 2.1
  double myarray[10];
  ArrayInitialize(myarray,2.1);
bool ArrayIsSeries(object array[])
Returns true if the array checked is a series array (time,open,close,high,low, or volume).
Parameters
array[]   -  Array to check.
Sample
   if(ArrayIsSeries(array1)==false)
     ArrayInitialize(array1,0);
   else
     {
      Print("Series array cannot be initialized!");
      return(-1);
     }
int ArrayMaximum(double array[], int count=WHOLE_ARRAY, int start=0)
Searches for elements with maximum value and returns its position.
Parameters
array[]   -  The numeric array to search for.
count
  -  Scans for the count of elements in the array.
start
  -  Start searching on the start index.
Sample
  double num_array[15]={4,1,6,3,9,4,1,6,3,9,4,1,6,3,9};
  int    maxValueIdx=ArrayMaximum(num_array);
  Print("Max value = ", num_array[maxValueIdx]);
int ArrayMinimum(double array[], int count=WHOLE_ARRAY, int start=0)
Searches for element with minimum value and returns its position.
Parameters

array[]   -  The numeric array to search for.
count
  -  Scans for the count of elements in the array.
start
  -  Start searching on the start index.
Sample
  double num_array[15]={4,1,6,3,9,4,1,6,3,9,4,1,6,3,9};
  double minValueidx=ArrayMinimum(num_array);
  Print("Min value = ", num_array[minValueIdx]);
int ArrayRange(object array[], int range_index)
Returns the count of elements in the indicated dimension of the array. Since indexes are zero-based, the size of dimension is 1 
greater than the largest index. 
Parameters
array[]
  -  Array to check
range_index   -  Dimension index.
Sample
  int    dim_size;
  double num_array[10,10,10];
  dim_size=ArrayRange(num_array, 1);
int ArrayResize(object& array[], int new_size)
Sets new size to the first dimension. If success returns count of all elements contained in the array after resizing, otherwise, 
returns zero and array is not resized. 
Parameters
array[]
  -  Array to resize.
new_size   -  New size for the first dimension.
Sample
  double array1[][4];
  int    element_count=ArrayResize(array, 20);
  // element count is 80 elements
bool ArraySetAsSeries(double& array[], bool set)
Sets indexing order of the array like a series arrays, i.e. last element has zero index. Returns previous state. 
Parameters
array[]   -  The numeric array to set.
set
  -  The Series flag to set (true) or drop (false).
Sample
   double macd_buffer[300];
   double signal_buffer[300];
   int    i,limit=ArraySize(macd_buffer);
   ArraySetAsSeries(macd_buffer,true);
   for(i=0; i<limit; i++)
      macd_buffer[i]=iMA(NULL,0,12,0,MODE_EMA,PRICE_CLOSE,i)-
iMA(NULL,0,26,0,MODE_EMA,PRICE_CLOSE,i);
   for(i=0; i<limit; i++)
      signal_buffer[i]=iMAOnArray(macd_buffer,limit,9,0,MODE_SMA,i);
int ArraySize(object array[])
Returns the count of elements contained in the array.

Parameters
array[]   -  Array of any type.
Sample
  int count=ArraySize(array1);
  for(int i=0; i<count; i++)
    {
     // do some calculations.
    }
int 
ArraySort(
double& array[], int count=WHOLE_ARRAY, int start=0, 
int sort_dir=MODE_ASCEND)
Sorts numeric arrays by first dimension. Series arrays cannot be sorted by ArraySort().
Parameters
array[]
  -  The numeric array to sort.
count
  -  Count of elements to sort.
start
  -  Starting index.
sort_dir   -  Array sorting direction. It can be any of the following values:
MODE_ASCEND - sort ascending,
MODE_DESCEND - sort descending.
Sample
  double num_array[5]={4,1,6,3,9};
  // now array contains values 4,1,6,3,9
  ArraySort(num_array);
  // now array is sorted 1,3,4,6,9
  ArraySort(num_array,MODE_DESCEND);
  // now array is sorted 9,6,4,3,1