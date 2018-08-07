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

set path '/tmp/fish-theme-mean-test'

rm -rf $path
mkdir $path
cd $path

assert 'base path' \
  '/p/t/fish-theme-mean-test ' 'brblack' \
  '' 'brblack'

mkdir $path/repo
cd $path/repo

assert 'into inner folder' \
  '/p/t/f/repo ' 'brblack' \
  '' 'brblack'

git init

assert 'init repository' \
  '/p/t/f/repo ' 'brblack' \
  'HEAD' 'brblack'

touch file

assert 'first commit' \
  '/p/t/f/repo ' 'brblack' \
  'HEAD' 'yellow'

git add file
git -c user.name=mariza -c user.email=mariza commit -m 'first commit'

assert 'first commit' \
  '/p/t/f/repo ' 'brblack' \
  'master' 'brblack'

git checkout -b 'dev'

assert 'get into new branch' \
  '/p/t/f/repo ' 'brblack' \
  'dev' 'brblack'

rm -rf $path
