#!/usr/bin/sh
#########################
#servidor de SRVFT01
#PASO01
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
clear
DIRS=/appl/kbpp01/utils/Menu/doc013031/FACTU/
RUTINA_FILESYS_SRVFT01() {
df -k /                    >> salidat_1.temp
df -k /tmp                 >> salidat_1.temp
df -k /home                >> salidat_1.temp
df -k /opt                 >> salidat_1.temp
df -k /usr                 >> salidat_1.temp
df -k /var                 >> salidat_1.temp
df -k /stand               >> salidat_1.temp
df -k /patrol              >> salidat_1.temp
df -k /prg/kbpp01          >> salidat_1.temp
df -k /oracle/agent        >> salidat_1.temp
df -k /var/adm/crash       >> salidat_1.temp
df -k /usr/local/cchft01   >> salidat_1.temp
df -k /usr/local/ctmft01   >> salidat_1.temp
grep '/' salidat_1.temp     > salidat_2.temp
grep '%' salidat_1.temp     > salidat_3.temp
sed -e 's/)/  )/' salidat_2.temp    > salidat_4.temp
awk 'NR==FNR { a[FNR]=$0; next } (FNR in a) { print FNR, a[FNR], $1,$2,$3,$4,$5 }' salidat_4.temp   salidat_3.temp    > salidat_5.temp
cat salidat_5.temp  | awk '{printf "%+30s %4d %-10s\n", $2, $10, $11}' | sort >  salidat_6.temp
sed '/oracle/d' salidat_6.temp  >  $DIRS/paso01_ccc_srvft01_pirami.txt
}
RUTINA_FILESYS_SRVFT01

#PASO02
awk -v nuevo_valor="SRVFT01   " 'BEGIN{FS=OFS="/"}{$1=nuevo_valor}1' salidat_5.temp > salidat_7.temp
sed '/oracle/d' salidat_7.temp   > salidat_8.temp
sed '/hosting/d' salidat_8.temp  > $DIRS/paso02_ccc_srvft01_mayor85.txt
rm salidat_*.temp

#PASO03
echo "dd" > nombre_fecha.temp ; date >> nombre_fecha.temp
awk 'BEGIN { ARGC = 2 ; ARGV[1] = "nombre_fecha.temp"
             RS = "" }
           { print FNR " " NR " " $2 " " $3 " " $4 " " $5, $6, $7 } ' > nombre_fechaa.temp
awk '$1=$1' nombre_fechaa.temp  > nombre_fechab.temp
sed 's/1 1 /*/g' nombre_fechab.temp > nombre_fechac.temp
awk -v nuevo_valor="SRVFT01   " 'BEGIN{FS=OFS="*"}{$1=nuevo_valor}1'  nombre_fechac.temp   > paso03_ccc_srvft01_fecha.txt
#cat paso03_ccc_srvft01_fecha.txt > salida_kenan_seleccion_fecha.txt
rm nombre_fe*.temp


#########################
#servidor de SRVFT02-SRVFT03-SRVFT04-SRVFT05 
#rm paso01_ccc_*.txt 
#DIR=/home/kbpp01/adminfac
#DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU/
#USERNAME=kbpp01
#HOSTS="161.196.11.143 161.196.11.144 161.196.11.145 161.196.11.146 "
#SCRIPT="$DIR/./piram.sh"
#for HOSTNAME in ${HOSTS} ; do
#    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"  
#    done
#        scp kbpp01@srvft02:$DIR/paso01_ccc_srvft02_pirami.txt $DIR2
#	scp kbpp01@srvft02:$DIR/paso02_ccc_srvft02_mayor85.txt $DIR2
#        scp kbpp01@srvft02:$DIR/paso03_ccc_srvft02_fecha.txt $DIR2
#  
#        scp kbpp01@srvft03:$DIR/paso01_ccc_srvft03_pirami.txt $DIR2
#        scp kbpp01@srvft03:$DIR/paso02_ccc_srvft03_mayor85.txt $DIR2
#        scp kbpp01@srvft03:$DIR/paso03_ccc_srvft03_fecha.txt $DIR2
#
#        scp kbpp01@srvft04:$DIR/paso01_ccc_srvft04_pirami.txt $DIR2
#        scp kbpp01@srvft04:$DIR/paso02_ccc_srvft04_mayor85.txt $DIR2
#        scp kbpp01@srvft04:$DIR/paso03_ccc_srvft04_fecha.txt $DIR2
#        
#        scp kbpp01@srvft05:$DIR/paso01_ccc_srvft05_pirami.txt $DIR2
#        scp kbpp01@srvft05:$DIR/paso02_ccc_srvft05_mayor85.txt $DIR2
#        scp kbpp01@srvft05:$DIR/paso03_ccc_srvft05_fecha.txt $DIR2



