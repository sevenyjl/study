:: 安装jdk
@echo off & title jdk 快速安装器 by seven



set Save=%~dp0
cd %Save% & %~d0
dir 

if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
    echo 32位操作系统
	set ws=32
) else (
    echo 64位操作系统
	set ws=64
)

:wx_jdk
:: 用户选择jdk版本，不同的版本下载连接不同
echo [1] jdk8
echo [2] jdk11
echo [3] jdk14
echo [4] jdk15
echo [5] jdk16
echo 请输入编号中的数字，按回车确定。如1 进行安装jdk8
set /p jdk_version=请输入编码：

if %jdk_version%==1 (
	set jdk_name=jdk8
	set jdk_path=C:\Program Files\AdoptOpenJDK\jdk-8.0.282.8-hotspot
	if %ws% ==64 (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/8/jdk/x64/windows/OpenJDK8U-jdk_x64_windows_hotspot_8u282b08.msi
	) else (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/8/jdk/x32/windows/OpenJDK8U-jdk_x86-32_windows_hotspot_8u282b08.msi
	)
	goto down
)
if %jdk_version%==2 (
	set jdk_name=jdk11
	set jdk_path=C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-hotspot
	if %ws% ==64 (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/11/jdk/x64/windows/OpenJDK11U-jdk_x64_windows_hotspot_11.0.10_9.msi
	) else (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/11/jdk/x32/windows/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.10_9.msi
	)
	goto down
)
if %jdk_version%==3 (
	set jdk_name=jdk14
	set jdk_path=C:\Program Files\AdoptOpenJDK\jdk-14.0.2.12-hotspot
	if %ws% ==64 (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/14/jdk/x32/windows/OpenJDK14U-jdk_x64_windows_hotspot_14.0.2_12.msi
	) else (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/14/jdk/x32/windows/OpenJDK14U-jdk_x86-32_windows_hotspot_14.0.2_12.msi
	)
	goto down
)
if %jdk_version%==4 (
	set jdk_name=jdk15
	set jdk_path=C:\Program Files\AdoptOpenJDK\jdk-15.0.2.7-hotspot
	if %ws% ==64 (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/15/jdk/x32/windows/OpenJDK15U-jdk_x64_windows_hotspot_15.0.2_7.msi
	) else (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/15/jdk/x32/windows/OpenJDK15U-jdk_x86-32_windows_hotspot_15.0.2_7.msi
	)
	goto down
)

if %jdk_version%==5 (
	set jdk_name=jdk16
	set jdk_path=C:\Program Files\AdoptOpenJDK\jdk-16.0.0.36-openj9\
	if %ws% ==64 (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/16/jdk/x64/windows/OpenJDK16-jdk_x64_windows_openj9_16_36_openj9-0.25.0.msi
	) else (
		set jdk_url=https://mirrors.tuna.tsinghua.edu.cn/AdoptOpenJDK/16/jdk/x32/windows/OpenJDK16-jdk_x86-32_windows_hotspot_16_36.msi
	)
	goto down
)
echo 选择无效！！重新选择！！
goto wx_jdk
:: 下载jdk
:down
echo ==	您选择了 %jdk_name% %ws%
echo ==	开始下载jdk 比较漫长请耐心等待	==
echo ++ 如果您觉得下载太慢可以复制下载地址进行手动安装：		++
echo ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
echo.													
echo %jdk_url%
echo.															 
echo ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
echo ++ CTRL+C 退出程序		++
%Save%/curl%ws% -# -k -C - -o %Save%\%jdk_name%.msi %jdk_url%

:: 静默安装jdk
%Save%\%jdk_name%.msi /passive /qn

echo 安装地址%jdk_path%
:: 设置环境变量
setx JAVA_HOME "%jdk_path%" -M
setx PATH "%%JAVA_HOME%%\bin;%PATH%;" -M

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "JAVA_HOME" /d "%jdk_path%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PATH" /d "%JAVA_HOME%\bin;%PATH%" /f


pause
