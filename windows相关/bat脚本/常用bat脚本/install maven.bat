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

set Save=%~dp0
cd %Save% & %~d0


::����Ҫ���ص��ļ����ӡ���д�
set Url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
 
::�����ļ�����Ŀ¼������������ǰĿ¼��������

if exist %Save% (echo λ�ã�%Save%) else (mkdir %Save% & echo �Ѵ�����%Save%)
for %%a in ("%Url%") do set "FileName=%%~nxa"
if not defined Save set "Save=%cd%"
if exist "%Save%\%FileName%" (echo ������ɣ�%Save%\%FileName% & goto beginInstall) else (echo ���أ�%FileName% ��ȴ�,����·����%Save%)
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

:: ��װ
:beginInstall
echo ====��ѹ���� "C:\Program Files\WinRAR\WinRAR.exe"
rem ��ѹ todo �з���
if exist "C:\Program Files\WinRAR\WinRAR.exe" ( goto :jy ) else (
	call "��Ĭ��װwinrar.bat"
)

:jy
set maven_home=%Save%\%FileName:~0,-8%
echo == ��ʼ��ѹ�� "%Save%\%FileName%" ==
if exist "%maven_home%" (
	goto :setting
)else (
	"C:\Program Files\WinRAR\WinRAR.exe" x %FileName%
)
:setting
:: ��ӻ������� MAVEN_HOME

setx MAVEN_HOME "%maven_home%" -M
setx PATH "%%MAVEN_HOME%%\bin;%PATH%;" -M

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "MAVEN_HOME" /d "%maven_home%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%%MAVEN_HOME%%\bin;%PATH%" /f
call mvn -v
echo ��ӻ����ɹ�
pause