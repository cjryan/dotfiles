"run pathogen
execute pathogen#infect()

" Some basic vim options to make it work better
set nocompatible
set number
syntax on
filetype on
filetype plugin indent on
"set spell

" Set tabbing options
autocmd FileType ruby,yaml,html,erb setlocal expandtab autoindent shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.pp setlocal tabstop=4 shiftwidth=4 expandtab list listchars=tab:>-,trail:.,extends:>
" Trim trailing whitespace from Ruby and Yaml files
autocmd BufWritePre *.rb,*.yml,*.yaml :%s/\s\+$//e

"flag problematic whitespace (trailing and spaces before tabs)
"Note you get the same by doing let c_space_errors=1 but
"this rule really applies to everything.
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

set tabstop=2
set shiftwidth=2
set expandtab
map <F7> :!cucumber --no-color --dry-run % <CR>

"tabular auto
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
