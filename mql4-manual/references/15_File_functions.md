# File functions

Page: 41

---

File functions
FileClose()
FileDelete()
FileFlush()
FileIsEnding()
FileIsLineEnding()
FileOpen()
FileOpenHistory()
FileReadArray()
FileReadDouble()
FileReadInteger()
FileReadNumber()
FileReadString()
FileSeek()
FileSize()
FileTell()
FileWrite()
FileWriteArray()
FileWriteDouble()
FileWriteInteger()

FileWriteString()
void FileClose(int handle)
Closes file previously opened by FileOpen() functions.
Parameters
handle   -  File handle, returned by FileOpen() functions
Sample
  int handle=FileOpen("filename", FILE_CSV|FILE_READ);
  if(handle>0)
    {
     // working with file ...
     FileClose(handle);
    }
void FileClose(int handle)
Closes file previously opened by FileOpen() functions.
Parameters
handle   -  File handle, returned by FileOpen() functions
Sample
  int handle=FileOpen("filename", FILE_CSV|FILE_READ);
  if(handle>0)
    {
     // working with file ...
     FileClose(handle);
    }
void FileFlush(int handle)
Flushes all data stored in the file buffer to disk.
Parameters
handle   -  File handle, returned by FileOpen() functions.
Sample
  int bars_count=Bars;
  int handle=FileOpen("mydat.csv",FILE_CSV|FILE_WRITE);
  if(handle>0)
    {
     FileWrite(handle, "#","OPEN","CLOSE","HIGH","LOW");
     for(int i=0;i<bars_count;i++)
       FileWrite(handle, i+1,Open[i],Close[i],High[i], Low[i]);
     FileFlush(handle);
     ...
     for(int i=0;i<bars_count;i++)
       FileWrite(handle, i+1,Open[i],Close[i],High[i], Low[i]);
     FileClose(handle);
    }
bool FileIsEnding(int handle)
Returns logical true if file pointer is at the end of the file, otherwise returns false. To get the detailed error information, call 
GetLastError() function. 
Parameters

handle   -  File handle, returned by FileOpen() functions.
Sample
  if(FileIsEnding(h1))
    {
     FileClose(h1);
     return(false);
    }
bool FileIsLineEnding(int handle)
For CSV file returns logical true if file pointer is at the end of the line, otherwise returns false. To get the detailed error 
information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
Sample
  if(FileIsLineEnding(h1))
    {
     FileClose(h1);
     return(false);
    }
int FileOpen(string filename, int mode, int delimiter=';')
Opens file for input and/or output. Returns a file handle for the opened file. If the function fails, the return value less than 1. To 
get
 
the
 
detailed
 
error
 
information,
 
call
 GetLastError() 
function.
Note: Files can be opened only from terminal_dir\experts\files directory and its subdirectories. 
Parameters
filename
  -  File name, file may be with any extensions.
mode
  -  Open mode. can be one or combination of values: FILE_BIN, FILE_CSV, FILE_READ, FILE_WRITE.
delimiter   -  Delimiter character for csv files. By default passed ';' symbol.
Sample
  int handle;
  handle=FileOpen("my_data.csv",FILE_CSV|FILE_READ,';');
  if(handle<1)
    {
     Print("File my_data.dat not found, the last error is ", GetLastError());
     return(false);
    }
int FileOpenHistory(string filename, int mode, int delimiter=';')
Opens file in the current history directory for input and/or output. Returns a file handle for the opened file. If the function fails, 
the return value less than 1. To get the detailed error information, call GetLastError().
Parameters
filename
  -  File name, file may be with any extensions.
mode
  -  Open mode. can be one or combination of values: FILE_BIN, FILE_CSV, FILE_READ, FILE_WRITE.
delimiter   -  Delimiter character for csv files. By default passed ';' symbol.
Sample
  int handle=FileOpenHistory("USDX240.HST",FILE_BIN|FILE_WRITE);
  if(handle<1)
    {
     Print("Cannot create file USDX240.HST");
     return(false);
    }

  // work with file
  // ...
  FileClose(handle);
