# rails_templete
rails自定义模版


这个是 Rails 默认模板的定制，用于公司开发时的基础代码生成。 生成的代码中包含了开发时常用的一些代码（默认注释掉了），可以直接修改使用。


## 安装

    将templates文件夹放置到项目的lib目录中
    
## 使用用法

你可以根据自己得喜好修改模板，然后用 Rails scaffold generator 生成


    普通生成命令    
    $ rails g scaffold Post title:string category_id:integer body:text
    命名空间模式生成命令，用于新模块的开发，Worker是模块名称，DictItem是模块的中的对象
    $ rails g scaffold Worker::DictItem dict_id:integer name:string val:integer 

如果不想生成测试，js，样式表等文件，可以修改config/application.rb ,替换如下代码禁止不需要的文件生成


    config.generators do |g|
      # g.test_framework :rspec,
      #   fixtures: true,
      #   view_specs: false,
      #   helper_specs: false,
      #   routing_specs: false,
      #   controller_specs: true,
      #   request_specs: false
      #g.fixture_replacement :factory_girl, dir: "spec/factories"

      g.test_framework  false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end
