:loop
@gnatmake -Pmain
cd bin
@main.exe
@cd..
@echo Do you want to compile again?
@pause
goto loop

