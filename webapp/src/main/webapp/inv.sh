#!/bin/bash
#
#
#


echo check if the system is 32 or 64 bits
echo
getconf LONG_BIT
sleep 2

echo check a total numbers of processes running
echo

ps -ef

sleep 2

echo create a file in tmp directory cal log
echo

touch /tmp/log    >/dev/null 2>&1
sleep 2

echo create a group call shipping
echo

groupadd shipping   >/dev/null 2>&1

sleep 2

echo -e "\n check if the directory /var/log exists on the systems \n"

if [ -d /var/log ] 

then

echo -e "\n /var/log exits on the system\n"

else

echo "\n/var/log doesn't exist on the system\n"

fi

echo check if the user ansible exists on the system

id ansible    >/dev/null 2>&1

if [ $? -eq 0 ] 

then 

echo user ansible exists on the system

else

useradd ansible

fi

echo check if the group pub exists on the system

grep pub /etc/group >/dev/null 2>&1

if [ $? -eq 0 ]

then 

echo group pub exists on the system

else

groupadd pub

fi

echo -e "\n check a first digit of our kernel\n"
 kernel=$(uname -r | awk -F. '{print$1}')

if [ ${kernel} -lt 3 ]

then 

echo -e "\n please considere update your kernel \n"

else

echo -e "\n this system is up-to-date\n"

fi

echo -e "\n check the status of selinux\n"

sel=$(egrep 'SELINUX=e|SELINUX=p|SELINUX=d' /etc/selinux/config | awk -F= '{print$2}') 
if [ $sel != enforcing ] 

then

echo -e "\n this system is not secure\n"

else

echo -e "\n this system is secure\n"

fi

echo -e "\n check the status of the system (interactive) \n"

int=$(grep PROMPT /etc/sysconfig/init | awk -F= '{print$2}') 

if [ $int == yes ]

then
echo -e "\n the system is configured to boot up in interactive mode \n"

else

echo -e "\n the system cannot boot up in interactive mode\n"

fi

maint=$(grep ^SINGLE /etc/sysconfig/init | awk -F/ '{print$3}')

if [ $maint != sulogin ]

then 

echo -e "\n the system can boot up in maintenance mode \n"

else
echo -e "\n the system cannot boot up in maintenance mode\n"
fi

echo -e "\ncheck if user ansible exist on the system\n"

id ansible
if [ $? -eq 0 ]

then 

echo -e "\n user ansible exists on the system\n"

else

echo -e "\n user ansible doesn't exists on the systems\n"
fi


echo -e "\n check if the package git is install\n"

rpm -qa | grep git

if [ $? -eq 0 ] 

then 

echo -e "\n git is install on the system \n"

else

echo -e "\n git is not install on the system\n"

fi

echo -e "\n check if these files exists on the systems\n"

if [ -f /etc/inittab ] 

then

echo -e "\n inittab file exists on the system\n"

else

echo -e "\n inittab file doesn't exist on the system\n"
fi

if [ -f /etc/grub.conf ]

then

echo -e "\n grub.conf file exist on the system\n"

else

echo -e "\n grub.conf doesn't exist on the system\n"

fi

if [ -f /etc/fstab ]

then 
echo -e "\n fstab file exist on the system\n"
else

echo -e "\n fstab file doesn't exist on the system\n"
fi

echo -e "\n check if the system has 2 processors\n"

p=$(nproc) 

if [ $p -le 2 ]

then 

echo -e "\n a system doesn't have 2 processors\n"

else

echo -e "\n the system has 2 processors\n"

fi

echo -e "\n the system need to be 64 bits\n"

bit=$(getconf LONG_BIT) 

if [ ${bit} -eq 64 ]

then 

echo -e "\n the system is 64 bits\n"

else

echo -e "\n the system is not 64 bits\n"
fi

echo -e "\n verify a kernel version \n"

if [ $kernel -ge 3 ]

then 
echo -e "\n the kernel first digit is at least 3..\n"
else
echo -e "\n the kernel first digit is less than 3..\n"
fi

echo -e "\n check OS version of our system\n"
os=$(cat /etc/issue | grep CentOS | awk '{print$3}'| awk -F. '{print$2}')

if [ $os -ge 5 ]

then
echo -e "\n the system has at least 6.5 digit\n"

else
echo -e "\n the system doesn't have at least 6.5 digit\n"
fi

echo -e "\n check a total memory of th system\n"

mem=$(cat /proc/meminfo| head -1 |awk '{print$2}') 

if [ $mem -ge 4000 ]

then

echo -e "\n the total memory is at least 4000MB\n"

else

echo -e "\n the total memory is not at least 4000MB\n"
fi
