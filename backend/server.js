const express = require('express')
const neatCsv = require('neat-csv');
const url = require('url') 
const path = require('path')
const app = express()
const fs = require("fs")
const req = require("request")
/* const csv = require('./jquery.csv.js'); */


app.get('/data', function (req, res) {
  fs.readFile('./Teams_Result_DB.csv', async (err, data) => {
    if (err) {
      console.error(err)
      return
    }
    res.send(await neatCsv(data))
  })
})


app.get('/*', function(req, res){
  var filename;
  var uri = req.originalUrl;
  filename = path.join(process.cwd(), uri);
  fs.exists(filename, function (exists) {
      if (!exists) {
          res.writeHead(404, {
          "Content-Type": "text/plain"
        });
        res.write("404 Not Found\n");
        res.end();
        return;
      }
  if (fs.statSync(filename).isDirectory()) filename += '/index2.html';
  fs.readFile(filename, "binary", function (err, file) {
      if (err) {
          res.writeHead(500, {
          "Content-Type": "text/plain"
        });
        res.write(err + "\n");
        res.end();
        return;
      }
      res.writeHead(200);
      res.write(file, "binary");
      res.end();
    });
  });
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
