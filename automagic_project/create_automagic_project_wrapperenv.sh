#!/bin/bash

#set -e
#------------------------------
cmdStr=''
#-------------------------------
cmdEndStr="automagic-Test:deploy work environment for automagic_sys project(virtualwrapper).End--------------------------"
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

write_log "INFO" "automagic-Test:deploy work environment for automagic_sys project(virtualwrapper).Begin----------------"

export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-automagic'
echo ---------------------------------
workon env-automagic

cd /home/download-dir/automagic_project/automagic

#install mariadb driver
echo 'installing mariadb driver...'
pip install MySQL-python

#install packages required for the current project
pip install -r requirements.txt

#model migrate
cd /home/download-dir/automagic_project/automagic
python manage.py makemigrations
python manage.py migrate

#create superuser
#python manage.py createsuperuser

echo "from django.contrib.auth.models import User; User.objects.filter(email='admin@example.com').delete(); User.objects.create_superuser('admin', 'admin@example.com', 'loongson')" | python manage.py shell

#启动web服务
#cd /home/download-dir/automagic_project/automagic_test/automagic_sys
#python manage.py runserver 0.0.0.0:8000 --insecure
