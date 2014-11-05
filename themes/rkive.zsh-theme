ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}) "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

function rkive_prompt {

  branch=$(current_branch)

  prompt=""
  prompt="${prompt}%{$fg[violet]%}ruby:%{$reset_color%}(%{$fg[yellow]%}${rbenv_prompt_info}%{$reset_color%}) "
  prompt="${prompt}$(git_prompt_info)%F{green}%}$PWD%{$reset_color%}"

  echo $prompt
}

setopt prompt_subst

PROMPT='
${vim_mode} $(rkive_prompt)
%{$fg[violet]%}%n%{$reset_color%}(%{$fg[blue]%}%m%{$reset_color%}) %{%F{green}%}⚡%{$reset_color%} '
