var pg = require("pg")
var restify = require('restify');
var fs      = require('fs');
var async = require('async');

var server = restify.createServer({
    name : "server kuntur"
});


// reading config file
var config = JSON.parse(fs.readFileSync('/etc/nodejs-config/Kuntur.json'));
var ip_addr = config.host;
var port    =  config.port;

// connection string to Kuntur database
var conString = "postgres://" +
               config.pg.user + ":" +
               config.pg.pass + "@" +
               config.pg.host + "/" +
               config.pg.db;

var client = new pg.Client(conString);
client.connect();


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

var findFirstOccurrence = function(array, property, value){
  for(var i = 0 ; i < array.length; i++){
    if(array[i][property]==value){
      return array[i];
    }
  }
  return -1;
}

var rollback = function(client, done) {
  client.query('ROLLBACK', function(err) {
    //if there was a problem rolling back the query
    //something is seriously messed up.  Return the error
    //to the done function to close & remove this client from
    //the pool.  If you leave a client in the pool with an unaborted
    //transaction weird, hard to diagnose problems might happen.
    return done(err);
  });
};


/**
  * Get universities filtered by the params given.
  *
  * @param {String} countryCode - The iso alpha 3 code of a country.
  * @param {String} searchText - Given text to search
  * @param {Boolean} showErased - Consider erased universities.
  * @param {Number} offset - List of universities offset.
  * @param {Number} limit - How many results do you want.
  *
*/
server.get({path : '/universities', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT org.id, org.short_name, org.original_name, org.url_photo, org.web_site, org.country_code, org.erased FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='U' ";

	if(req.params.countryCode){
		sql += "AND country_code='"+req.params.countryCode.toUpperCase()+"' ";
	}

	if(req.params.searchText){
		sql += "AND (org.short_name ILIKE '%" + req.params.searchText + "%' OR org.original_name ILIKE '%" + req.params.searchText + "%')";
	}

  if(!req.params.showErased){
		sql += "AND org.erased=false "; // FIXME when showErased is setted to false, it doesnt add this bit to the sql.
	}

	if(req.params.offset && req.params.limit){
		sql += "OFFSET '"+req.params.offset+"' LIMIT '"+req.params.limit+"'";
	}

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }
	});
});

/* Get a single university */

server.get({path : '/universities/:universityId', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT org.id, org.short_name, org.original_name, org.url_photo, org.web_site, org.country_code, org.erased FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='U' AND org.id='" + req.params.universityId + "'";

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }
	});
});

/* Update a university */
server.put({path:'/universities/:universityId', version:'0.0.1'}, function(req, res, next){
  // Body cannot be empty
  if(!req.body){
    res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
    return next();
  }

  // Original name cannot be empty
  if(!req.body.original_name){
    res.send(409, {code: 409, message: 'Conflict', description: 'original_name value required'});
    return next();
  }

  // web_site value cannot be blank
  if(!req.body.web_site){
    res.send(409, {code: 409, message: 'Conflict', description: 'web_site value required'});
    return next();
  }

  // country_code value cannot be blank
  if(!req.body.country_code){
    res.send(409, {code: 409, message: 'Conflict', description: 'country_code value required'});
    return next();
  }

  pg.connect(conString, function(err, client, done){
    if(err){
      done();
      console.error('error fetching client from pool', err);
      res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
      return next();
    }

    var sql = 'UPDATE kuntur.org SET ';
      sql += "original_name= '" + req.body.original_name + "', ";
      sql += "country_code= '" + req.body.country_code + "', ";
      sql += "web_site= '" + req.body.web_site + "' ";
      if(!!req.body.short_name){
        sql += ", short_name= '" + req.body.short_name + "' ";
      }
      if(typeof req.body.erased !== "undefined"){
          sql += ", erased= '" + req.body.erased + "' ";
      }
    sql += " WHERE id='" + req.params.universityId + "'";



    client.query(sql, function(err, result) {
      done();
      //Return if an error occurs
      if(err) { //connection failed
        console.error(err);
        res.send(503, {code: 503, message: 'Database error', description: err});
        return next();
      }
      res.send(204);
    });
  });
});

/* Delete a university */

server.del(
	{path:'/universities/:unversityId'},
	function(req, res, next){
		pg.connect(conString, function(err, client, done){

        //Return if an error occurs
        if(err) {
          done(); //release the pg client back to the pool
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }

        //querying database
        var sql = "UPDATE kuntur.org SET erased='true' WHERE id=";
          sql += "'" + req.params.unversityId + "'";

        client.query(sql, function(err, result) {
          done(); //release the pg client back to the pool
          //Return if an error occurs
          if(err) {//falta de conexion
            console.error('error fetching client from pool', err);
            res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
            return next();
          }
          if (result.rowCount == 0) {
            console.error('result not found', err);
            res.send(404, {code: 404, message: 'Not Found', description: 'Cannot delete a non existent resource'});
            return next();
          }else{
            res.send(204);
          }
        });
		});
	}
);



