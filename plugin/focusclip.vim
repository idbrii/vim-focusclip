
" I don't really want deletes to be put on the system clipboard like
" clipboard=unnamedplus.
"
" Behavior I think I want: I want the system clipboard to be put into @" when
" I enter vim (if it changed) and my last yank to be put into @+ when I leave
" (if it changed). I could use FocusGained and FocusLost to manage the
" clipboard myself. I don't want any other registers to be modified.

" TODO: Test this out
finish

if exists('loaded_focusclip') || &cp || version < 700
    finish
elseif match(&clipboard, 'unnamed') >= 0
    echoerr "Autoclip does not work with clipboard=unnamed(plus)"
    finish
endif
let loaded_focusclip = 1

augroup focusclip
    au!
    autocmd FocusGained * call focusclip#on_gain_focus() 
    autocmd FocusLost * call focusclip#on_lose_focus() 
augroup end
