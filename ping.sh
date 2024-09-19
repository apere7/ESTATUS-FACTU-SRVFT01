#!/usr/bin/sh
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
clear
echo "#----------------------------"
echo "#   Rutinas                  "
echo "#----------------------------" 
echo " ME ENCUENTRO EN PROCESO"
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


rm ccapi_kenan_salida_solo_ping.txt  

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
echo "Se Anexa Estatus Diario Adminfac"
echo "Saludos Cordiales"
echo "                      Adminfac Estatus Diario"


#------------------------
echo ""
titulo="PING SERVIDORES 11"
echo "*----------------------------------*"
echo "* "$titulo"			"
echo "*----------------------------------*"
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
#cat salida_kenan_seleccion_ping.txt
cat ccapi_kenan_salida_solo_ping.txt
echo " "

}



clear
echo "===================================="
echo " IMPRESION                          "
echo "===================================="
rm paso*_ccc_*.txt
RUTINA_MENSAJE 
RUTINA_IMPRESION
RUTINA_IMPRESION > $CRO03/ccapi_kenan_salida_solo_ping.txt 2> salida_kenan_ping_errorres.txt
clear
echo "Termine puede revisar la salida "
mailx -s "Adminfac01 Estatus Diario $DIA "  apere7@cantv.com.ve < $CRO03/ccapi_kenan_salida_solo_ping.txt
cat ccapi_kenan_salida_solo_ping.txt
