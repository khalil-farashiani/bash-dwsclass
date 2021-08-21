#!/usr/bin/env bash


args=("$@")

i_flag=0
n_flag=0

for i in "${args[@]}"
do
    if [ "$i" == "-i" ] ; then
        i_flag=1
    elif [ "$i" == "-n" ] ; then
        n_flag=1
    fi
done



flag=0
if [[ ( $i_flag == 1 ) && ( $n_flag != 1 ) || ( $i_flag != 1 ) && ( $n_flag == 1 ) ]];then
    flag=1
elif [[ ( $i_flag == 1 ) && ( $n_flag == 1 ) ]];then
    flag=2
else
    flag=0
fi





c_flag=1
if [[ ( $flag == 0 ) && ( $# == 0 ) ]]; then
    c_flag=0
elif [[ ( $flag == 1 ) && ( $# < 3 ) ]]; then
    c_flag=0
elif [[ ( $flag == 2 ) && ( $# < 5 ) ]]; then
    c_flag=0
fi


if [[ ( $c_flag == 1 ) ]];then
    if [[ ( $flag == 1 ) ]];then
        comand=${args[@]:2}
    elif [[ ( $flag == 2 ) ]];then
        comand=${args[@]:4}
    else
        comand=${args[@]:0}
    fi
elif [[ ( $c_flag == 0 ) && ( -z "${COMMAND}" ) ]];then
    echo "YOU SHOULD PASS AT LEAST 1 COMMAND"
    exit 1
else
    comand="${COMMAND}"
fi












ENV2=`$comand 2>&1`

if [[ ( $i_flag == 0 ) ]];then
    if [[ -z "${TRY_INTERVAL}" ]]; then
        Time=5
    else
        Time="${‫‪TRY_INTERVAL‬‬}"
    fi
fi


if [[ ( $n_flag == 0 ) ]];then
    if [[ -z "${TRY_NUMBER}" ]]; then
        Number=12
    else
        Number="${TRY_NUMBER}"
    fi
fi



if [[ ( $flag == 2 ) ]];then
    for item in "$@";do
        case $item in
            -i)
                shift;
                Time="$1"
                ;;
            -n)
                shift;
                Number="$2"
                ;;
            *)
                ;;
        esac
    done

elif [[ ( $flag == 1 ) && ( $i_flag == 1 ) ]];then
    Time="$2"
elif [[ ( $flag == 1 ) && ( $n_flag == 1 ) ]];then
    Number="$2"
fi

#########################################################################




echo $comand
echo $Time
echo $Number

flag=0
if [[ ( $ENV2 == *"not"* ) || ( $ENV2 == *"Usage"* ) ]];then
    for j in $(seq 1 $Number);do
        echo `$ENV2 2>&1`
        if [[ $? == 1 ]];then
            flag=1
            break
        fi
        sleep $((Time))
    done
    if [[ flag == 1 ]];then
        exit 0
    exit 1
    fi    
fi