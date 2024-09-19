#!/bin/sh
#clear
echo "========================="
echo "      srvft01            "
echo "========================="
#PASO01
echo "dd" > nombre_fecha.temp ; date >> nombre_fecha.temp
awk 'BEGIN { ARGC = 2 ; ARGV[1] = "nombre_fecha.temp"
             RS = "" }
           { print FNR " " NR " " $2 " " $3 " " $4 " " $5, $6, $7 } ' > nombre_fechaa.temp
awk '$1=$1' nombre_fechaa.temp  > nombre_fechab.temp
sed 's/1 1 /*/g' nombre_fechab.temp > nombre_fechac.temp
awk -v nuevo_valor="srvft01   " 'BEGIN{FS=OFS="*"}{$1=nuevo_valor}1'  nombre_fechac.temp   > paso01_srvft01_fecha.txt
rm nombre_fe*.temp
