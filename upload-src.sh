# without sandbox please move creation of the bucket to terraform
sh setup_src_bucket.sh
sh setup_job_bucket.sh

mkdir build
mkdir python

echo "zip files for server"
cd api-server
zip ../build/api-server.zip requirements.txt
zip -r ../build/api-server.zip src 
cd ..

echo "zip requests-layer for job-lambda"
cd python
pip3 install requests -t .
cd ..
zip -r ./build/requests-layer.zip python
rm -rf python

echo "zip job-lambda"
zip ./build/job-lambda.zip ./infrastructure/lambda/python/job_lambda.py

echo  "upload to s3"
aws s3 cp build s3://ip-src-bucket/ --recursive
