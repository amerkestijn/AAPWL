#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SleepTime:=1*60*1000 ; this is 1 minutes, since sleep param is in milliseconds
Loop ; run forever - stop it via right-click on tray icon, then Exit
{
  ; Stop the auto-update service in Windows 10
  RunWait,sc stop "wuauserv",,hide
  RunWait,sc stop "WaaSMedicSvc",,hide
  Sleep,%SleepTime%
}
