@echo off & title maven ���ٰ�װ�� by seven

:: ����Ա����
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

rem ��ȡ��ǰ�ű�Ŀ¼�����Ŀ¼�������������ļ��洢Ŀ¼
set Save=%~dp0
rem ���뵱ǰ�ű�Ŀ¼����
cd %Save% & %~d0

set Save=%~dp0
cd %Save% & %~d0

if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
    echo 32λ����ϵͳ
	set ws=32
) else (
    echo 64λ����ϵͳ
	set ws=64
)

:again
:: �û�ѡ��汾����ͬ�İ汾�������Ӳ�ͬ
echo [1] maven-3.1.1
echo [2] maven-3.3.9
echo [3] maven-3.5.4
echo [4] maven-3.6.3
echo [5] maven-3.8.1
echo ���������е����֣����س�ȷ������1 ���а�װmaven-3.1.1
set /p version=��������룺
if %version%==1 (
	set name=apache-maven-3.1.1
	if %ws% ==64 (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.zip
	) else (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.zip
	)
	goto down
)
if %version%==2 (
	set name=apache-maven-3.3.9
	if %ws% ==64 (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
	) else (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
	)
	goto down
)
if %version%==3 (
	set name=apache-maven-3.5.4
	if %ws% ==64 (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip
	) else (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip
	)
	goto down
)
if %version%==4 (
	set name=apache-maven-3.6.3
	if %ws% ==64 (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
	) else (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
	)
	goto down
)

if %version%==5 (
	set name=apache-maven-3.8.1
	if %ws% ==64 (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
	) else (
		set down_url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
	)
	goto down
)
echo ѡ����Ч��������ѡ�񣡣�
goto again
:: ����
:down
echo ==	��ѡ���� %name% %ws%
echo ==	��ʼ����maven �Ƚ����������ĵȴ�	==
echo ++ 	�������������̫�����Ը������ص�ַ�����ֶ���װ��		++
echo ����������������������������������������������������������������������������������������������������������������
echo.													
echo %down_url%
echo.															 
echo ����������������������������������������������������������������������������������������������������������������
echo ++ 	CTRL+C �˳�����		++
%Save%/curl%ws% -# -k -C - -o %Save%\%name%-bin.zip %down_url%
echo ==	���سɹ�

:: �жϽ�ѹ����Ƿ����
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	goto end
)
if exist "C:\Program Files (x86)\WinRAR\WinRAR.exe" (
	goto end
)
:: ���������ؽ�ѹ����
echo ==	���ع����У��ܿ�~���ĵȴ�һ��~~
%Save%/curl%ws% -# -k -C - -o %Save%\wrar600scp.exe http://www.winrar.com.cn/download/wrar600scp.exe
wrar600scp.exe /S
del wrar600scp.exe
:end
echo ==	��ʼ��ѹ
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%name%-bin.zip
)
if exist "C:\Program Files (x86)\WinRAR\WinRAR.exe" (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%name%-bin.zip
)
echo ==	��ѹ���
:: ���û�������
setx MAVEN_HOME "%Save%\%name%" -M
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%home%" /f
:: �жϻ���
set str=%PATH%
set matchStr=%MAVEN_HOME
if not "x!str:%%=!"=="x%str%" (
    echo Y
) else (
    echo N
	setx PATH "%matchStr%%\bin;%PATH%;" -M
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%matchStr%%\bin;%PATH%" /f
)
:: ���ð��ﾵ��
echo ==	���ð�����پ��� %Save%\settings-ali.xml
move %Save%\%name%\conf\settings.xml %Save%\%name%\conf\settings.xml.bak
copy %Save%\settings-ali.xml %Save%\%name%\conf\settings.xml
echo ==	���óɹ�
pause