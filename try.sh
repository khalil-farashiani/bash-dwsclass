#!/usr/bin/env bash

# ( )
# =>run as sub process ex: (ls ) run ls command ex: TEST=$(ls ) set output ls
# for value enviroment TEST


args=("$@")

comand=${args[@]:4}



ENV2=`$comand 2>&1`

flag=0
if [[ $ENV2 == *"not"* ]];then
    for item in "$@";do
    case $item in
        -i)
            shift;
            TIME="$1"
            echo $TIME
            ;;
        -n)
            shift;
            NUMBER="$2"
            echo $NUMBER
            ;;
        *)
            ;;
    esac
    done
    for j in $(seq 1 $NUMBER);do
        echo `$ENV2 2>&1`
        if [[ $? == 0 ]];then
            flag=1
            break
        sleep $((TIME))
        fi
    done
    if [[ flag == 1 ]];then
        exit 0
    exit 1
    fi
else
    # echo $ENV2
    echo $(eval $comand)
    exit 0
fi

