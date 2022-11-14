from fastapi import FastAPI, HTTPException
import uvicorn
from dynamodb_repository import  get_job_data, list_jobs
from typing import Union

app = FastAPI()


@app.get("/")
def health():
    return {"health": "OK"}


@app.get("/job")
def getJobs(startKey: Union[str, None] = None, limit: int = 10):
    return list_jobs(startKey, limit)


@app.get("/job/{id}")
def getJob(id):
    try:
        return get_job_data(id)
    except Exception as exception:
        print(exception)
        raise HTTPException(status_code=404, detail="Job with id " + id + " not found")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80)
