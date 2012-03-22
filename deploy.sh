rake generate
rake deploy
git add .
git commit -m 'update'
git push origin bak
git add .
git commit -am 'update'
git push origin source
git config branch.master.remote heroku
git add .
git commit -m 'update'
git push heroku master
git config branch.master.remote origin
git checkout source
