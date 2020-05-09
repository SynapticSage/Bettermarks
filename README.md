# Bettermarks

A program to create bash/zsh directory bookmarks, and is designed to mimic iPython's bookmark function, unlike other bookmark programs out there.

# Installation

`git clone https://github.com/SynapticSage/Bettermarks`

and add the following lines into you .bashrc or .zshrc:

```
PATH=${PATH}:<insert path to bettermarks folder>
# Bookmarking code
alias bookmark="bookmark.sh"
source ~/.fs-bookmarks       # (Add bookmark aliases to folders)
source ~/.fs-vars            # Add variable shortcuts (for things like server addesses not part of your file system)
bookmark                     # Display available bookmarks
```

You can now create a bookmark in a folder just by,

`bookmark name_of_bookmark`

You can display available bookmarks by,

`bookmark`

For each bookmarked folder, bettermarks generates an alias `NAME_OF_BOOKMARK` in all future zsh/bash sessions: `alias cd NAME_OF_BOOKMARK=current_working_directory`. I.e., no manual adding of shortcuts to your .bashrc/.zshrc. In addition, bettermarks creates a a variable in every future shell session `$NAME_OF_BOOKMARK` that evalutes to your directory. 

To go back to a bookmarked folder in any future shell session, just type `NAME_OF_BOOKMARK` in all caps. (Caps is used to reduce the probability of a symbol collision.) In addition, not only are aliases created to nav to those folders, but variables that can be used in commands as $NAME_OF_BOOKMARK. Variable storage and bookmarks span across sessions. 

Sometimes you might want to store variables that aren't local folders on your local machine across sessions. For that reason, I've added an ability to encode variables that show up in every bash session, completely separate from folder bookmarking. For instance, rsyncing files to a folder path on a remote computer, one might want to spinup a variable storing that path across bash sessions. 

```
bookmark -v name_of_variable value_of_variable 
```

And to display the available session-wide variables, simply run `bookmark -v`

