# rails_templete
rails自定义模版



这个是 Rails 默认模板的定制，用于公司开发时的基础代码生成。 


## 安装

    将templates文件夹放置到项目的lib目录中
    
## 使用用法

你可以根据自己得喜好修改模板，然后用 Rails scaffold generator 生成


    普通生成命令    
    $ rails g scaffold Post title:string category_id:integer body:text
    命名空间模式生成命令
    $ rails g scaffold Worker::DictItem dict_id:integer name:string val:integer 


