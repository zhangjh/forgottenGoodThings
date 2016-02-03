### sublime3安装
安装地址: [http://www.sublimetext.com/3](http://www.sublimetext.com/3)

### 安装插件
#### Package Control安装
1. `Ctrl+``调出终端
2. 黏贴以下代码到终端安装
```
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler() )  ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20') ).read())
```
3. 重启sublime3

#### 用Package Control安装插件
1. 按下`Ctrl+Shift+P`调出命令面板
2. 输入install(可以联想)调出install Package选项回车,然后在列表中选中要安装的插件

有了包管理器搜索安装就好了...

常用插件列表:
- emmet                 html补全
- jquery                jquery补全
- sublime prefixr       css3私有前缀自动补全
- jsFormat              js代码格式化
- sublimelinter-jshint  jshint代码检查
- alignment             代码格式自动对齐,默认快捷键是`ctr+alt+a`
- brackethighlighter    括号,引号,标签高亮
- git
