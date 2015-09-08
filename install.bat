@echo off 
setlocal
rename C:\vim\vimrc vimrc_back
set dir=%~dp0
mklink C:\vim\vimrc %dir%\.vimrc
mklink C:\vim\_gvimrc %dir%\_gvimrc
mklink /D C:\vim\vimfiles %dir%\vimfiles
