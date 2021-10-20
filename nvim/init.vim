" vim:foldmethod=marker

"set encoding=UTF-8

" polyglot {{{

set nocompatible

" }}}

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mcchrish/nnn.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" This devicon provide icons to nerdtree and airlines
Plug 'ryanoasis/vim-devicons'
" This devicon provide icons to telescope
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdcommenter'

Plug 'Yggdroot/indentLine'

" Go Language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Laravel plugs
" Enable only when developing laravel
Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-projectionist'        "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'

Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/nvim-cmp'
Plug 'prabirshrestha/async.vim'

" LuaSnip
"Plug 'L3MON4D3/LuaSnip'
"Plug 'saadparwaiz1/cmp_luasnip'

" ultisnips
"Plug 'SirVer/ultisnips'
"Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'habamax/vim-godot'

" Git
Plug 'tpope/vim-fugitive'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'stsewd/fzf-checkout.vim'

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
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'sheerun/vim-polyglot'
"Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat', 'do': ':TSUpdate'}  " We recommend updating the parsers on update
"Plug 'windwp/nvim-ts-autotag'

" Color schemes
"Plug 'morhetz/gruvbox'
"Plug 'colepeters/spacemacs-theme.vim'
Plug 'pineapplegiant/spaceduck'
"Plug 'tomasr/molokai'
"Plug 'sainnhe/gruvbox-material'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Time Tracker for Productivity
Plug 'wakatime/vim-wakatime'

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
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme spaceduck

" Molokai
"colorscheme molokai
"let g:rehash256 = 1

" spacemacs
"set background=dark
"colorscheme spacemacs-theme

"hi Normal guibg=black ctermbg=black

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Debugger mappings
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>ds :call vimspector#Reset()<CR>
nmap <Leader>db <Plug>VimspectorBalloonEval
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
set tabstop=4 softtabstop=4
set shiftwidth=4
"autocmd FileType gdscript3 set expandtab&
"autocmd FileType gd set expandtab&
set expandtab
set smartcase
set splitright
set nohlsearch
set noswapfile
set nobackup

set colorcolumn=80

"set termguicolors
"set foldmethod=syntax
"set foldlevel=1

"augroup lsp_folding
    "autocmd!
    "autocmd FileType html setlocal
        "\ foldlevel=2
"augroup end

nnoremap <F1> :!npm test<CR>
"nnoremap <F2> :!npm run test-report<CR>
nmap <leader>g <Plug>(coc-git-commit)
nmap <leader>v :vert belowright sb<CR>
nmap <C-h> :bprevious<CR>
nmap <C-l> :bnext<CR>
nmap <C-k> :cp<CR>
nmap <C-j> :cn<CR>

nmap <leader>F :Format<CR>


" }}}

" nerdtree{{{
map <C-n> :NERDTreeToggle<CR>
map <C-_> <plug>NERDCommenterToggle
"}}}

" nnn{{{
let g:nnn#layout = { 'window': { 'width': 0.3, 'height': 0.6, 'highlight': 'Debug' } }
"}}}

" vim-test{{{

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "neovim"
let test#neovim#term_position = "vert"

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

"}}}

"ctrlp Fuzzy{{{
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'

"let g:ctrlp_show_hidden = 1

"set wildignore+=*/.git/*,*/node_modules/*
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|node_modules)$'
"let g:ctrlp_custom_ignore = {
  "\ 'dir':  '\v[\/]\.(git|node_modules)$',
  "\ }
"let g:ctrlp_root_markers = ['CMakeLists.txt', 'artisan', "package.json"]
"}}}

": coc config {{{
let g:coc_global_extensions = [
    \ 'coc-prettier',
    \ 'coc-pairs',
    \ 'coc-git',
    \ 'coc-emmet',
    \ 'coc-yaml',
    \ 'coc-tsserver',
    \ 'coc-phpls',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-html-css-support',
    \ 'coc-css',
    \ 'coc-tailwindcss',
    \ 'coc-clangd',
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ 'coc-discord-rpc',
    \ 'coc-vetur',
    \ 'coc-inline-jest',
    \]
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
 set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <c-space> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

inoremap <silent><expr> <cr> pumvisible() ?
            \ &filetype == "gdscript" ? (coc#expandable() ?  "\<C-y>" : "\<Esc>a")
            \:  coc#rpc#request('hasSelected', []) ?
            \  "\<C-y>"
            \: "\<C-y><CR>"
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"let g:coc_filetype_map = {
        "\ 'blade.php': 'blade'
        "\ }
"
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

"}}}

" telescope{{{

" Using lua functions
nnoremap <leader>ff <cmd>lua require('excalios.telescope').ff()<cr>
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('excalios.telescope').fg()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fb <cmd>lua require('excalios.telescope').fb()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fh <cmd>lua require('excalios.telescope').find_hidden()<cr>

nnoremap <leader>tgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>tgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>tgf <cmd>lua require('excalios.telescope').tgf()<cr>
"nnoremap <leader>tgf <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>tlg <cmd>lua require('excalios.telescope').tlg()<cr>
"nnoremap <leader>tlg <cmd>lua require('telescope.builtin').live_grep()<cr>

"}}}

" treesitter {{{

"lua << EOF
"require'nvim-treesitter.configs'.setup { 
    "highlight = { enable = true, disable = { "html" } },
    "indent = { enable = true},
    "incremental_selection = { enable = false}
"}
"require('nvim-ts-autotag').setup()
"EOF

" }}}

" airline {{{

let g:airline_theme = 'spaceduck'
"let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" }}}

 "indents {{{

let g:indentLine_char = '>'
let g:indentLine_setColors = 0

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

"set completeopt=menuone,noinsert,noselect

"lua << EOF
"local cmp = require'cmp'

"cmp.setup({
    "snippet = {
        "expand = function(args)
            "-- require('luasnip').lsp_expand(args.body)
            "vim.fn["UltiSnips#Anon"](args.body)
        "end
    "},
    "mapping = {
        "['<C-d>'] = cmp.mapping.scroll_docs(-4),
        "['<C-f>'] = cmp.mapping.scroll_docs(4),
        "['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        "['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        "['<C-Space>'] = cmp.mapping.complete(),
        "['<C-e>'] = cmp.mapping.close(),
        "['<CR>'] = cmp.mapping.confirm({ select = true }),
     "},
    "sources = {
        "{ name = 'nvim_lsp' },
        "-- { name = 'luasnip' },
        "{ name = 'ultisnips' },
        "{ name = 'buffer' },
     "}
"})

"require'lspconfig'.gdscript.setup{
    "capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"}
"require'lspconfig'.rust_analyzer.setup {
    "capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"}
"require'lspconfig'.gopls.setup {
    "cmd = {"gopls", "serve"},
    "capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    "settings = {
      "gopls = {
        "analyses = {
          "unusedparams = true,
        "},
        "staticcheck = true,
      "},
    "},
"}

"-- Show Diagnosticts
"vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

"EOF

" }}}
"
" Go Language {{{

" Set to spaces instead of indent
autocmd BufNewFile,BufRead *.go setlocal expandtab tabstop=4 shiftwidth=4 

" Set tabs line
autocmd BufNewFile,BufRead *.go setlocal list lcs=tab:\|\ 

" completion
let g:go_code_completion_enabled = 0

" tests
let g:go_test_show_name = 0

" highlight
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
"let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

" }}}
