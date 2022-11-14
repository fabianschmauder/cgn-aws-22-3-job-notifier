import boto3
import os

dynamodb = boto3.resource('dynamodb')

jobs_table_name = os.getenv('JOBS_TABLE_NAME')

jobs_table = dynamodb.Table(jobs_table_name)


def save_job(job):
    jobs_table.put_item(Item = job)

def save_jobs(jobs):
    for job in jobs:
        save_job(job)
