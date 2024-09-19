#!/bin/sh
###########
#servidores de KENAN
############
awk '$1=$1' salida_kenan_seleccion_fecha.txt  > salfecha01.temp
sed 's/ )/)/g' salfecha01.temp    > salfecha02.temp
sed 's/ %/%/g' salfecha02.temp  | sort > salfecha03.temp
awk 'BEGIN { print "Servidor              FECHA             Hora"
             print "--------              -----             ---- "     }
             { printf "%-10s %10s %3s %3s %15s \n",$1, $4, $3, $7, $5 }' salfecha03.temp
rm salfecha*.temp
