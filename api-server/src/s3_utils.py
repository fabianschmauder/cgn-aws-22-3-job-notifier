import json
import boto3

s3 = boto3.resource('s3')

job_data_bucket_name= "nice-s3-bucket-for-jobs1234"
bucket = s3.Bucket(job_data_bucket_name)

def list_jobs():
    job_ids = []
    for obj in bucket.objects.all():
        job_ids.append(obj.key[:-5])
    return job_ids

def get_job_data(id):
    obj = s3.Object(job_data_bucket_name, id+".json")
    job_string = obj.get()['Body'].read().decode('utf-8')
    return json.loads(job_string)
