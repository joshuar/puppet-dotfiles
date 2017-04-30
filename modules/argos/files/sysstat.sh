#!/usr/bin/bash

# display available system resources as padded non-decimal percentage digits
#   CPU = current cpu usage
#   MEM = current memory in use percentage
#   HD = current percentage of hard drive in use

# debug mode - to turn on, set to 1 (run script manually to see debug outputs)
DEBUG=0

# get CPU info
CPU=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf("%02d", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5))}')
[ $DEBUG -eq 1 ] && echo "DEBUG: cpu -> "$CPU
CPULOAD=$(uptime | tr -s " " | cut -d' ' -f9-)
[ $DEBUG -eq 1 ] && echo "DEBUG: cpu load -> "$CPULOAD
TOPCPU=$(ps aux --no-headers | awk '{print $3 " "  $11}' | sort -rn | head -n 5)

# get memory info
MEMTOT=$(cat /proc/meminfo | grep MemTotal | awk '{printf ("% 0.1f", $2/1024000)}')
[ $DEBUG -eq 1 ] && echo "DEBUG: mem total-> "$MEMTOT
MEMAVA=$(cat /proc/meminfo | grep MemAvailable | awk '{printf ("%0.1f", $2/1024000)}')
[ $DEBUG -eq 1 ] && echo "DEBUG: mem availalbe-> "$MEMAVA
MEMUSAGE=$(free | grep Mem | awk '{printf("%02d",  $3/$2 * 100.0)}')
[ $DEBUG -eq 1 ] && echo "DEBUG: mem usage-> "$MEMUSAGE
MEMUSAGE2=$(echo "$MEMTOT GB in use")
[ $DEBUG -eq 1 ] && echo "DEBUG: mem usage tooltip -> "$MEMUSAGE2
MEMUSED=$(echo "scale=2;($MEMTOT - $MEMAVA)" | bc)
TOPMEM=$(ps aux --no-headers | awk '{print $4 " "  $11}' | sort -rn | head -n 5)

# get hard drive usage info
HD=$(df -hl /dev/mapper/fedora_agalloch-home | tail -1 | awk '{printf ("%02d", $5)}' | sed -e 's/%//')
[ $DEBUG -eq 1 ] && echo "DEBUG: hd -> "$HD
HDSIZE=$(df -hl /dev/mapper/fedora_agalloch-home | tail -1 | awk '{print $2}' | sed -e 's/G//')
HDUSED=$(df -hl /dev/mapper/fedora_agalloch-home | tail -1 | awk '{print $3}' | sed -e 's/G//')
[ $DEBUG -eq 1 ] && echo "DEBUG: hd size -> $HDSIZE GB drive capacity"
TOPHD=$(df -hl /dev/mapper/fedora_agalloch-home | tail -1)

[ $DEBUG -eq 1 ] && echo "DEBUG: genmon output"

echo "CPU: $CPU % MEM: $MEMUSAGE % HDD: $HD %"
echo "---"
echo -e "\033[1mCPU $CPULOAD\033[0m | ansi=true"
echo "$TOPCPU"
echo "---"
echo -e "\033[1mMEM: $MEMUSED of $MEMUSAGE2\033[0m | ansi=true"
echo "$TOPMEM"
echo "---"
echo "\033[1mHD usage: $HDUSED of $HDSIZE GB in use\033[0m | ansi=true"
echo "$TOPHD"
echo "---"
echo "Refresh... | refresh=true"

exit 0
