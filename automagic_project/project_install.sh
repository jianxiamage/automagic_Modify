#!/bin/bash　　

#set -e
#------------------------------
cmdStr=''
#-------------------------------
cmdEndStr="automagic-Test:project install.End------------------------------------"
#----------------------------------------------------------------------------------
source ./shell-log.sh
logFile=$logFile
#echo $logFile
write_log=$write_log
#----------------------------------------------------------------------------------
source ./exceptionTrap.sh
exit_end=$exit_end
exit_err=$exit_err
exit_int=$exit_int
#----------------------------------------------------------------------------------
trap 'exit_end "${cmdEndStr}"' EXIT
trap 'exit_err $LINENO $?'     ERR
trap 'exit_int'                INT
#----------------------------------------------------------------------------------

write_log "INFO" "automagic-Test:project install.Begin---------------------------"

pushd .

cd /home/download-dir/automagic_project

chmod +x *.sh
chmod +x *.py

sh install_depend_pkgs.sh

sh mariadb_install.sh

sh create_database.sh

#sh create_work_env.sh
sh create_work_env_wrapper.sh

sh create_automagic_project_wrapperenv.sh

sh automagic_service.sh start
