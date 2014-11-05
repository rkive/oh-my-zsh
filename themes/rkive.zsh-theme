ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}) "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

function rkive_prompt {

  branch=$(current_branch)

  knife_client=`grep node_name ~/.chef/knife.rb|awk -F \' '{ print $2 }'`

  kcm_ref=$(readlink ~/.chef/configured_context)
  kcm_context=$(basename $kcm_ref)

  aws_ref=$(readlink ~/.ec2/configured_context)
  aws_context=$(basename $aws_ref)

  prompt=""
  prompt="${prompt}%{$fg[violet]%}chef:%{$reset_color%}(${knife_client}@%{$fg[yellow]%}${kcm_context}%{$reset_color%}) "
  prompt="${prompt}%{$fg[violet]%}aws:%{$reset_color%}(%{$fg[yellow]%}${aws_context}%{$reset_color%}) "
  prompt="${prompt}%{$fg[violet]%}ruby:%{$reset_color%}(%{$fg[yellow]%}${rbenv_prompt_info}%{$reset_color%}) "
  prompt="${prompt}$(git_prompt_info)%F{green}%}$PWD%{$reset_color%}"

  echo $prompt
}

setopt prompt_subst

PROMPT='
$(rkive_prompt)
%{$fg[violet]%}%n%{$reset_color%}(%{$fg[blue]%}%m%{$reset_color%}) %{%F{green}%}⚡%{$reset_color%} '