server.get({path : '/universities/:id/agreements', version : '0.0.1'} , function(req, res , next){
//
	var sql = "SELECT a.*, ai.*, null::varchar AS agreement_contact ";
		sql += "FROM kuntur.agreement_item ai ";
		sql += "JOIN kuntur.v_agreement a ON a.id = ai.agreement_id ";
		sql += "WHERE ai.org_id='" + req.params.id + "'";

 	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);
		var agreements = []
		query.on("row", function(row, result){
			var agreement = {
				code: row.number_agreement,
				title: row.title,
				type: row.agreement_type_name,
				status: row.agreement_status_name,
				universitiesCount: row.orgs
			}
			result.addRow(row);
			agreements.push(agreement);
		});

		query.on("end",function(result){
			done();
			res.send(200,agreements);
		});

		if(err) {

        }
	});
});

/* GET list of emails from a given university */
server.get({path : '/universities/:id/mails', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.org_email WHERE org_id='" + req.params.id + "' AND erased='false'";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }
	});
});

/* Create a new university email (email and comment) */
server.post(
		{path: '/universities/:unversityId/mails', version: '0.0.1'},
		function(req, res, next){

			// Body cannot be empty
			if(!req.body){
				res.send(400, {code: 400, message: 'Bad Request', description: 'Empty body. Body format... {\"email\":\"some@email.foo\", \"comment\":\"bar\"}'});
				return next();
			}

			// Email value cannot be blank
			if(!req.body.email){
				res.send(400, {code: 400, message: 'Bad Request', description: 'email value required'});
				return next();
			}

			pg.connect(conString, function(err, client, done){
				if(err){
					done();
					console.error('error fetching client from pool', err);
					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
					return next();
				}

				var sql = 'INSERT INTO kuntur.org_email VALUES	(uuid_generate_v4()::varchar, false, ';
					sql += "'" + req.body.email + "', ";
					if(!!req.body.comment){
						sql += "'" + req.body.comment + "', '";
					}else{
						sql += "' ', '";
					}
					sql += req.params.unversityId + "') RETURNING id";



				client.query(sql, function(err, result) {
					done();
					//Return if an error occurs
					if(err) { //connection failed
						console.error(err);
						res.send(503, {code: 503, message: 'Database error', description: err});
						return next();
					}
					res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/mails/' + result.rows[0].id);
					res.send(201);
				});

			});
		}
	);

  /* Update a university email */
  server.put(
  		{path: '/universities/:unversityId/mails/:mailId', version: '0.0.1'},
  		function(req, res, next){

  			// Body cannot be empty
  			if(!req.body){
  				res.send(409, {code: 409, message: 'Conflict', description: 'Empty body. Body format... {\"email\":\"some@email.foo\", \"comment\":\"bar\"}'});
  				return next();
  			}

  			// Email value cannot be blank
  			if(!req.body.email){
  				res.send(409, {code: 409, message: 'Conflict', description: 'email value required'});
  				return next();
  			}

  			pg.connect(conString, function(err, client, done){
  				if(err){
  					done();
  					console.error('error fetching client from pool', err);
  					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  					return next();
  				}

  				var sql = 'UPDATE kuntur.org_email SET ';
  					sql += "email= '" + req.body.email + "' ";
  					if(!!req.body.comment){
  						sql += ", comment= '" + req.body.comment + "' ";
  					}
            if(!req.body.erased){
  						sql += ", erased= '" + req.body.erased + "' ";
  					}
          sql += " WHERE id='" + req.params.mailId + "'";



  				client.query(sql, function(err, result) {
  					done();
  					//Return if an error occurs
  					if(err) { //connection failed
  						console.error(err);
  						res.send(503, {code: 503, message: 'Database error', description: err});
  						return next();
  					}
  					res.send(204);
  				});

  			});
  		}
  	);

/* Delete a university email */

server.del(
	{path:'/universities/:unversityId/mails/:mailId'},
	function(req, res, next){
		pg.connect(conString, function(err, client, done){

        //Return if an error occurs
        if(err) {
          done(); //release the pg client back to the pool
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }

        //querying database
        var sql = "UPDATE kuntur.org_email SET erased='true' WHERE id=";
          sql += "'" + req.params.mailId + "'";

        client.query(sql, function(err, result) {
          done(); //release the pg client back to the pool
          //Return if an error occurs
          if(err) {//falta de conexion
            console.error('error fetching client from pool', err);
            res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
            return next();
          }
          if (result.rowCount == 0) {
            console.error('result not found', err);
            res.send(404, {code: 404, message: 'Not Found', description: 'Cannot delete a non existent resource'});
            return next();
          }else{
            res.send(204);
          }
        });

		});
	}
);

server.get({path : '/universities/:id/phones', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.org_phone WHERE org_id='" + req.params.id + "' AND erased='false'";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }
	});
});

