@echo off
rem �ɶ��Ժã������Ժ�
set /p number=����������
if "%number%" == "" (
	echo �������ֵ��
	goto end
)
if %number% LSS 0 ( 
  echo �����������%number%С��0
) ^
else if %number% EQU 0 ( 
  echo �����������%number%����0
) ^
else if %number% GTR 0 ( 
  echo �����������%number%����0
) ^
else ( 
  echo �������%number%�޷��ж�
)
:end
pause