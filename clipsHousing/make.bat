@ECHO off

cd protege2

TYPE  Housing.pont > ../ai2KBS.clp
echo (definstances ai2KBSinstances>> ../ai2KBS.clp
TYPE  Housing.pins >> ../ai2KBS.clp
echo ) >> ../ai2KBS.clp

cd ..
