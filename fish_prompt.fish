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

function _git_color
  set git_status (git status -s 2> /dev/null)
  if [ "$git_status" ]
    echo 'yellow'
  else
    echo 'brblack'
  end
end

function fish_right_prompt
  set text (_git_head_ref)
  set color (_git_color)

  print "$text" "$color"
end