#cat paso01_ccc_srvft01_pirami.txt paso01_ccc_srvft02_pirami.txt paso01_ccc_srvft03_pirami.txt paso01_ccc_srvft04_pirami.txt paso01_ccc_srvft05_pirami.txt  > salida_kenan_seleccion_pirami.txt
#cat paso02_ccc_srvft01_mayor85.txt paso02_ccc_srvft02_mayor85.txt paso02_ccc_srvft03_mayor85.txt paso02_ccc_srvft04_mayor85.txt paso02_ccc_srvft05_mayor85.txt  > salida_kenan_seleccion_mayor85.txt
#cat paso03_ccc_srvft01_fecha.txt paso03_ccc_srvft02_fecha.txt paso03_ccc_srvft03_fecha.txt paso03_ccc_srvft04_fecha.txt  paso03_ccc_srvft05_fecha.txt  > salida_kenan_seleccion_fecha.txt

##rm paso*_ccc_*.txt



#########################
#servidor de SRVFT20
#rm paso01_ccc_*.txt
DIR=/appl/appadm
DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU/
USERNAME=appadm
HOSTS="161.196.11.181 "
SCRIPT="$DIR/./piram.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"
    done

        scp appadm@srvft20:$DIR/paso01_ccc_srvft20_pirami.txt $DIR2
        scp appadm@srvft20:$DIR/paso02_ccc_srvft20_mayor85.txt $DIR2
        scp appadm@srvft20:$DIR/paso03_ccc_srvft20_fecha.txt $DIR2
        scp appadm@srvft20:$DIR/salida_kenan_seleccion_kdm.txt $DIR2
 

cat paso01_ccc_srvft20_pirami.txt  >> salida_kenan_seleccion_pirami.txt
cat paso02_ccc_srvft20_mayor85.txt >> salida_kenan_seleccion_mayor85.txt
cat paso03_ccc_srvft20_fecha.txt   >> salida_kenan_seleccion_fecha.txt

#########################
#servidor de SRVFT30-SRVFT31
DIR=/appl/ddfp01/ScriptsBF 
DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU
USERNAME=ddfp01
HOSTS="161.196.11.194 161.196.11.195 "
SCRIPT="$DIR/./piram.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"
    done

        scp ddfp01@srvft30:$DIR/paso01_ccc_srvft30_pirami.txt $DIR2
        scp ddfp01@srvft30:$DIR/paso02_ccc_srvft30_mayor85.txt $DIR2
        scp ddfp01@srvft30:$DIR/paso03_ccc_srvft30_fecha.txt $DIR2

        scp ddfp01@srvft31:$DIR/paso01_ccc_srvft31_pirami.txt $DIR2
        scp ddfp01@srvft31:$DIR/paso02_ccc_srvft31_mayor85.txt $DIR2
        scp ddfp01@srvft31:$DIR/paso03_ccc_srvft31_fecha.txt $DIR2


cat paso01_ccc_srvft30_pirami.txt paso01_ccc_srvft31_pirami.txt  >> salida_kenan_seleccion_pirami.txt
cat paso02_ccc_srvft30_mayor85.txt paso02_ccc_srvft31_mayor85.txt  >> salida_kenan_seleccion_mayor85.txt
cat paso03_ccc_srvft30_fecha.txt paso03_ccc_srvft31_fecha.txt   >> salida_kenan_seleccion_fecha.txt


#########################
#servidor de SRVFT25
DIR=/appl/appadm/adminfac
DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU/
USERNAME=appadm
HOSTS="161.196.189.184 "
SCRIPT="$DIR/./piram.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"
    done

        scp appadm@srvft25:$DIR/paso01_ccc_srvft25_pirami.txt $DIR2
        scp appadm@srvft25:$DIR/paso02_ccc_srvft25_mayor85.txt $DIR2
        scp appadm@srvft25:$DIR/paso03_ccc_srvft25_fecha.txt $DIR2


cat paso01_ccc_srvft25_pirami.txt   >> salida_kenan_seleccion_pirami.txt
cat paso02_ccc_srvft25_mayor85.txt  >> salida_kenan_seleccion_mayor85.txt
cat paso03_ccc_srvft25_fecha.txt    >> salida_kenan_seleccion_fecha.txt


#########################
#Nota Este esta Ejecutando uno aparte del que se encuentra en el directorio FACTU51
#servidor de SRVFT51
DIR=/appl/kbpp01/utils/Menu/doc013031/
DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU
USERNAME=kbpp01
HOSTS="161.196.11.198 "
SCRIPT="$DIR/./piram.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"
    done

        scp kbpp01@srvft51:$DIR/paso01_ccc_srvft51_pirami.txt $DIR2
        scp kbpp01@srvft51:$DIR/paso02_ccc_srvft51_mayor85.txt $DIR2
        scp kbpp01@srvft51:$DIR/paso03_ccc_srvft51_fecha.txt $DIR2


cat paso01_ccc_srvft51_pirami.txt   >> salida_kenan_seleccion_pirami.txt
cat paso02_ccc_srvft51_mayor85.txt  >> salida_kenan_seleccion_mayor85.txt
cat paso03_ccc_srvft51_fecha.txt    >> salida_kenan_seleccion_fecha.txt


