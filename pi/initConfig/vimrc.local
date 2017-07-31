set nu
runtime! debian.vim
"设置编码
set encoding=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set fileencodings=utf-8,ucs-bom,chinese
 
"语言设置
set langmenu=zh_CN.UTF-8
 
"设置语法高亮
syntax enable
syntax on
 
"设置配色方案
colorscheme torte
 
"可以在buffer的任何地方使用鼠标set mouse=a
set selection=exclusive
set selectmode=mouse,key
 
"高亮显示匹配的括号set showmatch
 
"去掉vi一致性set nocompatible
 
"设置缩进
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent

"this line edit by janyong
set expandtab

if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif
 
"打开文件类型自动检测功能
filetype on
 
"设置taglist
let Tlist_Show_One_File=0   "显示多个文件的tags
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "在taglist是最后一个窗口时退出vim
let Tlist_Use_SingleClick=1 "单击时跳转let Tlist_GainFocus_On_ToggleOpen=1 "打开taglist时获得输入焦点let Tlist_Process_File_Always=1 "不管taglist窗口是否打开，始终解析文件中的tag
 
"设置WinManager插件
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
map <silent> <F9> :WMToggle<cr> "将F9绑定至WinManager,即打开WimManager
 
"设置CSCOPE
set cscopequickfix=s-,c-,d-,i-,t-,e- "设定是否使用quickfix窗口显示cscope结果
 
"设置Grep插件
nnoremap <silent> <F3> :Grep<CR>
 
"设置一键编译
map <F6> :make<CR>
 
"设置自动补全
"filetype plugin indent on   "打开文件类型检测
"set completeopt=longest,menu "关掉智能补全时的预览窗口
 
"启动vim时如果存在tags则自动加载if exists("tags")
"    set tags=./tags
"endif
 
 
"设置默认shell
set shell=bash
 
"设置VIM记录的历史数
set history=400
 
"设置当文件被外部改变的时侯自动读入文件if exists("&autoread")
    set autoread
 
"设置ambiwidth
set ambiwidth=double
 
"设置文件类型
set ffs=unix,dos,mac
 
"设置增量搜索模式
set incsearch
 
"设置静音模式
set noerrorbells
set novisualbell
set t_vb=
 
"不要备份文件
set nobackup
set nowb

