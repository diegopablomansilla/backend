var pg = require("pg")
var restify = require('restify');
var fs      = require('fs-extra');
var async = require('async');
var uuid = require('node-uuid');
var path = require('path');

var server = restify.createServer({
    name : "server kuntur"
});


// reading config file
var config = JSON.parse(fs.readFileSync('/etc/nodejs-config/kuntur.json')).backend;
var ip_addr = config.host;
var port    =  config.port;
var activeMail = config.sendMail;

// connection string to Kuntur database
var conString = "postgres://" +
               config.pg.user + ":" +
               config.pg.pass + "@" +
               config.pg.host + "/" +
               config.pg.db;

server.get({path: '/test'}, function(req, res, next) {
  res.send('Ok');
});

server.use(function(req, res, next) {
  console.log(req.url);
  next();
})

server.use(restify.queryParser());
server.use(restify.bodyParser());
var corsOptions={
	headers : [ "location"]
}
server.use(restify.CORS(corsOptions));
server.use(restify.fullResponse());


// if (!Array.prototype.first)
// {
//    Array.prototype.first = function(predicate)
//    {
//      "use strict";
//      if (this == null)
//        throw new TypeError();
//      if (typeof predicate != "function")
//        throw new TypeError();

//      for (var i = 0; i < this.length; i++) {
//        if (predicate(this[i])) {
//          return this[i];
//        }
//      }
//      return null;
//    }
// }

server.get({path: '/file/:file'}, function(req, res, next) {
  var file = req.params.file;
  var filePath = path.join(__dirname, 'files', file.substr(0,2), file);
  fs.createReadStream(filePath).pipe(res);
});

server.post({path: '/file'}, function(req, res, next) {
  var n = 0;
  var mkFileName = function(cb) {
    var file = uuid.v4();
    // console.log(__dirname+' '+'files'+' '+ file.substr(0,2)+' '+ file);
    var filePath = path.join(__dirname, 'files', file.substr(0,2), file);
    // console.log('pas{o '+filePath);
    fs.stat(filePath, function(err, stat) {
      console.log(err);
      if(err) return cb(null, {file: file, path: filePath});
      if(n == 40) {
        return cb({status: 'err', message: 'No se puede crear el archivo'});
      }
      n++;
      mkFileName(cb);
    })
  };
  mkFileName(function(err, result) {
    // console.log('holaaaaa???');
    if(err) {
      console.log(err);
      return res.send(500, err);
    }
    // console.log('holaaaaa???2');
    // console.log(req.body.file.split(",")[1]);
    // console.log(req.body.file);
    var file = new Buffer(req.body.file.split(",")[1], 'base64');
    // console.log(file);
    fs.outputFile(result.path, file, function(err) {
      if(err) return res.send(500, err);
      res.send(200, {file: result.file});
    });

  })
});

require('./modulos/university')(server, conString);
require('./modulos/agreement')(server, conString);
require('./modulos/enrollment')(server, conString, activeMail);




server.listen(port , function(){
	console.log("Listening on "+ip_addr+":"+port);
});