/* Create a new university phone (phone and comment) */
server.post(
		{path: '/universities/:unversityId/phones', version: '0.0.1'},
		function(req, res, next){

			// Body cannot be empty
			if(!req.body){
				res.send(400, {code: 400, message: 'Bad Request', description: 'Empty body. Body format... {\"phone\":\"12345\", \"comment\":\"foo\"}'});
				return next();
			}

			// country code cannot be blank
			if(!req.body.country_code){
				res.send(400, {code: 400, message: 'Bad Request', description: 'country code phone value required'});
				return next();
			}

			// phone value cannot be blank
			if(!req.body.phone_number){
				res.send(400, {code: 400, message: 'Bad Request', description: 'phone value required'});
				return next();
			}

			pg.connect(conString, function(err, client, done){
				if(err){
					done();
					console.error('error fetching client from pool', err);
					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
					return next();
				}

				var sql = 'INSERT INTO kuntur.org_phone VALUES	(uuid_generate_v4()::varchar, false, ';
					sql += "'" + req.body.country_code + "', ";
					sql += "'" + req.body.phone_number + "', ";
					if(!!req.body.comment){
						sql += "'" + req.body.comment + "', '";
					}else{
						sql += "' ', '";
					}
					sql += req.params.unversityId + "') RETURNING id";



				client.query(sql, function(err, result) {
					done();
					//Return if an error occurs
					if(err) { //connection failed
						console.error(err);
						res.send(503, {code: 503, message: 'Database error', description: err});
						return next();
					}
					res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/phones/' + result.rows[0].id);
					res.send(201);
				});

			});
		}
	);

  /* Update a university phone */
  server.put(
  		{path: '/universities/:unversityId/phones/:phoneId', version: '0.0.1'},
  		function(req, res, next){

  			// Body cannot be empty
  			if(!req.body){
  				res.send(409, {code: 409, message: 'Conflict', description: 'Empty body. Body format... {\"email\":\"some@email.foo\", \"comment\":\"bar\"}'});
  				return next();
  			}

  			// Email value cannot be blank
        // country code cannot be blank
  			if(!req.body.country_code){
  				res.send(400, {code: 400, message: 'Bad Request', description: 'country code phone value required'});
  				return next();
  			}

  			// phone value cannot be blank
  			if(!req.body.phone_number){
  				res.send(400, {code: 400, message: 'Bad Request', description: 'phone value required'});
  				return next();
  			}

  			pg.connect(conString, function(err, client, done){
  				if(err){
  					done();
  					console.error('error fetching client from pool', err);
  					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  					return next();
  				}

  				var sql = 'UPDATE kuntur.org_phone SET ';
  					sql += "phone_number= '" + req.body.phone_number + "', ";
            sql += "country_code= '" + req.body.country_code + "' ";
  					if(!!req.body.comment){
  						sql += ", comment= '" + req.body.comment + "' ";
  					}
            if(!req.body.erased){
  						sql += ", erased= '" + req.body.erased + "' ";
  					}
          sql += " WHERE id='" + req.params.phoneId + "'";



  				client.query(sql, function(err, result) {
  					done();
  					//Return if an error occurs
  					if(err) { //connection failed
  						console.error(err);
  						res.send(503, {code: 503, message: 'Database error', description: err});
  						return next();
  					}
  					res.send(204);
  				});

  			});
  		}
  	);

server.del(
	{path:'/universities/:unversityId/phones/:phoneId'},
	function(req, res, next){
		pg.connect(conString, function(err, client, done){

        //Return if an error occurs
        if(err) {
          done(); //release the pg client back to the pool
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }

        //querying database
        var sql = "UPDATE kuntur.org_phone SET erased='true' WHERE id=";
          sql += "'" + req.params.phoneId + "'";

        client.query(sql, function(err, result) {
          done(); //release the pg client back to the pool
          //Return if an error occurs
          if(err) {//falta de conexion
            console.error('error fetching client from pool', err);
            res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
            return next();
          }
          if (result.rowCount == 0) {
            console.error('result not found', err);
            res.send(404, {code: 404, message: 'Not Found', description: 'Cannot delete a non existent resource'});
            return next();
          }else{
            res.send(204);
          }
        });

		});
	}
);

server.get({path : '/universities/:id/addresses', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.org_address WHERE org_id='" + req.params.id + "'";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }
	});
});



server.get({path : '/universities/:id_university/contacts', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.v_contacts WHERE org_id='" + req.params.id_university+"'";

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			
		});

		query.on("end",function(result){
			done();
			var contacts=[];
			result.rows.forEach(function(element){

				for (var i = 0; i < contacts.length; i++) {
					if(contacts[i].id == element.id){ //contact already added
						if(element.person_email_email){
							var emailRepeated = false;
							for (var j = 0; j < contacts[i].emails.length; j++) {
								if(contacts[i].emails[j].id == element.person_email_id){ //email already added
									emailRepeated = true;
									break;
								}
							};
							if(!emailRepeated)
								contacts[i].emails.push(
									{
										id: element.person_email_id,
										email: element.person_email_email,
										comment:element.person_email_comment
									}
								);
						}
						if(element.person_phone_phone_number){
							var phoneRepeated = false;
							for (var j = 0; j < contacts[i].phones.length; j++){
								if(contacts[i].phones[j].id == element.person_phone_id){ //phone already added
									phoneRepeated = true;
									break;
								}
							};
							if(!phoneRepeated){
								contacts[i].phones.push(
									{
										id: element.person_phone_id,
										countryCode: element.person_phone_country_code,
										phone: element.person_phone_phone_number,
										comment:element.person_phone_comment
									}
								);
							}
						}
						return;
					}
				};

				var contact = {
					id: element.id,
					firstName: element.person_given_name,
					surname: element.person_family_name,
					male: element.person_masculine,
					comment: element.person_comment,
					receptionStudent: element.reception_student,
					sendingStudent: element.sending_student,
					emails: [],
					phones: []
				}

				if(element.person_email_email){
					contact.emails.push(
						{
							id: element.person_email_id,
							email: element.person_email_email,
							comment:element.person_email_comment
						});
				}

				if(element.person_phone_phone_number){
					contact.phones.push(
						{
							id: element.person_phone_id,
							countryCode: element.person_phone_country_code,
							phone: element.person_phone_phone_number,
							comment:element.person_phone_comment
						});
				}

				contacts.push(contact);
			});
			res.send(200, contacts);
		});

		if(err) {

        }
	});
});

