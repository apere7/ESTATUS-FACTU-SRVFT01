#!/bin/sh
resetvid="\0033[0m"
iverde='\033[40m\033[32m'
fverde=' \033[0m'
imorado='\033[40m\033[35m'
fmorado=' \033[0m'
antes=0
nuevo=0
while true
do
   clear
   echo ""
   echo "$iverde======================================================$fverde" ;
   echo "  Monitoreo de procesos en  $LOGNAME " ;
    echo "$iverde======================================================$fverde" ; \

   echo ""
   echo ""
#   ps -fu $LOGNAME | grep CFT* | grep -v grep | grep -v usr
   ps -fu ctmft | grep CFT |sort
   S=$?
   echo ""
   echo "$iverde======================================================$fverde" ;
   echo ""
   if [ "$S" = "0" ]; then
      echo ""
      echo ""
      antes=$nuevo
      sleep 5
      else
      echo "NO existen procesos en ejecucion para $LOGNAME en el servidor ....."
      exit
   fi
done

