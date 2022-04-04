#!/bin/bash
#check docker container namespaces and
#show their differences and similarity.
#MAINTAINER: Hosein Yousefi <yousefi.hosein.o@gmail.com>

#printf length
CH_CG='%-10s'
CH_IC='%-10s'
CH_MT='%-10s'
CH_NT='%-10s'
CH_PD='%-10s'
CH_UR='%-10s'
CH_US='%-10s'

# Host information
SYS_PID=1
HOST_NAME=$(hostname)
SYS_CMD=$(lsns -p ${SYS_PID} -o COMMAND|tail -1| awk '{print $1}')
SYS_CGROUP=$(lsns -p ${SYS_PID} -o NS,TYPE|grep cgroup|awk '{print $1}')
SYS_IPC=$(lsns -p ${SYS_PID} -o NS,TYPE|grep ipc|awk '{print $1}')
SYS_MNT=$(lsns -p ${SYS_PID} -o NS,TYPE|grep mnt|awk '{print $1}')
SYS_NET=$(lsns -p ${SYS_PID} -o NS,TYPE|grep net|awk '{print $1}')
SYS_PROCD=$(lsns -p ${SYS_PID} -o NS,TYPE|grep pid|awk '{print $1}')
SYS_USER=$(lsns -p ${SYS_PID} -o NS,TYPE|grep user|awk '{print $1}')
SYS_UTS=$(lsns -p ${SYS_PID} -o NS,TYPE|grep uts|awk '{print $1}')


# Table structure
echo -e "\e[1;30m`printf "%-13s %-20s %-5s %-21s %-10s %-10s %-10s %-10s %-10s %-10s %-10s  \n" CONTAINER NAME PID PATH CGROUP IPC MNT NET PID USER UTS  ` \e[0m"
printf "%-13s %-20s %-5s %-21s %-10s %-10s %-10s %-10s %-10s %-10s %-10s  \n" "host" "${HOST_NAME}" "1" "${SYS_CMD}" "${SYS_CGROUP}" "${SYS_IPC}" "${SYS_MNT}" "${SYS_NET}" "${SYS_PROCD}" "${SYS_USER}" "${SYS_UTS}" 


#Containers namespaces
for i in $(docker ps |awk '{print $1}'|sed 's/CONTAINER//'|xargs)
do
	CONTAINER=${i}
	NAME=$(docker ps --format "{{.Names}} {{.ID}}"|grep ${i}|awk '{print$1}')
	PID=$(docker inspect ${i}|grep Pid\"|awk '{print $2}'|tr ',' ' ')
	CMD=$(lsns -p ${PID} -o COMMAND|tail -1| awk '{print $1}')
	CGROUP=$(lsns -p ${PID} -o NS,TYPE|grep cgroup|awk '{print $1}')
	IPC=$(lsns -p ${PID} -o NS,TYPE|grep ipc|awk '{print $1}')
	MNT=$(lsns -p ${PID} -o NS,TYPE|grep mnt|awk '{print $1}')
	NET=$(lsns -p ${PID} -o NS,TYPE|grep net|awk '{print $1}')
	PROCD=$(lsns -p ${PID} -o NS,TYPE|grep pid|awk '{print $1}')
	USER=$(lsns -p ${PID} -o NS,TYPE|grep user|awk '{print $1}')
	UTS=$(lsns -p ${PID} -o NS,TYPE|grep uts|awk '{print $1}')

	if [[ -z $CGROUP ]] || [[ $CGROUP == $SYS_CGROUP ]]
	then
		CGROUP=${SYS_CGROUP}
		CH_CG="\e[0;31m%-10s\e[m"
	fi

        if [[ -z $IPC ]] || [[ $IPC == $SYS_IPC ]]
        then
                IPC=${SYS_IPC}
                CH_IC="\e[0;31m%-10s\e[m"
        fi

        if [[ -z $MNT ]] || [[ $MNT == $SYS_MNT ]]
        then
                MNT=${SYS_MNT}
                CH_MT="\e[0;31m%-10s\e[m"
        fi

        if [[ -z $NET ]] || [[ $NET == $SYS_NET ]]
        then
                NET=${SYS_NET}
                CH_NT="\e[0;31m%-10s\e[m"
        fi

        if [[ -z $PROCD ]] || [[ $PROCD == $SYS_PROCD ]]
        then
                PROCD=${SYS_PROCD}
                CH_PD="\e[0;31m%-10s\e[m"
        fi

        if [[ -z $USER ]] || [[ $USER == $SYS_USER ]]
        then
                USER=${SYS_USER}
                CH_UR="\e[0;31m%-10s\e[m"
        fi

        if [[ -z $UTS ]] || [[ $UTS == $SYS_UTS ]]
        then
                UTS=${SYS_UTS}
                CH_US="\e[0;31m%-10s\e[m"
        fi

	printf "%-13s %-20s %-5s %-21s $CH_CG $CH_IC $CH_MT $CH_NT $CH_PD $CH_UR $CH_US  \n" ${CONTAINER} ${NAME} ${PID} ${CMD} ${CGROUP} ${IPC} ${MNT} ${NET} ${PROCD} ${USER} ${UTS}
done



#Copyright 2022 Hosein Yousefi <yousefi.hosein.o@gmail.com>
