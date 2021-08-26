#!/bin/bash

declare -A platPrj

platPrj["paymentgateway"]=dotnet-service-deploy-pipeline.yml
platPrj["urlshrinker"]=dotnet-service-deploy-pipeline.yml
platPrj["ipgeo"]=dotnet-service-deploy-pipeline.yml
platPrj["codeinterview-frontend"]=mono-repo-service-deploy-pipeline.yml
platPrj["codeinterview-service"]=mono-repo-service-deploy-pipeline.yml
platPrj["ab-backoffice"]=mono-repo-service-deploy-pipeline.yml
platPrj["ab-service"]=mono-repo-service-deploy-pipeline.yml
platPrj["distributor-frontend"]=mono-repo-service-deploy-pipeline.yml
platPrj["metadata"]=dotnet-service-deploy-pipeline.yml
platPrj["memory"]=dotnet-service-deploy-pipeline.yml
platPrj["messagesender"]=dotnet-service-deploy-pipeline.yml
platPrj["reception"]=dotnet-service-deploy-pipeline.yml
platPrj["phoneverifier"]=dotnet-service-deploy-pipeline.yml
platPrj["namesuggest"]=dotnet-service-deploy-pipeline.yml
platPrj["geocoding"]=dotnet-service-deploy-pipeline.yml
platPrj["apigateway"]=dotnet-service-deploy-pipeline.yml
platPrj["mobileapigateway"]=dotnet-service-deploy-pipeline.yml
platPrj["locations"]=dotnet-service-deploy-pipeline.yml
platPrj["identity"]=raw-k8s-dotnet-service-deploy-pipeline.yml
