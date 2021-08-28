@echo off
rem 可读性好，兼容性好
set /p number=请输入数字
if "%number%" == "" (
	echo 您输入空值了
	goto end
)
if %number% LSS 0 ( 
  echo 您输入的数字%number%小于0
) ^
else if %number% EQU 0 ( 
  echo 您输入的数字%number%等于0
) ^
else if %number% GTR 0 ( 
  echo 您输入的数字%number%大于0
) ^
else ( 
  echo 您输入的%number%无法判断
)
:end
pause