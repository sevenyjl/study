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
echo ==  开始下载，请耐心等待...  ==
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
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
if exist "%Save%\%FileName%" (echo 位置：%Save%\%FileName% & goto beginInstall) else (echo 下载：%FileName% 请等待,下载路径：%Save%)
DownloadFile.vbs "%Url%" "%Save%\%FileName%"
::del DownloadFile.vbs

:: 安装
:beginInstall
del DownloadFile.vbs
rem 解压
echo 请手动解压到当前路径，解压完再继续
set maven_home=%Save%\%FileName:~0,-8%
pause

:: 添加环境变量 MAVEN_HOME
setx /M MAVEN_HOME %maven_home%
echo 添加环境成功
todo mvn 环境检测
pause