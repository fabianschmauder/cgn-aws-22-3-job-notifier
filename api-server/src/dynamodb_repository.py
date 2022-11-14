import boto3
from boto3.dynamodb.conditions import Attr, Or
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('jobs')


def get_job_data(id):
    response = table.get_item(
        Key={
            'id': id
        }
    )
    return response['Item']

def list_jobs(search, exclusiveStartKey, limit):
    filter_expression = Or( Attr('title').contains(search), Attr('description').contains(search))
    response = table.scan(
        Limit = limit,  
        FilterExpression = filter_expression,
        ExclusiveStartKey = {"id":exclusiveStartKey}) if  exclusiveStartKey is not None else table.scan(Limit = limit,FilterExpression = filter_expression) 
    return { 
         'items' :response['Items'],
         'LastEvaluatedKey': response['LastEvaluatedKey']
    }
