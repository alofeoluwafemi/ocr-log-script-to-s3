#! /bin/bash
export PATH="/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/local/jdk1.8.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

#Define S3 URL, Must be unique name on S3 bucket
#!!RENAME BUCKET URL TO THE NEW S3 BUCKET URL YOU CREATED!!
S3_BUCKET_URL=s3://bucket-name

#namespace of pods
namespaces=$(kubectl get namespace -A | grep chainlink | awk '{print $1}')

for namespace in $namespaces; do
    #Sync logs to S3 bucket
    aws s3 sync ~/$namespace $S3_BUCKET_URL --acl public-read-write
done
