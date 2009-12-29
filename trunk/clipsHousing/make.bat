@ECHO off
DIR  . 

cd protege

TYPE  AIProject2pprj.pins > ../ai2KBS.clp
echo (definstances ai2KBSinstances>> ../ai2KBS.clp
TYPE  AIProject2pprj.pont >> ../ai2KBS.clp
echo ) >> ../ai2KBS.clp

cd ..

PAUSE
