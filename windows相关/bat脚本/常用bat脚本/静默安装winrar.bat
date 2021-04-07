::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

@echo off & title 安装WinRAR 快速安装器 by seven
 
if exist C:\Program Files\WinRAR\WinRAR.exe () else (
	::设置要下载的文件链接。必写项。
	set Url=http://www.winrar.com.cn/download/winrar-x64-600scp.exe
	 
	::设置文件保存目录，若下载至当前目录，请留空
	set Save=%~dp0
	cd %Save% & %~d0
	if exist %Save% (echo 位置：%Save%) else (mkdir %Save% & echo 已创建：%Save%)
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
	if exist "%Save%\%FileName%" (goto beginInstall)
	DownloadFile.vbs "%Url%" "%Save%\%FileName%"
	::del DownloadFile.vbs
	:: 安装
	:beginInstall
	del DownloadFile.vbs
	rem if exist "%Save%\%FileName%" (echo 安装：%Save%\%FileName% 请稍等，可能需要您手动确认安装 & start /wait "" "%Save%\%FileName%" /verysilent sp- & exit ) else (echo 异常：%Save%\%FileName% 文件不存在或被损坏！)
	if exist "%Save%\%FileName%" (cd %Save% & %FileName% /S ) else (echo 异常：%Save%\%FileName% 文件不存在或被损坏！)
)