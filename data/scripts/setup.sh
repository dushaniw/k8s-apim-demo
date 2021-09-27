#!/bin/bash

###### testing
# export APIM_HOST=localhost RETRY_SEC=10 RE_RUN=true
######

apim=am.wso2.com
export apim
retry=10
re_run="false"
echo "Waiting for WSO2 API Manager to start..."

while ! nc -z $apim 443; do   
  echo "Retrying after " $retry "s..."
  sleep $retry
done

#if [ $re_run -eq "true" ]
#then
#   rm lock
#fi
echo "WSO2 API Manager started"

## check if already created

FILE=lock
if (! test -f "$FILE"); then
    
echo "Creating tenants"

#sh tenant-creation.sh
cd quantis-resources
sh deploy-api.sh

#cd gogo-resources
#sh deploy-api.sh

#cd ../railco-resources
#sh deploy-api.sh

# back to home
cd ../ 
# create a file to prevent re-run
echo "created" >> lock

fi

echo "=================================Data population completed======================================================"
