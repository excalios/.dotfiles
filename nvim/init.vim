" vim:foldmethod=marker

"set encoding=UTF-8

" polyglot {{{

set nocompatible

" }}}

call plug#begin(stdpath('data') . '/plugged')

Plug 'github/copilot.vim'

Plug 'johnstef99/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-surround'
Plug 'johmsalas/text-case.nvim'

"Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" Go Language
Plug 'fatih/vim-go'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'udalov/kotlin-vim'

Plug 'jidn/vim-dbml'

" Laravel plugs
" Enable only when developing laravel
"Plug 'tpope/vim-dispatch'             "| Optional
"Plug 'tpope/vim-projectionist'        "|
"Plug 'noahfrederick/vim-composer'     "|
"Plug 'noahfrederick/vim-laravel'

Plug 'jpalardy/vim-slime'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind-nvim'
Plug 'prabirshrestha/async.vim'

Plug 'folke/trouble.nvim'

Plug 'theprimeagen/refactoring.nvim'

" Leap
Plug 'tpope/vim-repeat'
Plug 'ggandor/leap.nvim'

Plug 'windwp/nvim-autopairs'

"Plug 'chrisbra/csv.vim'

" LuaSnip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" ultisnips
"Plug 'SirVer/ultisnips'
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'habamax/vim-godot'

" Git
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'lewis6991/gitsigns.nvim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'stsewd/fzf-checkout.vim'

" Github
"Plug 'skanehira/gh.vim'

" History
Plug 'mbbill/undotree'

" Debugger
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Testing
Plug 'vim-test/vim-test'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-telescope/telescope-github.nvim'
"Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'ThePrimeagen/harpoon'

Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }  " We recommend updating the parsers on update

Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'mattn/emmet-vim'
"Plug 'windwp/nvim-ts-autotag'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Color schemes
"Plug 'morhetz/gruvbox'
"Plug 'colepeters/spacemacs-theme.vim'
"Plug 'pineapplegiant/spaceduck', { 'branch': 'dev' }
"Plug 'tomasr/molokai'
"Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim'

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lualine/lualine.nvim'


" Time Tracker for Productivity
Plug 'wakatime/vim-wakatime'

" Habits
Plug 'rcarriga/nvim-notify'

"Plug 'Stoozy/vimcord'

call plug#end()

" gruvbox
"autocmd vimenter * colorscheme gruvbox
"let g:gruvbox_contrast_dark='hard'

" gruvbox material

" Important!!
"if has('termguicolors')
  "set termguicolors
"endif

" For dark version.
"set background=dark

" For light version.
"set background=light

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
"let g:gruvbox_material_background = 'soft'

"colorscheme gruvbox-material

" Spaceduck
"if exists('+termguicolors')
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  "set termguicolors
"endif

"colorscheme spaceduck

" Molokai
"colorscheme molokai
"let g:rehash256 = 1

" spacemacs
"set background=dark
"colorscheme spacemacs-theme

"hi Normal guibg=black ctermbg=black

colorscheme tokyonight-moon

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
"command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:python3_host_prog = '/opt/homebrew/bin/python3.11'

" Debugger mappings
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>ds :call vimspector#Reset()<CR>
nmap <Leader>db <Plug>VimspectorBalloonEval
xmap <Leader>db <Plug>VimspectorBalloonEval
nmap <Leader>ds <Plug>VimspectorContinue
let g:vimspector_base_dir='/Users/v01d/.local/share/nvim/plugged/vimspector'

let g:maximizer_set_default_mapping = 0
nnoremap <A-m> :MaximizerToggle!<CR>

": vim default config {{{
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  " 1724126 - do not open new file with .spec suffix with spec file template
  " apparently there are other file types with .spec suffix, so disable the
  " template
  " autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
  "set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=dm
     set t_Sf=dm
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		 \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" Don't wake up system with blinking cursor:
let &guicursor = &guicursor . ",a:blinkon0"

" Source a global configuration file if available
if filereadable("/etc/vimrc.local")
  source /etc/vimrc.local
endif
"}}}

" My config{{{

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
set t_ut=

"set background=dark " Setting gruvbox darkmode
filetype indent on
set smartindent
set number
set relativenumber
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
"autocmd FileType gdscript3 set expandtab&
"autocmd FileType gd set expandtab&
set expandtab
set smartcase
set splitright
set nohlsearch
set noswapfile
set nobackup

set colorcolumn=80
set inccommand=split

"set termguicolors
"set foldmethod=syntax
"set foldlevel=1

"augroup lsp_folding
    "autocmd!
    "autocmd FileType html setlocal
        "\ foldlevel=2
"augroup end

nmap <leader>v :vert belowright sb<CR>
nmap <C-h> :bprevious<CR>
nmap <C-l> :bnext<CR>
nmap <C-k> :cp<CR>
nmap <C-j> :cn<CR>
nmap <leader>cq :ccl<CR>

nmap <leader>F :Format<CR>


