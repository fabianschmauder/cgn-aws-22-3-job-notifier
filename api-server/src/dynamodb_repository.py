import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('jobs')


def get_job_data(id):
    response = table.get_item(
        Key={
            'id': id
        }
    )
    return response['Item']

def list_jobs(exclusiveStartKey, limit):
    response = table.scan(Limit = limit,  ExclusiveStartKey = {"id":exclusiveStartKey}) if  exclusiveStartKey is not None else table.scan(Limit = limit) 
    return { 
         'items' :response['Items'],
         'LastEvaluatedKey': response['LastEvaluatedKey']
    }