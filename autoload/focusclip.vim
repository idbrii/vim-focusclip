" We use the quoteplus register because according to vim docs, that's the
" "CLIPBOARD" register, whereas quotestar is the selection register.

let g:focusclip_system = @+
let g:focusclip_last_yank = @0

" There's an asymmetry here: We read from the last yanked register, but write
" to the unnamed register. That's to maintain the definition that `"0p` will
" always give the last _vim_ yank. `""p` (or `p`) can always paste from
" anywhere, so we add system clipboard to that list.

function! focusclip#on_gain_focus()
    " If there was a change to the system clipboard register since last time
    " we gained focus, apply it to unnamed register.


    " Update last yank on every entry so when we re-enter vim and yank
    " something different from the clipboard, it always will be applied to the
    " clipboard.
    " Alternatively, move this to after the if?
    let g:focusclip_last_yank = @+

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

