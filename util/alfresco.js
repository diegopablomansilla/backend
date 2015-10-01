var pg = require('pg');
var request = require('request');
var config = require('/etc/nodejs-config/kuntur').backend;
var async = require('async');
var fs = require('fs-extra');
var util = require('util');

var pgc = config.pg;
var alfc = config.alfresco;
connStr = 'postgres://'+pgc.user+':'+pgc.pass+'@'+pgc.host+'/'+pgc.db;
console.log(connStr);

var offset = 0;
var limit = 10;
var max = false;

var walk = function(iter, done) {
  fs.readdir('fotos', function(err, files) {
    if(err) return done(err);
    async.each(files, iter, done);
  })
}

async.auto({
  ticket: function(cb) {
    console.log('http://'+alfc.alf_url+':'+alfc.alf_port+alfc.alf_api+'/login?u='+alfc.alf_usr+'&pw='+alfc.alf_pwd+'&format=json');
    request('http://'+alfc.alf_url+':'+alfc.alf_port+alfc.alf_api+'/login?u='+alfc.alf_usr+'&pw='+alfc.alf_pwd+'&format=json', function(err, response, body) {
      if(err) return cb(err);
      console.log(body);
      var o = JSON.parse(body);
      var ticket = o&&o.data&&o.data.ticket?o.data.ticket:false;
      if(!ticket) return cb('sin ticket');
      console.log("ticket "+ticket);
      cb(null, ticket);
    });
  },
  mkSql: function(cb) {
    pg.connect(connStr, function(err, client, done) {
      if(err) return cb(err);
      var sql =
        "select string_agg('select '||a.attname||' as file from '||n.nspname||'.'||c.relname, ' union ')||' order by 1' as query "+
        "from 	pg_namespace n "+
        "inner join "+
        "	      pg_class c "+
        "on	    c.relnamespace = n.oid "+
        "       and c.relkind = 'r' "+
        "inner join "+
        "       pg_attribute a "+
        "on	    a.attrelid = c.oid "+
        "       and a.attnum > 0 "+
        "       and a.attname ilike 'url_%' "+
        "where 	n.nspname = 'kuntur'"
        client.query(sql, function(err, result) {
          done();
          if(err) return cb(err);
          cb(null, result.rows[0].query);
        });
    })
  },
  fotosPG: ['mkSql', 'ticket', function(cb, auto) {
    pg.connect(connStr, function(err, client, done) {
      if(err) return cb(err);

      var listo = function(err) {
        done();
        if(err) return cb(err);
        cb();
      };
      var bucle = function() {
        if(max && offset >= max) return listo();
        var sql = auto.mkSql+" limit $1 offset $2";
        client.query(sql, [limit, offset], function(err, result) {
          if(err) return listo(err);
          offset += limit;
          if(!result.rows.length) return listo();
          async.each(result.rows, function(row, cb) {
            var r = request('http://'+alfc.alf_url+':'+alfc.alf_port+alfc.alf_api+alfc.alf_content+row.file+'?alf_ticket='+auto.ticket)
              .on('end', cb);
            r.on('response', function(resp) {
              if(resp.statusCode == 200) {
                process.stdout.write('.');
                r.pipe(fs.createOutputStream('../files/'+row.file.substr(0,2)+'/'+row.file));
              }
            })
          }, function(err) {
            if(err) return listo(err);
            bucle();
          })
        })
      };
      bucle();
    });
  }]
}, function(err, result) {
  pg.end();
  if(err) return console.log(err);
  process.stdout.write(' ok');
});
