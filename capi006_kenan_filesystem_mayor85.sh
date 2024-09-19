#!/bin/sh
clear
#servidores de KENAN
#cd /home/j2padm/adminbasic/
grep -e "Kb 85 %" -e "Kb 86 %" -e "Kb 87 %" -e "Kb 88 %" -e "Kb 89 %" -e "Kb 90 %" -e "Kb 91 %" -e "Kb 92 %" -e "Kb 93 %" -e "Kb 94 %" -e "Kb 95 %" -e "Kb 96 %" -e "Kb 97 %" -e "Kb 98 %" -e "Kb 99 %"  salida_kenan_seleccion_mayor85.txt  > salida_kenan_mayor85.txt

cont1=`cat salida_kenan_mayor85.txt | wc -l`
#echo "$cont1"
    if [ $cont1 -ne 0 ]; then
awk '$1=$1' salida_kenan_mayor85.txt > salfs01.temp
sed 's/ )/)/g' salfs01.temp    > salfs02.temp
sed 's/ %/%/g' salfs02.temp  | sort > salfs03.temp
awk 'BEGIN { print "Servidor                                                     filesystem             Porcentaje"
             print "--------                                                     ----------             ----------" }
             { printf "%-10s %60s %20s\n",$1, $2, $9 }' salfs03.temp
#rm salfs0*.temp

echo ""
echo "  #####  FILESYSTEM MAYORES A 85% REVISAR ...  ##### "
  else
echo ""
echo "  #####  FILESYSTEM ESTABLES ............ ...  ##### "
echo ""
    fi
rm salfs0*.temp

