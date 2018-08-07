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

function fish_right_prompt
  print 'Mundo' 'red'
end
