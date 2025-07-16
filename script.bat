:: Script de automação de Deploy Windows
:: Criado por Gabriel Servo | Versão 1.0
:: Obs.: Algumas funcionalidades só funcionarão corretamente caso o caminho e o programa existam, esse é só um demonstrativo.


@echo off
echo Por: Gabriel Servo | ver.: 1.0


:: Ativar e colocar senha em admin
net user administrador senha /Active:YES

::criar usuario comum
net user usuario senha

:: xml para importação de rede Wi-Fi
@REM netsh wlan add profile filename="C:\temp\redexml\INSIRA_SEU_XML_AQUI"



::menu de selecao
:menu
echo 1 - Copiar atalhos
echo 2 - Instalar programas
echo 3 - Adicionar descricao 3
echo 4 - Adicionar descricao 4
echo 5 - Office 2013
echo 6 - Office 365
echo 7 - Inserir no dominio
echo 8 - Criar usuário
echo 9 - Adicionar descricao 9
echo 10 - Adicionar descricao 10
echo 0 - Sair (Sair vai apagar todos os arquivos da pasta temp)


:: Menu interativo
set /p choice="Digite sua escolha (1-7): "
if "%choice%"=="1" goto atalhos
if "%choice%"=="2" goto programas
if "%choice%"=="3" goto opcao3
if "%choice%"=="4" goto opcao4
if "%choice%"=="5" goto Office2013
if "%choice%"=="6" goto Office365
if "%choice%"=="7" goto dominio
if "%choice%"=="8" goto osklen
if "%choice%"=="0" goto sair
if "%choice%"=="9" goto opcao9
if "%choice%"=="10" goto opcao10

echo Opcao invalida. Tente novamente.
goto menu

::Copia de atalhos para a pasta public (Faz com que novos usuários sejam criados com os atalhos predefinidos)
:atalhos
robocopy C:\temp\atalhos C:\users\public\desktop /E
goto menu


::Instalação de programas (Utilizando MSI)
:: Baixe o instalador MSI, mova para a pasta e insira o caminho\arquivo.msi /passive
:programas
msiexec /i "caminho_do_programa\programa.msi" /passive
msiexec /i "caminho_do_programa\programa.msi" /passive
msiexec /i "caminho_do_programa\programa.msi" /passive
msiexec /i "caminho_do_programa\programa.msi" /passive
msiexec /i "caminho_do_programa\programa.msi" /passive
msiexec /i "caminho_do_programa\programa.msi" /passive

goto menu


:opcao3

:: insira aqui o seu script

goto menu



:opcao4

:: insira aqui o seu script

goto menu



:Office365
::exemplo de script de instalacao de office 365
cd C:\temp\programas\
start OfficeSetup.exe
goto menu


:dominio
set /p novohostname="Digite o novo Hostname: "
powershell -Command "Add-Computer -DomainName 'seudominio.local' -NewName '%novohostname%' -Restart"
shutdown /r /t 0
goto menu

:usuario
:: Essa funcao cria um usuario. A linha abaixo define o usuario e senha criados, basta modificar
net user usuario senha /add
set /p reiniciar="Deseja reiniciar a máquina? (s) ou (n): "
if "%reiniciar%"=="s" goto restart
goto menu

:opcao 9

:: insira aqui o seu script

goto menu

:opcao 10

:: insira aqui o seu script


goto menu

:restart
shutdown /r /t 0
exit


:sair
rmdir /s /q "C:\temp"
exit
