::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

@echo off & title ��װWinRAR ���ٰ�װ�� by seven
 
if exist C:\Program Files\WinRAR\WinRAR.exe () else (
	::����Ҫ���ص��ļ����ӡ���д�
	set Url=http://www.winrar.com.cn/download/winrar-x64-600scp.exe
	 
	::�����ļ�����Ŀ¼������������ǰĿ¼��������
	set Save=%~dp0
	cd %Save% & %~d0
	if exist %Save% (echo λ�ã�%Save%) else (mkdir %Save% & echo �Ѵ�����%Save%)
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
	:: ��װ
	:beginInstall
	del DownloadFile.vbs
	rem if exist "%Save%\%FileName%" (echo ��װ��%Save%\%FileName% ���Եȣ�������Ҫ���ֶ�ȷ�ϰ�װ & start /wait "" "%Save%\%FileName%" /verysilent sp- & exit ) else (echo �쳣��%Save%\%FileName% �ļ������ڻ��𻵣�)
	if exist "%Save%\%FileName%" (cd %Save% & %FileName% /S ) else (echo �쳣��%Save%\%FileName% �ļ������ڻ��𻵣�)
)