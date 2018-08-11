# this is the left prompt of the fish theme named 'mean'.
# it is as much afraid of you as you are of it.

function print -d 'args: text color'
  set_color $argv[2]
  echo -n $argv[1]
  set_color normal
end

function fish_prompt
  print (prompt_pwd)' ' 'brblack'
end

function _git_head_ref
  git rev-parse --abbrev-ref HEAD 2> /dev/null
end

function _git_branches
  git status -sb --porcelain 2> /dev/null | sed 's/## //' | sed 's/\.\.\./ /'
end

function _git_dirty
  git status -s 2> /dev/null
end

function _git_revlist_count
  git rev-list --count "$argv[1]..$argv[2]" 2> /dev/null
end

function _git_color
  set branches (_git_branches)
  set local (echo $branches | awk '{ print $1 }')
  set remote (echo $branches | awk '{ print $2 }')

  set dirty (_git_dirty)
  set ahead (_git_revlist_count $remote $local)
  set behind (_git_revlist_count $local $remote)

  if [ "$dirty" ]
    echo 'yellow'
  else if [ $behind != '0' ]
    echo 'brred'
  else if [ $ahead != '0' ]
    echo 'cyan'
  else
    echo 'brblack'
  end
end

function fish_right_prompt
  set text (_git_head_ref)
  set color (_git_color)

  print "$text" "$color"
end