int FileReadArray(int handle, object& array[], int start, int count)
Reads  the  indicated  count  of  elements  from  the  binary  file  to  array.  Returns  actual  read  elements  count.
To get the detailed error information, call GetLastError() function. Note: Before reading the data, array must be resized to a 
sufficient size. 
Parameters
handle
  -  File handle, returned by FileOpen() function.
array[]   -  Array where data will be stored.
start
  -  Storing start position into array.
count
  -  Count of elements to read.
Sample
  int handle;
  double varray[10];
  handle=FileOpen("filename.dat", FILE_BIN|FILE_READ);
  if(handle>0)
    {
     FileReadArray(handle, varray, 0, 10);
     FileClose(handle);
    }
int FileReadArray(int handle, object& array[], int start, int count)
Reads  the  indicated  count  of  elements  from  the  binary  file  to  array.  Returns  actual  read  elements  count.
To get the detailed error information, call GetLastError() function. Note: Before reading the data, array must be resized to a 
sufficient size. 
Parameters
handle
  -  File handle, returned by FileOpen() function.
array[]   -  Array where data will be stored.
start
  -  Storing start position into array.
count
  -  Count of elements to read.
Sample
  int handle;
  double varray[10];
  handle=FileOpen("filename.dat", FILE_BIN|FILE_READ);
  if(handle>0)
    {
     FileReadArray(handle, varray, 0, 10);
     FileClose(handle);
    }
int FileReadInteger(int handle, int size=LONG_VALUE)
Read the integer from binary files from the current file position. Integer format size can be 1, 2 or 4 bytes length. If the format 
size is not specified system attempts to read 4 bytes length value. To get the detailed error information, call  GetLastError() 
function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
size
  -  Format size. Can be CHAR_VALUE(1 byte), SHORT_VALUE(2 bytes) or LONG_VALUE(4 bytes).
Sample
  int handle;
  int value;

  handle=FileOpen("mydata.dat", FILE_BIN|FILE_READ);
  if(handle>0)
    {
     value=FileReadInteger(h1,2);
     FileClose(handle);
    }
double FileReadNumber(int handle)
Read the number from the current file position to the delimiter. Only for CSV files. To get the detailed error information, call 
GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
Sample
  int handle;
  int value;
  handle=FileOpen("filename.csv", FILE_CSV, ';');
  if(handle>0)
    {
     value=FileReadNumber(handle);
     FileClose(handle);
    }
string FileReadString(int handle, int length=0)
Read the string from the current file position. Applied to both CSV and binary files. For text files string will be read to the delimiter 
and  for  binary  file  string  will  be  read  for  the  count  of  characters  indicated.  To  get  the  detailed  error  information,  call 
GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
length
  -  Reading characters count.
Sample
  int handle;
  string str;
  handle=FileOpen("filename.csv", FILE_CSV|FILE_READ);
  if(handle>0)
    {
     str=FileReadString(handle);
     FileClose(handle);
    }
bool FileSeek(int handle, int offset, int origin)
Moves the file pointer to a specified location. The FileSeek() function moves the file pointer associated with handle to a new 
location that is offset bytes from origin. The next operation on the file occurs at the new location. If successful, function returns 
TRUE. Otherwise, it returns FALSE. To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() functions.
offset
  -  Offset in bytes from origin.
origin
  -  Initial position. Value can be one of this constants:
SEEK_CUR - from current position,
SEEK_SET - from begin,
SEEK_END - from end of file.
Sample
  int handle=FileOpen("filename.csv", FILE_CSV|FILE_READ, ';');
  if(handle>0)

    {
     FileSeek(handle, 10, SEEK_SET);
     FileReadInteger(handle);
     FileClose(handle);
     handle=0;
    }
int FileSize(int handle)
Returns file size in bytes. To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
Sample
  int handle;
  int size;
  handle=FileOpen("my_table.dat", FILE_BIN|FILE_READ);
  if(handle>0)
    {
     size=FileSize(handle);
     Print("my_table.dat size is ", size, " bytes");
     FileClose(handle);
    }
int FileSize(int handle)
Returns file size in bytes. To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
Sample
  int handle;
  int size;
  handle=FileOpen("my_table.dat", FILE_BIN|FILE_READ);
  if(handle>0)
    {
     size=FileSize(handle);
     Print("my_table.dat size is ", size, " bytes");
     FileClose(handle);
    }
