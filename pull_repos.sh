#! /bin/bash

parent_dir=$PWD;
for repo in `find . -name ".git" | grep -v rakudo`; do
    cd $repo/..;                            # go into repository folder
    echo "$(tput setaf 3)Repository: $PWD$(tput sgr0)"
    current_branch=$(git branch | awk '/^\*/{print $2}')
    if ! [ $current_branch == 'master' ]    # if branch is not master
        then                                # then
            echo "$(tput setaf 6)Saving stash for: $current_branch$(tput sgr0)"
            git stash save                # save a stash
            echo "$(tput setaf 6)Switching to branch master$(tput sgr0)"
            git checkout master -q          # switch to branch master
            echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
            git pull                        # pull master
            echo "$(tput setaf 6)Returning to branch $current_branch$(tput sgr0)"
            git checkout $current_branch -q # switch back to current_branch
            echo "$(tput setaf 6)Re-applying Stash to branch $current_branch$(tput sgr0)"
            git stash pop                   # pop stash
        else                                # else (branch IS master)
            echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
            git pull                        # pull master
    fi                                      # end of IF
    cd $parent_dir                          # go back to $PWD
    echo ""
done