server.get({path : '/contacts', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.v_contacts where erased = false";

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			var contacts=[];
			result.rows.forEach(function(element){

				for (var i = 0; i < contacts.length; i++) {
					if(contacts[i].id == element.id){ //contact already added
						if(element.person_email_email){
							var emailRepeated = false;
							for (var j = 0; j < contacts[i].emails.length; j++) {
								if(contacts[i].emails[j].id == element.person_email_id){ //email already added
									emailRepeated = true;
									break;
								}
							};
							if(!emailRepeated)
								contacts[i].emails.push(
									{
										id: element.person_email_id,
										email: element.person_email_email,
										comment:element.person_email_comment
									}
								);
						}
						if(element.person_phone_phone_number){
							var phoneRepeated = false;
							for (var j = 0; j < contacts[i].phones.length; j++){
								if(contacts[i].phones[j].id == element.person_phone_id){ //phone already added
									phoneRepeated = true;
									break;
								}
							};
							if(!phoneRepeated){
								contacts[i].phones.push(
									{
										id: element.person_phone_id,
										countryCode: element.person_phone_country_code,
										phone: element.person_phone_phone_number,
										comment:element.person_phone_comment
									}
								);
							}
						}
						return;
					}
				};

				var contact = {
					id: element.id,
					firstName: element.person_given_name,
					surname: element.person_family_name,
					male: element.person_masculine,
					comment: element.person_comment,
					emails: [],
					phones: []
				}

				if(element.person_email_email){
					contact.emails.push(
						{
							id: element.person_email_id,
							email: element.person_email_email,
							comment:element.person_email_comment
						});
				}

				if(element.person_phone_phone_number){
					contact.phones.push(
						{
							id: element.person_phone_id,
							countryCode: element.person_phone_country_code,
							phone: element.person_phone_phone_number,
							comment:element.person_phone_comment
						});
				}

				contacts.push(contact);
			});
			res.send(200, contacts);
		});

		if(err) {

        }
	});
});


server.get({path : '/getAgreements', version : '0.0.1'} , function(req, res , next){
	if(req.params.busqueda){
		var busqueda=req.params.busqueda;
	}else{
		var busqueda="";
	}
	var deleted = false;

	sql="SELECT * FROM kuntur.findAgreements('"+busqueda+"',"+deleted+");";
	pg.connect(conString, function(err, client, done){
		client.query('BEGIN', function(err) {

			var query = client.query(sql);

			query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){

				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(){
				return rollback(client, done);
			});

			if(err) {

	          return rollback(client, done);
	        }
	    });

	});

});

server.get({path:'/findAgreementById', version:'0.0.1'}, function(req,res,next){
	var sql="SELECT * FROM kuntur.f_findagreementsById('"+req.params.idAgreement+"');";

		pg.connect(conString, function(err, client, done){
			client.query('BEGIN', function(err) {

				
			var query = client.query(sql);

			query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){

				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(){
				return rollback(client, done);
			});

			if(err) {

	          return rollback(client, done);
	        }
	    });

	});
});

server.get({path : '/getAgreementsTypes', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT id, name FROM kuntur.agreement_type where erased = false";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }

	});

});

server.get({path : '/getOrganizations', version : '0.0.1'} , function(req, res , next){


	var sql="SELECT id, name FROM kuntur.org";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }

	});

	// var query = client.query("SELECT id, name FROM kuntur.org");
	// query.on("row", function(row, result){
	// 	result.addRow(row);
	// });

	// query.on("end",function(result){
	
	// 	res.send(200,result.rows);
	// });

});

server.get({path : '/getStatus', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT id, name FROM kuntur.agreement_status where erased = false";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }

	});

	// var query = client.query("SELECT id, name FROM kuntur.agreement_status");
	// query.on("row", function(row, result){
	// 	result.addRow(row);
	// });

	// query.on("end",function(result){
	
	// 	res.send(200,result.rows);
	// });

});

server.get({path : '/getFullOrganizations', version : '0.0.1'} , function(req, res , next){
	var sql;
	if(req.params.offset && req.params.limit){
		var offset=req.params.offset;
		var limit=req.params.limit;
		sql="SELECT * FROM kuntur.org ORDER BY id OFFSET '"+offset+"' LIMIT '"+limit+"'";
		var query = client.query(sql);
	}else{
		sql="SELECT * FROM kuntur.org ORDER BY id";
		var query = client.query(sql);
	}

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }

	});

	// query.on("row", function(row, result){
	// 	result.addRow(row);
	// });
	// query.on("end",function(result){
	
	// 	res.send(200,result.rows);
	// });
});

