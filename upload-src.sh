# without sandbox please move creation of the bucket to terraform
sh setup_src_bucket.sh
sh setup_job_bucket.sh

mkdir build

echo "zip files for server"
cd api-server
zip ../build/api-server.zip requirements.txt
zip -r ../build/api-server.zip src 
cd ..

echo "requests-layer for job-lambda"
mkdir python
cd python
pip3 install requests -t .
cd ..
zip -r ../build/requests_layer.zip python
rm -rf python

echo  "upload to s3"
aws s3 cp build/api-server.zip s3://ip-src-bucket/
