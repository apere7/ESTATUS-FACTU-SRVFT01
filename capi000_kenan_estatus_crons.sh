#!/usr/bin/sh
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
#----------------------------
#   Rutinas 
#----------------------------
R=`pwd`
DIA=`date '+%d/%m/20%y'`; HORA=`date '+%H:%M:%S'`
ANO=`date '+20%y'`
MES=`date '+%m'`
Hora=$(date +%r)
SER=`uname -a | awk '{print $2}'`
CRO03=/appl/kbpp01/utils/Menu/doc013031/FACTU/

RUTINA_MENSAJE () {
    echo " "
    echo " "
    echo ""
    echo " Administracion de Plataformas Integradas                                                                        Ruta  :   $R "
    echo " Gerencia Sistema de Gestion Empresarial                                                                         Fecha :   $DIA "
    echo " Gerencia de Ingenieria, desarrollo y Construccion TI/SI                                                         Hora  :   $Hora "
    echo " Gerencia General de Tecnologia y Operaciones                                                                    Servidor: $SER "
    echo ""
    echo "===================================="
    echo "  ESTATUS DIARIO ADMINFACT          "
    echo "===================================="
}

#-----------------------
echo "#-----------------------------------#"
echo "#   lIMPIA ARCHIVO                  #"
echo "#-----------------------------------#"
$CRON03./capi001_kenan_limpiaken.sh
echo " "


#-------------------------
RUTINA_LTP() {
              valor=`ps -fu kbpltp| grep LTP |wc -l`
              if [ "$valor" = 9 ]; then
                 ps -fu kbpltp| grep LTP
                 echo "Status LTP = OPERATIVO OK"
              fi
}



#--------------------------
RUTINA_PING () {
cont=0
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
/usr/sbin/ping $servidor -n 6 | awk '{print $6}' > time_"$servidor".txt
                for linea in $(cat time_"$servidor".txt)
                do
                 if [ "$linea" = "time=0." ] || [ "$linea" = "time=1." ] || [ "$linea" = "time=2."  ] || [ "$linea" = "time=3." ] ||
                    [ "$linea" = "time=4." ] || [ "$linea" = "time=5." ] || [ "$linea" = "time=6."  ] || [ "$linea" = "time=7." ] ||
                    [ "$linea" = "time=8." ] || [ "$linea" = "time=9." ] || [ "$linea" = "time=10." ] ; then
                      cont=`expr $cont + 1`
                 fi
                done
                if [ "$cont" = 6  ]; then
                   echo "Tiempo de Respuesta Servidor " $servidor "OK"
                   else
                   echo "Tiempo de Respuesta Servidor " $servidor "NOT OK"
                fi
}
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
for servidor in $(cat ccapi_kenan_entrada_servidores.txt)
    do
	RUTINA_PING $servidor >> salida_kenan_seleccion_ping.txt
    done
rm time_*.txt

grep "NOT OK" salida_kenan_seleccion_ping.txt  > pingnok.temp
cat pingnok.temp > pingnok_mensual.temp

cont1=`cat pingnok.temp | wc -l`
#echo "$cont1 "
if  [ $cont1 -gt 0 ];    #si es mayor que
    then
       echo "#####                               #####                              ##### "
       echo "#####      ATENCION:  Se debe chequear ya que existe Servidores Caidos ##### "
       cat pingnok.temp
       cat pingnok_mensual.temp  | xargs -n1 -i sh -c 'echo `date +%Y-%m-%d\ %H-%M-%S`" {}"'  >> muestra_salida_historico_ping_kenan_mensual.txt
       #mailx -s "EXISTEN SERVIDORES CAIDOS EN KENAN $DIA "  alejo24175@gmail.com fritne23@gmail.com < pingnok.temp
       mailx -s "EXISTEN SERVIDORES CAIDOS EN KENAN $DIA "  alejo24175@gmail.com  < pingnok.temp
    else
       echo " "
       echo "           #####          PING  SERVIDORES ACTIVOS  ...   ##### "
fi



#-----------------------
echo ""
echo "*-----------------------------------*"
echo "*  Reportes 30 y 31                 "
echo "*-----------------------------------*"
echo ""
#/appl/kbpp01/utils/Menu/doc013031/./conectar.sh
/appl/kbpp01/utils/Menu/doc013031/FACTU/./capi002_kenan_trae_archivos_01.sh
echo ""


#-----------------------
echo "#-----------------------------------#"
echo "#   conexion para fechas            #"
echo "#-----------------------------------#"
#rm paso*_ccc_*.txt
#./conecta_trae.sh
./capi003_kenan_trae_archivos_02.sh
echo ""


#---------------------
# Saludos segun hora #
#---------------------
hora=`date +%R | cut -d ':' -f 1`
if [ $hora -ge 1 -a $hora -lt 12 ]
    then
       var1sa="Buenos Dias"
    elif [ $hora -ge 12 -a $hora -lt 18 ]
         then
       var1sa="Buenas Tardes"
    else
       var1sa="Buenas Noches"
fi


