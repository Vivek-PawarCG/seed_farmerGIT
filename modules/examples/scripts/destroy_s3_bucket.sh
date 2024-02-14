#!/bin/bash

# AWS credentials and region configuration
aws configure set aws_access_key_id AKIAW3MD7LS5KMTOI77R
aws configure set aws_secret_access_key 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
aws configure set region us-east-1

# S3 bucket name pattern to be destroyed
bucket_pattern="my-seedfarmer-s3-bucket-*"

# Get the list of matching bucket names
matching_buckets=$(aws s3 ls | awk '{print $3}' | grep "$bucket_pattern")

# Check if any matching buckets were found
if [ -z "$matching_buckets" ]; then
  echo "No matching buckets found with the pattern $bucket_pattern."
  exit 1
fi

# Iterate over matching buckets and delete them
for bucket_name in $matching_buckets; do
  echo "Emptying the bucket $bucket_name..."
  aws s3 rm --recursive "s3://$bucket_name"
  echo "Deleting the bucket $bucket_name..."
  aws s3 rb "s3://$bucket_name" --force
  echo "S3 bucket $bucket_name deleted successfully!"
done
