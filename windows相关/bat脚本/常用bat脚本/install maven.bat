::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

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


::设置要下载的文件链接。必写项。
set Url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
 
::设置文件保存目录，若下载至当前目录，请留空
if exist %Save% (echo ==	下载存储路径：%Save%) else (mkdir %Save% & echo ==	创建下载存储路径：%Save%)
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
if exist "%Save%\%FileName%" (
	rem 已经下载完成
	goto beginInstall
) else (
	echo ==	下载：%FileName% 请等待,下载路径：%Save%
	(if exist "%Save%\%FileName%" (goto beginInstall)
	echo Download Wscript.Arguments^(0^),Wscript.Arguments^(1^)
	echo Sub Download^(url,target^)
	echo   Const adTypeBinary = 1
	echo   Const adSaveCreateOverWrite = 2
	echo   Dim http,ado
	echo   Set http = CreateObject^("Msxml2.ServerXMLHTTP"^)
	echo   http.open "GET",url,False
	echo   http.send
	echo   Set ado = createobject^("Adodb.Stream"^)
	echo   ado.Type = adTypeBinary
	echo   ado.Open
	echo   ado.Write http.responseBody
	echo   ado.SaveToFile target
	echo   ado.Close
	echo End Sub)>DownloadFile.vbs
	DownloadFile.vbs "%Url%" "%Save%\%FileName%"
	del DownloadFile.vbs
)
:: 安装
:beginInstall
echo ==	下载完成：%Save%\%FileName%

:: 检测解压工具
set Url_jy=http://www.winrar.com.cn/download/wrar600scp.exe
for %%a in ("%Url_jy%") do set "FileName_jy=%%~nxa"
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	echo ==	解压工具存在 & goto jy 
) else (
	echo ==	下载：%FileName_jy% 请等待,下载路径：%Save%
	(if exist "%Save%\%FileName_jy%" ( echo 已经下载完成%FileName_jy% & goto jy)
	echo Download Wscript.Arguments^(0^),Wscript.Arguments^(1^)
	echo Sub Download^(url,target^)
	echo   Const adTypeBinary = 1
	echo   Const adSaveCreateOverWrite = 2
	echo   Dim http,ado
	echo   Set http = CreateObject^("Msxml2.ServerXMLHTTP"^)
	echo   http.open "GET",url,False
	echo   http.send
	echo   Set ado = createobject^("Adodb.Stream"^)
	echo   ado.Type = adTypeBinary
	echo   ado.Open
	echo   ado.Write http.responseBody
	echo   ado.SaveToFile target
	echo   ado.Close
	echo End Sub)>DownloadFile.vbs
	if exist "%Save%\%FileName_jy%" (goto beginInstall)
	DownloadFile.vbs "%Url%" "%Save%\%FileName_jy%"
	del DownloadFile.vbs
	if exist "%Save%\%FileName_jy%" (cd %Save% & %FileName_jy% /S ) else (echo 异常：%Save%\%FileName_jy% 文件不存在或被损坏！)
)
:jy
echo ==	开始解压：%Save%\%FileName%
set home=%Save%\%FileName:~0,-8%
if exist "%home%" (
	goto setting
)else (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%FileName% 
)
:setting
echo ==	解压完成

setx MAVEN_HOME "%home%" -M
setx PATH "%%MAVEN_HOME%%\bin;%PATH%;" -M

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%home%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%MAVEN_HOME%\bin;%PATH%" /f
pause