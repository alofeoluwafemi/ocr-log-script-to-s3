const express = require("express");
const app = express();
// import entire SDK
const AWS = require("aws-sdk");

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
  var params = {
    Bucket: "ocr-soak-test" /* required */,
    Prefix: req.params.id, // Can be your folder name
  };

  AWS.config.region = "us-west-2"; // Region
  AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: "us-west-2:6637fbb7-154b-4a1c-a22b-4c9da8038071",
  });

  // Create a new service object
  var S3 = new AWS.S3({
    apiVersion: "2006-03-01",
    params: {
      Bucket: "ocr-soak-test" /* required */,
      Prefix: req.params.id, // Can be your folder name
    },
  });

  S3.listObjectsV2(params, function (err, data) {
    if (err) {
      console.log(err, err.stack);
      res.send([]);
    } else {
      res.send(data?.Contents);
    }
  });
});

const port = process.env.PORT || 5000;

app.listen(port);
