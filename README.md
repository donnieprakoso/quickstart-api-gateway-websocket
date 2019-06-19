# Quickstart: Serverless Websocket Communication
With Amazon API Gateway, AWS Lambda and AWS SAM

## Overview
This repo demonstrates how to build and interact with WebSocket API Gateway using Python3.6 and integration with Amazon API Gateway, AWS Lambda, and AWS SAM. This repo is intended for anyone who wants to quickly start their WebSocket project using Python.

## Prerequisites
- Python3.6
- Amazon S3 Bucket -- to store deployment artifacts
- [AWS Command Line Interface](https://aws.amazon.com/cli/)
- [AWS Serverless Application Model CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-mac.html) 
- Strong will to debug in case the written steps below don't work for you

## Deployment
The fastest way to build and deploy the components on this app is to use AWS SAM. The little geeky squirrel has a cool 'sam build' command that iterates through all functions, manifest file(s), and build deployment artifacts for the subsequent commands 'sam package' and 'sam deploy'. 

To make it easier for you, you can run a file called "build.sh" which will get the deployment job done. If you choose to use "build.sh", you need to create an S3 bucket to store your deployment artifacts and then change the configuration on "build.sh" as shown below. 

```bash
S3_BUCKET_NAME='xxx.yyy.zzz' # PLEASE CHANGE TO YOUR S3 BUCKET REPO FOR STORING ARTIFACTS
```

## WebSocket Testing
Once the deployment phase is done, we can proceed to test this app by connecting to WebSocket URI. There are a few things that we need to do:
1. Get the WebSocket URI by calling "aws cloudformation" command.
```bash
aws cloudformation describe-stacks --stack-name QuickstartWebsocket --query 'Stacks[0].Outputs[?OutputKey==`WebSocketURI`].OutputValue'
```
2. Connect to the WebSocket URI by using [wscat](https://github.com/websockets/wscat) tool. 
3. Test the app by sending message
```json
{"message":"request","text":"hello world"}
```

If everything works well, WebSocket will return what you set as "text" value.

## Few Inspirations for You
Going forward, you can use this repo for:
1. Start your simple echo WebSocket project 
2. Harnessing the security by implementing authentication for any WebSocket requests
3. Build an asynchronous based-communication for microservices by integrating WebSocket and PubSub pattern with Amazon SNS and Amazon SQS. 

Feel free to file any issues, pull reqs or reach out to me at [@donnieprakoso](https://twitter.com/donnieprakoso) if you want to discuss more this repo. 

**GO BUILD!**
