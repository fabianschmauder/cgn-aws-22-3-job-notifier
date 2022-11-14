import boto3

dynamodb = boto3.resource('dynamodb')

jobs_table_name = "jobs"

jobs_table = dynamodb.Table(jobs_table_name)

def save_job(job):
    jobs_table.put_item(Item = job)

def save_jobs(jobs):
    for job in jobs:
        save_job(job)