# Bettermarks

A program to create bash/zsh directory bookmarks, and is designed to mimic iPython's bookmark function, unlike other bookmark programs out there.

# Installation

`git clone https://github.com/SynapticSage/Bettermarks`

and add the following lines into you .bashrc or .zshrc:

```
PATH=${PATH}:<insert path to bettermarks folder>
# Bookmarking code
alias bookmark="~/Projects/labscripts/bookmark.sh"
source ~/.fs-bookmarks
bookmark -l
```

You can now create a bookmark in a folder just by,

`bookmark name_of_bookmark`

To go back to the bookmark folder, just type `NAME_OF_BOOKMARK` in all caps. (Caps is used to reduce the probability of a symbol collision.)
