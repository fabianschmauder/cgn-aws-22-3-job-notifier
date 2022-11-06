
import boto3
import requests
import json

def get_job_data():
    url = "https://www.arbeitnow.com/api/job-board-api"
    response = requests.get(url)
    job_data = response.json()
    data= job_data["data"][0]
    s3 = boto3.resource("s3")
    job_info = {
                "Id":data["slug"],
                "Job_title":data["title"],
                "Job_description":data["description"],
                "Remote":data["remote"]
                } 
    with open('job_data.json', "w") as f:
        f.write(json.dumps(job_info))  

    i =1
    for data in job_data["data"]:
        s3.meta.client.upload_file('job_data.json', 'jobdatas3buck', 'job_data' + str(i)+'.json')
        i+=1

def lambda_handler(event, context):
    get_job_data()



