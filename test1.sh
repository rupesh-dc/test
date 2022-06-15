#!bin/bash
get_new_tag() {
    current_tag=$(git describe $(git rev-list --tags --max-count=1))
    arr_tag=(${current_tag//./ })
    version_num=${arr_tag[0]}
    release_num=${arr_tag[1]}
    hotfix_num=${arr_tag[2]}

    branch_type="hotfix"

    if [ $branch_type = "hotfix" ]
    then
        hotfix_num=$(($hotfix_num+1))
    elif [ $branch_type = "release" ]
    then
        release_num=$(($release_num+1))
    fi

    new_tag=$version_num.$release_num.$hotfix_num

    echo $new_tag
}

get_new_tag