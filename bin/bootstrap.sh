#!/usr/bin/env bash

current_date=$(date +"%Y-%m-%d")

pushd `dirname ${BASH_SOURCE[0]}` > /dev/null
dots_dir=`pwd`/../dots
popd > /dev/null

files=()
for f in `/bin/ls ${dots_dir}`
do
    files=("${files[@]}" ${f})
done

for f in ${files[@]}
do
    if [ -e "${HOME}/.${f}" ]
    then
        cp ${HOME}/.${f} ${HOME}/.${f}-${current_date}-backup
    fi
    cp ${dots_dir}/${f} ${HOME}/.${f}
done

# download and setup conda
if [ "$(uname)" == "Darwin" ]
then
    curl -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    curl -o mambaforge.sh https://github.com/conda-forge/miniforge/releases/download/latest/Mambaforge-latest-MacOSX-x86_64.sh
else
    curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    curl -o mambaforge.sh https://github.com/conda-forge/miniforge/releases/download/latest/Mambaforge-latest-Linux-x86_64.sh
fi
chmod +x miniconda.sh
./miniconda.sh -b
chmod +x mambaforge.sh
./mambaforge.sh -b

export PATH=${HOME}/miniconda3/bin:$PATH

conda update --yes conda
conda create --yes -n base numpy scipy pandas matplotlib argcomplete jupyter flake8

source activate base

# this profile will resolve for both py27 and py35
ipython profile create

# set a reasonabe default IPython config
echo "c.Application.verbose_crash=True" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.AliasManager.user_aliases = [" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "         ('ls', 'ls -lrthG')" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "         ]" >> ${HOME}/.ipython/profile_default/ipython_config.py

if [ ! -z "$DISPLAY" ]
then
    echo "c.InteractiveShellApp.pylab = 'auto'" >> ${HOME}/.ipython/profile_default/ipython_config.py
fi

echo "c.TerminalIPythonApp.display_banner = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.InteractiveShell.colors = 'Linux'" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.autoindent = True" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.editor = 'vim'" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.confirm_exit = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.true_color = True" >> ${HOME}/.ipython/profile_default/ipython_config.py
#echo "c.PromptManager.justify = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
#echo "c.PromptManager.in_template = u'{color.Yellow}\T {color.White}({color.LightGreen}\\\u{color.White}@{color.LightBlue}\h{color.White}):\Y1> '" >> ${HOME}/.ipython/profile_default/ipython_config.py

echo ""
echo "Not automatically sourcing environment. Please open a new terminal or type: "
echo "source ~/.bash_profile"
echo ""
