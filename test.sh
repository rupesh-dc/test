#!/bin/bash
# flow.sh feature finish feature_name

# constants
feature="feature"
release="release"
hotfix="hotfix"
bugfix="bugfix"

start="start"
finish="finish"

# command line arguments
branch_type=$1
action_type=$2
branch_name=$3

# if branch type is feature
if [ $branch_type=$feature ]
then
    git checkout develop
    git pull -v
    git flow feature $action_type $branch_name
    if [ $action_type=$start ]
    then
        git checkout feature/$branch_name
        git push --set-upstream origin feature/$branch_name -v
    elif [ $action_type=$finish ] 
    then
        git push -v
    fi

# if branch type is bugfix
elif [ $branch_type=$bugfix ]
then
    git checkout develop
    git pull -v
    git flow bugfix $action_type $branch_name
    if [$action_type=$start]
    then
        git push -u origin bugfix/$branch_name -v
    elif [$action_type=$finish]
    then
        git push -v
    fi
else
    echo "Branch type unknow. Only supports feature, release, hotfix, bugfix"
fi