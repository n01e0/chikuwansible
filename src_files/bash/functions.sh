jmp() {
    if test $# -eq 0 ;then
        cat $REPOS/mgtools/conf/jmp.conf
    elif test $1 = "add" ;then
        echo "$2: $(pwd)" >> $REPOS/mgtools/conf/jmp.conf
    else
        cd $(rg "$1: (.*)" -r '$1' -N $REPOS/mgtools/conf/jmp.conf)
    fi
}

recgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttyrec /tmp/.gif_record
}

mkgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttygif /tmp/.gif_record
    if test $# -ge 1 ;then
        mv tty.gif $1
        echo "[+]mv tty.gif "$1
    fi
    rm -rf /tmp/.gif_record
}

repobase(){
    now=$(pwd)/
    if test "$(echo $now | rg "/mnt/c/Users/miyagaw61/home/")" ;then
        now=$(echo $now | rg "/mnt/c/Users/miyagaw61/home/" -r "/home/miyagaw61/")
    fi
    now=$(echo "$now" | sed -E "s@$REPOS@@g")
    now=$(echo "$now" | sed -E "s@^/@@g")
    repo=$(echo "$now" | sed -E "s@/.*@@g")
    cd $REPOS/$repo
}

nv(){
    if test $# -eq 0 ;then
        nvr -c "Denite buffer"
    fi
    nvr -c "e "$(realpath $1)
}

nd(){
    nvr -c "cd "$(realpath $1)
}

#repos(){
#    var=$(rg --files $REPOS | rsed '[^/]*$' '' | sort | uniq | fzf2nd)
#    if test "$var" ;then
#        cd $var
#    fi
#}
#
red(){ #この関数を作らないとゼロマッチの時に何も出力されない
    arg="$(cat -)"
    echo "$arg" | rg "$1" -r "$2" -C 9999999999999999999
}

#readline_injection() {
#  READLINE_LINE="$READLINE_LINE | hoge"
#  READLINE_POINT=${#READLINE_LINE}
#}
#bind -x '"\C-j":readline_injection'
h() {
    cd $HOME/$1
}
h_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F h_completion h

r() {
    cd $HOME/repos/$1
}
r_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/repos/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F r_completion r

e() {
    cd $HOME/events/$1
}
e_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/events/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F e_completion e

d() {
    cd $HOME/docs/$1
}
d_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/docs/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F d_completion d

malist() {
	rg --files -g*.exe -g*.bat -g*.scr -g*.rtf -g*.cpl -g*.jar -g*.lnk | while read line ;do cp -a $line $1/$line ;done
}

pd() {
    if test "$1" == "-h" -o "$1" == "--help" -o $# -eq 0 ;then
        echo "pd [file-name] [line-num]"
    else
        cp -a $1 pd_tmp.py
        space_num=$(sed -n ${2}p pd_tmp.py | sed -E "s@(^ *).*@\1@g" | wc -m)
        spaces=""
        if test ${space_num} -gt 1 ;then
            space_num=$((${space_num}-2))
            for i in $(seq 0 ${space_num}) ;do
                spaces="${spaces} "
            done
        fi
        after="${spaces}""import ptpdb; ptpdb.set_trace()"
        sed -E "$((${2}-1))a_PDHOGE_" -i pd_tmp.py
        sed -E "s@_PDHOGE_@""${after}""@g" -i pd_tmp.py
        python pd_tmp.py
        rm -rf pd_tmp.py
    fi
}

getref() {
    url=$1
    title="$(curl -s ${url} | rg ".*<title>(.*)</title>.*" -r '$1')"
    archive="$(curl -s -H "User-Agent:archiveis (https://github.com/pastpages/archiveis)" -X POST http://archive.is/submit/ -d "url=${url}" -i | rg ".*:.*(http://archive.is/.*)" -r '$1' | tr -d '\r')"
    echo "・[${title}](${url}) ( [archive](${archive}) )"
}

getrefs() {
    cat $1 | while read url ;do
        title="$(curl -s ${url} | rg ".*<title>(.*)</title>.*" -r '$1')"
        archive="$(curl -s -H "User-Agent:archiveis (https://github.com/pastpages/archiveis)" -X POST http://archive.is/submit/ -d "url=${url}" -i | rg ".*:.*(http://archive.is/.*)" -r '$1' | tr -d '\r')"
        echo "・[${title}](${url}) ( [archive](${archive}) )"
    done
}
