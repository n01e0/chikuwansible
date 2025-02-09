
" SCB_VSPLIT
" ==========
function! g:Scb_vsplit()
    set noscb
    rightbelow vsplit
    set noscb
    normal gGCf
    normal gGCe
    normal gGCe
    set scb
    normal gh
    set scb
endfunction
nnoremap <leader>v :call Scb_vsplit()<CR>
"# AUTO SCB_VSPLIT
"augroup scb_vsplit
"    au!
"    autocmd VimEnter * call s:scb_vsplit()
"augroup END


"GETVISUALSELECTION
"==================
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if lnum1 == 0 && lnum2 == 0 && col1 == 0 && col2 == 0
        return ''
    endif
    let lines[-1] = lines[-1][:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let ret = join(lines, "\n")
    return ret
endfunction

"terminal close
"==============
function! s:termexit() abort
    execute 'buffer #'
endfunction

"python run
"==========
"function! Python_run(arg, ...)
"    execute 'w /tmp/%.vimrun'
"    execute ':b bash'
"    execute ':cd #:h'
"    call deol#send('python run
"nnoremap [Space]rp :w /tmp/%.vimrun<CR>:b bash<CR>:cd #:h<CR>imv /tmp/vimrun.py ./vimrun.py; python vimrun.py; rm -rf vimrun.py 

command! -nargs=? MyRustRun call My_rust_run(<f-args>)
function! My_rust_run(...)
    execute "w"
    "normal !echo \"%:p:h\" > /tmp/deol_cd.tmp
    execute "b bash"
    "normal icd $(cat /tmp/deol_cd.tmp); cargo run<Space>"
    execute "call deol#send(\"cd \" . expand(\"#:p:h\") . \"; \" . \"cargo run " . join(a:000, " ") . "\")"
endfunction

command! -nargs=? MyAg call My_Ag(<f-args>)
function! My_Ag(...)
    execute "Ag " . join(a:000, " ") . " %"
endfunction

command! -nargs=? Add call Add_Func(<f-args>)
function! Add_Func(...)
    execute "!rusgit ac % -a " . join(a:000, " ")
endfunction

command! -nargs=? Remove call Remove_Func(<f-args>)
function! Remove_Func(...)
    execute "!rusgit ac % -r " . join(a:000, " ")
endfunction

command! -nargs=? Change call Change_Func(<f-args>)
function! Change_Func(...)
    execute "!rusgit ac % -c " . join(a:000, " ")
endfunction

command! -nargs=? Improve call Improve_Func(<f-args>)
function! Improve_Func(...)
    execute "!rusgit ac % -i " . join(a:000, " ")
endfunction

command! -nargs=? Support call Support_Func(<f-args>)
function! Support_Func(...)
    execute "!rusgit ac % -s " . join(a:000, " ")
endfunction

command! -nargs=? Fix call Fix_Func(<f-args>)
function! Fix_Func(...)
    execute "!rusgit ac % -f " . join(a:000, " ")
endfunction

command! -nargs=? Use call Use_Func(<f-args>)
function! Use_Func(...)
    execute "!rusgit ac % -u " . join(a:000, " ")
endfunction

command! -nargs=? Update call Update_Func(<f-args>)
function! Update_Func(...)
    execute "!rusgit ac % -U " . join(a:000, " ")
endfunction

command! -nargs=? Allow call Allow_Func(<f-args>)
function! Allow_Func(...)
    execute "!rusgit ac % -l " . join(a:000, " ")
endfunction

command! -nargs=? Avoid call Avoid_Func(<f-args>)
function! Avoid_Func(...)
    execute "!rusgit ac % -v " . join(a:000, " ")
endfunction

command! -nargs=? Refactor call Refactor_Func(<f-args>)
function! Refactor_Func(...)
    execute "!rusgit ac % -R " . join(a:000, " ")
endfunction

" GREP
" ====
command! -nargs=? Frep call Frep_Func(<f-args>)
function! Frep_Func(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    let regexp = join(args[1:], " ")
    let regexp = substitute(regexp, '"', '\\"', "g")
    execute "w"
    execute "b bash"
    if argc > 2
        let cmd = "call deol#send(\"frep " . path . " " . regexp . "\")"
        execute cmd
    else
        let cmd = "call deol#send(\"frep " . path . " " . regexp . "\")"
        execute cmd
    endif
endfunction

command! -nargs=? Frepl call Frepl_Func(<f-args>)
function! Frepl_Func(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    let regexp = join(args[1:], " ")
    let regexp = substitute(regexp, '"', '\\"', "g")
    execute "w"
    execute "b bash"
    if argc > 2
        let cmd = "call deol#send(\"frepl " . path . " " . regexp . "\")"
        execute cmd
    else
        let cmd = "call deol#send(\"frepl " . path . " " . regexp . "\")"
        execute cmd
    endif
    normal i
endfunction

" quick_open
" ==========
function! g:Quick_open()
    let l:path = system("cat /tmp/viming_path")
    let l:pathes = split(l:path, "\n")
    for l:x in l:pathes
        execute "e " . l:x
    endfor
endfunction
nnoremap <leader>o :call Quick_open()<CR>

" my_vimgrep
" ==========
command! -nargs=? MyVimgrep call My_vimgrep(<f-args>)
function! My_vimgrep(...)
    execute "mark a"
    execute "vimgrep /" . join(a:000, " ") . "/ %" . " | cw"
    normal gk
    set cursorline
endfunction

" save this file name
" ===================
command! -nargs=? SaveThisFileName call SaveThisFileName(<f-args>)
function! SaveThisFileName(...)
    execute "r !echo %:p"
    normal ddk
    execute "w!"
    execute "e /tmp/viming_path"
    normal Vp
    execute "w"
    execute "bd"
endfunction

" my_vimgrepadd
" ==============
command! -nargs=? MyVimgrepadd call My_vimgrepadd(<f-args>)
function! My_vimgrepadd(...)
    let l:args = join(a:000, " ")
    let l:cmd = "bufdo vimgrepadd /" . l:args . "/ %"
    execute "mark a"
    execute "cex ''"
    execute l:cmd
    execute "cw"
    normal gk
    set cursorline
    execute "call Quick_open()"
endfunction

" my_vimgrep_all
" ==============
command! -nargs=? MyVimgrepAll call My_vimgrep_all(<f-args>)
function! My_vimgrep_all(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:num = l:argc -2
    let l:last = l:argc - 1
    execute "mark a"
    execute "cd %:h"
    execute "vimgrep /" . join(l:args[0:l:num], " ") . "/ " . l:args[l:last] . " | cw"
    normal gk
    set cursorline
endfunction

" make
" ====
command! -nargs=? MB call MB(<f-args>)
function! MB(...)
    execute "make build | cw"
endfunction

command! -nargs=? MT call MT(<f-args>)
function! MT(...)
    let l:ft = &filetype
    if l:ft == 'rust'
        execute "!make test"
    else 
        execute "make test"
    endif
endfunction

command! -nargs=? MR call MR(<f-args>)
function! MR(...)
    let l:argc = len(a:000)
    let l:ft = &filetype
    if l:argc != 0
        let l:args = split(a:000[0], " ")
        let l:args_str = join(l:args, " ")
        if l:ft == 'rust'
            execute "make run " . l:args_str
        else
            execute "!make run ARG='" . l:args_str . "'"
        endif
    else
        if l:ft == 'rust'
            execute "make run"
        else
            execute "make run ARG=''"
        endif
    endif
endfunction

"" Denite Grep
"" ===========
"command! -nargs=? DG call Denite_grep(<f-args>)
"function! Denite_grep(...)
"    execute "mark a"
"    "execute "Denite -buffer-name=search -auto-highlight -winheight=10 line"
"    "execute "Denite -buffer-name=search -winheight=10 line"
"    "execute "Denite -buffer-name=search line"
"    execute "Denite line"
"endfunction
"nnoremap <silent>/ :<C-u>DG<CR>

" CNEXT
" =====
command! -nargs=? CN call CN(<f-args>)
function! CN(...)
    execute "cnext"
    normal zz
    set cursorline
endfunction
nnoremap <silent><C-n> :<C-u>CN<CR>
nnoremap <silent><C-j> :<C-u>CN<CR>

" CPREV
" =====
command! -nargs=? CP call CP(<f-args>)
function! CP(...)
    execute "cNext"
    normal zz
    set cursorline
endfunction
nnoremap <silent><C-p> :<C-u>CP<CR>
nnoremap <silent><C-k> :<C-u>CP<CR>

" QuickFix Closer
" ===============
command! -nargs=? QC call QC(<f-args>)
function! QC(...)
    set nocursorline
    normal gj
    execute "bd"
endfunction
nnoremap <silent><C-h> :<C-u>QC<CR>

" CdDirname
" =========
command! -nargs=? -complete=file_in_path CdDirname call CdDirname(<f-args>)
function! CdDirname(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
endfunction

" GitCommit
" =========
command! -nargs=? -complete=file_in_path GitCommit call GitCommit(<f-args>)
function! GitCommit(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "silent !git a " . l:fullpath
    execute "silent !git c -m '" . l:message . "'"
    execute "!git l3n"
endfunction

" GitStatus
" =========
command! -nargs=? -complete=file_in_path GitStatus call GitStatus(<f-args>)
function! GitStatus(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "!git_sn"
endfunction

" GitLog
" ======
command! -nargs=? -complete=file_in_path GitLog call GitLog(<f-args>)
function! GitLog(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "!git l20n"
endfunction

" GitPush
" =======
command! -nargs=? -complete=file_in_path GitPush call GitPush(<f-args>)
function! GitPush(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "!git push"
endfunction

" GitDiff
" =======
command! -nargs=? -complete=file_in_path GitDiff call GitDiff(<f-args>)
function! GitDiff(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "silent !git diff > /tmp/git_diff"
    execute "e /tmp/git_diff"
endfunction

" GitAdd
" ======
command! -nargs=? -complete=file_in_path GitAdd call GitAdd(<f-args>)
function! GitAdd(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:path = expand(l:args[0])
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    let l:message = join(l:args[1:], " ")
    execute "cd " . l:dirname
    execute "silent !git add " . l:fullpath
endfunction

" GitCommitDefx
" =============
command! -nargs=? -complete=file_in_path GitCommitDefx call GitCommitDefx(<f-args>)
function! GitCommitDefx(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:message = l:args_str
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "silent !git add " . l:fullpath
    execute "silent !git c -m '" . l:message . "'"
    execute "!git l3n"
endfunction

" GitDiffDefx
" ===========
command! -nargs=? GitDiffDefx call GitDiffDefx(<f-args>)
function! GitDiffDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "silent !git diff > /tmp/git_diff"
    execute "e /tmp/git_diff"
endfunction

" GitPushDefx
" ===========
command! -nargs=? GitPushDefx call GitPushDefx(<f-args>)
function! GitPushDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "!git push"
endfunction

" GitAddDefx
" ==========
command! -nargs=? GitAddDefx call GitAddDefx(<f-args>)
function! GitAddDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "silent !git add " . l:fullpath
endfunction

" GitStatusDefx
" =============
command! -nargs=? GitStatusDefx call GitStatusDefx(<f-args>)
function! GitStatusDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "!git_sn"
endfunction

" GitLogDefx
" ==========
command! -nargs=? GitLogDefx call GitLogDefx(<f-args>)
function! GitLogDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "!git l20n"
endfunction

" SystemDefx
" ==========
command! -nargs=? -complete=file_in_path SystemDefx call SystemDefx(<f-args>)
function! SystemDefx(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:args_str = join(l:args, " ")
    let l:command = l:args_str
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "cd " . l:dirname
    execute "!" . l:command
endfunction

" ChangeFileDefx
" ==============
command! -nargs=? ChangeFileDefx call ChangeFileDefx(<f-args>)
function! ChangeFileDefx(...)
    execute "w!"
    let l:filename = expand('%:p')
    let l:dirname = expand('%:p:h')
    execute "bd"
    execute "Defx " . l:dirname . " -search=" . l:filename
endfunction

" SaveDir
" =======
command! -nargs=? -complete=file_in_path SaveDir call SaveDir(<f-args>)
function! SaveDir(...)
    let l:fullpath = expand("%:p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    execute "silent !echo " . l:dirname . " > /tmp/SaveDir.tmp"
    execute "silent w!"
endfunction

" CdNowDefx
" ==========
command! -nargs=? -complete=file_in_path CdNowDefx call CdNowDefx(<f-args>)
function! CdNowDefx(...)
    normal yy
    let l:path = @+
    let l:fullpath = fnamemodify(l:path, ":p")
    let l:dirname = fnamemodify(l:fullpath, ":h")
    if isdirectory(l:path)
        let l:dirname = fnamemodify(l:dirname, ":h")
    endif
    execute "cd " . l:dirname
endfunction

" CdDefx
" ======
command! -nargs=? -complete=file_in_path CdDefx call CdDefx(<f-args>)
function! CdDefx(...)
    let l:args_len = len(a:000)
    if l:args_len != 0
        let l:args = split(a:000[0], " ")
        let l:argc = len(args)
        let l:args_str = join(l:args, " ")
        "let l:open_path = expand(l:args[0])
        "let l:open_fullpath = fnamemodify(l:open_path, ":p")
        "let l:open_dirname = fnamemodify(l:open_fullpath, ":h")
        let l:goto_path = fnamemodify(l:args_str, ":p")
        execute "Defx " . l:goto_path
    else
        execute "Defx ."
    endif
endfunction

" OpenFileByDenite
" ================
command! -nargs=? -complete=file_in_path OpenFileByDenite call OpenFileByDenite(<f-args>)
function! OpenFileByDenite(...)
    let l:args_len = len(a:000)
    if l:args_len != 0
        let l:args = split(a:000[0], " ")
        let l:argc = len(args)
        let l:args_str = join(l:args, " ")
        if l:args_str == "d"
            execute "Denite file/rec -path=$HOME/docs"
        elseif l:args_str == "v"
            execute "Denite file/rec -path=$HOME/docs/config_files/nvim"
        elseif l:args_str == "b"
            execute "Denite file/rec -path=$HOME/docs/config_files/bash"
        elseif l:args_str == "s"
            execute "Denite file/rec -path=$HOME/src"
        elseif l:args_str == "g"
            execute "Denite file/rec -path=$HOME/src/github.com"
        elseif l:args_str == "m"
            execute "Denite file/rec -path=$HOME/src/github.com/miyagaw61"
        elseif l:args_str == "t"
            execute "Denite file/rec -path=$HOME/tmp"
        elseif l:args_str == "/"
            execute "Denite file/rec -path=/"
        else
            "let l:open_path = expand(l:args[0])
            "let l:open_fullpath = fnamemodify(l:open_path, ":p")
            "let l:open_dirname = fnamemodify(l:open_fullpath, ":h")
            let l:goto_path = fnamemodify(l:args_str, ":p")
            execute "Denite file/rec -path=" . l:goto_path
        endif
    else
        execute "Denite file/rec -path=$HOME/"
    endif
endfunction

" ReadyNew
" ========
command! -nargs=? -complete=file_in_path ReadyNew call ReadyNew(<f-args>)
function! ReadyNew(...)
    let l:filename = expand('%')
    let l:fullpath = fnamemodify(l:filename, ':p')
    execute 'redir! > /tmp/viming_path'
    execute 'silent! echon "' . l:fullpath . '"'
    execute 'redir END'
    let l:linenr = line('.')
    execute 'redir! > /tmp/viming_linenr'
    execute 'silent! echon "' . l:linenr . '"'
    execute 'redir END'
    normal gt
endfunction

" Sp
" ==
command! -nargs=? -complete=file_in_path Sp call Sp(<f-args>)
function! Sp(...)
    execute 'sp'
    execute 'wincmd j'
    execute 'call Quick_open()'
    normal gt
endfunction

" Sv
" ==
command! -nargs=? -complete=file_in_path Sv call Sv(<f-args>)
function! Sv(...)
    execute 'vs'
    execute 'wincmd l'
    execute 'call Quick_open()'
    normal gt
endfunction

" GoTab
" =====
command! -nargs=? -complete=file_in_path GoTab call GoTab(<f-args>)
function! GoTab(...)
    execute 'ReadyNew'
    execute 'call Quick_open()'
endfunction

" GetBufferFiles
" ==============
command! -nargs=? GetBufferFiles call GetBufferFiles(<f-args>)
function! GetBufferFiles(...)
    let l:infs = getbufinfo()
    execute 'call delete("/tmp/buffer_files")'
    for inf in l:infs
        let l:name = inf.name
        if l:name !~ '/\[[^]]*\][^/]*$'
            execute 'redir! >> /tmp/buffer_files'
            execute 'silent! echon "' . l:name . '\n"'
            execute 'redir END'
        endif
    endfor
endfunction

" GrepBuffers
" ===========
command! -nargs=? GrepBuffers call GrepBuffers(<f-args>)
function! GrepBuffers(...)
    let l:argc = len(a:000)
    let l:args = split(a:000[0], " ")
    let l:args_str = join(l:args, " ")
    execute 'GetBufferFiles'
    let l:cmd = 'rg -nH "' . l:args_str . '" $(cat /tmp/buffer_files) > /tmp/quickfix'
    execute 'silent !' . l:cmd
    execute 'cgetfile /tmp/quickfix | cwindow'
endfunction