#####-------------------------------
RUTINA_IMPRESION () {

#-------------------------
echo "$var1sa"
#echo "Buenos Dias"
echo "Se Anexa Estatus Diario Adminfac"
echo "Saludos Cordiales"
echo "                      Adminfac Estatus Diario"


#-----------------------
echo ""
titulo="SECURITY SERVER "
echo "*-----------------------------------*"
echo "*  "$titulo"                        "
echo "*-----------------------------------*"
cd ../.. ; ./check_security_server.sh
echo " "

#-----------------------
echo ""
titulo="TUXEDO/MIDDELWARE "
echo "*-----------------------------------*"
echo "*  "$titulo"                       "
echo "*-----------------------------------*"
echo ""
#cd ../.. ; ./check_middleware.sh
./check_middleware.sh
#./capi005_kenan_check_middleware.sh
echo " "
#Regresa al directorio donde estan los Otros Script
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/

#---------------------
titulo="KENAN LTP"
echo ""
echo "*----------------------------------*"
echo "*        " $titulo "               "
echo "*----------------------------------*"
RUTINA_LTP
echo " "

#-----------------------
echo "#-----------------------------------#"
echo "#   FILESYSTEM Mayores a 85%        #"
echo "#-----------------------------------#"
#./muestra_file_kenan_mayor85.sh
./capi006_kenan_filesystem_mayor85.sh
echo ""

#------------------------
echo ""
titulo="PING SERVIDORES 11"
echo "*----------------------------------*"
echo "* "$titulo"			"
echo "*----------------------------------*"
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
cat salida_kenan_seleccion_ping.txt
#cat salida_ping_pagweb.txt
###cd /appl/kbpp01/utils/Menu/doc013031/./pingall_kenan_conif.sh 
echo " "

#-----------------------
echo "#-----------------------------------#"
echo "#   Fecha y Hora Servidores 10      #"
echo "#-----------------------------------#"
#./muestra_file_kenan_fecha.sh
./capi007_kenan_fecha_serv.sh
echo ""

#-----------------------
echo ""
titulo="Estado Base de Datos 7"
echo "*---------------------------------------------*"
echo "* "                     $titulo "              "
echo "INSTANCE_NAME      STATUS       DATABASE_STATUS"
echo "*---------------------------------------------*"
#/appl/kbpp01/utils/Menu/doc013031/./BD_STATUS_CRON.sh
#cat kp01.temp
/appl/kbpp01/utils/Menu/doc013031/FACTU/./capi008_kenan_bdatos.sh
#cat kp01.temp
cat salida_kenan_seleccion_bd.txt
echo ""
echo ""

#-----------------------
echo ""
titulo="DATA FLOW (SRVFT30) 5 "
echo "*----------------------------------*"
echo "*           " $titulo "            "
echo "*----------------------------------*"
echo ""
date;
if  [ -s servicio30OK.txt ]  ; then
           echo "Instancias (ddfp01, ddfp02, ddfp03, ddfp04, ddfp05 y ddfp06)"
           echo "Servicios y Aplicativos Operativa 100%"
                 cat servicio31OK.txt
   else
           echo "Existen ERRORES en los servicios REVISAR y no enviar Correo "
           echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
           echo "*                                                     *"
           echo "*                                                     *"
           echo "*  ERRORES - ERRORES - ERRORES - EN -SERVICIOS        *"
           echo "*            REVISARLOS - REVISARLOS                  *"
           echo "*                                                     *"
           echo "*                                                     *"
           echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
fi



#-----------------------
echo ""
titulo="GENERATE"
echo "*-----------------------------------*"
echo "*           " $titulo "             "
echo "*-----------------------------------*"
echo "" 
echo " Operativa 100% "
echo ""


#-----------------------
echo ""
titulo="DATA FLOW (SRVFT31) 5 "
echo "*-----------------------------------*"
echo "*           " $titulo "             "
echo "*-----------------------------------*"
echo ""
date;
if  [ -s servicio31OK.txt ]  ; then
           echo "Instancias (ddfp01, ddfp02, ddfp03, ddfp04, ddfp05 y ddfp06)"
           echo "Servicios y Aplicativos Operativa 100%"
                 cat servicio31OK.txt
   else
           echo "Existen ERRORES en los servicios REVISAR y no enviar Correo "
           echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
           echo "*                                                     *"
           echo "*                                                     *"
           echo "*  ERRORES - ERRORES - ERRORES - EN -SERVICIOS        *"
           echo "*            REVISARLOS - REVISARLOS                  *"
           echo "*                                                     *"
           echo "*                                                     *"
           echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
fi



#------------------------
echo ""
titulo="SERVICIO KDM SRVFT20"
echo "*----------------------------------*"
echo "* "$titulo"                       "
echo "*----------------------------------*"
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
cat salida_kenan_seleccion_kdm.txt
echo " "


#-----------------------
echo ""
titulo="PROCESOS QUE ESTAN EJECUTANDO"
echo "*-----------------------------------*"
echo "* "$titulo"                         "
echo "*-----------------------------------*"
echo ""
ps -fu ctmft | grep CFT |sort
echo ""

}



clear
echo "===================================="
echo " IMPRESION                          "
echo "===================================="
rm paso*_ccc_*.txt
RUTINA_MENSAJE 
RUTINA_IMPRESION
echo "En Proceso Gardando en archivo: salida_estatus_crontab.txt Tarda:Aproximadamente 1 Minuto" 
#RUTINA_IMPRESION > salida_estatus_crontab.txt
RUTINA_IMPRESION > $CRO03/ccapi_kenan_salida_estatus_correo.txt 2> salida_kenan_errorres.txt
clear
echo "Termine puede revisar la salida "
rm FS_30.txt FS_31.txt servicio31OK.txt servicio31NOK.txt servicio30OK.txt servicio30NOK.txt sali20.txt kp01.temp salida_ping_pagweb.txt kk.temp1
#mailx -s "Adminfac01 Estatus Diario $DIA"  alejo24175@gmail.com luisengardo60@gmail.com fritne23@gmail.com admfac@cantv.com.ve < ccapi_kenan_salida_estatus_correo.txt
mailx -s "Adminfac01 Estatus Diario $DIA "  apere7@cantv.com.ve < $CRO03/ccapi_kenan_salida_estatus_correo.txt
