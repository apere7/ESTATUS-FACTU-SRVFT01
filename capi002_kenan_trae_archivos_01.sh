#!/bin/sh
###########
# Con esto consulto los -noxwin de los dos servidores 30 y 31 
# Para la revision que no tengan DEFUCTION O DOS -NOXWIN    
DIR=/appl/ddfp01/ScriptsBF
DIR2=/appl/kbpp01/utils/Menu/doc013031/FACTU/
USERNAME=ddfp01 
HOSTS="161.196.11.194 161.196.11.195"
SCRIPT="$DIR/chequeoDF.sh"
echo "-------------------------------------"
echo " Proceso que realiza la Ejecucion del job:chequeoDF.sh"
echo " En los servidores: srvft30 y servft31"
echo " Luego Envia la salida en archivos hacia el srvft01"
echo " FS_30.txt "                # Filesystem de srvft30"
echo " FS_31.txt "                # Filesystem de srvft31"
echo " servicio30OK.txt           #Servicios  OK del srvft30"
echo " servicio30NOK.txt          #Servicios NOK del srvft30"
echo " servicio31OK.txt           #Servicios  OK del srvft31"
echo " servicio31NOK.txt          #Servicios NOK del srvft31"
echo "-------------------------------------"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}  "${SCRIPT}"  
done
scp ddfp01@srvft30:$DIR/*3*.txt $DIR2
scp ddfp01@srvft31:$DIR/*3*.txt $DIR2
