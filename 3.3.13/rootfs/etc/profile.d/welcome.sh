#!/bin/bash

# For more information regarding bash shells, see:
# https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files

echo
echo "Welcome $(whoami), from '/etc/profile.d/welcome.sh'"
echo "Sourced by: $0."
echo

# colorized pretty print "username pwd $ "
export PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u \[\033[01;34m\]\w \$\[\033[00m\] '
