echo -n $GIT_TOKEN | xclip -selection clipboard
git status
git add --all
git commit -m $1
git push
