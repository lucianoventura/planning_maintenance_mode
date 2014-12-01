#!/bin/bash
# set_all_app_START.sh
# Created by:  luciano.ventura@gmail.com 2014-12-01


set_app_mode=/u01/Oracle/home_infra/maintenance_mode/bin/set_app_mode.sh

sleep_time=30

for app_name in app_01 app_02 app_03 app_04 app_nn
do
    echo "Starting $app_name"
     
    $set_app_mode START $app_name
     
    sleep $sleep_time
done


