import boto3
import json


def lambda_handler(event, context):
    ssm_client = boto3.client('ssm', region_name="us-east-1", use_ssl=False)
    value = ssm_client.get_parameter(Name='/params/vini')
    return {
        'statusCode': 200,
        'body': json.dumps({"message": "hello world", "ssm": value})
    }
