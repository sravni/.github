#!/bin/bash

# ./update-pipeline-all-platform-projects.sh -p '/Users/vla8islav/repos/team-platform' -b pe-666

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORKFLOW_TEMPLATES_DIR=$SCRIPT_DIR/../workflow-templates

usage() { echo "Usage: $0 [-p dir_for_git_checkout] [-b new_branch_name]" 1>&2; exit 1; }

while getopts ":p:b:" o; do
    case "${o}" in
        p)
            PRJ_ROOT=${OPTARG}
            ;;
        b)
            TARGET_BRANCH=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


declare -A platPrj

platPrj[paymentgateway]=dotnet-service-deploy-pipeline.yml
platPrj[urlshrinker]=dotnet-service-deploy-pipeline.yml
platPrj[ipgeo]=dotnet-service-deploy-pipeline.yml
platPrj[codeinterview-frontend]=mono-repo-service-deploy-pipeline.yml
platPrj[codeinterview-service]=mono-repo-service-deploy-pipeline.yml
platPrj[ab-backoffice]=mono-repo-service-deploy-pipeline.yml
platPrj[ab-service]=mono-repo-service-deploy-pipeline.yml
platPrj[distributor-frontend]=mono-repo-service-deploy-pipeline.yml
platPrj[metadata]=dotnet-service-deploy-pipeline.yml
platPrj[memory]=dotnet-service-deploy-pipeline.yml
platPrj[messagesender]=dotnet-service-deploy-pipeline.yml
platPrj[reception]=dotnet-service-deploy-pipeline.yml
platPrj[phoneverifier]=dotnet-service-deploy-pipeline.yml
platPrj[namesuggest]=dotnet-service-deploy-pipeline.yml
platPrj[geocoding]=dotnet-service-deploy-pipeline.yml
platPrj[apigateway]=dotnet-service-deploy-pipeline.yml
platPrj[mobileapigateway]=dotnet-service-deploy-pipeline.yml
platPrj[locations]=dotnet-service-deploy-pipeline.yml
platPrj[identity]=raw-k8s-dotnet-service-deploy-pipeline.yml


for key in "${!platPrj[@]}"; do 
    prj_name=$key;
    pipeline_filename=${platPrj[$key]} 
    cd $PRJ_ROOT
    git clone git@github.com:sravni/${prj_name}.git
    cd $prj_name
    git checkout -b $TARGET_BRANCH
    cp $WORKFLOW_TEMPLATES_DIR/$pipeline_filename $PRJ_ROOT/$prj_name/.github/workflows/
    git branch --show-current
    git add . && git commit -m "Added a separate yaml for yandex stage deployment" && git push
    # git checkout -b pe-666
    # git checkout pe-657
    # git checkout pe-666
done
