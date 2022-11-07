from fastapi import FastAPI, HTTPException
import uvicorn
from s3_utils import get_job_data, list_jobs

app = FastAPI()


@app.get("/")
def health():
    return {"health": "OK"}


@app.get("/job")
def getJobs():
    jobs = []
    for jobname in list_jobs():
        jobs.append(get_job_data(jobname))
    return jobs


@app.get("/job/{id}")
def getJob(id):
    try:
        return get_job_data(id)
    except Exception:
        raise HTTPException(status_code=404, detail="Job with id " + id + " not found")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80)
