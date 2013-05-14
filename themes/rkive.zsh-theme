ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}) "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

function rkive_prompt {

  # Get the current ruby version in use with RVM:
  if [ -e ~/.rvm/bin/rvm-prompt ]; then
      RUBY_PROMPT_="%{$fg_bold[blue]%}rvm:(%{$fg[green]%}\$(~/.rvm/bin/rvm-prompt s i v g)%{$fg_bold[blue]%})%{$reset_color%} "
  fi

  rvm_context=$(~/.rvm/bin/rvm-prompt)

  branch=$(current_branch)

  #acm_ref=$(readlink ~/.acm/configured_context)
  #acm_context=$(basename $acm_ref)

  knife_client=`grep node_name ~/.chef/knife.rb|awk -F \' '{ print $2 }'`

  kcm_ref=$(readlink ~/.chef/configured_context)
  kcm_context=$(basename $kcm_ref)

  aws_ref=$(readlink ~/.ec2/configured_context)
  aws_context=$(basename $aws_ref)

  prompt=""
  prompt="${prompt}%{$fg[violet]%}chef:%{$reset_color%}(${knife_client}@%{$fg[yellow]%}${kcm_context}%{$reset_color%}) "
  prompt="${prompt}%{$fg[violet]%}aws:%{$reset_color%}(%{$fg[yellow]%}${aws_context}%{$reset_color%}) "
  prompt="${prompt}%{$fg[violet]%}rvm:%{$reset_color%}(%{$fg[yellow]%}${rvm_context}%{$reset_color%}) "
  prompt="${prompt}$(git_prompt_info)%F{green}%}$PWD%{$reset_color%}"

  echo $prompt
}

setopt prompt_subst

PROMPT='
$(rkive_prompt)
%{$fg[violet]%}%n%{$reset_color%}(%{$fg[blue]%}%m%{$reset_color%}) %{%F{green}%}⚡%{$reset_color%} '
