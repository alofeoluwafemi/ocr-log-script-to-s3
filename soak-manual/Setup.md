## Create S3 Bucket for Static website hosting

- Name your bucket (suggested: `ocr-soak-test-${chain}` e.g `ocr-soak-test-iotex`)
- Enable static website hosting in properties
-

### Download and install aws cli on your machine

The AWS Command Line Interface (AWS CLI) enables us sync our logs to S3 bucket programmatically
https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

### Create AWS Key ID and Secret Key ID

Access keys consist of an access key ID and secret access key, which are used to sign programmatic requests that you make to AWS.
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds

### Set ACL to Match the below

![ACL Bucket Settings](s3://drewhyte-west-1/acl.png)

### Attach this policy

```
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::<BUCKET_NAME>/*"]
    }
  ]
}
```

### Copy the Bash scirpt to your home directory & update your crontab with the following commnads

```
# Runs every hour
0 * * * * ~/ocr-iotex-log.sh >~/ocr-command-output.log 2>&1

# Runs every 2 hours to sync logs to S3
# !! REMEMBER TO CHANGE BUCKET URL TO MATCHING URL
0 */2 * * * ~/ocr-s3.sh >~/ocr-s3-output.log 2>&1
```


### Edit `app.js` of the nodejs script that list the logs

### Host the nodejs script on Heroku