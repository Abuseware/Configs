[[ $- != *i* ]] && return

### OPTIONS ###

# History
setopt append_history
setopt auto_pushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# Completion
setopt always_to_end
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_aliases
setopt correct
setopt extended_glob
setopt mark_dirs

setopt no_CASE_GLOB
unsetopt CASE_GLOB

# Display
setopt c_bases
setopt c_precedences
setopt check_jobs
setopt notify
setopt printexitvalue

# Other
setopt auto_cd
setopt auto_continue
setopt bad_pattern
setopt beep
setopt bsd_echo
setopt hup
setopt nocaseglob
setopt printexitvalue
setopt short_loops


### KEYBOARD ###

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


### COMPLETION ###

autoload -U compinit
compinit
zstyle ':completion:*' menu select rehash use-cache verbose


### PROMPT ###

autoload -U promptinit
promptinit
prompt adam2 8bit


### MODS ###

fpath=("$HOME/.zsh.d" $fpath)


### ALIASES ###

alias sudo='sudo '

alias dig='dig +short'

alias ls='ls -FGlho'

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

alias mkdir='mkdir -pv'

alias du='du -ch'
alias df='df -h'

[ -f ~/.ssh/config ] && for x in $(awk '($1=="Host" && $2!="*"){print $2}' ~/.ssh/config); alias @${x}="ssh $x"
#alias @rpi='mosh rpi'
#alias @sway='mosh sway'

alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'

### FUNCTIONS

function precmd() {
	print -Pn "\e]0;%n@%m: %~\a"
}
