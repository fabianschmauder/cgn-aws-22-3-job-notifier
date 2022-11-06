
import requests
import boto3
import json

s3_client = boto3.resource('s3')
bucket = "melectronx-jobvault"

        
def get_job_data():
    
    response = requests.get("https://www.arbeitnow.com/api/job-board-api")
    return response.json()



def putter(job_input, filename):
    
    object = s3_client.Object(bucket, filename)
    body = json.dumps(job_input)
    object.put(Body=body)

def jobvault_main():
    
    jobs = get_job_data()
    for job in jobs["data"]:
        filename = job["slug"]+".json"
        putter(job, filename)

def lambda_handler(event, context):
    
    jobvault_main()
    
    print("Jobvault updated!")