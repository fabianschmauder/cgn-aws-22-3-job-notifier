S3_BUCKET_NAME=terraform-state-12312d123f
REGION=us-west-2
if aws s3 ls "s3://jayterraform-bucket" 2>&1 | grep -q 'An error occurred'
then
    aws s3api create-bucket --bucket $S3 jayterraform-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=$REGION
else
    echo "bucket already exists"
fi
