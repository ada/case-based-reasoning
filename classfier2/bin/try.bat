@cls
@normalize.exe db.csv db.csv
@normalize.exe db.csv s.csv s.csv

@echo ==========Informaion==========
@echo:
::@info.exe db.csv
::@echo:

@echo ==========Distance==========
@echo:
::@distance.exe db.csv s.csv manhattan
@distance.exe db.csv s.csv canberra d.csv

@echo ==========K-Sort==========
@echo:
@ksort.exe d.csv 100
@ksort.exe d.csv 100 p.csv
@echo:

@echo ==========Evaluation==========
@echo:
@eval.exe p.csv s.csv