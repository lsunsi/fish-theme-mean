# this is the left prompt of the fish theme named 'mean'.
# it is as much afraid of you as you are of it.

function __mean_git_head_ref
  git rev-parse --abbrev-ref HEAD 2> /dev/null
end

function __mean_git_branches
  git status -sb --porcelain 2> /dev/null | sed 's/## //' | sed 's/\.\.\./ /'
end

function __mean_git_dirty
  git status -s 2> /dev/null
end

function __mean_git_revlist_count
  git rev-list --count "$argv[1]..$argv[2]" 2> /dev/null
end

function __mean_git_stash_list
  git stash list 2> /dev/null
end

function __mean_git_color
  set branches (__mean_git_branches)
  set local (echo $branches | awk '{ print $1 }')
  set remote (echo $branches | awk '{ print $2 }')

  set dirty (__mean_git_dirty)
  set ahead (__mean_git_revlist_count $remote $local)
  set behind (__mean_git_revlist_count $local $remote)

  if [ "$dirty" ]
    echo 'yellow'
  else if [ -n "$behind" -a "$behind" != '0' ]
    echo 'brred'
  else if [ -n "$ahead" -a "$ahead" != '0' ]
    echo 'cyan'
  else
    echo 'brblack'
  end
end

function __mean_git_color_options
  set stash (__mean_git_stash_list)

  if [ "$stash" ]
    echo '-u'
  end
end

function __mean_print -d 'args: text color options'
  set_color $argv[3] $argv[2]
  echo -n $argv[1]
  set_color normal
end

function fish_prompt
  __mean_print (prompt_pwd)' ' 'brblack'
end

function fish_right_prompt
  set text (__mean_git_head_ref)
  set color (__mean_git_color)
  set options (__mean_git_color_options)

  __mean_print "$text" "$color" $options
end
