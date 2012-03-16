---
layout: page
title: "部署Octopress"
date: 2012-03-16 11:14
comments: true
published: false
footer: false
categories: octopress
---


* ###认识github

github其实就是一个具有社区功能的代码管理网站，方便开源程序的协力开发，当然它也可以成为软件公司的代码分布平台，但是如果你不想公开你的代码，就必须缴纳年费。

在github上建站最好将repo名称设置成username.github.com的模式，之后username.github.com这个连接就会自动打开repo内的index.html，而不是github的网站页面。

创建好名为username.github.com的repo后上传一个index.html到master branch来完成建站的准备工作：

<!-- more -->

开始之前先设定git SSh密匙，和git用户全局参数，参照www.github.com

{%codeblock%}
$ git init
$ git remote add origin git@github.com:username/username.github.com.git
$ echo "My GitHub Page" > index.html
$ git add .
$ git commit -a -m "First pages commit"
$ git push origin master
{%endcodeblock%}

刷新`username.github.com`可以看到`My GitHub Page`的字样就完成了。

了解github指令和更多的用法：
[git - the simple guide - no deep shit](http://rogerdudler.github.com/git-guide/index.zh.html)


#####部署Octopress到github

进入octopress目录,设定远程仓库：

	$ git remote add origin git@github.com:username/
	$ rake setup_github_pages #设定Github账户目录

之后它会提示输入github账户名，按照一下形式输入：
	
	git@github.com:username/username.github.com.git
	
如果已经执行过rake generate,则可以直接进行部署了：

	$ rake deploy

完成后将源码保存到github的source branch

	$ git add .
	$ git commit -m 'site updated'
	$ git push origin HEAD:source
	
#####绑定域名

	$ echo '你要绑定的域名' >> source/CNAME

将你要绑定的域名CNAME到 http://你的GitHub用户名.github.com，如果是@纪录，需要加入207.97.227.245。


#####编辑已经在github搭建好的Octopress：

{%codeblock%}
$ cd local.blog.path  #选择一个本地目录保存octopress
$ git init				
$ git remote add origin git@github.com:username/username.github.com.git
$ git pull origin source		#从source抓取网站源码
$ gem install bundler
$ bundle install
$ sudo rm -rf _deploy
$ rake setup_github_pages	#设定账户名
git@github.com:username/username.github.com.git
{%endcodeblock%}

		
		
		

## 认识heroku

Heroku 是云端应用程式平台，可以想成是「云端上的网页空间」，不同于传统网页空间的计费方式，Heroku 是按照你所使用的资源来计费的，像是 CPU、RAM 使用越多就需要付越多钱，不过免费的方案已经够一般应用程式使用了。对比github，heroku的好处是repo是不公开的，也就是说除了作者外没有人可以看到网站目录。而且个人感觉在国内浏览heroku好像比github快

要使用heroku,先得要安装heroku工具：

	$ gem install heroku   #在octopress目录内
	
之后就可以直接登陆heroku:

	$ heoku login
	
首次使用需要上传RSA密匙:

	$ heroku keys:add
	$ heroku keys   #查看是否上传成功
	
最后就可以开始创建程序了(appName为自定义程序名)：

	$ heroku create appName
	

#####部署Octopress到heroku

首先要修改 `.gitignore` 文件，去掉文档中的 `public`,否则git不会 上传public文件夹，会出现网站无法访问的错误

设定默认的远程库为heroku

	# Set heroku to be the default remote for push/fetch
	git config branch.master.remote heroku

如果已经用rake generate生成过网站则可以直接开始部署了：

	git add .
	git commit -m 'site updated'
	git push heroku master
	
如果出现 `Permission Denied(public key)` 则会有两种可能：

1.生成的rsa密匙不是默认的id_rsa名称，则需要在 `~/.ssh` 目录中添加`config` 文件将heroku的密匙指向你设定的密匙：

{%codeblock%}
Host heroku.com
Hostname heroku.com
Port 22
IdentitiesOnly yes
IdentityFile ~/.ssh/id_heroku
TCPKeepAlive yes
User brandon
{%endcodeblock%}

2.heroku进入了 `/root/.shh/`而不是`~/.ssh/`查找密匙, 简单将密匙拷贝过去就可以了:

	$ sudo cp ~/.ssh/id_rsa* /root/.ssh/
	
部署完成后就可以在appName.heroku.com看到octopress页面了

	$ heroku open    #查看应用
	

#####编辑已经在heroku搭建好的Octopress
{%codeblock%}
#设定远程库
git config branch.master.remote heroku
git remote set-url heroku git@heroku.com:appName.git
#抓取网站源码
git clone git@heroku.com:appName.git -o heroku
#生成上传
rake generate
git add .
git commit -m 'site updated'
git push heroku master
{%endcodeblock%}


## 参考连接

* <http://aboukone.com/2012/02/04/heroku-setup-git-push-heroku-master-permission-denied-ssh-issue/>
* <http://zylstra.wordpress.com/2008/08/29/overcome-herokus-permission-denied-publickey-problem/>
* <http://octopress.org/docs/deploying/heroku/>
* <http://octopress.org/docs/deploying/github/>
* <http://devcenter.heroku.com/articles/keys>


