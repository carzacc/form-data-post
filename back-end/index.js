var express = require('express')
var multer  = require('multer')
var fs = require('fs');
var upload = multer({ dest: 'uploads/' })

var app = express()

app.post('/upload', upload.single("picture"), function (req,res) {
    console.log("Received file" + req.file.originalname);
    var src = fs.createReadStream(req.file.path);
    var dest = fs.createWriteStream('uploads/' + req.file.originalname);
    src.pipe(dest);
    src.on('end', function() {
    	fs.unlinkSync(req.file.path);
    	res.json('OK: received ' + req.file.originalname);
    });
    src.on('error', function(err) { res.json('Something went wrong!'); });
  
  })

let port = process.env.PORT || 3000;
app.listen(port, function () {
    return console.log("Started file upload server on port " + port);
});