server.post({path: "/insertarAgreement",version: '0.0.1'}, function(req,res){


	var sql="INSERT INTO kuntur.agreement("+
            "id, erased, title, from_date, to_date, comment, agreement_type_id, "+
            "agreement_status_id, org_id)"+
	"VALUES (uuid_generate_v4()::varchar, false,'"+req.body.agreement.name+"', '"+req.body.agreement.from+"', '"+req.body.agreement.to+"', 'asdasd', '"+req.body.agreement.type+"',"+
	"'"+req.body.agreement.status+"', 'b57e010c-426a-45d4-b218-f819fd1bf4e7') RETURNING id;"

    pg.connect(conString, function(err, client, done){
    	client.query('BEGIN', function(err) {
			var query = client.query(sql);

			query.on("row", function(row, result){

				var agreementId=row.id;

				req.body.agreement.agreementItem.forEach(function(elementAgreementItem){
					

					// var agreementItemDetail = elementAgreementItem.agreementItemOu.first(function(i) { return i.id === 'UNC' });
					var agreementItemDetail = findFirstOccurrence(elementAgreementItem.agreementItemOu,'id','UNC')
					

					var sql="INSERT INTO kuntur.agreement_item("+
						    "id, erased, in_units, out_units, agreement_id, org_id)"+
					"VALUES (uuid_generate_v4()::varchar, false, '"+agreementItemDetail.in+"', '"+agreementItemDetail.out+"', '"+agreementId+"', '"+elementAgreementItem.id+"')"+
					"RETURNING id;"
						

					var query2 = client.query(sql);

					query2.on("row", function(row, result){
						var agreementItemId=row.id;

						async.parallel([
						function(callback){

							async.forEach(elementAgreementItem.agreementItemOu,function(elementAgreementItemOu, callbackInterno){
							//elementAgreementItem.agreementItemOu.forEach(function(elementAgreementItemOu){
								
								 
								if(elementAgreementItemOu.id!="UNC"){//SON PARA LOS AGREEMENT ITEMS, LOS USE EN EL PASO ANTERIOR
									
									
									var sqlAgItOu="INSERT INTO kuntur.agreement_item_ou("+
							   		"id, erased, in_units, out_units, agreement_item_id, org_id)"+
									"VALUES (uuid_generate_v4()::varchar, false, '"+elementAgreementItemOu.in+"', '"+elementAgreementItemOu.out+"', '"+agreementItemId+"', '"+elementAgreementItemOu.id+"');"
									var queryAgItOu = client.query(sqlAgItOu);

									queryAgItOu.on("row", function(row, result){
									});

									queryAgItOu.on("end",function(result){
										
										callbackInterno();
									});

									queryAgItOu.on("error",function(error){
										
										res.send(500,error.message);
										return rollback(client, done);
									});

								}else{
									callbackInterno();//Para que termine el elemento UNC
								}
							},function(err){
								
								callback();
							});
						},
						function(callback){
							async.forEach(elementAgreementItem.contacts,function(contacts, callbackInterno){
							//elementAgreementItem.contacts.forEach(function(contacts){
								var inn;
								var out;
								if(contacts.in===true){
									inn="true";
								}else{
									inn="false";
								}
								if(contacts.out===true){
									out="true";
								}else{
									out="false";
								}
								var sqlAgrCon="INSERT INTO kuntur.agreement_contact("+
						    	"id, erased, agreement_item_id, contact_id, reception_student, sending_student)"+
								"VALUES (uuid_generate_v4()::varchar, false, '"+agreementItemId+"', '"+contacts.id+"', '"+inn+"', '"+out+"');"//(contacts.in === true && typeof contacts.in != 'undefined') ? "true" : "false"+
								
								
								
								
								var queryAgrCon = client.query(sqlAgrCon);

								queryAgrCon.on("row", function(row, result){
								});

								queryAgrCon.on("end",function(result){
									callbackInterno();
								});

								queryAgrCon.on("error",function(error){
									
									res.send(500,error);
									return rollback(client, done);
								});


							},function(err){
								if(err){
									
									res.send(500,err.message);
									rollback(client, done);
								}
								
								callback();
							});
						}], function(err){
							done();
							if(err){

								rollback(client, done);
								res.send(500,err.message);

							}else{
								client.query('COMMIT', done);
								res.send(200,agreementId);
							}
						});

					});



					query2.on("end",function(result){
					});

					query2.on("error",function(error){
						
						res.send(500,error.message);
						return rollback(client, done);

					});



				});
			});

			query.on("end",function(result){
				
				//res.send(200,"");//JSON.parse(result.rows[0].f_plazas)
			});

			query.on("error",function(error){

				res.send(500,error.message);
				return rollback(client, done);

			});

			if(err) {

	          rollback(client, done);
	          res.send(500,err);
	        }

		});

	});

	// for(i in req.body.agreement.agreementItem){
	
	
 //        for(j in req.body.agreement.agreementItem[i].agreementItemOu){
 
 
 
 
 
 
 //    	}
 //    	for(j in req.body.agreement.agreementItem[i].contactIn){
	
	
	//     }
	//     for(j in req.body.agreement.agreementItem[i].contactOut){
	
	
	//     }
 //    }


});

