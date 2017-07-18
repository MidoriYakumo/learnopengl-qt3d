hostname > Publisher.obj
set /p Publisher=<Publisher.obj
del *.obj *.cpp *.appx
windeployqt.exe -qmldir qml learnopengl-qt3d.exe
MakeAppx.exe pack /o /d . /p learnopengl-qt3d.appx
MakeCert.exe /n "CN=%Publisher%" /len 2048 /r /sv key.pvk key.cer
pvk2pfx.exe /f /pvk key.pvk /pi password /spc key.cer /pfx key.pfx
SignTool.exe sign /fd SHA256 /a /f key.pfx /p password learnopengl-qt3d.appx
