@echo on

set CLIPSDIR=C:\Progra~1/CLIPS/BIN

call make

%CLIPSDIR%/CLIPSDOS.exe -f init.clp
