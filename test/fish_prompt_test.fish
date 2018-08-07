source $DIRNAME/../fish_prompt.fish

function assert -d \
  'checks the value and color for each prompt.
   args: description left-text left-color right-text right-color'
  test "left prompt: $argv[1]"
    (print $argv[2] $argv[3]) = (fish_prompt)
  end
  test "right prompt: $argv[1]"
    (print $argv[4] $argv[5]) = (fish_right_prompt)
  end
end

assert 'initial' \
  'Oie' 'blue' \
  'Mundo' 'red'
