" FocusClip

" clipboard=unnamed makes @* and @" the same register. But the most common
" reason to access the system clipboard is because you were in another
" application and you want to copy from there or you're copying something out
" of vim and want to switch to another application and paste it there.
"
" Instead of reducing the number of registers, FocusClip only interacts with
" the system clipboard when vim gains/loses focus.

" Also, vim puts lots of stuff in registers (deletes), but you usually don't
" want to copy those to another application (like clipboard=unnamed).
"
" Desired behavior: I want the system clipboard to be put into @" when I enter
" vim (if it changed) and my last yank to be put into @+ when I leave (if it
" changed). I could use FocusGained and FocusLost to manage the clipboard
" myself. I don't want any other registers to be modified.

if exists('loaded_focusclip') || &cp || version < 700
    finish
elseif match(&clipboard, 'unnamed') >= 0
    echoerr "Autoclip does not work with clipboard=unnamed(plus). Aborting."
    finish
endif
let loaded_focusclip = 1

augroup focusclip
    au!
    autocmd FocusGained * call focusclip#on_gain_focus() 
    autocmd FocusLost * call focusclip#on_lose_focus() 
augroup end
