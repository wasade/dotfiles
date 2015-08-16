#!/bin/sh

if [ "$(uname)" == "Darwin" ]
then
    curl -o miniconda.sh http://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
else
    curl -o miniconda.sh http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
fi

sh miniconda.sh -b

echo "export PATH=${HOME}/miniconda3/bin:$PATH" >> ${HOME}/.bash_profile
export PATH=${HOME}/miniconda3/bin:$PATH

conda update --yes conda
conda create --yes -n py34-base numpy scipy pandas matplotlib argcomplete jupyter
conda create --yes -n py27-base python=2 numpy scipy pandas matplotlib argcomplete jupyter

eval "$(register-python-argcomplete conda)"
source activate py34-base

echo "source activate py34-base" >> ${HOME}/.bash_profile

ipython profile create

echo "c.Application.verbose_crash=True" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.AliasManager.user_aliases = [" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "         ('ls', 'ls -lrthG')" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "         ]" >> ${HOME}/.ipython/profile_default/ipython_config.py

if [ ! -z "$DISPLAY" ]
then
    echo "c.InteractiveShellApp.pylab = 'auto'" >> ${HOME}/.ipython/profile_default/ipython_config.py
fi

echo "c.TerminalIPythonApp.display_banner = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.colors = 'Linux'" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.autoindent = True" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.editor = 'vim'" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.confirm_exit = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.pager = 'less -FSR'" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.PromptManager.justify = False" >> ${HOME}/.ipython/profile_default/ipython_config.py
echo "c.PromptManager.in_template = u'{color.Yellow}\T {color.White}({color.LightGreen}\\\u{color.White}@{color.LightBlue}\h{color.White}):\Y1> '" >> ${HOME}/.ipython/profile_default/ipython_config.py