int FileWrite(int handle, ... )
Writes to the CSV file some values, delimiter inserted automatically. Returns the number of characters written, or a negative value 
if an error occurs. To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
...
  -  User data to write, separated with commas.
Note: int and double types automatically converted to string,but color, datetime and bool types does not automatically converted 
and will be writen to file in it's as integers.
Sample
  int handle;
  datetime orderOpen=OrderOpenTime();
  handle=FileOpen("filename", FILE_CSV|FILE_WRITE, ';');
  if(handle>0)
    {

     FileWrite(handle, Close[0], Open[0], High[0], Low[0], TimeToStr(orderOpen));
     FileClose(handle);
    }
int FileWriteArray(int handle, object array[], int start, int count)
Writes array to the binary file. Arrays of type int, bool, datetime and color will be written as 4 bytes integers. Arrays of type 
double will be written as 8 bytes floating point numbers. Arrays of string will be written as one string where elements will be 
divided
 
by
 
Carriage
 
return
 
and
 
Line
 
feed
 
symbols
 
(0D
 
0A).
Returns the number of elements wrote, or a negative value if an error occurs. To get the detailed error information, call 
GetLastError() function. 
Parameters
handle
  -  File handle, returned by FileOpen() function.
array[]   -  Array to write.
start
  -  Starting index into array to write.
count
  -  Count of elements to write.
Sample
  int handle;
  double BarOpenValues[10];
  // copy first ten bars to the array
  for(int i=0;i<10; i++)
    BarOpenValues[i]=Open[i];
  // writing array to the file
  handle=FileOpen("mydata.dat", FILE_BIN|FILE_WRITE);
  if(handle>0)
    {
     FileWriteArray(handle, BarOpenValues, 3, 7); // writing last 7 elements
     FileClose(handle);
    }
int FileWriteDouble(int handle, double value, int size=DOUBLE_VALUE)
Writes double value to the binary file. If size is FLOAT_VALUE, value will be written as 4 bytes floating point format, else will be 
written
 
in
 
8
 
bytes
 
floating
 
point
 
format.
 
Returns
 
actual
 
written
 
bytes
 
count.
To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
value
  -  Value to write.
size
  -  Optional format flag. It can be any of the following values:
DOUBLE_VALUE (8 bytes, default)
FLOAT_VALUE (4 bytes).
Sample
  int handle;
  double var1=0.345;
  handle=FileOpen("mydata.dat", FILE_BIN|FILE_WRITE);
  if(handle<1)
    {
     Print("can't open file error-",GetLastError());
     return(0);
    }
  FileWriteDouble(h1, var1, DOUBLE_VALUE);
  //...
  FileClose(handle);
int FileWriteInteger(int handle, int value, int size=LONG_VALUE)
Writes integer value to the binary file. If size is SHORT_VALUE, value will be written as 2 bytes integer, if size is CHAR_VALUE, 

value will be written as 1 bytes integer and if size is LONG_VALUE, value will be written as 4 bytes integer. Returns actual written 
bytes
 
count.
To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
value
  -  Value to write.
size
  -  Optional format flag. It can be any of the following values:
CHAR_VALUE (1 byte),
SHORT_VALUE (2 bytes),
LONG_VALUE (4 bytes, default).
Sample
  int handle;
  int value=10;
  handle=FileOpen("filename.dat", FILE_BIN|FILE_WRITE);
  if(handle<1)
    {
     Print("can't open file error-",GetLastError());
     return(0);
    }
  FileWriteInteger(handle, value, SHORT_VALUE);
  //...
  FileClose(handle);
int FileWriteString(int handle, string value, int length)
Writes  string  to  the  binary  file  from  current  file  position.  Returns  actual  written  bytes  count.
To get the detailed error information, call GetLastError() function. 
Parameters
handle   -  File handle, returned by FileOpen() function.
value
  -  Text to write.
length
  -  Counts of characters to write.
Sample
  int handle;
  string str="some string";
  handle=FileOpen("filename.bin", FILE_BIN|FILE_WRITE);
    if(handle<1)
    {
     Print("can't open file error-",GetLastError());
     return(0);
    }
  FileWriteString(h1, str, 8);
  FileClose(handle);