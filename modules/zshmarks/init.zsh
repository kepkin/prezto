# ------------------------------------------------------------------------------
#          FILE:  zshmarks.plugin.zsh
#   DESCRIPTION:  oh-my-zsh plugin file.
#        AUTHOR:  Jocelyn Mallon
#       VERSION:  1.5.0
# ------------------------------------------------------------------------------

__zshmarks_bookmarks_file="$HOME/.bookmarks"

# Create __zshmarks_bookmarks_file it if it doesn't exist
if [[ ! -f $__zshmarks_bookmarks_file ]]; then
    touch $__zshmarks_bookmarks_file
fi

__bookmark_search_by_name() {
    grep -P "^$1\t" $__zshmarks_bookmarks_file
}

function bmark() {
    bookmark_name=$1
    bookmark_cmd="${@:2}"
    if [[ -z $bookmark_name ]]; then
        echo 'Invalid name, please provide a name for your bookmark. For example:'
        echo '  $0 foo'
        return 1
    fi
    if [[ -z $bookmark_cmd ]]; then
        echo 'Invalid commandline, please provide a name for your bookmark. For example:'
        echo '  $0 foo'
        return 1
    fi
    # Store the bookmark as: name\tcmd
    if [[ -z $(__bookmark_search_by_name $bookmark_name) ]]; then
        echo "$bookmark_name\t$bookmark_cmd" >> $__zshmarks_bookmarks_file
        echo "Bookmark '$bookmark_name' saved"
    else
        echo "Bookmark already existed"
        return 1
    fi
}

function bmarkdo() {
    bookmark_name=$1
    bookmark="$(__bookmark_search_by_name $bookmark_name)"
    if [[ -z $bookmark ]]; then
        echo "Invalid name, please provide a valid bookmark name. For example:"
        echo "  bmarkdo foo"
        echo
        echo "To bookmark a folder, go to the folder then do this (naming the bookmark 'foo'):"
        echo "  bookmark foo"
        return 1
    else
        cmd=$( echo ${bookmark} | sed "s/^[^\t]*\t//")
        echo $cmd
        eval $cmd
    fi
}

# Show a list of the bookmarks
function showmarks() {
    cat ~/.bookmarks
}
