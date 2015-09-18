var pg = require("pg")
var restify = require('restify');
var fs      = require('fs');
var async = require('async');

var server = restify.createServer({
    name : "server kuntur"
});


// reading config file
var config = JSON.parse(fs.readFileSync('/etc/nodejs-config/kuntur.json')).backend;
var ip_addr = config.host;
var port    =  config.port;

// connection string to Kuntur database
var conString = "postgres://" +
               config.pg.user + ":" +
               config.pg.pass + "@" +
               config.pg.host + "/" +
               config.pg.db;


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


require('./modulos/university')(server, conString);
require('./modulos/agreement')(server, conString);
require('./modulos/enrollment')(server, conString);




server.listen(port ,ip_addr, function(){
	console.log("Listening on "+ip_addr+":"+port);
});
