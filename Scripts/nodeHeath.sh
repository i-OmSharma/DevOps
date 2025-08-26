#!/bin/bash

# Meta Data
########################
# Author: Om
# Date: 25/08/2025
#
# This script output the node health
#
# version: v1
#########################

set -x # debug mode 
set -e # exit the script when there is an error
set -o pipefail

# set -exo pipefail

# echo "disk usage"
df -h

# echo "Memory usage"
free -g

# echo "no of cpu"
nproc

ps -ef | grep bluetooth | awk -F" " '{print $2}'

