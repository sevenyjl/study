::  https://cdn.npm.taobao.org/dist/node/v14.16.0/node-v14.16.0-x64.msi

@echo off & title mysql ���ٰ�װ�� by seven
 
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

::����Ҫ���ص��ļ����ӡ���д�
set Url=http://mirrors.sohu.com/mysql/MySQL-8.0/mysql-8.0.11-winx64.msi
 
::�����ļ�����Ŀ¼������������ǰĿ¼��������
set Save=%~dp0
cd %Save% & %~d0

if exist %Save% (echo λ�ã�%Save%) else (mkdir %Save% & echo �Ѵ�����%Save%)
echo ==  ��ʼ���أ������ĵȴ�...  ==
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
if exist "%Save%\%FileName%" (echo λ�ã�%Save%\%FileName% & goto beginInstall) else (echo ���أ�%FileName% ��ȴ�,����·����%Save%)
DownloadFile.vbs "%Url%" "%Save%\%FileName%"
::del DownloadFile.vbs

:: ��װ
:beginInstall
del DownloadFile.vbs
echo Ĭ�ϰ�װһֱnext����
if exist "%Save%\%FileName%" (echo ��װ��%Save%\%FileName% ���Եȣ�������Ҫ���ֶ�ȷ�ϰ�װ & cd %Save% & %FileName% ) else (echo �쳣��%Save%\%FileName% �ļ������ڻ��𻵣�)
pause