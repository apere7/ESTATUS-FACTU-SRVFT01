#!/usr/bin/sh

export ORACLE_HOME=/oracle/ft01/920_64
export PATH=$PATH:${ORACLE_HOME}/bin:${ORACLE_HOME}/ccr/bin
export ORACLE_BASE=/oracle
export LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/jlib:${ORACLE_HOME}/lib32
export SHLIB_PATH=${ORACLE_HOME}/lib32
export TNS_ADMIN=${ORACLE_HOME}/network/admin
export ORACLE_SID=KP01CUS1
export ORACLE_TERM=vt220
export NLS_LANG=AMERICAN_AMERICA.UTF8
export JAVA_HOME=${ORACLE_HOME}/jdk

export ARBORDIR=/appl/kbpp01

#----------------------------
#   Rutinas
#----------------------------
RUTINA_IMPRESION () {
cd /appl/kbpp01/utils/Menu/doc013031/FACTU/
echo ""
#titulo="DDFP1ADM BASES DE DATOS"
echo "#----------------------------------#"
#echo " $titulo "
echo "INSTANCE_NAME      STATUS       DATABASE_STATUS"

echo "#----------------------------------#"
P=`cat $ARBORDIR/.arborpw`
sqlplus sagent/sagent@ddfp1adm <<EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01CUS1"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01cus1 << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01CUS2"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01cus2 << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01CUS3"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01cus3 << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01INT"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01int << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01ADM"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01adm << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
#titulo="KP01CAT"
echo "#----------------------------------#"
echo "##         " $titulo "              #"
echo "#----------------------------------#"
sqlplus arbor/$P@kp01cat << EOF
select instance_name, status, database_status from v\$instance;
EOF
echo ""
}
RUTINA_IMPRESION > salida_kenan_BD_cron.txt

grep KP01 salida_kenan_BD_cron.txt > kp01.temp
grep DDFP salida_kenan_BD_cron.txt >> kp01.temp 
echo " "
cont1=`cat kp01.temp | wc -l` 
#echo "$cont1 de 7" 
if  [ $cont1 -lt 7 ];    #si es menor que 7
    then
      echo "ATENCION:  Se debe chequear ya que existe Base de Datos: INACTIVA "     > salida_kenan_seleccion_bd.txt
      echo "$cont1 de 7"                                                           >> salida_kenan_seleccion_bd.txt
      cat kp01.temp                                                                >> salida_kenan_seleccion_bd.txt
      #mailx -s "EXISTEN BASES DE DATOS CAIDAS EN KENAN $DIA "  alejo24175@gmail.com  < pingnok.temp
      mailx -s "EXISTEN BASES DE DATOS CAIDAS EN KENAN $DIA "  alejo24175@gmail.com  < salida_kenan_seleccion_bd.txt
 
    else
      cat kp01.temp > salida_kenan_seleccion_bd.txt
fi
