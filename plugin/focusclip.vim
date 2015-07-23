" FocusClip

" Desired behavior: system clipboard in @" when entering vim and last yank
" into @+ when leaving. Only if values changed. I don't want any other
" registers to be modified.

if exists('loaded_focusclip') || &cp || version < 700
    finish
elseif match(&clipboard, 'unnamed') >= 0
    " Since unnamedplus will mess around with the @+ register, we definitely
    " can't allow it to interfere with FocusClip. 'unnamed' also messes with
    " the @" register, so we don't want to allow it either.
    "
    " Also, on Windows 'quotestar' and 'quotestar' are the same, so 'unnamed'
    " and 'unnamedplus' are the same.
    "
    " ref: http://stackoverflow.com/a/30691754/79125
    echoerr "FocusClip conflicts with clipboard=unnamed(plus). Disabling..."
    finish
endif
let loaded_focusclip = 1

augroup focusclip
    au!
    autocmd FocusGained * call focusclip#on_gain_focus() 
    autocmd FocusLost * call focusclip#on_lose_focus() 
augroup end
