echo Deploying github pages...
rake generate
rm -rf _deploy/*
cp -rf public/ _deploy/
cd _deploy/
git add .
git commit -am 'update'
git push -f origin master

echo Backing up sourcecode history...
cd ../
git remote set-url origin git@github.com:sealand210/did-histroy.git
git config branch.remote origin
git add .
git commit -m 'update'
git push origin master

echo Backing up source code...
git add .
git commit -am 'update'
git remote set-url origin git@github.com:sealand210/did.git
git push origin master

echo Deploying heroku pages...
git config branch.remote heroku
git commit -am 'update'
git push heroku master








