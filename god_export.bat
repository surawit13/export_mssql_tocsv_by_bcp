set HOST_IP=IT-WRK2008-0117
set HOST_DATABASE=bg
set HOST_TABLE=customer
set HEADER_NAME=col.csv
set FETCH_ROW=data.csv
set NAME_FILE=export_file.csv
BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + ',', '') + column_name from %HOST_DATABASE%.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='%HOST_TABLE%'; select @colnames;" queryout %HEADER_NAME% -c -T -S%HOST_IP%
BCP %HOST_DATABASE%.dbo.%HOST_TABLE% out %FETCH_ROW% -c -t, -T -S%HOST_IP%
set HOST_IP=
set HOST_DATABASE=
set HOST_TABLE=
copy /b %HEADER_NAME%+%FETCH_ROW% %NAME_FILE%
del %HEADER_NAME%
del %FETCH_ROW%
@REM pause