" }}}

" nerdcomment{{{

map <C-_> <plug>NERDCommenterToggle

"}}}


" vim-test{{{

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "neovim"
let g:test#preserve_screen = 1
let test#neovim#term_position = "vert"
let g:test#echo_command = 0

let test#go#gotest#options = '-v'

let test#php#phpunit#executable = 'php artisan test'
"let test#javascript#nx#options = '--skip-nx-cache --verbose'

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

"}}}

" telescope{{{

" Using lua functions
lua require('excalios.telescope')
nnoremap <leader>ff <cmd>lua require('excalios.telescope').ff()<cr>
nnoremap <leader>fm <cmd>lua require('excalios.telescope').fm()<cr>

"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('excalios.telescope').fg()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>

nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
nnoremap <leader>fb <cmd>lua require('excalios.telescope').fb()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fh <cmd>lua require('excalios.telescope').find_hidden()<cr>

nnoremap <leader>tgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>tgc <cmd>lua require('telescope.builtin').git_commits()<cr>

" File Browser
nnoremap <leader>tgf <cmd>lua require('excalios.telescope').tgf()<cr>
"nnoremap <leader>tgf <cmd>lua require('telescope.builtin').file_browser()<cr>

nnoremap <leader>tlg <cmd>lua require('excalios.telescope').tlg()<cr>
"nnoremap <leader>tlg <cmd>lua require('telescope.builtin').live_grep()<cr>

" Harpoon
nnoremap <leader>th :Telescope harpoon marks<cr>

" Github
nnoremap <leader>gi <cmd>lua require('telescope').extensions.gh.issues()<cr><cr>
nnoremap <leader>gp <cmd>lua require('telescope').extensions.gh.pull_request()<cr><cr>
nnoremap <leader>gg <cmd>lua require('telescope').extensions.gh.gist()<cr><cr>
nnoremap <leader>gr <cmd>lua require('telescope').extensions.gh.run()<cr><cr>

"}}}

" harpoon{{{

nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <silent><A-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><A-t> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><A-n> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><A-s> :lua require("harpoon.ui").nav_file(4)<CR>

"}}}

"" treesitter {{{"",

lua << EOF
require'nvim-treesitter.configs'.setup { 
    highlight = { enable = true, disable = { "html" } },
    indent = { enable = true},
    incremental_selection = { enable = false}
}
-- require('nvim-ts-autotag').setup()
EOF

" }}}

"" airline {{{"",

"let g:airline_theme = 'spaceduck'
"let g:airline_theme = 'gruvbox_material'
"let g:airline_theme = 'tokyonight'
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

" }}}

 "indents {{{

"let g:indentLine_char = '>'
"let g:indentLine_setColors = 0
"let g:indent_blankline_show_first_indent_level = v:false

lua << EOF
vim.opt.list = true

require("ibl").setup {
    --space_char_blankline = " ",
    --show_trailing_blankline_indent = false,
    --show_first_indent_level = false,
    --show_current_context = true,
    --show_current_context_start = true,
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = { enabled = true },
}
EOF

" }}}

" fzf {{{

"let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
"let $FZF_DEFAULT_OPTS='--reverse'

" }}}

" fugitive {{{

nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

" }}}

" Devicons {{{

lua << EOF
require'nvim-web-devicons'.setup {
 default = true;
}
EOF

" }}}

" LSP {{{

set completeopt=menu,menuone,noselect

lua require('excalios.lsp')

autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

" }}}
"
" Go Language {{{

nnoremap <leader>gor :GoRun<CR>

" Set to spaces instead of indent
autocmd BufNewFile,BufRead *.go setlocal expandtab tabstop=2 shiftwidth=2

" Set tabs line
autocmd BufNewFile,BufRead *.go setlocal list lcs=tab:\|\ 

" completion
let g:go_term_enabled = 1
let g:go_code_completion_enabled = 0

" tests
let g:go_test_show_name = 0

" highlight
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

" }}}

" nvim notify {{{

lua require('excalios.notify')

" }}}

" Git Worktree {{{

lua require('excalios.git-worktree')

" }}}

" Lualine {{{

lua require('excalios.lualine')
"lua require('excalios.evil-lualine')

" }}}

" Gitsigns {{{

lua require('excalios.gitsigns')

" }}}

" Leap {{{

lua require('excalios.leap')

" }}}

" Undo History {{{

lua << EOF
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
EOF

" }}}

" Trouble {{{

lua require('excalios.trouble')

" }}}

" Refactoring {{{

lua require('excalios.refactoring')

" }}}

" Text Case {{{

lua require('excalios.text-case')

" }}}

" Copilot {{{

lua require('excalios.copilot')

" }}}

let g:slime_target = "tmux"
let g:slime_python_ipython = 1

"let g:python3_host_prog='/usr/bin/python3'

let g:flutter_show_log_on_run=0

autocmd BufRead,BufNewFile *.blade.php set filetype=blade

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
