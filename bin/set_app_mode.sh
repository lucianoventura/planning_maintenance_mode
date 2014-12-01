#!/bin/bash
# set_app_mode.sh
# Created by:  luciano.ventura@gmail.com 2014-12-01


# exit codes
readonly SUCCESS=0
readonly FAILURE=1


show_usage(){
    echo
    echo
    echo
    echo "Set application mode"
    echo
    echo "How to use:"
    echo
    echo "$(basename $0) ( START or STOP ) application"
    echo
    echo
    echo
     
    exit $FAILURE
}


if [ -z "$1" -o -z "$2" ]; then                                                                 # Check for missing parameters
    show_usage
fi

  action=$1                                                                                     # action START or STOP
app_name=$2                                                                                     # application name


app_owner=carga                                                                                 # application owner, not just some admin user


planning_dir=/u01/Oracle/Middleware/user_projects/epmsystem_$(hostname -s)/Planning/planning1   # Planning directory


mainten_mode=$planning_dir/MaintenanceMode.sh                                                   # script to run


passcarga=$planning_dir/passcarga.txt                                                           # password file


home_dir=/u01/Oracle/home_infra/maintenance_mode                                                # script´s directories
 log_dir=$home_dir/log


weekday=$(date +%A | tr [:upper:] [:lower:])                                                    # get weekday in lower case 

 
    log_file=$log_dir/$weekday"_"$action"_"$app_name                                            # log files
out_log_file=$log_file.out
err_log_file=$log_file.err


case $action in
    "START")login_level=ALL_USERS   ;;
     "STOP")login_level=OWNER       ;;
          *)show_usage              ;;
esac


$mainten_mode -f:$passcarga /A=$app_name,/U=$app_owner,/LL=$login_level 1>$out_log_file 2>$err_log_file


