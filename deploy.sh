git add .
git commit -m 'update'
git push heroku master
git config branch.master.remote origin
git add .
git commit -m 'update'
git push origin master
git config branch.master.remote heroku
