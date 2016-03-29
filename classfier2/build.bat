:loop
@cls
if exist bin\info.exe del /F bin\info.exe
@gprbuild main.gpr -p

@pause
goto loop

@if exist bin\info.exe (
  cd bin
  info.exe D.csv
  cd ..
) else (
  echo "No info.exe try again?"
)

@pause
goto loop
