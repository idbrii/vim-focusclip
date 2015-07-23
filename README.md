# FocusClip

Integrate vim and your system clipboard without messing everything up.

## Why not clipboard=unnamedplus?
Using `clipboard=unnamedplus` makes `@+` and `@"` the same register. But the most
common reason to access the system clipboard is because you were in another
application and you want to copy from there or you're copying something out of
vim and want to switch to another application and paste it there.

Instead of reducing the number of registers, FocusClip only interacts with the
system clipboard when vim gains/loses focus. This way you'll always be able to
access the last system clipboard yank from `@+` instead of it being lost when
you delete something.

Also, vim frequently changes registers (line, word, character deletes and
yanks) and clipboard=unnamedplus puts these on your system clipboard. You usually
don't want to copy those to another application, so we only use the yank
register `@0`.

Finally, I dislike how `clipboard=unnamedplus` redirects `p` to different registers instead of copying content to `@"`:

    $ gvim -Nu NONE +"source ~/.vim/bundle/sensible/plugin/sensible.vim" +"set clipboard=unnamedplus"
    Copy from external application.
    `p` in vim and it pastes external yank
    Type several lines of text
    Yank a line with `yy`
    `p` and it pastes the external yank, but I want to put what I just yanked.


## Desired Behavior

* System clipboard copied into `@"` when entering vim.
* Last yank to be put into `@+` when leaving vim.
* Registers only change if the source differs from the last copy.
 * Ensures `@"` and `@+` are only clobbered by copy actions and not just focus changes.
* No other registers are modified.
* Yanks to a named register are ignored. (`"ayy` will not be copied to system clipboard.)


## Requirements

Vim built with `+clipboard` on Windows or `+clipboard +xterm_clipboard` on X11 systems.

'clipboard' option is not set to 'unnamed' or 'unnamedplus'.

Use gvim or a terminal supporting vim's FocusGained/FocusLost events.


## Example Usage

FocusClip uses no mappings, so you can copy and paste like normal. Here's some specific examples of how it behaves.

* In vim, yank some text with `yy`. Switch to another application and paste it.
* Copy some text in that other application. Switch to vim and paste it with `p` or `C-r "` in insert mode.
* Do a bunch of yanking, deleting, and editing.
* Paste from system clipboard with `"+p` -- that external yank is still maintained until you leave vim!

