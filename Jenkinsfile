#!/bin/bash
 
export AWS_DEFAULT_REGION="ap-south-1"
export APP_NAME="champ"
export ENV_NAME="champ-env"
export S3_BUCKET="elasticbeanstalk-ap-south-1-996034040698"
export APP_VERSION=$(git rev-parse --short HEAD)
 
fail_check () {
    if [ $? -ne 0 ]; then
        echo "Failed"
        exit 1
    fi
}
 
# Create EBS package
{ set +x; } 2>/dev/null
printf "\n\n##### Zip up package to deploy to EBS #####\n"
git clean -fd
zip -x *.git* -r "${APP_NAME}-${APP_VERSION}.zip" .
 
# Deploy EBS package
aws elasticbeanstalk delete-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}"  --delete-source-bundle
aws s3 cp "${APP_NAME}-${APP_VERSION}.zip" "s3://${S3_BUCKET}/${APP_NAME}-${APP_VERSION}.zip"
aws elasticbeanstalk create-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}" --source-bundle S3Bucket="${S3_BUCKET}",S3Key="${APP_NAME}-${APP_VERSION}.zip"
aws elasticbeanstalk update-environment --environment-name "${ENV_NAME}" --version-label "${APP_VERSION}"
 
# Print VPC Peering Connection ID for reference
echo "VPC Peering Connection ID: $PEERING_CONNECTION_ID"
 
# Sleep before checking health of the app
sleep 60
 
# Check on application status
{ set +x; } 2>/dev/null
