source $DIRNAME/../fish_prompt.fish

function git_
  git $argv > /dev/null ^ /dev/null
end

function assert \
  -a description left_text right_text right_color right_option

  if [ $left_text ]
    set left_prompt (__mean_print $left_text 'white')
  end
  if [ $right_text ]
    set right_prompt (__mean_print $right_text $right_color $right_option)
  end

  test "left prompt: $description"
    $left_prompt = (fish_prompt)
  end

  test "right prompt: $description"
    $right_prompt = (fish_right_prompt)
  end
end

function os_prompt_path_prefix
  set os_name (uname -s)

  if [ $os_name = 'Darwin' ]
    echo '/p/t'
  else
    echo '/t'
  end
end

set path '/tmp/fish-theme-mean-test'
set prompt_path_prefix (os_prompt_path_prefix)

rm -rf $path
mkdir $path
cd $path

assert 'base path' \
  "$prompt_path_prefix/fish-theme-mean-test "

mkdir $path/repo
cd $path/repo

assert 'into inner folder' \
  "$prompt_path_prefix/f/repo "

git_ init
git_ config user.name 'mariza'
git_ config user.email 'mariza@email'

assert 'init repository' \
  "$prompt_path_prefix/f/repo " \
  'HEAD' 'white'

touch file

assert 'first commit' \
  "$prompt_path_prefix/f/repo " \
  'HEAD' 'yellow'

git_ add file
git_ commit -m 'first commit'

assert 'first commit' \
  "$prompt_path_prefix/f/repo " \
  'master' 'brblack'

git_ checkout -b 'dev'

assert 'get into new branch' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'brblack'

cd $path
mkdir $path/remote-repo
cd remote-repo
git_ init
cd $path/repo
git_ remote add origin $path/remote-repo
git_ push -u origin dev

assert 'synced to remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'white'

touch file2
git_ add .
git_ commit -m "second commit"

assert 'ahead of remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'cyan'

git_ push

assert 'resynced to remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'white'

git_ reset --hard HEAD~1

assert 'behind remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'brmagenta'

git_ pull

assert 'reresynced remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'white'

git_ reset HEAD~1
git_ add .
git_ commit -m "third commit"

assert 'diverged' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'brred'

touch file3
git_ add .
git_ stash

assert 'stashed' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'brred' '-u'

git_ push -f

assert 'rereresynced remote' \
  "$prompt_path_prefix/f/repo " \
  'dev' 'white' '-u'

rm -rf $path
