::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

@echo off & title mysql 快速安装器 by seven
 
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

::设置要下载的文件链接。必写项。
set Url=http://mirrors.sohu.com/mysql/MySQL-8.0/mysql-8.0.11-winx64.msi
 
::设置文件保存目录，若下载至当前目录，请留空
set Save=%~dp0
cd %Save% & %~d0

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
echo 默认安装一直next即可
if exist "%Save%\%FileName%" (echo 安装：%Save%\%FileName% 请稍等，可能需要您手动确认安装 & cd %Save% & %FileName% ) else (echo 异常：%Save%\%FileName% 文件不存在或被损坏！)
pause