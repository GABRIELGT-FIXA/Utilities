@echo off
echo Por: Gabriel Servo | ver.: 2.0
@REM Ativar e colocar senha em admin
color fd


:menu
echo Menu de opcoes ---- Suporte tecnico -----
echo por: Gabriel Servo
echo.
echo.
echo 1 - Resetar as configuracoes do Winsock
echo 2 - Liberar o endereco IP atual atribuido ao computador (Somente em IP Dinamico)
echo 3 - Executar Limpeza de arquivos temporarios
echo 4 - Executar Limpeza de disco
echo 5 - Reparo de imagem Windows (DISM)
echo 6 - Reset do Windows Update (Requer reinicializacao)
echo 7 - Atualizacao de politicas de grupo (GPO)
echo 8 - Limpar log de eventos
echo 9 - Exibir informacoes do sistema (MsInfo)
echo 10 - Gerenciamento do Computador
echo 11 - Visualizar configuracoes de IP
echo 12 - Exibir programas instalados
echo 13 - Exibir serviços
echo 0 - Reiniciar PC

set /p choice="Digite sua escolha (1-12): "
if "%choice%"=="1" goto SFCscan
if "%choice%"=="2" goto resetarIP
if "%choice%"=="3" goto temporarios
if "%choice%"=="4" goto discoClean
if "%choice%"=="5" goto DISMrestore
if "%choice%"=="6" goto updateReset
if "%choice%"=="7" goto gpo
if "%choice%"=="8" goto event
if "%choice%"=="9" goto informacoes
if "%choice%"=="10" goto manageComputer
if "%choice%"=="11" goto confIP
if "%choice%"=="12" goto programas
if "%choice%"=="13" goto servicos
if "%choice%"=="0" goto restart


echo.
echo.
echo Entrada invalida!
set /a count=3

:countdown
if %count% lss 1 goto end
echo Tente novamente em: %count%
set /a count=%count%-1
timeout /t 1 > nul
goto countdown

:end
cls
goto menu



:SFCscan
cls
sfc /scannow
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu

:resetarIP
cls
ipconfig /release
ipconfig /renew
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu


:temporarios
cls
del /q/f/s %temp%\*
del /q/f/s C:\Windows\Temp\*
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls
goto menu



:discoClean
cls
cleanmgr /sageset:1
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls
goto menu



:DISMrestore
cls
dism /online /cleanup-image /restorehealth
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls
goto menu



:updateReset
cls
echo Parando servicos do Windows Update
net stop wuauserv
net stop bits
net stop cryptsvc

echo Excluir os arquivos da pasta SoftwareDistribution
del /f /s /q %windir%\SoftwareDistribution\*.* 

echo Excluir arquivos da pasta catroot2
del /f /s /q %windir%\system32\catroot2\*.* 

echo Forcar o Windows Update a buscar atualizaçoes
wuauclt /detectnow

echo Reparando arquivos do sistema
dism /online /cleanup-image /restorehealth
sfc /scannow
echo Reparo concluido

shutdown -r -t 0
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu


:gpo
cls
gpupdate /force
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu

:event
cls
wevtutil.exe cl Application
wevtutil.exe cl System
wevtutil.exe cl Security
wevtutil.exe cl Setup
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu

:informacoes
cls
msinfo32
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu

:manageComputer
cls
compmgmt.msc
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls

goto menu

:restart
shutdown /r /t 0
exit

:confIP
cls
ipconfig

echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls
goto menu

:programas 
cls
wmic product get name
echo.
echo.
echo.
echo.
echo.
echo Pressione enter para voltar para o Menu: 
pause > nul
echo.
echo.
echo.
echo.
echo.
cls
goto menu

:servicos
cls

