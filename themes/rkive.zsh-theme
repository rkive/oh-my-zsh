ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}) "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

function rkive_prompt {

  branch=$(current_branch)

  prompt=""
  prompt="${prompt}%{$fg[violet]%}ruby:%{$reset_color%}(%{$fg[yellow]%}${rbenv_prompt_info}%{$reset_color%}) "
  prompt="${prompt}$(git_prompt_info)%F{green}%}$PWD%{$reset_color%}"

  echo $prompt
}

setopt prompt_subst

PROMPT='
$(rkive_prompt)
%{$fg[violet]%}%n%{$reset_color%}(%{$fg[blue]%}%m%{$reset_color%}) %{%F{green}%}⚡%{$reset_color%} '
