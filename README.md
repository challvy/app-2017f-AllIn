# AllIn
**许卓尔 151220136@smail.nju.edu.cn**

**郑聪尉 151220169@smail.nju.edu.cn**

## 应用介绍

AllIn是一款聚合阅读内容的类RSS阅读器，在普通RSS阅读器的基础上，增加了如Hupu这类主流论坛的支持；

![AllIn](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/AllIn.png)


## 功能说明

### 信息获取

* 对于RSS源，进行网络请求，获取信息，进行XML解析，添加到主页的digests中；
* 对于HTML网页，获取网页内容，借助Fuzi框架进行HTML解析，添加到主页的digests中；
* 显示已读/未读，帮助用户更好地浏览；
* 收藏功能——"AllIn"板块，存储了所有收藏内容；
* 下拉tableview进行刷新，每次仅更新新的文章摘要；

![DigestView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/DigestView.png)

### 信息源选择

* 采用侧滑抽屉的方式进行交互，更为优雅；

![MenuView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/MenuView.png)

### 文章浏览

#### 一、RSS格式文章浏览

* 根据RSS格式的规范，编写XML解析器，并根据标签属性生成富文本，输出到ContentView；
* 可根据用户设置进行字体大小、种类的个性化设置；

![RssContentView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/RssContentView.png)

#### 二、HTML文章浏览

* 由于HTML格式比较复杂，没有统一内容标准，暂时利用了UIWebView加载页面进行内容输出，希望以后优化；
* 因为使用UIWebView显示的，字体设置等无法对其起作用
> 网上找了一下可以用javascript代码设置字体等信息，有点来不及，希望以后补上！


<img src="https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/HTMLContentView.png" width="500">


### 登陆

* 仅针对User信息进行数据持久化，因此用户需要登陆以存储自己的偏好设置；
* 用户头像为默认头像，但背景可以在本地进行选择；（因为没有实现存储图片的服务器，json传图片有些许问题）
* 可在设置中进行密码修改、编辑信息源等操作，不允许修改用户名；
* 禁止重复的用户名注册，禁止不存在的用户登陆；
* 添加有趣的哆啦A梦动画效果；

![SignInSignUpView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/SignInSignUpView.png)


### 个人设置

#### 一、密码修改

* 仅针对已登陆用户进行密码修改；
* 先输入正确的原密码，再连续两次输入一致的新密码；

![SettingAccountView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/SettingAccountView.png)

#### 二、字体设置

* 利用pickView进行字体大小、类型的选择；
* 相应设置会体现在文章浏览视图中；

![SettingDisplayView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/SettingDisplayView.png)

#### 三、信息源编辑

* 在设置中加入了可编辑的tableView，利用AlterView进行源的添加；
> 由于json传数据的一些问题，有所限制；
* 非法的信息源将会弹出Alter告警框；
> 本来要求源遵守http://、htpps://的格式，但是在后端put方面出了点问题，暂时弃用此功能；

![SettingView](https://github.com/challvy/app-2017f-AllIn/raw/master/Screenshots/SettingView.png)



### 数据持久化

* 对User信息进行持久化，本地存储用户偏好；
* 对收藏的文章进行持久化，不存储在User后端数据库中；

## 不足之处

选择这个项目的出发点是用iPhone6每天在多个app刷内容不仅切换很慢还十分繁琐，想要一个有能聚合我需要信息的app，并且找到了类似的概念——RSS阅读器；

但是实际操作的时候发现，目前Rss源许多都弃用了，已成为过去式；其他一些主流的论坛、QQ、微博，对于爬虫也不是很友好，QQ空间为了防止刷访问的现象还会封IP，导致了这个app有点鸡肋，但是至少满足了我对于Hupu、知乎日报的需求；

* 一开始不太了解Swift，用了值传递的数组[ ]，造成了很多错误，浪费了自己的事件，牺牲了app的效率，类似的错误还有一些，到现在也有地方没改过来；
* 由于后端编写的比较晚，工程中有许多不必要的部分夹杂在一起，没能很好的去除；
* 留有一些bug，自己写的排版器有时候不能正常显示；
* 功能划分比较混乱，许多东西都是初次上手，代码复用度也不是太高，没有很好地进行抽象；
* 两人编写的时候分工不是太好，利用git进行项目管理，总是出现合并冲突；


## 其他说明

* 后端使用 NodeJs + express + mongodb，开发本地服务器，使用了mongoose模块；
* 使用第三方代码库Fuzi进行HTML解析，借助Carthage管理第三方依赖；
