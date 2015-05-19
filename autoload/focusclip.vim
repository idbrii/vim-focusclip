let g:focusclip_system = @+
let g:focusclip_last_yank = @0

" There's an asymmetry here: We read from the last yanked register, but modify
" the unnamed register. That's so that `"0p` will always give a vim yank and
" `p` will paste from system clipboard.

function! focusclip#on_gain_focus()
    " If there was a change to the system clipboard register since last time
    " we gained focus, apply it to unnamed register.
    if g:focusclip_system == @+
        return
    endif
    let g:focusclip_system = @+

    let @" = @+
endf

function! focusclip#on_lose_focus()
    " If there was a change to the last yank register since last time we
    " gained focus, apply it to system clipboard register.
    if g:focusclip_last_yank == @0
        return
    endif
    let g:focusclip_last_yank = @0

    let @+ = @0
endf

