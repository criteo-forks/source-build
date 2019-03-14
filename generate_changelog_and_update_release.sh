#!/bin/bash -xe

branch_or_tag=$1
github_token=$2
original_branch_or_tag=${branch_or_tag%%-*}

echo "Generate change log for $branch_or_tag"

function build_change_log_from()
{
   original_branch_or_tag=$1

   git submodule foreach --quiet "remote=\$(git config --get remote.origin.url | grep -F \"criteo-forks\"); if [ ! -z \$remote ]; then commits_logs=\$(git log v2.2.2..HEAD); if [ ! -z \"\$commits_logs\" ];then echo \"## \$displaypath\n\";echo \"\$commits_logs\n\n\"; fi;fi"
}

echo -e "# Changelog $branch_or_tag\n\n" > changelog

if [ $branch_or_tag == $original_branch_or_tag ]
then
   echo "not possible to build the changelog"
   git log -1 --pretty=format:%b >> changelog
else
    changelog=$(build_change_log_from $original_branch_or_tag)
    if [ -z "$changelog" ]
    then
        echo "Vanilla version" >> changelog
    else
        echo -e "$changelog" >> changelog
    fi
fi

echo "Create or update GitHub release for $branch_or_tag"
ruby github_release.rb -s "$github_token" -r "criteo-forks/source-build" -c changelog -t "$branch_or_tag"
