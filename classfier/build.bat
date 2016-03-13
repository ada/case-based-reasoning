:loop
@cls
if exist bin\main.exe del /F bin\main.exe
@gprbuild main.gpr -p
@if exist bin\main.exe (
  cd bin
  :: <Distance> <Asset_Count_Max> <Class_Count> <Class_File_Name> <Dimension_Count> <Dimension_File_Names...> <Weights...> <Sample_Count> <Sample_Index...>
  main.exe Euclidean2 20 2 R.csv 3 AN.csv BN.csv CN.csv 0.0 0.0 0.0 3 5 6 7
  cd ..
) else (
  echo "No main.exe try again?"
)

@pause
goto loop
