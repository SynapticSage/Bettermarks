#!/bin/bash
#
# Auth: Ryan Y
#
# Mimics the bookmark function in iron python
# terminals, to store a database of folders I
# can jump to.

debug=0

bookmark_file="${HOME}/.fs-bookmarks"
if [[ ! -f ${bookmark_file} ]]
then
    echo Creating $bookmark_file
    touch $bookmark_file
fi

##########################
# PARSE OPTIONAL ARGUMENTS
##########################
let LIST=0
let DELETE_ALL=0

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
    -l|--list)
        let LIST=1
        shift # past argument
        ;;
    --delete-all)
    let DELETE_ALL=1
    shift # past argument
    ;;
    -d|--delete)
    DELETE="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
    esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

###################################
## ECHO COMMANDS SO USER CAN SEE ##
###################################

if (($DELETE_ALL == 1)) || (($LIST == 1)) || [[ -n $DELETE ]] && (($debug == 1))
then
    echo "LIST           = ${LIST}"
    echo "DELETE         = ${DELETE}"
fi

#####################
## PERFORM ACTIONS ##
#####################
if (($LIST == 1))
then
    if [[ -n $(cat $bookmark_file) ]]
    then
        echo ---------------------------------------- | lolcat
        printf '\tAvailable bookmarks' | lolcat
        echo ---------------------------------------- | lolcat
        cat $bookmark_file | sed 's/\<alias\>//g' | sed 's/cd //g' | sed 's/=/\t=>\t/g'
        #cat $bookmark_file
        source $bookmark_file
    fi
elif (($DELETE_ALL == 1))
then
    echo Deleting entire bookmark list
    cp $bookmark_file ${bookmark_file}.bak
    echo "" > $bookmark_file
elif [[ -n $DELETE ]]
then
    echo Deleting ${DELETE^^} from $bookmark_file
    delete_awk_program="\$1 != ${DELETE^^} {print \$0}"
    cp $bookmark_file ${bookmark_file}.bak
    cat $bookmark_file | awk -F '[ =]{1,2}' "$delete_awk_program" > $bookmark_file
    unalias ${1^^p} &> /dev/null
else
    bookmark_name=${1:-""}
    if [[ -n $bookmark_name ]]
    then
        echo Adding $1 to $bookmark_file
        bookmark_location=${2:-$(pwd)}
        echo "alias ${bookmark_name^^}='cd $bookmark_location'" >> $bookmark_file
        source $bookmark_file
    else
        echo no input given
    fi
fi
