#!/bin/sh

current_date=$(date +"%Y-%m-%d")

# getting current script directory from:
# http://stackoverflow.com/a/246128/19741
dots_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../dots

# creating an array from ls from:
# http://stackoverflow.com/a/18885068/19741
files=($(/bin/ls ${dots_dir}))

for f in ${files[@]}
do
    if [ -e "${HOME}/.${f}" ]
    then
        cp ${HOME}/.${f} ${HOME}/.${f}-${current_date}-backup
    fi
    cp ${dots_dir}/${f} ${HOME}/.${f}
done
