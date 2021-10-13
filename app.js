const express = require("express");
const app = express();
// import entire SDK
const AWS = require("aws-sdk");
const BUCKETNAME = "ocr-soak-test-iotex"
const BUCKET_REGION = "us-west-2"

app.use(express.json()); // for parsing application/json
app.use(express.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

// serve your css as static
app.use(express.static(__dirname));

app.get("/", async (req, res) => {
  res.sendFile(__dirname + "/nodes.html");
});

app.get("/logs/:id", async (req, res) => {
  res.sendFile(__dirname + "/logs.html");
});

app.get("/node/:id", async (req, res) => {
  return getS3Object(req.params.id,res)
});

app.get("/nodes", async (req, res) => {
  return getS3Object("",res)
});

const getS3Object = (prefix,res) => {
var params = {
    Bucket: BUCKETNAME /* required */,
    Prefix: prefix, // Can be your folder name
  };

  AWS.config.region = BUCKET_REGION; // Region
  AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: "us-west-2:6637fbb7-154b-4a1c-a22b-4c9da8038071",
  });

  // Create a new service object
  S3 = new AWS.S3({
    apiVersion: "2006-03-01",
    params: {
      Bucket: BUCKETNAME /* required */,
      Prefix: prefix ?? '', // Can be your folder name
    },
  });

  return S3.listObjectsV2(params, function (err, data) {
    if (err) {
      console.log(err, err.stack);
      res.send([]);
    } else {
      res.send(data?.Contents);
    }
  });
}

const port = process.env.PORT || 5000;

app.listen(port);
