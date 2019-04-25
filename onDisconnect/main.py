import boto3
from boto3.dynamodb.conditions import Attr
import json
import os
import logging
import traceback

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def response_proxy(data):
    '''
    For HTTP status codes, you can take a look at https://httpstatuses.com/
    '''
    try:
        response = {}
        response["isBase64Encoded"] = False
        response["statusCode"] = data["statusCode"]
        response["headers"] = {}
        if "headers" in data:
            response["headers"] = data["headers"]
        response["body"] = json.dumps(data["body"])
        return response
    except Exception:
        logger.info(traceback.format_exc())
        return {}


def prep_response(status_code, message):
    '''
    Function template for quick return response
    '''
    data = {}
    data["statusCode"] = status_code
    data["headers"] = {}
    data["body"] = {}
    data["body"]["message"] = message
    return response_proxy(data)



def handler(event, context):
    deleteConnection(event)
    return prep_response(200, "OK")


def deleteConnection(event):
    try:
        connection_id = event['requestContext']['connectionId']
        api_id = event['requestContext']['apiId']
        if connection_id and api_id:
            dynamodb = boto3.resource('dynamodb')
            table = dynamodb.Table(os.getenv("TABLE_NAME"))
            table.delete_item(
                Key={
                    'connectionId': connection_id,
                },
                ConditionExpression=Attr('apiId').eq(api_id),
            )
            return True
    except Exception as e:
        logger.info(e)
        logger.error(e)
        return False
