@ECHO OFF
MODE CON COLS=20 LINES=3
COLOR A
ECHO UACTEST>"%WINDIR%\SYSTEM32\UAC_TEST.XB"
CLS
ECHO. UAC REQUEST...
IF EXIST "%WINDIR%\SYSTEM32\UAC_TEST.XB" GOTO GOTADMIN
ECHO SET UAC = CREATEOBJECT^("SHELL.APPLICATION"^) > "%TEMP%\GETADMIN.VBS"
ECHO UAC.SHELLEXECUTE "%~S0", "", "", "RUNAS", 1 >> "%TEMP%\GETADMIN.VBS"
"%TEMP%\GETADMIN.VBS"
EXIT /B
:GOTADMIN
IF EXIST "%TEMP%\GETADMIN.VBS" ( DEL "%TEMP%\GETADMIN.VBS" )
IF EXIST "%WINDIR%\SYSTEM32\UAC_TEST.XB" ( DEL "%WINDIR%\SYSTEM32\UAC_TEST.XB" )
PUSHD "%~DP0"
MODE CON COLS=52 LINES=20
TITLE Office365 Downloader^&Installer-FCZBL.VIP
VER|FINDSTR "版本">NUL&&SET SYSLANGUAGE=CHS||SET SYSLANGUAGE=ENG
IF "%SYSLANGUAGE%"=="CHS" (
SET BOX1=       未在本目录发现365离线包！
SET BOX2=          请选择要执行的操作：
SET BOX3=群号：
SET BOX4=小白-白
SET BOX5=   请选择Office365的语言：
SET BOX6=简体中文  
SET BOX7=繁体中文  
SET BOX8=请输入对应的数字，不包括括号：
SET BOX9=    请选择Office位数：
SET BOX10=      执行前的最后确认：
SET BOX11=   程序版本：
SET BOX12=   程序语言：
SET BOX13=   程序位数：
SET BOX14=按任意键继续；取消请直接关闭本窗口。
SET BOX15=正在下载
SET BOX16=请不要关闭此窗口！！！
SET BOX17=         下载完成，按任意键退出。
SET BOX18=如需立即安装，请再次运行本程序！
SET BOX18_5= 
SET BOX19=已检测到的安装包信息：
SET BOX20=程序版本：
SET BOX21=程序语言：
SET BOX22=程序位数：
SET BOX23=若确认无误，请回车；需重新下载，请输2后回车：
SET BOX24=请选择不需要安装的组件：
SET BOX25=例如不需要安装Outlook，则输入7即可
SET BOX26=     支持多选,如不需要Word,Excel,则输12
SET BOX27=请输入数字后回车或直接回车：
SET BOX28=确认需要排除的组件列表：
SET BOX29=按任意键继续安装,要退出请直接关闭本窗口。
SET BOX30=按任意键继续安装。
SET BOX31=  正在安装
SET BOX32= 安装完成
SET BOX33=按任意键退出。
SET BOX34=XP系统无法安装Office365！！！
SET BOX35=出现错误，下载失败。
SET BOX37=出现错误，安装失败。
SET BOX38=更多语言...
SET BOX39=英语   
SET BOX40=日语    
SET BOX41=韩语  
SET BOX42=下载离线包：
SET BOX43=在线安装  ：
)
IF "%SYSLANGUAGE%"=="ENG" (
SET BOX1= Office365 offline package not found.
SET BOX2=    Please select the way to install:
SET BOX3=QQ Group:
SET BOX4=XB2016
SET BOX5=Please select the language:
SET BOX6=ChineseSimplified 
SET BOX7=ChineseTraditional
SET BOX8=Please enter the number without brackets:
SET BOX9=Please select ClientEdition:
SET BOX10=Final confirmation before execution:
SET BOX11= Version:       
SET BOX12= Language:      
SET BOX13= ClientEdition: 
SET BOX14=Press any key to continue,or close this window.
SET BOX15=Downloading 
SET BOX16=Do NOT close this window.
SET BOX17=Download completed,press any key to exit.
SET BOX18=Please run the program again,
SET BOX18_5=If you need to install it immediately.
SET BOX19=Package informations has been detected:
SET BOX20=Version:       
SET BOX21=Language:      
SET BOX22=ClientEdition: 
SET BOX23=Press Enter to continue;or enter 2 to redownload:
SET BOX24=Select the components you DON'T need:
SET BOX25=For example,if you do not need to
SET BOX26= install Word and Excel,you can enter 12.
SET BOX27=Please enter the number:
SET BOX28=Identify the excluded components:
SET BOX29=Press any key to continue installation.
SET BOX30=Press any key to continue.
SET BOX31=Installing 
SET BOX32= Installed.
SET BOX33=Press any key to exit.
SET BOX34=XP DON'T support Office365.
SET BOX35=ERROR.Failed to download.
SET BOX37=ERROR.Failed to install.
SET BOX38=More Language ...
SET BOX39=English  
SET BOX40=Japanese  
SET BOX41=Korean  
SET BOX42=Download: 
SET BOX43=Install : 
)
VER | FINDSTR "5.1." >NUL&&GOTO ERROR0
SETLOCAL ENABLEDELAYEDEXPANSION
IF EXIST "%CD%\DATA\DOWNLOAD.INFO" ( DEL "%CD%\DATA\DOWNLOAD.INFO" /F /Q )
IF EXIST "%CD%\DATA\SETUP.INFO" ( DEL "%CD%\DATA\SETUP.INFO" /F /Q )
IF NOT EXIST "%CD%\OFFICE\DATA\" GOTO DOWNLOAD
FOR /D %%A IN ("%CD%\OFFICE\DATA\*") DO (
SET FULLPATCH=%%A
SET CHECKFULLVERSION=!FULLPATCH:~-14!
IF "!CHECKFULLVERSION:~2,1!"=="." (
IF "!CHECKFULLVERSION:~4,1!"=="." (
IF "!CHECKFULLVERSION:~9,1!"=="." (
SET FULLVERSION=!FULLPATCH:~-14!
)
)
)
)
IF NOT DEFINED FULLVERSION GOTO DOWNLOAD
DIR /B "%CD%\OFFICE\DATA\%FULLVERSION%\*"|FIND /I "STREAM.X">"%WINDIR%\365CHECK.TEMP"
FOR /F %%I IN (%WINDIR%\365CHECK.TEMP) DO (
SET DAT=%%I
IF "!DAT:~13,1!"=="-" (
SET WS2=!DAT:~8,2!
SET LANGUAGE=!DAT:~11,5!
)
)
DEL "%WINDIR%\365CHECK.TEMP" /F /Q
IF NOT DEFINED LANGUAGE GOTO DOWNLOAD
IF "%FULLVERSION:~0,2%"=="15" SET VERSION=2013
IF "%FULLVERSION:~0,2%"=="16" SET VERSION=2016
IF "%WS2%"=="86" SET WS=32
IF "%WS2%"=="64" SET WS=64
IF "%VERSION%"=="2013" SET ECH0=[0]  InfoPath
IF NOT DEFINED VERSION GOTO DOWNLOAD
IF NOT DEFINED WS GOTO DOWNLOAD
IF NOT EXIST "%CD%\OFFICE\DATA\%FULLVERSION%\STREAM.X%WS2%.X-NONE.DAT" GOTO DOWNLOAD
IF NOT EXIST "%CD%\OFFICE\DATA\%FULLVERSION%\STREAM.X%WS2%.%LANGUAGE%.DAT" GOTO DOWNLOAD
GOTO INSTALL
:DOWNLOAD
CLS
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.       %BOX1%
ECHO.
ECHO.      %BOX2%
ECHO.
ECHO.      [1] %BOX42%Office 365 Version 2016
ECHO.
ECHO.      [2] %BOX43%Office 365 Version 2016
ECHO.
ECHO.
ECHO.      (C)2016 FCZBL
ECHO.
ECHO.      %BOX3%537639679             by %BOX4%
ECHO.
ECHO. ==================================================
ECHO.
SET /P C1=%BOX8%
SET VERSION=2016
IF "%C1%"=="2" GOTO ONLINEINSTALL
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.            %BOX5%
ECHO.
ECHO.             [1]  %BOX6%  zh-cn
ECHO.             [2]  %BOX7%  zh-tw
ECHO.             [3]  %BOX39%     en-us
ECHO.             [4]  %BOX41%      ko-kr
ECHO.             [5]  %BOX40%    ja-jp
ECHO.             [6]  %BOX38%
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
SET /P C2=%BOX8%
SET LANGUAGE=zh-cn
IF "%C2%"=="2" SET LANGUAGE=zh-tw
IF "%C2%"=="3" SET LANGUAGE=en-us
IF "%C2%"=="4" SET LANGUAGE=ko-kr
IF "%C2%"=="5" SET LANGUAGE=ja-jp
IF "%C2%"=="6" GOTO MORELANGUAGE
:CONDOWNLOAD
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.            %BOX9%
ECHO.
ECHO.               [1]  32 Bit (X86)
ECHO.
ECHO.               [2]  64 Bit (X64)
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
SET /P C3=%BOX8%
SET WS=32
SET WS2=86
IF "%C3%"=="2" SET WS=64
IF "%C3%"=="2" SET WS2=64
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.          %BOX10%
ECHO.
ECHO.             %BOX11%%VERSION%
ECHO.
ECHO.             %BOX12%%LANGUAGE%
ECHO.
ECHO.             %BOX13%%WS% Bit
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX14%&PAUSE>NUL
(
ECHO ^<Configuration^>
ECHO   ^<Add OfficeClientEdition="%WS%"^>
ECHO    ^<Product ID="O365ProPlusRetail"^>
ECHO      ^<Language ID="%LANGUAGE%" /^>
ECHO    ^</Product^>
ECHO   ^</Add^>
ECHO ^</Configuration^>
)>"%CD%\DATA\DOWNLOAD.INFO"
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.           %BOX15%Office365 Version 2016
ECHO.
ECHO.
ECHO.                 %LANGUAGE% %WS%Bit
ECHO.
ECHO.
ECHO.              %BOX16%
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
"%CD%\DATA\XB2016.EXE"
"%CD%\DATA\%VERSION%.EXE" /DOWNLOAD "%CD%\DATA\DOWNLOAD.INFO"
DEL "%CD%\DATA\DOWNLOAD.INFO" /F /Q
IF NOT EXIST "%CD%\OFFICE\DATA" GOTO ERROR
FOR /D %%A IN ("%CD%\OFFICE\DATA\*") DO (
SET FULLPATCH=%%A
SET CHECKFULLVERSION=!FULLPATCH:~-14!
IF "!CHECKFULLVERSION:~2,1!"=="." (
IF "!CHECKFULLVERSION:~4,1!"=="." (
IF "!CHECKFULLVERSION:~9,1!"=="." (
SET FULLVERSION=!FULLPATCH:~-14!
)
)
)
)
IF NOT EXIST "%CD%\OFFICE\DATA\%FULLVERSION%\STREAM.X%WS2%.X-NONE.DAT" GOTO ERROR
IF NOT EXIST "%CD%\OFFICE\DATA\%FULLVERSION%\STREAM.X%WS2%.%LANGUAGE%.DAT" GOTO ERROR
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.     %BOX17%
ECHO.
ECHO.
ECHO.
ECHO.          %BOX18%
ECHO.      %BOX18_5%
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX33%&PAUSE>NUL
EXIT
:INSTALL
CLS
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.       %BOX19%
ECHO.
ECHO.           %BOX20%%FULLVERSION%
ECHO.
ECHO.           %BOX21%%LANGUAGE% 
ECHO.
ECHO.           %BOX22%%WS% Bit
ECHO.
ECHO.      (C)2016 FCZBL
ECHO.
ECHO.      %BOX3%537639679             by %BOX4%
ECHO.
ECHO. ==================================================
ECHO.
SET /P C4=%BOX23%
IF "%C4%"=="2" GOTO DE
:SETUP
CLS
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.        %BOX24%
ECHO.
ECHO.             [1]  Word
ECHO.             [2]  Excel
ECHO.             [3]  PowerPoint
ECHO.             [4]  Access
ECHO.             [5]  OneNote
ECHO.             [6]  Outlook
ECHO.             [7]  Publisher
ECHO.             [8]  Groove(OneDrive for Business)
ECHO.             [9]  Lync(Skype for Business)
ECHO.             %ECH0%
ECHO.
ECHO.      %BOX25%
ECHO.   %BOX26%
ECHO. ==================================================
SET /P C5= %BOX27%
SET C6=%C5%
SET LENGTH=0
IF NOT DEFINED C5 (
SET ZDY=N
GOTO SETUP2
)
:CON
SET /A LENGTH+=1
SET C5=%C5:~0,-1%
IF DEFINED C5 GOTO CON
SET /A LENGTH-=1
FOR /L %%Y IN (0,1,%LENGTH%) DO (
SET 1=!C6:~%%Y,1!
IF "!1!"=="1" SET 10=Word
IF "!1!"=="2" SET 11=Excel
IF "!1!"=="3" SET 12=PowerPoint
IF "!1!"=="4" SET 13=Access
IF "!1!"=="5" SET 14=OneNote
IF "!1!"=="6" SET 15=Outlook
IF "!1!"=="7" SET 16=Publisher
IF "!1!"=="8" SET 17=Groove
IF "!1!"=="9" SET 18=Lync
IF "!1!"=="0" SET 19=InfoPath
)
CLS
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.          %BOX28%
ECHO.
FOR /L %%A IN (10,1,19) DO (
IF NOT "!%%A!"=="" ECHO.           !%%A!
)
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX29%&PAUSE>NUL
:SETUP2
ECHO ^<Configuration^>>"%CD%\DATA\SETUP.INFO"
ECHO   ^<Add SourcePath="%CD%" OfficeClientEdition="%WS%" Branch="Current"^>>>"%CD%\DATA\SETUP.INFO"
ECHO     ^<Product ID="O365ProPlusRetail"^>>>"%CD%\DATA\SETUP.INFO"
ECHO       ^<Language ID="%language%" /^>>>"%CD%\DATA\SETUP.INFO"
IF NOT "%ZDY%"=="N" (FOR /L %%A IN (10,1,19) DO (
IF NOT "!%%A!"=="" ECHO       ^<ExcludeApp ID="!%%A!" /^>>>"%CD%\DATA\SETUP.INFO"
)
)
ECHO     ^</Product^>>>"%CD%\DATA\SETUP.INFO"
ECHO   ^</Add^>>>"%CD%\DATA\SETUP.INFO"
ECHO ^</Configuration^>>>"%CD%\DATA\SETUP.INFO"
CLS
ECHO.
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.
ECHO.         %BOX31%Office365 Version %VERSION%
ECHO.
ECHO.
ECHO.                %LANGUAGE% %WS%Bit
ECHO.
ECHO.
ECHO.             %BOX16%
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
"%CD%\DATA\XB2016.EXE"
"%CD%\DATA\%VERSION%.EXE" /CONFIGURE "%CD%\DATA\SETUP.INFO"
DEL "%CD%\DATA\SETUP.INFO" /F /Q
REG QUERY "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\UNINSTALL\O365PROPLUSRETAIL - %LANGUAGE%" /S | FINDSTR "365">NUL||GOTO ERROR2
CLS
ECHO.
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.     Office365 Version %VERSION% %LANGUAGE%%BOX32%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX33%&PAUSE>NUL
EXIT
:MORELANGUAGE
MODE CON COLS=78 LINES=25
CLS
ECHO.
ECHO.
ECHO. ========================Office 365 Downloader V1.7==========================
ECHO.
ECHO.                  Please choose the language of Office365
ECHO.
ECHO.  [1]  Arabic     ar-sa   [13] Hindi      hi-in   [25] Russian    ru-ru
ECHO.  [2]  Bulgarian  bg-bg   [14] Hungarian  hu-hu   [26] Serbian    sr-latn-rs
ECHO.  [3]  Croatian   hr-hr   [15] Indonesian id-id   [27] Slovak     sk-sk
ECHO.  [4]  Czech      cs-cz   [16] Italian    it-it   [28] Slovenian  sl-si
ECHO.  [5]  Danish     da-dk   [17] Kazakh     kk-kh   [29] Spanish    es-es
ECHO.  [6]  Dutch      nl-nl   [18] Latvian    lv-lv   [30] Swedish    sv-se
ECHO.  [7]  Estonian   et-ee   [19] Lithuanian lt-lt   [31] Thai       th-th
ECHO.  [8]  Finnish    fi-fi   [20] Malay      ms-my   [32] Turkish    tr-tr
ECHO.  [9]  French     fr-fr   [21] Norwegian  nb-no   [33] Ukrainian  uk-ua
ECHO.  [10] German     de-de   [22] Polish     pl-pl   [34] Vietnamese vi-vn
ECHO.  [11] Greek      el-gr   [23] Portuguese pt-pt
ECHO.  [12] Hebrew     he-il   [24] Romanian   ro-ro
ECHO.
ECHO. ============================================================================
ECHO.
SET /P C2C=Please enter the number without brackets:
SET LANGUAGE=ar-sa
IF "%C2C%"=="2" SET LANGUAGE=bg-bg
IF "%C2C%"=="3" SET LANGUAGE=hr-hr
IF "%C2C%"=="4" SET LANGUAGE=cs-cz
IF "%C2C%"=="5" SET LANGUAGE=da-dk
IF "%C2C%"=="6" SET LANGUAGE=nl-nl
IF "%C2C%"=="7" SET LANGUAGE=et-ee
IF "%C2C%"=="8" SET LANGUAGE=fi-fi
IF "%C2C%"=="9" SET LANGUAGE=fr-fr
IF "%C2C%"=="10" SET LANGUAGE=de-de
IF "%C2C%"=="11" SET LANGUAGE=el-gr
IF "%C2C%"=="12" SET LANGUAGE=he-il
IF "%C2C%"=="13" SET LANGUAGE=hi-in
IF "%C2C%"=="14" SET LANGUAGE=hu-hu
IF "%C2C%"=="15" SET LANGUAGE=id-id
IF "%C2C%"=="16" SET LANGUAGE=it-it
IF "%C2C%"=="17" SET LANGUAGE=kk-kh
IF "%C2C%"=="18" SET LANGUAGE=lv-lv
IF "%C2C%"=="19" SET LANGUAGE=lt-lt
IF "%C2C%"=="20" SET LANGUAGE=ms-my
IF "%C2C%"=="21" SET LANGUAGE=nb-no
IF "%C2C%"=="22" SET LANGUAGE=pl-pl
IF "%C2C%"=="23" SET LANGUAGE=pt-pt
IF "%C2C%"=="24" SET LANGUAGE=ro-ro
IF "%C2C%"=="25" SET LANGUAGE=ru-ru
IF "%C2C%"=="26" SET LANGUAGE=sr-latn-rs
IF "%C2C%"=="27" SET LANGUAGE=sk-sk
IF "%C2C%"=="28" SET LANGUAGE=sl-si
IF "%C2C%"=="29" SET LANGUAGE=es-es
IF "%C2C%"=="30" SET LANGUAGE=sv-se
IF "%C2C%"=="31" SET LANGUAGE=th-th
IF "%C2C%"=="32" SET LANGUAGE=tr-tr
IF "%C2C%"=="33" SET LANGUAGE=uk-ua
IF "%C2C%"=="34" SET LANGUAGE=vi-vn
MODE CON COLS=52 LINES=20
GOTO CONDOWNLOAD
:DE
RD "%CD%\OFFICE" /Q /S
DEL "%CD%\DATA\DOWNLOAD.INFO" /F /Q
DEL "%CD%\DATA\SETUP.INFO" /F /Q
GOTO DOWNLOAD
:ONLINEINSTALL
CLS
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.            %BOX5%
ECHO.
ECHO.             [1]  %BOX6%  zh-cn
ECHO.             [2]  %BOX7%  zh-tw
ECHO.             [3]  %BOX39%     en-us
ECHO.             [4]  %BOX41%      ko-kr
ECHO.             [5]  %BOX40%    ja-jp
ECHO.             [6]  %BOX38%
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
SET /P C2=%BOX8%
SET LANGUAGE=zh-cn
IF "%C2%"=="2" SET LANGUAGE=zh-tw
IF "%C2%"=="3" SET LANGUAGE=en-us
IF "%C2%"=="4" SET LANGUAGE=ko-kr
IF "%C2%"=="5" SET LANGUAGE=ja-jp
IF "%C2%"=="6" GOTO ONLINEINSTALL_MORELANGUAGE
:CONONLINEINSTALL
CLS
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.            %BOX9%
ECHO.
ECHO.               [1]  32 Bit (X86)
ECHO.
ECHO.               [2]  64 Bit (X64)
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
SET /P C3=%BOX8%
SET WS=32
SET WS2=86
IF "%C3%"=="2" SET WS=64
IF "%C3%"=="2" SET WS2=64
CLS
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.        %BOX24%
ECHO.
ECHO.             [1]  Word
ECHO.             [2]  Excel
ECHO.             [3]  PowerPoint
ECHO.             [4]  Access
ECHO.             [5]  OneNote
ECHO.             [6]  Outlook
ECHO.             [7]  Publisher
ECHO.             [8]  Groove(OneDrive for Business)
ECHO.             [9]  Lync(Skype for Business)
ECHO.             %ECH0%
ECHO.
ECHO.      %BOX25%
ECHO.   %BOX26%
ECHO. ==================================================
SET /P C5= %BOX27%
SET C6=%C5%
SET LENGTH=0
IF NOT DEFINED C5 (
SET ZDY=N
)
:CON2
SET /A LENGTH+=1
SET C5=%C5:~0,-1%
IF DEFINED C5 GOTO CON2
SET /A LENGTH-=1
FOR /L %%Y IN (0,1,%LENGTH%) DO (
SET 1=!C6:~%%Y,1!
IF "!1!"=="1" SET 10=Word
IF "!1!"=="2" SET 11=Excel
IF "!1!"=="3" SET 12=PowerPoint
IF "!1!"=="4" SET 13=Access
IF "!1!"=="5" SET 14=OneNote
IF "!1!"=="6" SET 15=Outlook
IF "!1!"=="7" SET 16=Publisher
IF "!1!"=="8" SET 17=Groove
IF "!1!"=="9" SET 18=Lync
IF "!1!"=="0" SET 19=InfoPath
)
CLS
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.      %BOX11%Office%VERSION%  %LANGUAGE%  %WS%Bit
ECHO.
ECHO.           %BOX28%
FOR /L %%A IN (10,1,19) DO (
IF NOT "!%%A!"=="" ECHO.            !%%A!
)
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX29%&PAUSE>NUL
ECHO ^<Configuration^>>"%CD%\DATA\SETUP.INFO"
ECHO   ^<Add OfficeClientEdition="%WS%" Branch="Current"^>>>"%CD%\DATA\SETUP.INFO"
ECHO     ^<Product ID="O365ProPlusRetail"^>>>"%CD%\DATA\SETUP.INFO"
ECHO       ^<Language ID="%language%" /^>>>"%CD%\DATA\SETUP.INFO"
IF NOT "%ZDY%"=="N" (FOR /L %%A IN (10,1,19) DO (
IF NOT "!%%A!"=="" ECHO       ^<ExcludeApp ID="!%%A!" /^>>>"%CD%\DATA\SETUP.INFO"
)
)
ECHO     ^</Product^>>>"%CD%\DATA\SETUP.INFO"
ECHO   ^</Add^>>>"%CD%\DATA\SETUP.INFO"
ECHO ^</Configuration^>>>"%CD%\DATA\SETUP.INFO"
CLS
ECHO.
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.         %BOX31%Office365 Version %VERSION%
ECHO.
ECHO.
ECHO.                %LANGUAGE% %WS%Bit
ECHO.
ECHO.
ECHO.             %BOX16%
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
"%CD%\DATA\XB2016.EXE"
"%CD%\DATA\%VERSION%.EXE" /CONFIGURE "%CD%\DATA\SETUP.INFO"
DEL "%CD%\DATA\SETUP.INFO" /F /Q
REG QUERY "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\UNINSTALL\O365PROPLUSRETAIL - %LANGUAGE%" /S | FINDSTR "365">NUL||GOTO ERROR2
CLS
ECHO.
ECHO.
ECHO.
ECHO. ============Office 365 Installer V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.     Office365 Version %VERSION% %LANGUAGE%%BOX32%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO.%BOX33%&PAUSE>NUL
EXIT
:ONLINEINSTALL_MORELANGUAGE
MODE CON COLS=78 LINES=25
CLS
ECHO.
ECHO.
ECHO. =========================Office 365 Installer V1.7==========================
ECHO.
ECHO.                  Please choose the language of Office365
ECHO.
ECHO.  [1]  Arabic     ar-sa   [13] Hindi      hi-in   [25] Russian    ru-ru
ECHO.  [2]  Bulgarian  bg-bg   [14] Hungarian  hu-hu   [26] Serbian    sr-latn-rs
ECHO.  [3]  Croatian   hr-hr   [15] Indonesian id-id   [27] Slovak     sk-sk
ECHO.  [4]  Czech      cs-cz   [16] Italian    it-it   [28] Slovenian  sl-si
ECHO.  [5]  Danish     da-dk   [17] Kazakh     kk-kh   [29] Spanish    es-es
ECHO.  [6]  Dutch      nl-nl   [18] Latvian    lv-lv   [30] Swedish    sv-se
ECHO.  [7]  Estonian   et-ee   [19] Lithuanian lt-lt   [31] Thai       th-th
ECHO.  [8]  Finnish    fi-fi   [20] Malay      ms-my   [32] Turkish    tr-tr
ECHO.  [9]  French     fr-fr   [21] Norwegian  nb-no   [33] Ukrainian  uk-ua
ECHO.  [10] German     de-de   [22] Polish     pl-pl   [34] Vietnamese vi-vn
ECHO.  [11] Greek      el-gr   [23] Portuguese pt-pt
ECHO.  [12] Hebrew     he-il   [24] Romanian   ro-ro
ECHO.
ECHO. ============================================================================
ECHO.
SET /P C2C=Please enter the number without brackets:
SET LANGUAGE=ar-sa
IF "%C2C%"=="2" SET LANGUAGE=bg-bg
IF "%C2C%"=="3" SET LANGUAGE=hr-hr
IF "%C2C%"=="4" SET LANGUAGE=cs-cz
IF "%C2C%"=="5" SET LANGUAGE=da-dk
IF "%C2C%"=="6" SET LANGUAGE=nl-nl
IF "%C2C%"=="7" SET LANGUAGE=et-ee
IF "%C2C%"=="8" SET LANGUAGE=fi-fi
IF "%C2C%"=="9" SET LANGUAGE=fr-fr
IF "%C2C%"=="10" SET LANGUAGE=de-de
IF "%C2C%"=="11" SET LANGUAGE=el-gr
IF "%C2C%"=="12" SET LANGUAGE=he-il
IF "%C2C%"=="13" SET LANGUAGE=hi-in
IF "%C2C%"=="14" SET LANGUAGE=hu-hu
IF "%C2C%"=="15" SET LANGUAGE=id-id
IF "%C2C%"=="16" SET LANGUAGE=it-it
IF "%C2C%"=="17" SET LANGUAGE=kk-kh
IF "%C2C%"=="18" SET LANGUAGE=lv-lv
IF "%C2C%"=="19" SET LANGUAGE=lt-lt
IF "%C2C%"=="20" SET LANGUAGE=ms-my
IF "%C2C%"=="21" SET LANGUAGE=nb-no
IF "%C2C%"=="22" SET LANGUAGE=pl-pl
IF "%C2C%"=="23" SET LANGUAGE=pt-pt
IF "%C2C%"=="24" SET LANGUAGE=ro-ro
IF "%C2C%"=="25" SET LANGUAGE=ru-ru
IF "%C2C%"=="26" SET LANGUAGE=sr-latn-rs
IF "%C2C%"=="27" SET LANGUAGE=sk-sk
IF "%C2C%"=="28" SET LANGUAGE=sl-si
IF "%C2C%"=="29" SET LANGUAGE=es-es
IF "%C2C%"=="30" SET LANGUAGE=sv-se
IF "%C2C%"=="31" SET LANGUAGE=th-th
IF "%C2C%"=="32" SET LANGUAGE=tr-tr
IF "%C2C%"=="33" SET LANGUAGE=uk-ua
IF "%C2C%"=="34" SET LANGUAGE=vi-vn
MODE CON COLS=52 LINES=20
GOTO CONONLINEINSTALL
:ERROR0
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.           %BOX34%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO. %BOX33%&PAUSE>NUL
EXIT
:ERROR
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.               %BOX35%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO. %BOX33%&PAUSE>NUL
EXIT
:ERROR2
CLS
ECHO.
ECHO.
ECHO. ===========Office 365 Downloader V1.7=============
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.         %BOX37%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. ==================================================
ECHO.
ECHO. %BOX33%&PAUSE>NUL
EXIT