[[ $- != *i* ]] && return
setopt autocd
setopt automenu
setopt beep
setopt completealiases
setopt extendedglob
setopt histignoredups
setopt notify

bindkey -e
typeset -gA key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init() {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish() {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

autoload -U compinit
compinit
zstyle ':completion:*' menu select

autoload -U promptinit
promptinit
prompt adam2 8bit

fpath=("$HOME/.zsh.d" $fpath)

alias sudo='sudo '

alias dig='dig +short'

alias ls='ls -FGlho'

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias mkdir='mkdir -pv'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

alias du='du -ch'
alias df='df -h'

function TRAPZERR() {
	print "\e[1;33m(Error: $?)\e[m" >&2
}

function precmd() {
	print -Pn "\e]0;%n@%m: %~\a"
}

[ -f ~/.ssh/config ] &&	for x in $(awk '($1=="Host" && $2!="*"){print $2}' ~/.ssh/config); alias @${x}="ssh $x"
