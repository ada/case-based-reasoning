@cls
::@echo ==========Normalize==========
::@normalize.exe -mm db.csv -o dbn.csv
::@normalize.exe -mm db.csv -data s.csv -o sn.csv


::@echo ==========Informaion==========
::@echo:
::@info.exe db.csv
::@echo:

::@echo ==========Distance==========
::@echo:
::@distance.exe -db dbn.csv -s sn.csv -d manhattan -w 1.0 1.0
::@distance.exe -db dbn.csv -s sn.csv -d manhattan -w 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.0 -o d.csv

::@echo ==========K-Sort==========
::@echo:


@distance.exe -db dbn.csv -s sn.csv -d canberra -w 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.0 -o d.csv
@ksort.exe -d d.csv -k 10 -put

@distance.exe -db dbn.csv -s sn.csv -d canberra -w 1.0 1.0 1.0 1.0 0.0 1.0 1.0 0.0 -o d.csv
@ksort.exe -d d.csv -k 10 -put
