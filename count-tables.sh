#!/bin/bash
MYSQL_HOST=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_DATABASE=
FILE_NAME=


function parseValidArguments() {
  while :; do
    case $1 in
      -h|--host) MYSQL_HOST="$2"; shift
      ;;
      -u|--user) MYSQL_USER="$2"; shift
      ;;
      -p|--password) MYSQL_PASSWORD="$2"; shift
      ;;
      -db|--database) MYSQL_DATABASE="$2"; shift
      ;;
      -h|--help) help
      ;;
      *) break
    esac
    shift
  done
}

function validateArguments(){
  if [[ -z "$MYSQL_HOST" ]]; then
    echo "Mysql host required ( Param: -h or --host)"
    exit 1;
  fi

  if [[ -z "$MYSQL_USER" ]]; then
    echo "User Mysql user required ( Param: -u or --user)"
    exit 1;
  fi

  if [[ -z "$MYSQL_PASSWORD" ]]; then
    echo "Password Mysql db required ( Param: -p or --password)"
    exit 1;
  fi

  if [[ -z "$MYSQL_DATABASE" ]]; then
    echo "Database name Mysql required ( Param: -db or --database)"
    exit 1;
  fi
}

function help() {
  echo "#################"

  echo "Options you can use:"
  echo "  -h  | --host : host url of mySql (required)"
  echo "  -u  | --user : user of mysql db  (required)"
  echo "  -p  | --password : password of mySql db (required)"
  echo "  -db | --database : username external ftp (required)"


  echo "#################"
  exit 1
}

function log() {
  echo "$(date +%Y-%m-%d'T'%H:%M:%S)" $@
}

##############
## Main
##############
parseValidArguments $@
validateArguments

log "INFO" "INFO PARAMS"
log "INFO" "=================="
log "INFO" "Mysql HOST : $MYSQL_HOST"
log "INFO" "Mysql USER : $MYSQL_USER"
log "INFO" "Mysql PASSWORD  : $MYSQL_PASSWORD"
log "INFO" "Mysql DATABASE : $MYSQL_DATABASE"

log "INFO" "=================="


#Complete the name of the tables you want to be counted. Repeat the line according to the number of tables you want to process. Example:
#echo  cash_clientes ,$(mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -e 'select count(1)  as 'cant' from cash_clientes ' )   >> CantidadRegistros$MYSQL_HOST.csv


#uncomment the following lines
#echo ""  >> CantidadRegistros$MYSQL_HOST.csv
#echo ""  >> CantidadRegistros$MYSQL_HOST.csv

echo  "Mysql HOST" , $MYSQL_HOST  >> CantidadRegistros$MYSQL_HOST.csv
echo  "Mysql USER" , $MYSQL_USER  >> CantidadRegistros$MYSQL_HOST.csv
echo  "Mysql DATABASE" , $MYSQL_DATABASE  >> CantidadRegistros$MYSQL_HOST.csv


sed -e "s/cant//g" -i CantidadRegistros$MYSQL_HOST.csv

echo "###########"



##############
## End Main
##############
