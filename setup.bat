@echo off
setlocal enabledelayedexpansion

set question=What do your prefer?

set vimpath=C:%HOMEPATH%

set p="call plug#begin()"
set p=%p:"=%


echo %p%  > %TEMP%/pluginstall.txt
type nul > %TEMP%/settings.txt


:darkmode
        set question=[1 - dark, 2 - light 3 - dont install]: 
        call :makecolor

        set /p choice=Light or dark theme? %question%

        if %choice%==1 (
            set t="Plug 'sonph/onehalf', { 'rtp': 'vim' }"
            set t=!t:"=!
            
            set s1="colorscheme onehalfdark"
            set s2="let g:airline_theme='onehalfdark'"

            set tt="\<Esc>[38;2;%%lu;%%lu;%%lum"
            set tt1="\<Esc>[48;2;%%lu;%%lu;%%lum"

            set s3="if exists('+termguicolors')"
            set s4=  let ^&t_8f = !tt!
            set s5=  let ^&t_8b = !tt1!
            set s6="  set termguicolors"
            set s7="endif"

            set s1=!s1:"=!
            set s2=!s2:"=! 
            set s3=!s3:"=! 
            set s6=!s6:"=! 
            set s7=!s7:"=! 


            ( echo !t!) >> %TEMP%/pluginstall.txt
            ( echo !s1! & echo !s2! & echo !s3! & echo !s4! & echo !s5! & echo !s6! & echo !s7!) >> %TEMP%/settings.txt

            goto :filetree
        ) 
        if %choice%==2 (
            set t="Plug 'sonph/onehalf', { 'rtp': 'vim' }"
            set t=!t:"=!
            
            set s1="colorscheme onehalflight"
            set s2="let g:airline_theme='onehalflight'"

            set s1=!s1:"=!
            set s2=!s2:"=!

            ( echo !t!) >> %TEMP%/pluginstall.txt
            ( echo !s1! & echo !s2!) >> %TEMP%/settings.txt


            goto :filetree
        )
        if %choice%==3 (
            goto :filetree
        )
    goto :darkmode

:filetree
    set question=[1 - auto open, 2 - auto close 3 - both 4 - dont install]: 
    call :makecolor

    set /p choice=File tree? %question%
    if %choice%==1 (
        set t="Plug 'preservim/nerdtree'"
        set t=!t:"=!
        
        set s1="autocmd VimEnter * NERDTree | wincmd p"

        set s1=!s1:"=!

        ( echo !t!) >> %TEMP%/pluginstall.txt
        ( echo !s1!) >> %TEMP%/settings.txt

        goto :emmet
    )
    if %choice%==2 (
        set t="Plug 'preservim/nerdtree'"
        set t=!t:"=!
        
        set s1="autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"

        set s1=!s1:"=!

        ( echo !t!) >> %TEMP%/pluginstall.txt
        ( echo !s1!) >> %TEMP%/settings.txt

        goto :emmet
    )
    if %choice%==3 (
        set t="Plug 'preservim/nerdtree'"
        set t=!t:"=!
        
        set s1="autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"
        set s2="autocmd VimEnter * NERDTree | wincmd p"

        set s1=!s1:"=!
        set s2=!s2:"=!


        ( echo !t!) >> %TEMP%/pluginstall.txt
        ( echo !s1! & echo !s2!) >> %TEMP%/settings.txt

        goto :emmet
    )
    if %choice%==4 (
        goto :emmet
    )
    goto :filetree

:emmet
    set question=[1 - install, 2 - dont install]: 
    call :makecolor

    set /p choice=Install Emmet? %question%

    if %choice%==1 (
        set t="Plug 'mattn/emmet-vim'"
        set t=!t:"=!
        
        set s1="let g:user_emmet_install_global = 0"
        set s2="autocmd FileType html,css EmmetInstall"

        set s1=!s1:"=!
        set s2=!s2:"=!


        ( echo !t!) >> %TEMP%/pluginstall.txt
        ( echo !s1! & echo !s2!) >> %TEMP%/settings.txt

        goto :commentary
    )
    if %choice%==2 (
        goto :commentary
    )
    goto :emmet

:commentary
    set question=[1 - install, 2 - dont install]: 
    call :makecolor

    set /p choice=Install vim-commentary? %question%

    if %choice%==1 (
        set t="Plug 'tpope/vim-commentary'"
        set t=!t:"=!

        ( echo !t!) >> %TEMP%/pluginstall.txt

        goto :airline
    )
    if %choice%==2 (
        goto :airline
    )
    goto :commentary

:airline
    set question=[1 - install, 2 - dont install]: 
    call :makecolor

    set /p choice=Install vim-airline? %question%

    if %choice%==1 (
        set t="Plug 'vim-airline/vim-airline'"
        set t=!t:"=!

        ( echo !t!) >> %TEMP%/pluginstall.txt

        goto :snippets
    )
    if %choice%==2 (
        goto :snippets
    )
    goto :airline

:snippets
    set question=[1 - install, 2 - dont install]: 
    call :makecolor

    set /p choice=Add code snippets? %question%

    if %choice%==1 (
        set t="Plug 'MarcWeber/vim-addon-mw-utils'"
        set t1="Plug 'tomtom/tlib_vim'"
        set t2="Plug 'garbas/vim-snipmate'"
        set t3="Plug 'honza/vim-snippets'"

        set t=!t:"=!
        set t1=!t1:"=!
        set t2=!t2:"=!
        set t3=!t3:"=!

        set s1="let g:snipMate = { 'snippet_version' : 1 }"
        set s1=!s1:"=!

        ( echo !t! & echo !t1! & echo !t2! & echo !t3!) >> %TEMP%/pluginstall.txt
        ( echo !s1!) >> %TEMP%/settings.txt

        goto :installPlugins
    )
    if %choice%==2 (
        goto :installPlugins
    )
    goto :snippets

:installPlugins
    set p="call plug#end()"
    set p=%p:"=%
    cmd /c "cd /d %TEMP% "

    (echo !p!) >> %TEMP%/pluginstall.txt

    copy %TEMP%\pluginstall.txt %TEMP%\_vimrc > nul
    move %TEMP%\_vimrc %vimpath% > nul
    

    if exist %vimpath%\vimfiles (
        rd /s /q %vimpath%\vimfiles
        md %vimpath%\vimfiles\autoload
        @powershell -Command "(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')" > %vimpath%/vimfiles/autoload/Plug.vim
    )
    if not exist %vimpath%\vimfiles (
        md %vimpath%\vimfiles\autoload
        @powershell -Command "(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')" > %vimpath%/vimfiles/autoload/Plug.vim 
    )

    cmd /c "cd /d %vimpath%/vimfiles/autoload && (for /f "delims=" %%i in (Plug.vim) do @echo %%i)>Plug1.vim && del Plug.vim && rename Plug1.vim Plug.vim"


    vim -c :PlugInstall -c :qa

    copy %TEMP%\pluginstall.txt + %TEMP%\settings.txt _vimrc > nul
    move _vimrc %vimpath% > nul

    @REM cmd /c "C: && cd Desktop && vim app.js"
    
    set question=Nothing crashed, have fun!
    call :makecolor
    echo.
    echo ------------------
    echo %question%
    echo ------------------

    pause
goto :eof

:makecolor
set temp1=%question%
set question=[32m[1m%temp1%[0m[0m
goto :eof