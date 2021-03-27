echo -n $GIT_TOKEN | xclip -selection clipboard
cd results
rm -rf results11
git add --all
git commit -m 'update'
git push origin master
cd ..
rm -rf results
cd results2
rm -rf results22
git add --all
git commit -m 'update'
git push origin master
cd ..
rm -rf results2
