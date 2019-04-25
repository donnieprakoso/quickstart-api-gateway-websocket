#!/bin/bash

S3_BUCKET_NAME='xxx.yyy.zzz' # PLEASE CHANGE TO YOUR S3 BUCKET REPO FOR STORING ARTIFACTS
S3_PREFIX='quickstart-websocket'
STACK_NAME='QuickstartWebsocket'
REGION='ap-southeast-1'
SAM_TEMPLATE_FILE='.aws-sam/build/template.yaml'
CF_PACKAGED_TEMPLATE_FILE='.aws-sam/build/packaged-template.yaml'
sam build
[ $? -eq 0 ] && echo "BUILD PASSED" || ( echo "BUILD FAILED"; exit 1 )
aws cloudformation package --template-file $SAM_TEMPLATE_FILE --s3-bucket $S3_BUCKET_NAME --s3-prefix $S3_PREFIX --output-template-file $CF_PACKAGED_TEMPLATE_FILE --region $REGION
[ $? -eq 0 ] && echo "PACKAGING PASSED" || ( echo "PACKAGING FAILED"; exit 1 )
aws cloudformation deploy --template-file $CF_PACKAGED_TEMPLATE_FILE --stack-name $STACK_NAME --capabilities "CAPABILITY_IAM" --region $REGION
[ $? -eq 0 ] && echo "DEPLOYED" || ( echo "DEPLOYMENT FAILED"; exit 1 )
echo "WebSocket URI:"
aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[0].Outputs[?OutputKey==`WebSocketURI`].OutputValue'

