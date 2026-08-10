# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gentoo" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-interactive-cd zsh-navigation-tools fzf archlinux pip docker emoji emoji-clock eza cp)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export MANPAGER='nvim +Man!'


alias l='eza --icons=always -G -L 2 --color=always'
alias ls='l -a'
alias ipython="ipython --colors=linux"
alias get="git clone --depth 1"
alias lzvim="NVIM_APPNAME=nvim-lazy nvim"
alias mivim="NVIM_APPNAME=nvim-mini nvim"
alias tvim="NVIM_APPNAME=nvim-clean nvim"
alias fvim="NVIM_APPNAME=nvim-fun nvim"
alias colx="bat -l conf -p"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

cdf() {
  selected_dir=$(fd --type d --hidden --exclude \
    .git --exclude node_modules --exclude .cache --follow --full-path "$1" |
    fzf -i --layout=reverse \
      --preview='exa -T -L 2 -G --icons --git-ignore --color=always {}' \
      --preview-window=up\
      --prompt='Change Dir: ') && [[ -n "$selected_dir" ]] && cd "$selected_dir" || return
}


sf() {
  while true; do
    selected_file=("${(ps:\n:)$(fd --type f --extension "$1" --hidden --exclude \
      .git --exclude node_modules --exclude .cache --follow --full-path . |
      fzf -i -m --layout=reverse \
      --preview="prevme {}" \
      --preview-window=right \
      --prompt='Find:' \
      --bind "ctrl-r:execute(rm -rf /tmp/tabpdf.txt)")}")
    if [[ -n "$selected_file" ]] && [[ "$1" == "pdf" ]];then
      ( nohup lektra "${selected_file[@]}" >/dev/null 2>&1  ) &
      clear
      continue
    else
      if [[ -n "$selected_file" ]]; then
        (
          nohup xdg-open "$selected_file" > /dev/null 2>&1 &
          ) &
          clear
          echo "File opened. Select another file..."
          continue
        else
          break
      fi
      break
    fi
    done
}

txsf(){
  cd "/usr/local/texlive/2025/texmf-dist/" || exit
  sf pdf
  cd || exit
}


fzc() {
  cd "$HOME" || exit
  selected_file=("${(ps:\n:)$(fd --type f --extension "$1" --hidden --exclude \
      .git --exclude node_modules --exclude .cache --follow --full-path . |
      fzf -i -m --layout=reverse \
      --preview="prevme {}" \
      --preview-window=right \
      --prompt='Find:' )}")
  cp "${selected_file[@]}" "$2" || notify-send "Fuzzy Copy" "Failed to copy files"

}

mf() {
  man "$(man -k . | awk '{print $1}' | fzf -i --layout=reverse \
    --preview='man {} | bat -l man' \
    --preview-window=up \
    --prompt='Search Man: ')"
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

frg() {
  [ "$#" -ne 0 ] && nvim "$@" || rg --files --hidden \
    | fzf --print0 --multi --height 50% --layout=reverse \
    --preview="prevme {}" \
    --preview-window=right | xargs -0 -r nvim

}

if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
  export TERMINAL="st"
else
  export TERMINAL="foot"
fi

cat ~/.cache/wal/sequences
export QUTE_BIB_FILEPATH="/home/kratos/Desktop/MyBibs/qute.bib"

export zylokey="sk-zy-da3892f6476804ec0569a2b270c9eb323641a64acdef9d79"