server.get({path : '/getConveniosXOrganizacion', version : '0.0.1'} , function(req, res , next){
	//var agreementId=req.params.agreementId;
	var agreementId=req.params.agrId;
	//var sql=//"SELECT org.short_name FROM kuntur.agreement_item ai join kuntur.org on org.id=ai.org_unit_id where ai.agreement_id='"+agreementId+"' group by org.id order by org.id;";
	var sql="SELECT * FROM kuntur.f_plazas('"+agreementId+"');";
	//var query = client.query("SELECT org.short_name FROM kuntur.agreement_item ai join kuntur.org on org.id=ai.org_unit_id where ai.agreement_id='"+agreementId+"' group by org.id order by org.id;");

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){

			// if(result.rows.length<1){
			// 	done();
			// 	res.send(200,[]);
			// }else{
			// 	sql="CREATE EXTENSION IF NOT EXISTS tablefunc;"+
			// 	"select * from crosstab("+
			// 		 "'select org2.name, org.id, w.in_units || ''-'' || w.out_units from kuntur.agreement_item w join kuntur.org org ON w.org_unit_id = org.id join kuntur.org org2 ON w.org_id = org2.id  where w.agreement_id=''"+agreementId+"''',"+
			// 		 "'select org.id from kuntur.agreement_item w join kuntur.org org on w.org_unit_id = org.id where w.agreement_id=''"+agreementId+"'' group by org.id order by org.id'"+
			// 	") as ("+
			// 	 "Universidad character varying";
			// 	for(var i = 0 ; i < result.rows.length ; i++){
			// 		sql+=",\""+result.rows[i].short_name+"\" text";
			// 	}
			// 	sql+=");";

			
			// 	var query2 = client.query(sql);

			// 	query2.on("row", function(row, result){

			// 		result.addRow(row);
			// 	});

			// 	query2.on("end",function(result){
			
			
			// 		done();
			// 		res.send(200,result);
			// 	});
			// }
			
			
			done();
			res.send(200,JSON.parse(result.rows[0].f_plazas));
		});

		if(err) {

        }

	});


	// query.on("row", function(row, result){
	// 	result.addRow(row);
	// });
	// query.on("end",function(result){
	
	// 	var sql="CREATE EXTENSION IF NOT EXISTS tablefunc;"+
	// 			"select * from crosstab("+
	// 				 "'select org2.name, org.id, w.in_units || ''-'' || w.out_units from kuntur.agreement_item w join kuntur.org org ON w.org_unit_id = org.id join kuntur.org org2 ON w.org_id = org2.id  where w.agreement_id=''"+agreementId+"''',"+
	// 				 "'select org.id from kuntur.agreement_item w join kuntur.org org on w.org_unit_id = org.id where w.agreement_id=''"+agreementId+"'' group by org.id order by org.id'"+
	// 			") as ("+
	// 			 "Universidad character varying";

	// 	if(result.rows.length<1){
	// 		res.send(200,[]);
	// 	}else{
	// 		for(var i = 0 ; i < result.rows.length ; i++){
	// 			sql+=",\""+result.rows[i].short_name+"\" text";
	// 		}
	// 		sql+=");";

	
	// 		query = client.query(sql);

	// 		query.on("row", function(row, result){
	// 			result.addRow(row);
	// 		});

	// 		query.on("end",function(result){
	
	
	// 			res.send(200,result);
	// 		});
	// 	}
	// 	//res.send(200,result.rows);
	// });
});

server.get({path : '/getResponsableXOrgXConvenio', version : '0.0.1'} , function(req, res , next){
	var agreementId=req.params.agrId;
	
var sql = "SELECT org_id,org_short_name, person_family_name || ',' || person_given_name AS name,string_agg(person_email_email, ' ') AS email,string_agg(person_phone_phone_number, ' ') AS tel,"+
 "agreement_contact_reception_student AS reception_student, agreement_contact_sending_student AS sending_student "
+"FROM kuntur.v_responsables "
+"WHERE agreement_item_agreement_id= '"+agreementId+"' AND erased = false AND agreement_item_erased = false "
+"GROUP BY org_short_name, agreement_contact_reception_student, agreement_contact_sending_student, person_family_name, person_given_name, org_id, erased ORDER BY org_short_name";

	
	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		if(err) {

        }

	});


});

server.post({path : '/listResponsablesByOrgs', version : '0.0.1'} , function(req, res , next){//:orgs

	//var aux=["'UNC'", "'IUA'"];
	var aux=[]
	for(var i=0;i<req.body.orgs.length;i++){
		var string="";
		string="\'"+req.body.orgs[i].id+"\'";//+"\'" Tenia esto por alguna razon
		aux.push(string);
	}
	

	var sql = "select * from kuntur.f_responsablesByOrg(ARRAY["+aux+"])";

	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			
			res.send(200,result.rows);
		});

		if(err) {

        }

	});
});

var findId = function(id, array){
	for(i in array){
		
		if(array[i].id==id){
			
			return i;
		}else{
			return null;
		}
	}
}

var recursiva = function(originalTree, nodo){
	
	// nodo.children.forEach()
	if(nodo.children.length>0){//completar
		
		for(i in nodo.children){
			(function(p){
				
				if(p=='first'){

				}
				var j = findId(nodo.children[p].id, originalTree.children);
				
				
				if(j){
					
					recursiva(originalTree.children[j],nodo.children[p]);
				}else{
					
					originalTree.children.push(nodo.children[p]);
				}
			})(i);
		}
	}else{

	}
}
//Prueba es el verdadero org2
server.get({path : '/orgs2lvl', version : '0.0.1'} , function(req, res , next){

	var sql="select * from kuntur.getOrgTree()";


	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);

		query.on("row", function(row, result){
			
			
			result.addRow(JSON.parse(row.getorgtree));//JSON.parse(result.rows[0].f_plazas)
		});

		query.on("end",function(result){
			done();
			var original=result.rows[0];
			
			// for(var i=1;i<result.rows.length;i++){
			
			// 	recursiva(original,result.rows[i])
			// }

			for(var i = 1; i < result.rows.length;i++){
		        (function(j){
		        	recursiva(original,result.rows[j]);
		        })(i);
  			}
			
			//res.send(200,result.rows);
			res.send(200,original);
		});

		if(err) {

        }
	});
});

