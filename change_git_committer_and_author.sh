#!/bin/sh

if [ $# -ne 3 ]; then
  echo '引数は、変更元コミッターネーム、変更先名前、変更先メールアドレスの順です。' 1>&2
  exit 1
fi

git filter-branch -f --commit-filter "
if [ \"\$GIT_COMMITTER_NAME\" = '$1' ]; then
  GIT_COMMITTER_NAME='$2'
  GIT_COMMITTER_EMAIL='$3'
  GIT_AUTHOR_NAME='$2'
  GIT_AUTHOR_EMAIL='$3'
fi
git commit-tree \"\$@\"
" HEAD
