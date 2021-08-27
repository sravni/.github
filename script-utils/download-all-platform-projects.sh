#!/usr/local/bin/bash

PRJ_ROOT=/Users/vla8islav/repos/team-platform
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORKFLOW_TEMPLATES_DIR=$SCRIPT_DIR/../workflow-templates

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
    # git clone git@github.com:sravni/${prj_name}.git
    cd $prj_name
    cp $WORKFLOW_TEMPLATES_DIR/$pipeline_filename $PRJ_ROOT/$prj_name/.github/workflows/
    # git checkout pe-657
    # git checkout pe-666
done
