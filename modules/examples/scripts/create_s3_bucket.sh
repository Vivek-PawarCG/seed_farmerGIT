#!/bin/bash
 
# AWS credentials and region configuration
aws configure set aws_access_key_id AKIAW3MD7LS5KMTOI77R
aws configure set aws_secret_access_key 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
aws configure set region us-east-1
 
bucket_name="my-seedfarmer-s3-bucket"
bucket_versioning="Enabled" 
 
# Create the S3 bucket
aws s3 mb s3://$bucket_name
 
# Enable versioning (if applicable)
if [[ "$bucket_versioning" == "Enabled" ]]; then
  aws s3api put-bucket-versioning --bucket $bucket_name --versioning-configuration {"Status": "Enabled"}
fi
 
# Optional: Output success message
echo "S3 bucket $bucket_name created successfully!" >> output.txt