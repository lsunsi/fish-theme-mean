source $DIRNAME/../fish_prompt.fish

function git_
  git $argv > /dev/null ^ /dev/null
end

function assert -d \
  'checks the value and color for each prompt.
   args: description left-text right-text right-color right-options'
  test "left prompt: $argv[1]"
    (__mean_print $argv[2] 'white') = (fish_prompt)
  end
  test "right prompt: $argv[1]"
    (__mean_print $argv[3] $argv[4] $argv[5]) = (fish_right_prompt)
  end
end

set path '/tmp/fish-theme-mean-test'

rm -rf $path
mkdir $path
cd $path

assert 'base path' \
  '/p/t/fish-theme-mean-test ' \
  '' 'white'

mkdir $path/repo
cd $path/repo

assert 'into inner folder' \
  '/p/t/f/repo ' \
  '' 'white'

git_ init

assert 'init repository' \
  '/p/t/f/repo ' \
  'HEAD' 'white'

touch file

assert 'first commit' \
  '/p/t/f/repo ' \
  'HEAD' 'yellow'

git_ add file
git_ -c user.name=mariza -c user.email=mariza commit -m 'first commit'

assert 'first commit' \
  '/p/t/f/repo ' \
  'master' 'white'

git_ checkout -b 'dev'

assert 'get into new branch' \
  '/p/t/f/repo ' \
  'dev' 'white'

cd $path
mkdir $path/remote-repo
cd remote-repo
git_ init
cd $path/repo
git_ remote add origin $path/remote-repo
git_ push -u origin dev

assert 'synced to remote' \
  '/p/t/f/repo ' \
  'dev' 'white'

touch file2
git_ add .
git_ -c user.name=mariza -c user.email=mariza commit -m "second commit"

assert 'ahead of remote' \
  '/p/t/f/repo ' \
  'dev' 'cyan'

git_ push

assert 'resynced to remote' \
  '/p/t/f/repo ' \
  'dev' 'white'

git_ reset --hard HEAD~1

assert 'behind remote' \
  '/p/t/f/repo ' \
  'dev' 'brred'

git_ pull

assert 'reresynced remote' \
  '/p/t/f/repo ' \
  'dev' 'white'

touch file3
git_ add .
git_ stash

assert 'stashed' \
  '/p/t/f/repo ' \
  'dev' 'white' '-u'

rm -rf $path
