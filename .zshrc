#!/usr/bin/zsh
# 文字コードの設定
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export JLESSCHARSET=japanese-sjis
export OUTPUT_CHARSET=utf-8

#----------------------------------------------------------
# パス
#----------------------------------------------------------
export PATH=/usr/local/bin:$PATH
# mecab
export PATH=$PATH:/usr/local/mecab/bin

#----------------------------------------------------------
# エイリアス
#----------------------------------------------------------
# 補完される前にオリジナルのコマンドまで展開してチェックする
setopt complete_aliases

case "${OSTYPE}" in
darwin*)
  alias ls="ls -GhF"
  ;;
linux*)
  alias ls='ls -hF --color'
  ;;
esac
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lal='ls -lA'
alias pu='pushd'
alias po='popd'
alias grep='grep -n --color'
alias e='emacs'
alias ipython='/usr/bin/ipython'
#alias screen='screen -U'

#----------------------------------------------------------
# 基本
#----------------------------------------------------------
# 色を使う
autoload -U colors; colors
# ビープを鳴らさない
setopt nobeep
# エスケープシーケンスを使う
setopt prompt_subst
# コマンドラインでも#以降をコメントと見なす
setopt interactive_comments
# emacs風のキーバインド
bindkey -e
# C-s, C-qを無効にする
setopt no_flow_control
# 日本語のファイル名を表示可能
setopt print_eight_bit
# C-wで直前の/までを削除する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# cd の後に ls を実行
function chpwd() { ls }

#----------------------------------------------------------
# 色
#----------------------------------------------------------
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=00;36:ln=00;35:ex=00;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#----------------------------------------------------------
# 補完関連
#----------------------------------------------------------
# 補完機能を強化
autoload -Uz compinit; compinit
# URLを自動エスケープ
autoload -Uz url-quote-magic; zle -N self-insert url-quote-magic

# TABで順に補完候補を切り替える
setopt auto_menu
# 補完候補を一覧表示
setopt auto_list
# 補完候補をEmacsのキーバインドで動けるように
zstyle ':completion:*:default' menu select=1
# --prefix=/usrなどの=以降も補間
setopt magic_equal_subst
# ディレクトリ名の補間で末尾の/を自動的に付加し、次の補間に備える
setopt auto_param_slash
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧でファイルの種別をマーク表示
setopt list_types
# 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
# スペルチェック
setopt correct
# killコマンドでプロセスを補完
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# 補完時に大文字と小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#----------------------------------------------------------
# 移動関連
#----------------------------------------------------------
# ディレクトリ名でもcd
setopt auto_cd
# cdのタイミングで自動的にpushd.直前と同じ場合は無視
setopt auto_pushd
setopt pushd_ignore_dups

#----------------------------------------------------------
# 履歴関連
#----------------------------------------------------------
# 履歴の保存先
HISTFILE=$HOME/.zsh-history
# メモリに展開する履歴の数
HISTSIZE=10000
# 保存する履歴の数
SAVEHIST=10000
# ヒストリ全体でのコマンドの重複を禁止する
setopt hist_ignore_dups
# コマンドの空白をけずる
setopt hist_reduce_blanks
# historyコマンドはログに記述しない
setopt hist_no_store
# 先頭が空白だった場合はログに残さない
setopt hist_ignore_space
# 履歴ファイルに時刻を記録
setopt extended_history
# シェルのプロセスごとに履歴を共有
setopt share_history
# 複数のzshを同時に使うときなどhistoryファイルに上書きせず追加
setopt append_history
# 履歴をインクリメンタルに追加
setopt inc_append_history
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# インクリメンタルサーチの設定
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# 全履歴の一覧を出力する
function history-all { history -E 1 }

#----------------------------------------------------------
# プロンプト表示関連
#----------------------------------------------------------
# 右側に時間を表示する
RPROMPT="%T"
# 右側まで入力が来ら時間を消す
setopt transient_rprompt
# プロンプト
function precmd() {
PROMPT="%{${fg[green]}%}%n@%M%{${fg[yellow]}%} %~%{${reset_color}%}"
st=`git status 2>/dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
	color=${fg[cyan]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
	color=${fg[blue]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
	color=${fg_bold[red]}
else
	color=${fg[red]}
fi
PROMPT+=" %{$color%}$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /')%b%{${reset_color}%}
"
}

#----------------------------------------------------------
# Python
#----------------------------------------------------------
# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
#----------------------------------------------------------
# virtualenvwrapperの設定
#----------------------------------------------------------
export WORKON_HOME=$HOME/.virtualenvs
if [[ -e `which virtualenvwrapper.sh` ]]; then
    source `which virtualenvwrapper.sh`
fi

#----------------------------------------------------------
# その他
#----------------------------------------------------------
# ログアウト時にバックグラウンドジョブをkillしない
setopt no_hup
# ログアウト時にバックグラウンドジョブを確認しない
setopt no_checkjobs
# バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt notify

# makeのエラー出力に色付け
e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`
function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

#----------------------------------------------------------
# 環境依存対応
#----------------------------------------------------------
# .zshrc.mineがあれば読み込む
#[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
#eval "$(rbenv init -)"