server.post({path : '/updateAgreement', version : '0.0.1'} , function(req, res , next){

	var sql = "UPDATE kuntur.agreement "+
  		"SET title='"+req.body.agreement.title+"', from_date='"+req.body.agreement.from_date+"', to_date='"+req.body.agreement.to_date+"', agreement_type_id='"+req.body.agreement.agreement_type_id+
  		"', agreement_status_id='"+req.body.agreement.agreement_status_id+"'"+
 		" WHERE id='"+req.body.agreement.id+"';"



 	pg.connect(conString, function(err, client, done){
 		client.query('BEGIN', function(err) {
	 		var query = client.query(sql);

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,"OK");
			});

			query.on("error",function(error){
				res.send(500,error.message);
				return rollback(client, done);
			});

			if(err) {
	          res.send(500,err);
	          return rollback(client, done);
	        }
	    });
 	});
});

server.post({path : '/updateAgreementData', version : '0.0.1'} , function(req, res , next){
	var agreementId=req.body.agreement.id;
	req.body.agreement.agreementItem.forEach(function(elementAgreementItem){
		

		// var agreementItemDetail = elementAgreementItem.agreementItemOu.first(function(i) { return i.id === 'UNC' });
		var agreementItemDetail = findFirstOccurrence(elementAgreementItem.agreementItemOu,'id','UNC');
		var newAgreementItem=false;

		if(findFirstOccurrence(req.body.agreement.universitiesInsert,'id',elementAgreementItem.id)!=-1){// se debe crear un nuevo agreement_item porque la universidad vino en el arreglo de insersiones
	 		var sql="select kuntur.f_insertAgreementItem('"+agreementId+"', '"+elementAgreementItem.id+"','"+agreementItemDetail.in+"','"+agreementItemDetail.out+"');";//function que inserta el agreement si no exsite (puede estar borrado y en ese caso se revive)
			newAgreementItem=true;
		}else if(findFirstOccurrence(req.body.agreement.universitiesDelete,'id',elementAgreementItem.id)!=-1){// se debe borrar el agreement intem (erased = true)
			var sql="UPDATE kuntur.agreement_item "+
	   			"SET erased=true "+
	 			"WHERE agreement_id = '"+agreementId+"' and org_id = '"+elementAgreementItem.id+"' RETURNING id;"
		}else{//como la universidad no esta en el arreglo de insersiones ni el de eliminaciones, solo se hace un update.
			var sql="UPDATE kuntur.agreement_item "+
	   			"SET erased=false, in_units='"+agreementItemDetail.in+"', out_units='"+agreementItemDetail.out+"' "+
	 			"WHERE agreement_id = '"+agreementId+"' and org_id = '"+elementAgreementItem.id+"' RETURNING id;"
		}
		console.log("AgreementItem");
		console.log(sql);

	 	pg.connect(conString, function(err, client, done){

	 		client.query('BEGIN', function(err) {
				var query2 = client.query(sql);


				query2.on("row", function(row, result){

					var agreementItemId=row.id;
					if(typeof agreementItemId === 'undefined'){
						agreementItemId=row.f_insertagreementitem;
					}
					async.parallel([
					function(callback){

						async.forEach(elementAgreementItem.agreementItemOu,function(elementAgreementItemOu, callbackInterno){
							if(elementAgreementItemOu.id!="UNC"){//SON PARA LOS AGREEMENT ITEMS, LOS USE EN EL PASO ANTERIOR
								
								if((findFirstOccurrence(req.body.agreement.selectedOrgs2LvlInsert,'id',elementAgreementItemOu.id)!=-1) || (newAgreementItem)){//insersion de agreement_item_ou, en caso que sea un nuevo agreementItem la insersion se realiza si o si
									var sqlAgItOu="select kuntur.f_insertAgreementItemOu('"+agreementItemId+"','"+elementAgreementItemOu.id+"', '"+elementAgreementItemOu.in+"', '"+elementAgreementItemOu.out+"');";
								}else if(findFirstOccurrence(req.body.agreement.selectedOrgs2LvlDelete,'org_id',elementAgreementItemOu.id)!=-1){
									var sqlAgItOu="UPDATE kuntur.agreement_item_ou "+
						   			" SET erased=true "+
									"WHERE agreement_item_id = '"+agreementItemId+"' and org_id='"+elementAgreementItemOu.id+"';"
								}else{
									var sqlAgItOu="UPDATE kuntur.agreement_item_ou "+
						   			" SET erased=false, in_units='"+elementAgreementItemOu.in+"', out_units='"+elementAgreementItemOu.out+"' "+
									"WHERE agreement_item_id = '"+agreementItemId+"' and org_id='"+elementAgreementItemOu.id+"';"
								}

								console.log("Agreement_item_ou");
								console.log(sqlAgItOu);

								var queryAgItOu = client.query(sqlAgItOu);

								queryAgItOu.on("row", function(row, result){
								});

								queryAgItOu.on("end",function(result){
									callbackInterno();
								});

								queryAgItOu.on("error",function(error){
									res.send(500,error.message);
									return rollback(client, done);
								});

							}else{
								callbackInterno();//Para que termine el elemento UNC
							}
						},function(err){
							
							callback();
						});
					},
					function(callback){
						async.forEach(elementAgreementItem.contacts,function(contacts, callbackInterno){
						//elementAgreementItem.contacts.forEach(function(contacts){
							var inn;
							var out;

							if(contacts.in===true){
								inn="true";
							}else{
								inn="false";
							}
							if(contacts.out===true){
								out="true";
							}else{
								out="false";
							}

							if(findFirstOccurrence(req.body.agreement.contactsInsert,'id',contacts.id)!=-1){//insersion de agreement_contact, en caso de ser un nuevo agreementItem se debe seleccionar igualmente el responsable
								var sqlAgrCon="select kuntur.f_insertAgreementContact('"+agreementItemId+"', '"+contacts.id+"', '"+inn+"', '"+out+"');"
							}else{//es un update, si los dos estan en falso, un trigger deberia setear la bandera erased en true
								var sqlAgrCon="UPDATE kuntur.agreement_contact "+
									"SET erased=false, reception_student='"+inn+"', sending_student='"+out+"' "+
									"WHERE agreement_item_id='"+agreementItemId+"' and contact_id='"+contacts.contact_id+"';"
							}

							console.log("agreement_contact");
							console.log(sqlAgrCon);
							
							
							var queryAgrCon = client.query(sqlAgrCon);

							queryAgrCon.on("row", function(row, result){
							});

							queryAgrCon.on("end",function(result){
								callbackInterno();
							});

							queryAgrCon.on("error",function(error){
								
								res.send(500,error);
								return rollback(client, done);
							});


						},function(err){
							if(err){
								
								res.send(500,err.message);
								rollback(client, done);
							}
							
							callback();
						});
					}], function(err){
						done();
						if(err){

							rollback(client, done);
							res.send(500,err.message);

						}else{
							client.query('COMMIT', done);
							res.send(200,agreementId);
						}
					});

				});



				query2.on("end",function(result){

				});

				query2.on("error",function(error){
					
					res.send(500,error.message);
					return rollback(client, done);

				});



			});


	    });
 	});
});

