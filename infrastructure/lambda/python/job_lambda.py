import json
import requests
import boto3

api_url = "https://www.arbeitnow.com/api/job-board-api?page="

def get_json(urlVar):
    try:
        res = requests.get(urlVar)
        return res.json()
    except requests.exceptions.RequestException as e:
        raise SystemExit(e)

def create_job(singleJsonObject):
    return {
        "id": singleJsonObject["slug"],
        "title": singleJsonObject["title"],
        "description": singleJsonObject["description"]
    }

def save_job(jsonJob):
    s3_client = boto3.client('s3')
    return s3_client.put_object(Body=json.dumps(jsonJob), Bucket='ip-job-bucket', Key=jsonJob['id']+'.json')

def lambda_handler(event, context):
    result_array = {"saved": [], "failed": []}
    page = '1'
    while True:
        json = get_json(api_url + page)
        jobsArray = json["data"]
        for job in jobsArray:
            try:
                jobJson = create_job(job)
                save_job(jobJson)
                result_array['saved'].append(jobJson)
            except:
                result_array['saved'].append(job)

        if json['links']['next'] and int(page) < 5:
            page = str(int(page) + 1)
        else:
            break
    return result_array
    