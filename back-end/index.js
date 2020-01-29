var express = require('express')
var multer  = require('multer')
var fs = require('fs');
var upload = multer({ dest: 'uploads/' })

var app = express()

app.post('/upload', upload.single("n"), function (req,res) {
    console.log(req.body);
    var src = fs.createReadStream(req.file.path);
    var dest = fs.createWriteStream('uploads/' + req.file.originalname);
    src.pipe(dest);
    src.on('end', function() { res.json('complete'); });
    src.on('error', function(err) { res.json('error'); });
  
  })

let port = process.env.PORT || 3000;
app.listen(port, function () {
    return console.log("Started file upload server on port " + port);
});