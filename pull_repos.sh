#! /bin/bash

parent_dir=$PWD;
for repo in `find . -name ".git" | grep -v rakudo`; do
    cd $repo/..;
    echo "$(tput setaf 3)Repository: $PWD$(tput sgr0)"
    current_branch=$(git branch | awk '/^\*/{print $2}')
    if [ $current_branch == 'master' ]
        then
            if [[ $(git status --porcelain | grep -v \?\?) ]]
                then

                    echo "$(tput setaf 6)Saving stash for: $current_branch$(tput sgr0)"
                    git stash save
                    echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
                    git pull
                    echo "$(tput setaf 6)Re-applying Stash to branch $current_branch$(tput sgr0)"
                    git stash pop

                else

                    echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
                    git pull

            fi
        else
            if [[ $(git status --porcelain | grep -v \?\?) ]]
                then

                    echo "$(tput setaf 6)Saving stash for: $current_branch$(tput sgr0)"
                    git stash save
                    echo "$(tput setaf 6)Switching to branch master$(tput sgr0)"
                    git checkout master -q
                    echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
                    git pull
                    echo "$(tput setaf 6)Returning to branch $current_branch$(tput sgr0)"
                    git checkout $current_branch -q
                    echo "$(tput setaf 6)Re-applying Stash to branch $current_branch$(tput sgr0)"
                    git stash pop

                else

                    echo "$(tput setaf 6)Switching to branch master$(tput sgr0)"
                    git checkout master -q
                    echo "$(tput setaf 2)Pulling branch master$(tput sgr0)"
                    git pull
                    echo "$(tput setaf 6)Returning to branch $current_branch$(tput sgr0)"
                    git checkout $current_branch -q

            fi
    fi

    cd $parent_dir
    echo ""

done
