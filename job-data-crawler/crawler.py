from arbeitnowapi import load_jobs


def map_jobs(jobs_from_api):
    jobs = []
    for api_job in jobs_from_api:
        jobs.append({
            "id": api_job["slug"],
            "title": api_job["title"],
            "description": api_job["description"],
        })
    return jobs



def handler(event, context):
    jobs_from_api = load_jobs()
    jobs = map_jobs(jobs_from_api)
    save_jobs_to_s3(jobs)


if __name__ == "__main__":
    handler({},{})
