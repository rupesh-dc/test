#!/bin/bash
# flow.sh feature finish feature_name

# branch constants
feature="feature"
release="release"
hotfix="hotfix"
bugfix="bugfix"

# action type constants
start="start"
finish="finish"

# command line arguments
branch_type=$1
action_type=$2
branch_name=$3

echo $branch_type
echo $action_type
echo $branch_name

# function to get new tag number based on latest tag and branch_type
get_new_tag() {
    current_tag=$(git describe $(git rev-list --tags --max-count=1))
    arr_tag=(${current_tag//./ })
    version_num=${arr_tag[0]}
    release_num=${arr_tag[1]}
    hotfix_num=${arr_tag[2]}

    if [ $branch_type = $hotfix ]
    then
        hotfix_num=$(($hotfix_num+1))
    elif [ $branch_type = $release ]
    then
        release_num=$(($release_num+1))
        hotfix_num=0
    fi

    new_tag=$version_num.$release_num.$hotfix_num

    echo $new_tag
}

git fetch -v

# if branch type is feature
if [[ $branch_type == $feature ]]
then
    echo "inside feature block"
    git checkout develop
    git pull -v
    if [ $action_type = $start ]
    then
        git flow $feature $action_type $branch_name
        git push --set-upstream origin $feature/$branch_name -v
    elif [ $action_type = $finish ] 
    then
        git flow $feature $action_type $branch_name --push
    fi
# if branch type is bugfix
elif [[ $branch_type == $bugfix ]]
then
    git checkout develop
    git pull -v
    echo $bugfix
    echo $action_type
    if [ $action_type = $start ]
    then
        git flow $bugfix $action_type $branch_name
        git push --set-upstream origin $bugfix/$branch_name -v
    elif [ $action_type = $finish ]
    then
        git flow $bugfix $action_type $branch_name --push
    fi
# if branch type is hotfix
elif [[ $branch_type == $hotfix ]]
then
    git checkout master
    git pull -v
    tag=$(get_new_tag)
    if [ $action_type = $start ]
    then
        git flow $hotfix $action_type $tag
        git push --set-upstream origin $hotfix/$tag -v
    elif [ $action_type = $finish ]
    then
        git flow $hotfix $action_type $tag --push
    fi
# if branch type is hotfix
elif [[ $branch_type == $release ]]
then
    git checkout develop
    git pull -v
    tag=$(get_new_tag)
    if [ $action_type = $start ]
    then
        git flow $hotfix $action_type $tag
        git push --set-upstream origin $hotfix/$tag -v
    elif [ $action_type = $finish ]
    then
        git flow $hotfix $action_type $tag --push
    fi
else
    echo "Branch type unknow. Only supports feature, release, hotfix, bugfix"
fi