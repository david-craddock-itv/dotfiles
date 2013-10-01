syntax on
set backspace=2     " backspace back up a line
set ts=4            " each tab is four spaces
set background=dark " dark background, light foreground
set ls=2            " always show status line
set expandtab       " always expand tabs
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set number          " show line numbers
set ignorecase      " ignore case when searching 
set title           " show title in console title bar
set ttyfast         " smoother changes
set cursorline      " highlight current line
set splitright      " Open new vertical split windows to the right of the current one, not the left.
set splitbelow      " See above description. Opens new windows below, not above.
set visualbell      " flashing bell instead of beep
set history=1000    " 1000 previous commands remembered
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set t_Co=256        " force 256 colour mode

colorscheme tir_black " Set colorscheme to a black/grey theme


"ruby
let g:ruby_path = '/usr/bin/ruby'
if has('autocmd')
    autocmd filetype ruby set omnifunc=rubycomplete#Complete
    autocmd filetype ruby let g:rubycomplete_buffer_loading = 1
    autocmd filetype ruby let g:rubycomplete_classes_in_global = 1
    autocmd filetype ruby let g:RCT_ri_cmd = "ri -T -f plain "
    autocmd filetype text colorscheme endif
endif

"Installed plugins

" Supertab
" http://www.vim.org/scripts/script.php?script_id=1643
" Supertab allows you to use <Tab> for all your insert completion needs 
" (:help ins-completion). 

" <tab> to autocomplete
" control-N to cycle through autocomplete popup downwards
" control-P to cycle through autocomplete popup upwards

":retab is a useful command to fix tabs, changes them into spaces..

" This is necessary under crunchbang/debian
set t_Sf=[3%dm
set t_Sb=[4%dm

" Shell command to display output of shell commands in new window
" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction
