# without sandbox please move creation of the bucket to terraform
sh setup_src_bucket.sh

mkdir build

echo "zip files for server"
cd api-server
zip ../build/api-server.zip requirements.txt
zip -r ../build/api-server.zip src 
cd ..

echo  "upload to s3"
aws s3 cp build/api-server.zip s3://job-notifier-src-bucket-21345/


mkdir infrastructure/build
cd job-data-crawler/src
zip -r ../../infrastructure/build/job_crawler.zip .
cd ../..


cd requests-layer
pip3 install -r requirements.txt --target python/lib/python3.9/site-packages
zip -r ../build/requests-layer.zip .
cd ..

echo  "upload to s3"
aws s3 cp build/requests-layer.zip s3://job-notifier-src-bucket-21345/