from fastapi import FastAPI, HTTPException
import uvicorn
from get_jobs_from_s3 import get_da_jobs

app = FastAPI()

jobs_data = get_da_jobs()


@app.get("/")
def health():
    return {"health": "OK"}


@app.get("/job")
def getJobs():
    return jobs_data


@app.get("/job/{id}")
def getJob(id):
    for job in jobs_data:
        if(job["id"] == id):
            return job
    raise HTTPException(
        status_code=404, detail="Job with id " + id + " not found")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80)
