# without sandbox please move creation of the bucket to terraform
sh setup_src_bucket.sh

mkdir build

echo "zip files for server"
cd api-server
zip ../build/api-server.zip requirements.txt
zip -r ../build/api-server.zip src 
cd ..

echo  "upload to s3"
aws s3 cp build/api-server.zip s3://ip-src-bucket/
