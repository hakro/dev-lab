# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;32m\] @ \[\033[01;31m\]DevLab\[\033[00m\]: \[\033[01;32m\]\w\[\033[00m\]\$\n\[\033[33m\]\$(parse_git_branch)\[\033[00m\]-> "

HISTIGNORE='history*:*force*:rm *:*delete*:*uninstall*:export AWS_*:git restore*:git commit *--amend*:git rebase*:git reset*:git revert*:terraform apply*:terraform destroy*'


parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# Start the dev-lab image from the host
# lab() {
#     if docker inspect dev-lab > /dev/null; then
# 	docker start dev-lab
# 	docker exec -it dev-lab bash

#     else
# 	docker run -it --name dev-lab -v ~/Projects:/home/ubuntu/Projects hakrou/dev-lab bash
#     fi
# }

# Run scons from the host
# function scons() {
#     docker exec --workdir=$PWD dev-lab scons "$@"
# }

# function gf() {
#     echo "-----------------------------------------------------------"
#     echo "|  Redirect Program output from GDB with: tty $(tty)  |"
#     echo "-----------------------------------------------------------"
#     /home/hakim/Apps/GF2/gf2 --args "$@"
# }

function genpass() {
    local length=${1:-"50"}
    local res=$(cat /dev/urandom | tr -dc "a-zA-Z0-9&\!;" | head -c $length)
    echo $res
}

export EDITOR=vim
export EMSDK_QUIET=1
alias vim=nvim
alias pgadmin='docker run --network host --rm -e PGADMIN_DEFAULT_EMAIL=admin@admin.com -e PGADMIN_DEFAULT_PASSWORD=admin -e PGADMIN_DISABLE_POSTFIX=True -e PGADMIN_LISTEN_ADDRESS=localhost -e PGADMIN_LISTEN_PORT=8888 -d --name pgadmin dpage/pgadmin4 && echo "PGAdmin starting on http://localhost:8888 (admin@admin.com/admin)"'
