import json
import boto3

s3 = boto3.resource('s3')
bucket = s3.Bucket("melectronx-jobvault")



def get_da_jobs():
    
    file_list = [f for f in bucket.objects.all() if f.key[-4:] == 'json']

    for file in file_list:
        jobs = file.get()['Body'].read().decode(encoding="utf-8", errors="ignore")
    
    print(jobs)    
    return jobs
    