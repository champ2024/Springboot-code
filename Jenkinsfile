# Set environment variables
export AWS_DEFAULT_REGION="ap-south-1"
export APP_NAME="champ"
export ENV_NAME="Champ-env"
export S3_BUCKET="elasticbeanstalk-ap-south-1-996034040698"
export APP_VERSION=$(git rev-parse --short HEAD)

# Function to check command execution status
fail_check () {
    if [ $? -ne 0 ]; then
        echo "Failed"
        exit 1
    fi
}

# Zip up package to deploy to Elastic Beanstalk
printf "\n\n##### Zipping up package to deploy to Elastic Beanstalk #####\n"
git clean -fd
zip -x *.git* -r "${APP_NAME}-${APP_VERSION}.zip" .

# Deploy package to Elastic Beanstalk
printf "\n\n##### Deploying package to Elastic Beanstalk #####\n"
aws elasticbeanstalk delete-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}" --delete-source-bundle
fail_check
aws s3 cp "${APP_NAME}-${APP_VERSION}.zip" "s3://${S3_BUCKET}/${APP_NAME}-${APP_VERSION}.zip"
fail_check
aws elasticbeanstalk create-application-version --application-name "${APP_NAME}" --version-label "${APP_VERSION}" --source-bundle S3Bucket="${S3_BUCKET}",S3Key="${APP_NAME}-${APP_VERSION}.zip"
fail_check
aws elasticbeanstalk update-environment --environment-name "${ENV_NAME}" --version-label "${APP_VERSION}"
fail_check

# Sleep before checking health of the application
sleep 60

# Check application status
printf "\n\n##### Checking application status #####\n"
aws elasticbeanstalk describe-environment-health --environment-name "${ENV_NAME}"
