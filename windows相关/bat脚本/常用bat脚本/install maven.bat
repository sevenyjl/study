::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

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


::����Ҫ���ص��ļ����ӡ���д�
set Url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
 
::�����ļ�����Ŀ¼������������ǰĿ¼��������
if exist %Save% (echo ==	���ش洢·����%Save%) else (mkdir %Save% & echo ==	�������ش洢·����%Save%)
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
if exist "%Save%\%FileName%" (
	rem �Ѿ��������
	goto beginInstall
) else (
	echo ==	���أ�%FileName% ��ȴ�,����·����%Save%
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
:: ��װ
:beginInstall
echo ==	������ɣ�%Save%\%FileName%

:: ����ѹ����
set Url_jy=http://www.winrar.com.cn/download/wrar600scp.exe
for %%a in ("%Url_jy%") do set "FileName_jy=%%~nxa"
if exist "C:\Program Files\WinRAR\WinRAR.exe" (
	echo ==	��ѹ���ߴ��� & goto jy 
) else (
	echo ==	���أ�%FileName_jy% ��ȴ�,����·����%Save%
	(if exist "%Save%\%FileName_jy%" ( echo �Ѿ��������%FileName_jy% & goto jy)
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
	if exist "%Save%\%FileName_jy%" (cd %Save% & %FileName_jy% /S ) else (echo �쳣��%Save%\%FileName_jy% �ļ������ڻ��𻵣�)
)
:jy
echo ==	��ʼ��ѹ��%Save%\%FileName%
set home=%Save%\%FileName:~0,-8%
if exist "%home%" (
	goto setting
)else (
	"C:\Program Files\WinRAR\WinRAR.exe" x -o+ %Save%\%FileName% 
)
:setting
echo ==	��ѹ���

setx MAVEN_HOME "%home%" -M
setx PATH "%%MAVEN_HOME%%\bin;%PATH%;" -M

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%home%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%MAVEN_HOME%\bin;%PATH%" /f
pause