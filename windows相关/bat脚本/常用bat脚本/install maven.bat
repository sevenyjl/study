@echo off & title maven 快速安装器 by seven

:: 管理员启动
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

rem 获取当前脚本目录，这个目录将会做个下载文件存储目录
set Save=%~dp0
rem 进入当前脚本目录磁盘
cd %Save% & %~d0

set Save=%~dp0
cd %Save% & %~d0

if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
    echo 32位操作系统
	set ws=32
) else (
    echo 64位操作系统
	set ws=64
)

:again
:: 用户选择版本，不同的版本下载连接不同
echo [1] maven-3.1.1
echo [2] maven-3.3.9
echo [3] maven-3.5.4
echo [4] maven-3.6.3
echo [5] maven-3.8.1
echo 请输入编号中的数字，按回车确定。如1 进行安装maven-3.1.1
set /p version=请输入编码：
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
echo 选择无效！！重新选择！！
goto again
:: 下载
:down
echo ==	您选择了 %name% %ws%
echo ==	开始下载maven 比较漫长请耐心等待	==
echo ++ 	如果您觉得下载太慢可以复制下载地址进行手动安装：		++
echo ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
echo.													
echo %down_url%
echo.															 
echo ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
echo ++ 	CTRL+C 退出程序		++
%Save%/curl%ws% -# -k -C - -o %Save%\%name%-bin.zip %down_url%
echo ==	下载成功

:: 判断解压软件是否存在
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	goto end
)
if exist "C:\Program Files (x86)\WinRAR\WinRAR.exe" (
	goto end
)
:: 不存在下载解压程序
echo ==	下载工具中，很快~耐心等待一下~~
%Save%/curl%ws% -# -k -C - -o %Save%\wrar600scp.exe http://www.winrar.com.cn/download/wrar600scp.exe
wrar600scp.exe /S
del wrar600scp.exe
:end
echo ==	开始解压
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%name%-bin.zip
)
if exist "C:\Program Files (x86)\WinRAR\WinRAR.exe" (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%name%-bin.zip
)
echo ==	解压完成
:: 设置环境变量
setx MAVEN_HOME "%Save%\%name%" -M
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%home%" /f
:: 判断环境
set str=%PATH%
set matchStr=%MAVEN_HOME
if not "x!str:%%=!"=="x%str%" (
    echo Y
) else (
    echo N
	setx PATH "%matchStr%%\bin;%PATH%;" -M
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%matchStr%%\bin;%PATH%" /f
)
:: 设置阿里镜像
echo ==	设置阿里加速镜像 %Save%\settings-ali.xml
move %Save%\%name%\conf\settings.xml %Save%\%name%\conf\settings.xml.bak
copy %Save%\settings-ali.xml %Save%\%name%\conf\settings.xml
echo ==	设置成功
pause