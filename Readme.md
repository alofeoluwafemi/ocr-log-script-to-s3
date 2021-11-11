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

![ACL Bucket Settings](https://drewhyte-west-1.s3.us-west-1.amazonaws.com/acl.png)

### Attach this policy

```
{
    "Version": "2012-10-17",
    "Id": "Policy1634203649401",
    "Statement": [
        {
            "Sid": "Stmt1634203628199",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::{BUCKET_NAME_HERE}"
        }
    ]
}
```

### Copy the 2 Bash scripts in the [soak-manual](https://github.com/slim12kg/ocr-log-script-to-s3/tree/master/soak-manual) directory to your machine home directory & update your crontab with the following commnads

```
# Runs every hour
0 * * * * ~/ocr-iotex-log.sh >~/ocr-command-output.log 2>&1

# Runs every 2 hours to sync logs to S3
# !! REMEMBER TO CHANGE BUCKET URL TO MATCHING URL
0 */2 * * * ~/ocr-s3.sh >~/ocr-s3-output.log 2>&1
```

// Todo Automate this process
### Edit `nodes.js` and update the list the logs to match the name of the chainlink nodes. Add or remove as appropriate

// Todo Automate this process
### Edit `log.js` and replace `BASE_URL`

// Todo Automate this process
### Edit `app.js` and replace `BUCKETNAME`

// Todo Automate this process
### Edit `app.js` and replace `BUCKET_REGION` if its not hosted on us-west2

### Host the nodejs script on Heroku (Its Free for 5 Apps)
Learn How Here: https://devcenter.heroku.com/articles/deploying-nodejs
