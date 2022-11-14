import boto3
import os
client = boto3.client('sns')

topic_arn = os.getenv("TOPIC_ARN")

def inform_about_new_job(title, description):
    client.publish(
        TopicArn=topic_arn,
        Message= "New Job: "+ title +" \n "+description,
        Subject='New Job: ' + title
    )


def handle_new_image(newImage):
    title = newImage["title"]["S"]
    description = newImage["description"]["S"]
    if "aws" in title.lower() or "aws" in description.lower():
        inform_about_new_job(title, description)


def handle_record(record):
    if "NewImage" in record["dynamodb"]:
        handle_new_image(record["dynamodb"]["NewImage"])


def handler(event, context):
    for record in event["Records"]:
        handle_record(record)
