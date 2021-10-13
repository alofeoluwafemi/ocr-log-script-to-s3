#! /bin/bash

#Define S3 URL, Must be unique name on S3 bucket
#!!RENAME BUCKET URL TO THE NEW S3 BUCKET URL YOU CREATED!!
S3_BUCKET_URL=s3://ocr-soak-test-iotex

#namespace of pods
namespace=($(kubectl get pods -A | grep chainlink | awk '{print $1}')[0])

#Sync logs to S3 bucket
aws s3 sync ~/$namespace $S3_BUCKET_URL --acl public-read-write