server.get({path : '/getSelectedOrgs', version : '0.0.1'} , function(req, res , next){

	var sql = "select * from kuntur.org o join kuntur.v_agreement_data ai on ai.org_id=o.id where ai.agreement_id='"+req.params.id+"' AND ai.erased = false;"

 	pg.connect(conString, function(err, client, done){
 		client.query('BEGIN', function(err) {
	 		var query = client.query(sql);

	 		query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(error){
				res.send(500,error.message);
				return rollback(client, done);
			});

			if(err) {
	          res.send(500,err);
	          return rollback(client, done);
	        }
	    });
 	});
});

 server.get({path : '/agreementData', version : '0.0.1'} , function(req, res , next){

	var agreementId=req.params.agrId;

	var sql="select ai.id, ai.in_units, ai.out_units, ai.agreement_id, ai.org_id, o.short_name, o.name, o.original_name, o.country_code from kuntur.agreement_item ai join kuntur.org o on o.id=ai.org_id where agreement_id = '"+agreementId+"' AND ai.erased = false;";


	var query = client.query(sql);
	pg.connect(conString, function(err, client, done){
		client.query('BEGIN', function(err) {
			var query = client.query(sql);
			var agreement={}
			agreement.agreementItem=[];

			query.on("row", function(row, result){
				
				
				// row.prueba="lala";
				result.addRow(row);


			});

			query.on("end",function(result){



				async.forEach(result.rows, function(agreementItem, callbackForEach) {
					var agreementItemId=agreementItem.id;


					async.parallel([
						function(callbackInterno){
							var sqlItem="select ac.id, ac.reception_student, ac.sending_student, c.org_id, p.given_name, p.middle_name, p.family_name, p.id as person_id, c.id as contact_id from kuntur.agreement_contact ac join kuntur.contact c on c.id = ac.contact_id join kuntur.person p on p.id = c.person_id where agreement_item_id='"+agreementItemId+"' and ac.erased=false;"
							var queryContact = client.query(sqlItem);

							queryContact.on("row", function(row, result){
								result.addRow(row);
							});

							queryContact.on("end", function(result){
								callbackInterno(null, result.rows);
							});

							queryContact.on("error",function(error){
								res.send(500,error.message);
								rollback(client, done);
								callbackInterno();
							});

						},
						function(callbackInterno){
							var sqlItemOu="select ou.id, ou.in_units, ou.out_units, ou.org_id, o.short_name, o.name, o.original_name, o.country_code from kuntur.agreement_item_ou ou join kuntur.org o on o.id = ou.org_id where agreement_item_id='"+agreementItemId+"' and ou.erased=false;"
							var queryItemOu = client.query(sqlItemOu);

							queryItemOu.on("row", function(row, result){
								result.addRow(row);
							});

							queryItemOu.on("end", function(result){
								callbackInterno(null, result.rows);
							});

							queryItemOu.on("error",function(error){
								res.send(500,error.message);
								rollback(client, done);
								callbackInterno();
							});
						}
					], function(err, results){
						
						
						agreementItem.contacts=results[0];
						agreementItem.agreementItemOu=results[1];

						agreement.agreementItem.push(agreementItem);
						callbackForEach(null);
					});
				}, function(err){



					res.send(200, agreement);
					done();

				});



			});

			if(err) {

	          	done();
	        }
	    });
	});

});

server.listen(port ,ip_addr, function(){
	console.log("Listening on "+ip_addr+":"+port);
});
