import boto3
import requests
import json
def get_jobs_data():
    url = "https://www.arbeitnow.com/api/job-board-api"
    response = requests.get(url)
    jobdata = response.json()
    return jobdata

def separate_jobs(jobdata):
    filenamesuffix=int(0)
    for jobs in jobdata["data"]:
        s3client = boto3.resource('s3')
        object = s3client.Object('nfish-des-jobdata','jobs'+str(filenamesuffix)+'.json')
        txtdata = str(json.dumps(jobs))
        object.put(Body=txtdata)
        filenamesuffix+=1

jobdata=get_jobs_data()

def lambda_handler(event, context):
    return separate_jobs(jobdata)
