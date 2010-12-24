"vim config taken from
"http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
"and http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab

