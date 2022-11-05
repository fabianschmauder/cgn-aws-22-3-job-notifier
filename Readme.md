# Fetch jobs from url using Lambda function

## Fetch jobs from url

import boto3
import requests
import json
def get_jobs_data():
    url = "https://www.arbeitnow.com/api/job-board-api"
    response = requests.get(url)
    job_data = response.json()
    return job_data

    with open('jobs'+str(filenamesuffix)+'.json' ,'w') as file:
        file.write(json.dumps(job_data))

def separate_jobs(job_data):
    filenamesuffix=int(0)
    for jobs in job_data["data"]:

        s3_client = boto3.resource('s3')
        object = s3_client.Object('wale-friday-bucket','jobs'+str(filenamesuffix)+'.json')
        txt_data = str(json.dumps(jobs))
        object.put(Body=txt_data)
        # source: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#object
        # source: https://www.stackvidhya.com/write-a-file-to-s3-using-boto3/
        ###
        filenamesuffix+=1

job_data=get_jobs_data()
separate_jobs(job_data)

def lambda_handler(event, context):
    return separate_jobs(job_data)
