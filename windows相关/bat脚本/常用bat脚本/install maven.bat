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

set Save=%~dp0
cd %Save% & %~d0


::设置要下载的文件链接。必写项。
set Url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
 
::设置文件保存目录，若下载至当前目录，请留空

if exist %Save% (echo 位置：%Save%) else (mkdir %Save% & echo 已创建：%Save%)
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
if exist "%Save%\%FileName%" (echo 下载完成：%Save%\%FileName% & goto beginInstall) else (echo 下载：%FileName% 请等待,下载路径：%Save%)
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

:: 安装
:beginInstall
echo ====解压程序 "C:\Program Files\WinRAR\WinRAR.exe"
rem 解压 todo 有风险
if exist "C:\Program Files\WinRAR\WinRAR.exe" ( goto :jy ) else (
	call "静默安装winrar.bat"
)

:jy
set maven_home=%Save%\%FileName:~0,-8%
echo == 开始解压缩 "%Save%\%FileName%" ==
if exist "%maven_home%" (
	goto :setting
)else (
	"C:\Program Files\WinRAR\WinRAR.exe" x %FileName%
)
:setting
:: 添加环境变量 MAVEN_HOME

setx MAVEN_HOME "%maven_home%" -M
setx PATH "%%MAVEN_HOME%%\bin;%PATH%;" -M

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%maven_home%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%%MAVEN_HOME%%\bin;%PATH%" /f
call mvn -v
echo 添加环境成功
pause