@echo off
cd /d %~dp0


echo ====================================
echo Demarrage du serveur nom
echo ====================================

REM Remplacez le chemin ci-dessous par le chemin correct vers votre FXServer.exe
"C:\FXServeur\FXServer.exe" +exec server.cfg

pause