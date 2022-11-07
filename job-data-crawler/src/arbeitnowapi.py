import requests

url = "https://www.arbeitnow.com/api/job-board-api"

def load_jobs():
    response = requests.get(url)
    return response.json()["data"]