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

	var sql="SELECT org.id, org.short_name, org.original_name, org.name, org.url_photo, org.primary_org, org.web_site, org.country_code, org.comment, org.erased  FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='U' ";

	if(req.params.countryCode){
		sql += "AND country_code='"+req.params.countryCode.toUpperCase()+"' ";
	}

	if(req.params.searchText){
    // search by short_name, original_name, name, comment or web_site
		sql += "AND (org.short_name ILIKE '%" + req.params.searchText + "%'" ;
    sql += " OR translate(coalesce(org.original_name::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + req.params.searchText + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')" ;
    sql += " OR translate(coalesce(org.name::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + req.params.searchText + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')" ;
    sql += " OR translate(coalesce(org.comment::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + req.params.searchText + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')" ;
    sql += " OR translate(coalesce(org.web_site::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + req.params.searchText + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN'))" ;
    // translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')
	}

  if(!req.params.showErased){
		sql += "AND org.erased=false "; // FIXME when showErased is setted to false, it doesnt add this bit to the sql.
	}

    sql += ' order by primary_org desc, original_name asc ';


	if(req.params.offset && req.params.limit){
		sql += "OFFSET '"+req.params.offset+"' LIMIT '"+req.params.limit+"'";
	}

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
    if(err) {
      done();
      res.send(500,err);
      console.log(err);
    }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });



	});
});

/* Get a single university */
server.get({path : '/universities/:universityId', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT org.id, org.short_name, org.original_name, org.name, org.url_photo, org.primary_org, org.web_site, org.country_code, org.comment, org.erased FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='U' AND org.id='" + req.params.universityId + "'";

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

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

		if(err) {

        }
	});
});


/* Create a university */

server.post(
  {path:'/universities', version:'0.0.1'},
  function (req, res, next) {
    // Body cannot be empty
    if(!req.body){
      res.send(409, {code: 400, message: 'Bad Request', description: 'No body found in request.'});
      return next();
    }

    // Original name cannot be empty
    if(!req.body.original_name){
      res.send(400, {code: 400, message: 'Bad Request', description: 'original_name value required'});
      return next();
    }

    // web_site value cannot be blank
    if(!req.body.web_site){
      res.send(400, {code: 400, message: 'Bad Request', description: 'web_site value required'});
      return next();
    }

    // country_code value cannot be blank
    if(!req.body.country_code){
      res.send(400, {code: 400, message: 'Bad Request', description: 'country_code value required'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      var sql_u = "select id from kuntur.org_type where code = 'U'";
      client.query(sql_u, function(err, result){
        //Return if an error occurs
        if(err) {
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }
        var sql = 'INSERT INTO kuntur.org (id, erased, short_name, original_name, web_site, country_code, primary_org, comment, org_type_id) VALUES(uuid_generate_v4()::varchar, false, '; //column id, erased
          if(!!req.body.short_name){ //column short_name
            sql += "'" + req.body.short_name + "', ";
          }
          else {
            sql += "' ', "
          }
            sql += "'" + req.body.original_name + "', ";  // column original_name
            sql += "'" + req.body.web_site + "', ";       // column web_site
            sql += "'" + req.body.country_code + "', ";   // column country_code
            sql += 'false, ';                             // column primary_org
            sql += "'" + req.body.comment + "', ";        // column comment
            sql += "'" + result.rows[0].id + "') RETURNING id";       // column org_type_id

            client.query(sql, function(err, result) {
              done();
              //Return if an error occurs
              if(err) { //connection failed
                console.error(err);
                res.send(503, {code: 503, message: 'Database error', description: err});
                return next();
              }
			  res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + result.rows[0].id);
              res.send(201);
            }); // end of insert query
          }); // end of u code query
        }); //end of pg connect
  } // end of function
);

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
      if(!!req.body.comment){
        sql += ", comment= '" + req.body.comment + "' ";
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

	var sql = "SELECT a.id, number_agreement, title, agreement_type_name, agreement_status_name, orgs, ac.contact_id as contact_id, reception_student, sending_student ";
		sql += "FROM kuntur.agreement_item ai ";
		sql += "LEFT JOIN kuntur.agreement_contact ac ON ac.agreement_item_id = ai.id ";
		sql += "LEFT JOIN kuntur.v_agreement a ON a.id = ai.agreement_id ";
		sql += "WHERE ai.org_id='" + req.params.id + "' AND a.erased=false ORDER BY number_agreement";

 	pg.connect(conString, function(err, client, done){
		var query = client.query(sql);
		var agreements = []
		query.on("row", function(row, result){
			var agreement = {
        id: row.id,
				code: row.number_agreement,
				title: row.title,
				type: row.agreement_type_name,
				status: row.agreement_status_name,
				universitiesCount: row.orgs,
        contacts: {
          in: [],
          out: []
        }
			}

      if(row.contact_id){
        if(row.reception_student)
          agreement.contacts.in.push(row.contact_id);
        if(row.sending_student)
          agreement.contacts.out.push(row.contact_id);
      }

      if(agreements.length > 0){
        if(agreements[agreements.length-1].id == agreement.id){ //duplicate agreement (due to having more than one agreement contact)
          agreements[agreements.length-1].contacts.in = agreements[agreements.length-1].contacts.in.concat(agreement.contacts.in);
          agreements[agreements.length-1].contacts.out = agreements[agreements.length-1].contacts.out.concat(agreement.contacts.out);
        }
        else {
          agreements.push(agreement);
        }
      }
      else {
        agreements.push(agreement);
      }
		});

		query.on("end",function(result){
			var sql="SELECT * FROM kuntur.v_contacts WHERE org_id='" + req.params.id+"'"; // new select, getting contacts for the given university

			var query2 = client.query(sql);

			query2.on("row", function(row, result2){
      			result2.addRow(row);
			});

			var contacts=[];
			query2.on("end",function(result2){
				done();

				result2.rows.forEach(function(element){

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
					emails: [],
					phones: []
				}

				if(element.person_email_email){
					contact.emails.push(
						{
							id: element.person_email_id,
							email: element.person_email_email,
						});
				}

				if(element.person_phone_phone_number){
					contact.phones.push(
						{
							id: element.person_phone_id,
							countryCode: element.person_phone_country_code,
							phone: element.person_phone_phone_number,
						});
				}

				contacts.push(contact);
			});
			// console.log(contacts);

			agreements.forEach(function(agreement){
				for (var j = 0; j < agreement.contacts.in.length; j++) {
					for (var i = 0; i < contacts.length; i++) {
						if(contacts[i].id == agreement.contacts.in[j])
							agreement.contacts.in[j] = contacts[i];
					};
				};
				for (var j = 0; j < agreement.contacts.out.length; j++) {
					for (var i = 0; i < contacts.length; i++) {
						if(contacts[i].id == agreement.contacts.out[j])
							agreement.contacts.out[j] = contacts[i];
					};
				};
			});


			res.send(200,agreements);
		});
		});

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

		if(err) {
      		console.log(err);
        }
	});
});

/* GET list of emails from a given university */
server.get({path : '/universities/:id/mails', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.org_email WHERE org_id='" + req.params.id + "' AND erased='false' ORDER BY comment";

	pg.connect(conString, function(err, client, done){
		if(err) {
      done();
      res.send(500,err);
    }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end",function(result){
      done();
      res.send(200,result.rows);
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });
    

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

	var sql="SELECT * FROM kuntur.org_phone WHERE org_id='" + req.params.id + "' AND erased='false' ORDER BY comment";

	pg.connect(conString, function(err, client, done){

		if(err) {
      done();
      res.send(500, err);
        }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end",function(result){
      done();
      res.send(200,result.rows);
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });
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

	var sql="SELECT * FROM kuntur.org_address WHERE org_id='" + req.params.id + "' and erased=false ORDER BY comment";

	pg.connect(conString, function(err, client, done){
		if(err) {
      done();
      res.send(500, err);
        }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end",function(result){
      done();
      res.send(200,result.rows);
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

	});
});


/* Get a sigle university address */
server.get({path : '/universities/:id/addresses/:addressId', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.org_address WHERE id='" + req.params.addressId + "'";

	pg.connect(conString, function(err, client, done){
		if(err) {
      done();
      res.send(500, err);
        }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end",function(result){
      done();
      res.send(200,result.rows);
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

	});
});

/* Delete a university address */
server.del(
	{path:'/universities/:unversityId/addresses/:addressId'},
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
        var sql = "UPDATE kuntur.org_address SET erased='true' WHERE id=";
          sql += "'" + req.params.addressId + "'";

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


/* Create a new university address */
server.post(
		{path: '/universities/:unversityId/addresses', version: '0.0.1'},
		function(req, res, next){

			// Body cannot be empty
			if(!req.body){
				res.send(400, {code: 400, message: 'Bad Request', description: 'Request body cannot be empty.'});
				return next();
			}

      // Checking for required values
			if(!req.body.country_code){
				res.send(400, {code: 400, message: 'Bad Request', description: 'country_code value is required'});
				return next();
			}

			if(!req.body.locality){
				res.send(400, {code: 400, message: 'Bad Request', description: 'locality value is required'});
				return next();
			}

			if(!req.body.street){
				res.send(400, {code: 400, message: 'Bad Request', description: 'street value is required'});
				return next();
			}

			if(!req.body.postal_code){
				res.send(400, {code: 400, message: 'Bad Request', description: 'postal_code value is required'});
				return next();
			}

			pg.connect(conString, function(err, client, done){
				if(err){
					done();
					console.error('error fetching client from pool', err);
					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
					return next();
				}

        // sql base string
				var sql = 'INSERT INTO kuntur.org_address ';
          //columns to be inserted
          sql += '(id, erased, country_code, admin_area_level1_code, locality, street, street_number, building, neighbourhood, postal_code, comment, org_id) VALUES ';

          //values inserted
          sql += "(uuid_generate_v4()::varchar, false, ";    //id, erased
					sql += "'" + req.body.country_code + "', ";        //country_code

					if(!!req.body.admin_area_level1_code){            //admin_area_level_1_code
						sql += "'" + req.body.admin_area_level1_code + "', ";
					}else{
						sql += "' ', ";
					}

          sql += "'" + req.body.locality + "', ";           //locality
          sql += "'" + req.body.street + "', ";             //street

          if(!!req.body.street_number){                     //street_number
						sql += "'" + req.body.street_number + "', ";
					}else{
						sql += "'s/n', ";
					}

          if(!!req.body.building){                         //building
						sql += "'" + req.body.building + "', ";
					}else{
						sql += "' ', ";
					}

          if(!!req.body.neighbourhood){                         //neighbourhood
						sql += "'" + req.body.neighbourhood + "', ";
					}else{
						sql += "' ', ";
					}

          sql += "'" + req.body.postal_code + "', ";      //postal_code

          if(!!req.body.comment){                         //comment
						sql += "'" + req.body.comment + "', ";
					}else{
						sql += "' ', ";
					}

					sql += "'" +req.params.unversityId + "') RETURNING id";  //org_id

				client.query(sql, function(err, result) {
					done();
					//Return if an error occurs
					if(err) { //connection failed
						console.error(err);
						res.send(503, {code: 503, message: 'Database error', description: err});
						return next();
					}
					res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/addresses/' + result.rows[0].id);
					res.send(201);
				});

			});
		}
	);

  /* Update a university address */
  server.put(
  		{path: '/universities/:unversityId/addresses/:addressId', version: '0.0.1'},
  		function(req, res, next){

  			// Body cannot be empty
  			if(!req.body){
  				res.send(409, {code: 409, message: 'Conflict', description: 'Request body cannot be empty.'});
  				return next();
  			}

        // Checking for required values
  			if(!req.body.country_code){
  				res.send(409, {code: 409, message: 'Conflict', description: 'country_code value is required'});
  				return next();
  			}

  			if(!req.body.locality){
  				res.send(409, {code: 409, message: 'Conflict', description: 'locality value is required'});
  				return next();
  			}

  			if(!req.body.street){
  				res.send(409, {code: 409, message: 'Conflict', description: 'street value is required'});
  				return next();
  			}

  			if(!req.body.postal_code){
  				res.send(409, {code: 409, message: 'Conflict', description: 'postal_code value is required'});
  				return next();
  			}

  			pg.connect(conString, function(err, client, done){
  				if(err){
  					done();
  					console.error('error fetching client from pool', err);
  					res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  					return next();
  				}

          // sql base string
  				var sql = 'UPDATE kuntur.org_address SET ';

            //updated values
            if(typeof req.body.erased !== "undefined"){
                sql += "erased= '" + req.body.erased + "', ";
            }

  					sql += "country_code ='" + req.body.country_code + "', ";

  					if(!!req.body.admin_area_level1_code){
  						sql += "admin_area_level1_code = '" + req.body.admin_area_level1_code + "', ";
  					}

            sql += "locality ='" + req.body.locality + "', ";
            sql += "street ='" + req.body.street + "', ";

            if(!!req.body.street_number){
  						sql += "street_number ='" + req.body.street_number + "', ";
  					}

            if(!!req.body.building){
  						sql += "building ='" + req.body.building + "', ";
  					}

            if(!!req.body.neighbourhood){
  						sql += "neighbourhood ='" + req.body.neighbourhood + "', ";
  					}

            sql += "postal_code ='" + req.body.postal_code + "', ";

            if(!!req.body.comment){
  						sql += "comment ='" + req.body.comment + "', ";
  					}

            sql = sql.substring(0, sql.length - 2); //removing the final ", " characters

  					sql += " WHERE id ='" +req.params.addressId + "'";

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

  /* Delete a university address */
  server.del({path : '/universities/:id/addresses/:addressId', version : '0.0.1'} , function(req, res , next){

  	var sql="SELECT * FROM kuntur.org_address WHERE id='" + req.params.addressId + "'";

  	pg.connect(conString, function(err, client, done){

  		if(err) {
        done();
        res.send(500, err);
          }
      var query = client.query(sql);

      query.on("row", function(row, result){
        result.addRow(row);
      });

      query.on("end",function(result){
        done();
        res.send(200,result.rows);
      });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });
  	});
  });


// Get list of contacts
server.get({path : '/universities/:id_university/contacts', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.v_contacts WHERE org_id='" + req.params.id_university+"' and erased='false'";

	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
			done();
			return res.send(500,err);
        }
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
                    erased: element.person_email_erased,
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
                    erased: element.person_phone_erased,
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
          erased: element.erased,
					emails: [],
					phones: []
				}

				if(element.person_email_email){
					contact.emails.push(
						{
							id: element.person_email_id,
							email: element.person_email_email,
              erased: element.person_email_erased,
							comment:element.person_email_comment
						});
				}

				if(element.person_phone_phone_number){
					contact.phones.push(
						{
							id: element.person_phone_id,
							countryCode: element.person_phone_country_code,
							phone: element.person_phone_phone_number,
              erased: element.person_phone_erased,
							comment:element.person_phone_comment
						});
				}

				contacts.push(contact);
			});
			res.send(200, contacts);
		});

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });
	});
});

// Get a single contact
server.get({path : '/universities/:id_university/contacts/:id', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.v_contacts WHERE org_id='" + req.params.id_university+"' and erased='false' and id='" +req.params.id+"'";

	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
			done();
			return res.send(500,err);
        }
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
                    erased: element.person_email_erased,
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
                    erased: element.person_phone_erased,
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
          erased: element.erased,
					emails: [],
					phones: []
				}

				if(element.person_email_email){
					contact.emails.push(
						{
							id: element.person_email_id,
							email: element.person_email_email,
              erased: element.person_email_erased,
							comment:element.person_email_comment
						});
				}

				if(element.person_phone_phone_number){
					contact.phones.push(
						{
							id: element.person_phone_id,
							countryCode: element.person_phone_country_code,
							phone: element.person_phone_phone_number,
              erased: element.person_phone_erased,
							comment:element.person_phone_comment
						});
				}

				contacts.push(contact);
			});
			res.send(200, contacts);
		});

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });
	});
});

/* Create a new contact */
server.post({path:'/universities/:id_university/contacts', version : '0.0.1'} , function(req, res, next){
	var idUniversity=req.params.id_university;
	var contactId;

	var sql = "INSERT INTO kuntur.person(" +
            "id, erased, given_name, family_name, comment) "+
    "VALUES (uuid_generate_v4()::varchar, false, '"+req.body.firstName+"', '"+req.body.surname+"', '"+req.body.comment+"') RETURNING id;"

    pg.connect(conString, function(err, client, done){
    	if(err) {
			console.log(err);
	    	done();
	    	return res.send(500,err);
	    }
    	client.query('BEGIN', function(err) {
    		if(err) {
				console.log(err);
		    	done();
		    	return res.send(500,err);
	    	}

			var query = client.query(sql);

			query.on("row", function(row, result){

				var personId=row.id;
				async.parallel([

					function(callback){//insert contact

						var sqlContact = "INSERT INTO kuntur.contact( "+
            								"id, erased, org_id, person_id) "+
   											"VALUES (uuid_generate_v4()::varchar, false, "+" '"+idUniversity+"', '"+personId+"') RETURNING id;"
						// console.log(sqlContact);

						var queryContact = client.query(sqlContact);

						queryContact.on("row", function(row, result){
							contactId=row.id;
						});

						queryContact.on("end",function(result){
							callback();
						});

						queryContact.on("error",function(error){
							console.log(error);
              rollback(client, done)
							res.send(500,error);
							return ;
						});

						if(err) {
							console.log(err);
	          				rollback(client, done);
	          				return res.send(500,err);
	        			}
					},

					function(callback){//insert emails

						async.forEach(req.body.emails,function(mail, callbackInterno){

							var sqlMail = "INSERT INTO kuntur.person_email( "+
            								"id, erased, email, comment, person_id) "+
    										"VALUES (uuid_generate_v4()::varchar, false, '"+mail.email+"', '"+mail.comment+"', '"+personId+"');";

    						var queryMail = client.query(sqlMail);

    						queryMail.on("row", function(row, result){

							});

							queryMail.on("end",function(result){
								callbackInterno();
							});

							queryMail.on("error",function(error){
								console.log(err);
                rollback(client, done)
								res.send(500,error);
								return ;
							});

							if(err) {
								console.log(err);
		          				rollback(client, done);
		          				return res.send(500,err);
		        			}

						},function(err){
							if(err){
								console.log(err);
								rollback(client, done);
		          				return res.send(500,err);
							}
							callback();
						});
					},

					function(callback){//insert tel
						async.forEach(req.body.phones,function(tel, callbackInterno){

							var sqlTel = "INSERT INTO kuntur.person_phone( "+
            								"id, erased, country_code, phone_number, comment, person_id) "+
    										"VALUES (uuid_generate_v4()::varchar, false, '"+tel.countryCode+"', '"+tel.phone+"', '"+tel.comment+"', '"+personId+"');"

    						var queryTel = client.query(sqlTel);

    						queryTel.on("row", function(row, result){

							});

							queryTel.on("end",function(result){
								callbackInterno();
							});

							queryTel.on("error",function(error){
								console.log(error);
                rollback(client, done)
								res.send(500,error);
								return ;
							});

							if(err) {
								console.log(err);
		          				rollback(client, done);
		          				return res.send(500,err);
		        			}

						},function(err){
							if(err){
								console.log(err);
								rollback(client, done);
		          				return res.send(500,err);
							}
							callback();
						});
					}

					],function(err){
					done();
					if(err){
						console.log(err);
						rollback(client, done);
						return res.send(500,err.message);
					}else{
						client.query('COMMIT', done);
						res.send(201,contactId);
					}
				});

			});


			query.on("end",function(result){

			});

			query.on("error",function(error){
				console.log(error);
        rollback(client, done)
				res.send(500,error);
				return ;
			});

			if(err) {
			  console.log(error);
	          rollback(client, done);
	          return res.send(500,err);
	        }

    	});
    });
});

server.del(
  {path:'/universities/:id_university/contacts/:id', version : '0.0.1'}, function (req, res, next) {
    pg.connect(conString, function (err, client, done) {

      //Return if an error occurs
      if(err) {
        done(); //release the pg client back to the pool
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      //querying database
      var sql = "UPDATE kuntur.contact SET erased='true' WHERE id=";
        sql += "'" + req.params.id + "'";

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


/*Update a contact*/
server.put(
  {path:'/universities/:id_university/contacts/:id'},
  function (req, res, next) {

    // Body cannot be empty
    if(!req.body){
      res.send(409, {code: 409, message: 'Caonflict', description: 'No body found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      var sql = "select person_id from kuntur.contact where id='"+ req.params.id +"'";

      client.query(sql, function(err, result) {
      	var personId = result.rows[0].person_id;

        //Return if an error occurs
        if(err) { //connection failed
          console.error(err);
          res.send(503, {code: 503, message: 'Database error', description: err});
          return next();
        }
        sql = '';
        //TODO update erased in contact (if needeed)
        sql += 'UPDATE kuntur.person SET ';
        if(!!req.body.firstName){
          sql += " given_name= '" + req.body.firstName + "' ";
        }
        if(!!req.body.surname){
          sql += ", family_name= '" + req.body.surname + "' ";
        }
        if(!!req.body.comment){
          sql += ", comment= '" + req.body.comment + "' ";
        }

      	sql += " WHERE id='" + personId + "'";

      	client.query(sql, function (err, result){
      		async.parallel([

      			//update emails
      			function(callback){
      				async.forEach(
      					//array
      					req.body.emails,
      					//function
      					function(email, callbackInterno){
      						// first case, an email has been added
      						if(!email.id){
      							var sqlMail = "INSERT INTO kuntur.person_email( "+
            								"id, erased, email, person_id) "+
    										"VALUES (uuid_generate_v4()::varchar, false, '"+email.email+"', '"+personId+"');";
    							client.query(sqlMail, function(){
      								callbackInterno();
    							});
      						}
      						else{
	      						// second case, an email has been deleted
	      						if(!!email.erased){
	      							var sqlMail = "DELETE FROM kuntur.person_email WHERE id='"+email.id+"'";
	      							client.query(sqlMail, function(){
	      								callbackInterno();
	    							});
	      						}
	      						else{
		      						// default case, an email has been updated
		      						var sqlMail ="UPDATE kuntur.person_email SET email ='"+ email.email +"' where id = '" + email.id + "'";
		      						client.query(sqlMail, function(){
		  								callbackInterno();
		    						});
	      						}
      						}
      					},
      					//foreach callback
      					function(){
	      					callback(); //calling parallel callback
      					}
      				);
      			},

      			//update phones
      			function(callback){
      				async.forEach(
      					//array
      					req.body.phones,
      					//function
      					function(phone, callbackInterno){
      						// first case, an phone has been added
      						if(!phone.id){
      							var sqlPhone = "INSERT INTO kuntur.person_phone( "+
            								"id, erased, country_code, phone_number, person_id) "+
    										"VALUES (uuid_generate_v4()::varchar, false, '"+phone.countryCode+"', '"+phone.phone+"', '"+personId+"');";
    							client.query(sqlPhone, function(){
      								callbackInterno();
    							});
      						}
      						else{
	      						// second case, an email has been deleted
	      						if(!!phone.erased){
	      							var sqlPhone = "DELETE FROM kuntur.person_phone WHERE id='"+phone.id+"'";
	      							client.query(sqlPhone, function(){
	      								callbackInterno();
	    							});
	      						}
	      						else{
		      						// default case, an phone has been updated
		      						var sqlPhone ="UPDATE kuntur.person_phone SET country_code = '"+phone.countryCode+"', phone_number ='"+ phone.phone +"' where id = '" + phone.id + "'";
		      						client.query(sqlPhone, function(){
		  								callbackInterno();
		    						});
	      						}
      						}
      					},
      					//foreach callback
      					function(){
	      					callback(); //calling parallel callback
      					}
      				);
      			},
      			//restore delete contact
      			function(callback){
      				if(typeof req.body.erased !== "undefined"){
						var sql = "UPDATE kuntur.contact SET erased='"+req.body.erased+"' where id='"+req.body.id+"'";
          				client.query(sql, function(){
          					callback();
          				})
      				}
      				else
      					callback();
      			}
  			], function(){
	      		done();
	        	res.send(204);
      		});
      	});
      });
    });

  }
);

server.get({path : '/contacts', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT * FROM kuntur.v_contacts where erased = false";

	var query = client.query(sql);

	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
			done();
			return res.send(500,err);
    }

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
      done();
			res.send(200, contacts);
			
		});

		query.on("error",function(error){
			console.log(error)
      done();
			res.send(500,error);
			return ;
		});


	});
});


server.get({path : '/getAgreements', version : '0.0.1'} , function(req, res , next){
	var busqueda="";
	var deleted = false;
	var pageSize = req.params.pageSize;
	var offset = req.params.offset;
	if(req.params.filter){
		var filtro=JSON.parse(req.params.filter);
		// console.log(filtro);

		if(filtro.cadenaBuscada){
			busqueda=filtro.cadenaBuscada;
		}
		if(filtro.showErased){
			deleted = filtro.showErased;
		}
	}
	// var deleted = false;

	sql="SELECT * FROM kuntur.findAgreements('"+busqueda+"',"+deleted+","+offset+","+pageSize+") ORDER BY number_agreement DESC;";
	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
      done();
			res.send(500,err);
	       	return ;
	    }

		client.query('BEGIN', function(err) {
			if(err) {
				console.log(err);
				done();
				return res.send(500,err);
	     }

			var query = client.query(sql);

			query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(error){
				console.log(error);
        rollback(client, done);
				res.send(500,error);
				return ;
			});

	    });

	});

});

server.get({path:'/findAgreementById', version:'0.0.1'}, function(req,res,next){
	var sql="SELECT * FROM kuntur.f_findagreementsById('"+req.params.idAgreement+"');";

		pg.connect(conString, function(err, client, done){
			if(err) {
			  console.log(err);
        done();
			  res.send(500,err);
	          return ;
	        }

			client.query('BEGIN', function(err) {

			if(err) {
			  console.log(err);
        done();
			  res.send(500,err);
	          return ;
	        }

			var query = client.query(sql);

			query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){

				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(error){
				console.log(error)
        rollback(client, done);
				res.send(500,err);
				return ;
			});



	    });

	});
});

server.get({path : '/getAgreementsTypes', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT id, name FROM kuntur.agreement_type where erased = false";

	pg.connect(conString, function(err, client, done){

		if(err) {
			console.log(err)
      done();
			res.send(500,err);
			return ;
        }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		query.on("error",function(error){
			console.log(error)
      done();
			res.send(500,error);
			
		});


	});

});

server.get({path : '/getOrganizations', version : '0.0.1'} , function(req, res , next){


	var sql="SELECT id, name FROM kuntur.org";

	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
	    	done();
	    	return res.send(500,err);
        }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		query.on("error",function(error){
			console.log(error);
      done();
			res.send(500,error);
			return ;
		});

	});


});

server.get({path : '/getStatus', version : '0.0.1'} , function(req, res , next){

	var sql="SELECT id, name FROM kuntur.agreement_status where erased = false";

	pg.connect(conString, function(err, client, done){

		if(err) {
			console.log(err);
	    	done();
	    	return res.send(500,err);
        }


		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		query.on("error",function(error){
			console.log(error);
      done();
			res.send(500,error);
			return ;
		});

	});



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
		if(err) {
			console.log(err);
	    	done();
	    	return res.send(500,err);
        }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		query.on("error",function(error){
			console.log(error);
      rollback(client, done)
			res.send(500,error);
			return ;
		});

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
    	if(err) {
			console.log(err)
			done();
			return res.send(500,err);
        }

    	client.query('BEGIN', function(err) {
    		if(err) {
				console.log(err)
				done();
				return res.send(500,err);
        	}

    		var agreementId;
			var query = client.query(sql);

			query.on("row", function(row, result){

				agreementId=row.id;



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

									if(elementAgreementItemOu.in=='*'){
										elementAgreementItemOu.in='NULL';
									}

									if(elementAgreementItemOu.out=='*'){
										elementAgreementItemOu.out='NULL';
									}

									var sqlAgItOu="INSERT INTO kuntur.agreement_item_ou("+
							   		"id, erased, in_units, out_units, agreement_item_id, org_id)"+
									"VALUES (uuid_generate_v4()::varchar, false, "+elementAgreementItemOu.in+", "+elementAgreementItemOu.out+", '"+agreementItemId+"', '"+elementAgreementItemOu.id+"');"
									var queryAgItOu = client.query(sqlAgItOu);

									queryAgItOu.on("row", function(row, result){
									});

									queryAgItOu.on("end",function(result){

										callbackInterno();
									});

									queryAgItOu.on("error",function(error){
										console.log(error);
                    rollback(client, done);
										res.send(500,error.message);
										return ;
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
									console.log(error);
                  rollback(client, done)
									res.send(500,error);
									return ;
								});


							},function(err){
								if(err){
									console.log(err);
                  rollback(client, done);
									res.send(500,err.message);
									return ;
								}

								callback();
							});
						}], function(err){
							// done();
							if(err){
								console.log(err);
								rollback(client, done);
								return res.send(500,err.message);

							}else{
								client.query('COMMIT', done);
								res.send(200,agreementId);
							}
						});

					});



					query2.on("end",function(result){
					});

					query2.on("error",function(error){
						console.log(error);
            rollback(client, done);
						res.send(500,error.message);
						return ;
					});



				});
			});

			query.on("end",function(result){
				if(req.body.agreement.agreementItem.length==0){//No se insertaron agreements_items
					client.query('COMMIT', done);
					res.send(200,agreementId);
				}
			});

			query.on("error",function(error){
				console.log(error);
        rollback(client, done);
				res.send(500,error.message);
				return ;

			});

			if(err) {
			  console.log(error);
	          rollback(client, done);
	          return res.send(500,err);
	        }

		});

	});


});

server.get({path : '/getConveniosXOrganizacion', version : '0.0.1'} , function(req, res , next){
	//var agreementId=req.params.agreementId;
	var agreementId=req.params.agrId;
	//var sql=//"SELECT org.short_name FROM kuntur.agreement_item ai join kuntur.org on org.id=ai.org_unit_id where ai.agreement_id='"+agreementId+"' group by org.id order by org.id;";
	var sql="SELECT * FROM kuntur.f_plazas('"+agreementId+"');";
	//var query = client.query("SELECT org.short_name FROM kuntur.agreement_item ai join kuntur.org on org.id=ai.org_unit_id where ai.agreement_id='"+agreementId+"' group by org.id order by org.id;");

	pg.connect(conString, function(err, client, done){

		if(err) {
			console.log(err)
      done();
			return res.send(500,err);
      
        }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){

			// console.log(result.rows[0]);
			done();
			res.send(200,JSON.parse(result.rows[0].f_plazas));
		});

		query.on("error",function(error){
			console.log(error);
      done();
			res.send(500,error.message);
			
		});

	});

});



server.get({path : '/getResponsableXOrgXConvenio', version : '0.0.1'} , function(req, res , next){
	var agreementId=req.params.agrId;

var sql = "SELECT org_id,org_original_name,org_short_name, person_family_name || ', ' || person_given_name AS name,string_agg(person_email_email, ' | ') AS email,string_agg('(' || person_phone_country_code || ')' || person_phone_phone_number, ' | ') AS tel,"+
 "agreement_contact_reception_student AS reception_student, agreement_contact_sending_student AS sending_student "
+"FROM kuntur.v_responsables "
+"WHERE agreement_item_agreement_id= '"+agreementId+"' AND erased = false AND agreement_item_erased = false "
+"GROUP BY org_original_name, org_short_name, agreement_contact_reception_student, agreement_contact_sending_student, person_family_name, person_given_name, org_id, erased ORDER BY org_original_name";


	pg.connect(conString, function(err, client, done){

		if(err) {
			console.log(err)
      done();
			return res.send(500,err);
      
        }

		var query = client.query(sql);

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();
			res.send(200,result.rows);
		});

		query.on("error",function(error){
			console.log(error)
      done();
			res.send(500,error.message);
			
		});

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

    if(err) {
      done();
      res.send(500,err);
    }

		query.on("row", function(row, result){
			result.addRow(row);
		});

		query.on("end",function(result){
			done();

			res.send(200,result.rows);
		});

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });


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

    if(err) {
      done();
      res.send(500,err);
    }
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
    
    query.on("error", function(row, result){
        console.log(error);
        rollback(client, done);
        res.send(500,error.message);
        return ;
    });

	});
});

server.post({path : '/updateAgreement', version : '0.0.1'} , function(req, res , next){

	var sql = "UPDATE kuntur.agreement "+
  		"SET title='"+req.body.agreement.title+"', from_date='"+req.body.agreement.from_date+"', to_date='"+req.body.agreement.to_date+"', agreement_type_id='"+req.body.agreement.agreement_type_id+
  		"', agreement_status_id='"+req.body.agreement.agreement_status_id+"'"+
 		" WHERE id='"+req.body.agreement.id+"';"



 	pg.connect(conString, function(err, client, done){
 		client.query('BEGIN', function(err) {
	 		if(err) {
			    console.log(err);
          done();
			    res.send(500,err);
			    return ;
			}
	 		var query = client.query(sql);
	 		if(err) {
			    console.log(err);
          done();
			    res.send(500,err);
			    return ;
			}

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,"OK");
			});

			query.on("error",function(error){
				console.log(error);
        rollback(client, done);
				res.send(500,error.message);
				return ;
			});

	    });
 	});
});

server.post({path : '/updateAgreementData', version : '0.0.1'} , function(req, res , next){

	pg.connect(conString, function(err, client, done){
		if(err) {
			console.log(err);
      done();
			res.send(500,err);
			return ;
		}

		client.query('BEGIN', function(err) {
			if(err) {
				console.log(err);
        done();
			    res.send(500,err);
			    return ;
			}

			var sqlCount = "select count(*) from kuntur.admission_period_agreement where agreement_id = '"+req.body.agreement.id+"';";

			var queryCount = client.query(sqlCount);

			queryCount.on("row", function(row, result){
				result.addRow(row);
				var cantidad = row.count;

				if(cantidad>0){//El acuerdo no se puede borrar porque tiene convocatorias
					rollback(client, done);
					res.send(403,"El acuerdo no puede editarse debido a que tiene convocatorias");

				}else{//El acuerdo no tiene convocatorias, se puede borrar

					var sqlAgreement = "UPDATE kuntur.agreement "+
			  		"SET title='"+req.body.agreement.title+"', from_date='"+req.body.agreement.from_date+"', to_date='"+req.body.agreement.to_date+"', agreement_type_id='"+req.body.agreement.agreement_type_id+
			  		"', agreement_status_id='"+req.body.agreement.agreement_status_id+"'"+
			 		" WHERE id='"+req.body.agreement.id+"';"

					var queryAgreement = client.query(sqlAgreement);

					queryAgreement.on("end",function(result){

						var agreementId=req.body.agreement.id;
						req.body.agreement.agreementItem.forEach(function(elementAgreementItem){


						// var agreementItemDetail = elementAgreementItem.agreementItemOu.first(function(i) { return i.id === 'UNC' });
							var agreementItemDetail = findFirstOccurrence(elementAgreementItem.agreementItemOu,'id','UNC');
							var newAgreementItem=false;

							if(findFirstOccurrence(req.body.agreement.universitiesInsert,'id',elementAgreementItem.id)!=-1){// se debe crear un nuevo agreement_item porque la universidad vino en el arreglo de insersiones
						 		var sql="select kuntur.f_insertAgreementItem('"+agreementId+"', '"+elementAgreementItem.id+"','"+agreementItemDetail.in+"','"+agreementItemDetail.out+"');";//function que inserta el agreement si no exsite (puede estar borrado y en ese caso se revive)
								newAgreementItem=true;
							}else if(findFirstOccurrence(req.body.agreement.universitiesDelete,'id',elementAgreementItem.id)!=-1){// se debe borrar el agreement intem (erased = true)
								// var sql="UPDATE kuntur.agreement_item "+
						  //  			"SET erased=true "+
						 	// 		"WHERE agreement_id = '"+agreementId+"' and org_id = '"+elementAgreementItem.id+"' and erased = false RETURNING id;"
						 		var sql="select kuntur.f_deleteAgreement_item('"+agreementId+"', '"+elementAgreementItem.id+"');"
							}else{//como la universidad no esta en el arreglo de insersiones ni el de eliminaciones, solo se hace un update.
								var sql="UPDATE kuntur.agreement_item "+
						   			"SET erased=false, in_units='"+agreementItemDetail.in+"', out_units='"+agreementItemDetail.out+"' "+
						 			"WHERE agreement_id = '"+agreementId+"' and org_id = '"+elementAgreementItem.id+"' and erased = false RETURNING id;"
							}
							// console.log("AgreementItem");
							// console.log(sql);


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


											if(elementAgreementItemOu.in=='*'){
												elementAgreementItemOu.in='NULL';
											}

											if(elementAgreementItemOu.out=='*'){
												elementAgreementItemOu.out='NULL';
											}

											if((findFirstOccurrence(req.body.agreement.selectedOrgs2LvlInsert,'id',elementAgreementItemOu.id)!=-1) || (newAgreementItem)){//insersion de agreement_item_ou, en caso que sea un nuevo agreementItem la insersion se realiza si o si
												var sqlAgItOu="select kuntur.f_insertAgreementItemOu('"+agreementItemId+"','"+elementAgreementItemOu.id+"', "+elementAgreementItemOu.in+", "+elementAgreementItemOu.out+");";
											}else if(findFirstOccurrence(req.body.agreement.selectedOrgs2LvlDelete,'org_id',elementAgreementItemOu.id)!=-1){
												var sqlAgItOu="DELETE kuntur.agreement_item_ou "+
												"WHERE agreement_item_id = '"+agreementItemId+"' and org_id='"+elementAgreementItemOu.id+"';"
											}else{
												var sqlAgItOu="UPDATE kuntur.agreement_item_ou "+
									   			" SET erased=false, in_units="+elementAgreementItemOu.in+", out_units="+elementAgreementItemOu.out+" "+
												"WHERE agreement_item_id = '"+agreementItemId+"' and org_id='"+elementAgreementItemOu.id+"' and erased = false;"
											}

											// console.log("Agreement_item_ou");
											// console.log(sqlAgItOu);

											var queryAgItOu = client.query(sqlAgItOu);

											queryAgItOu.on("row", function(row, result){
											});

											queryAgItOu.on("end",function(result){
												callbackInterno();
											});

											queryAgItOu.on("error",function(error){
												console.log(error);
                        rollback(client, done);
												res.send(500,error.message);
												return ;
											});

										}else{
											callbackInterno();//Para que termine el elemento UNC
										}
									},function(err){
										if(err){
											console.log(err);
											res.send(500,err);
										}
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



										var queryAgrCon = client.query(sqlAgrCon);

										queryAgrCon.on("row", function(row, result){
										});

										queryAgrCon.on("end",function(result){
											callbackInterno();
										});

										queryAgrCon.on("error",function(error){
											console.log(error);
                      rollback(client, done);
											res.send(500,error);
											return ;
										});


									},function(err){
										if(err){
											console.log(err);
                      rollback(client, done);
											res.send(500,err.message);
											
										}

										callback();
									});
								}], function(err){
									// done();
									if(err){
										console.log(err);
										rollback(client, done);
										return res.send(500,err.message);

									}else{
										client.query('COMMIT', done);
										res.send(200,agreementId);
									}
								});

							});



							query2.on("end",function(result){

							});

							query2.on("error",function(error){
                rollback(client, done);
								console.log(error);
								res.send(500,error.message);
								return ;

							});


						});//forEach


					});//FIN EDL END DE AGREEMENT



					queryAgreement.on("error",function(error){
						console.log(error);
            rollback(client, done);
						res.send(500,error.message);
						return ;
					});

					if(err) {//del queryAgreement
            rollback(client, done);
					  console.log(err);
			          res.send(500,err);
			          return ;
			        }


	        	}
			});

			queryCount.on("end",function(result){//fin del count
			});

			queryCount.on("error",function(error){
        rollback(client, done);
				console.log(error);
				res.send(500,error.message);
				
			});


			if(err) {//error del count
	          	done();
	        }

		});//begin


	});//connect

});//funcion




server.get({path : '/getSelectedOrgs', version : '0.0.1'} , function(req, res , next){

	var sql = "select * from kuntur.org o join kuntur.v_agreement_data ai on ai.org_id=o.id where ai.agreement_id='"+req.params.id+"' AND ai.erased = false;"

 	pg.connect(conString, function(err, client, done){

 		if(err) {
      done();
				res.send(500,err);
				console.log(err);
	          	return ;
	    }

 		client.query('BEGIN', function(err) {

			if(err) {
        done();
				res.send(500,err);
				console.log(err);
	          	return ;
	    	}

	 		var query = client.query(sql);

	 		query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,result.rows);
			});

			query.on("error",function(error){
        rollback(client, done);
				console.log(error);
				res.send(500,error.message);
				return ;
			});

	    });
 	});
});




server.get({path : '/deleteAgreement', version : '0.0.1'} , function(req, res , next){
	var agreementId=req.params.agrId;

	var sqlCount = "select count(*) from kuntur.admission_period_agreement where agreement_id = '"+req.params.agrId+"';";




	pg.connect(conString, function(err, client, done){
		if(err) {
      done();
			res.send(500,err);
			console.log(err);
	        return ;
	    }
		client.query('BEGIN', function(err) {
			if(err) {
        done();
				res.send(500,err);
				console.log(err);
	      return ;
	   		}

			var queryCount = client.query(sqlCount);

			queryCount.on("row", function(row, result){
				result.addRow(row);
				var cantidad = row.count;

				if(cantidad>0){//El acuerdo no se puede borrar porque tiene convocatorias

					res.send(403,"El acuerdo no puede borrarse debido a que tiene convocatorias");

				}else{//El acuerdo no tiene convocatorias, se puede borrar

					var sql = "UPDATE kuntur.agreement SET erased = true where id = '"+agreementId+"' RETURNING id;";
					var query = client.query(sql);

					query.on("row", function(row, result){
						result.addRow(row);
					});

					query.on("end",function(result){
						client.query('COMMIT', done);
						res.send(200,result);
					});

					query.on("error",function(error){
            rollback(client, done);
						console.log(error);
						res.send(500,error.message);
						
					});

				}
			});

			queryCount.on("end",function(result){
			});

			queryCount.on("error",function(error){
        rollback(client, done);
				console.log(error)
				res.send(500,error.message);
				return ;
			});


			if(err) {
	          	done();
	        }

		});
	});

});

server.get({path : '/reinsertAgreement', version : '0.0.1'} , function(req, res , next){
	var agreementId=req.params.agrId;

	var sql = "UPDATE kuntur.agreement SET erased = false where id = '"+agreementId+"'  RETURNING id;";

	var query = client.query(sql);
	pg.connect(conString, function(err, client, done){
		if(err) {
        done();
				res.send(500,err);
				console.log(err);
	      return ;
	    }
		client.query('BEGIN', function(err) {
			if(err) {
         done();
				res.send(500,err);
				console.log(err);
	       return;
	    	}

			var query = client.query(sql);

			query.on("row", function(row, result){
				result.addRow(row);
			});

			query.on("end",function(result){
				client.query('COMMIT', done);
				res.send(200,result);
			});

			query.on("error",function(error){
				console.log(error)
        rollback(client, done);
				res.send(500,error.message);
				
			});

		});
	});

});

server.get({path : '/postulacionData', version : '0.0.1'}, function(req,res,next){
  postulacionId=req.params.postulacionId;

  var sql = "SELECT  * FROM kuntur.f_find_enrrollment_by_id ('"+postulacionId+"', "+
    "(SELECT id FROM kuntur.user_system WHERE name = '46385'));";

  pg.connect(conString, function(err, client, done){
    if(err) {
      done();
      res.send(500,err);
      
      console.log(err);
      return ;
    }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end", function(result){
      // console.log(result.rows[0].f_find_enrrollment_by_id);

      done();
      res.send(200,JSON.parse(result.rows[0].f_find_enrrollment_by_id));
      
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
      
    });
  });


});

server.get({path : '/postulaciones', version : '0.0.1'}, function(req,res,next){

  filter=JSON.parse(req.params.filter);
  if(filter.year){
    var year = filter.year;
  }else{
    var year=null;
  }
  if(filter.semester){
    var semester = filter.semester;
  }else{
    var semester = null;
  }
  if(filter.country){
    var country = "'"+filter.country+"'";
  }else{
    var country = null;
  }
  if(filter.name){
    var name = "'"+filter.name+"'";
  }else{
    var name = null;
  }
  if(filter.university){
    var university = "'"+filter.university+"'";
  }else{
    var university = null;
  }
  if(filter.email){
    var email = "'"+filter.email+"'";
  }else{
    var email = null;
  }
  if(filter.status){
    var status = "'"+filter.status+"'";
  }else{
    var status = null;
  }
  if(filter.number){
    var number = filter.number;
  }else{
    var number = null;
  }


  var sql = "SELECT  * FROM kuntur.f_find_enrrollment_list("+year+", "+semester+",(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = "+status+"), "+country+", "+
    ""+name+"," +
    ""+university+", "+number+", (SELECT id FROM kuntur.user_system WHERE name = '46385')) offset "+req.params.offset+" limit "+req.params.pageSize+" ;";
  pg.connect(conString, function(err, client, done){
      if(err) {
        done();
        res.send(500,err);
        console.log(err);
        return;
        }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end", function(result){    
      done();
      res.send(200, result.rows);
    
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error.message);
    });
});

});

server.get({path : '/enrrollmentStatus', version : '0.0.1'}, function(req,res,next){

var sql = "select code, name from kuntur.enrrollment_status"


pg.connect(conString, function(err, client, done){
     if(err) {
        done();
        res.send(500,err);
        console.log(err);
        return;
        }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end", function(result){    
      done();
      res.send(200, result.rows);
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error.message);
    });
});

});

server.get({path : '/enrrollmentYears', version : '0.0.1'}, function(req,res,next){

var sql = "select year from kuntur.v_enrrollment_list group by year"

pg.connect(conString, function(err, client, done){
     if(err) {
      done();
      res.send(500,err);
      console.log(err);
      return;
    }
    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end", function(result){    
      done();
      res.send(200, result.rows);
      });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error.message);
    });
});

});




server.get({path : '/agreementData', version : '0.0.1'} , function(req, res , next){

	var agreementId=req.params.agrId;

	var sql="select ai.id, ai.in_units, ai.out_units, ai.agreement_id, ai.org_id, o.short_name, o.name, o.original_name, o.country_code from kuntur.agreement_item ai join kuntur.org o on o.id=ai.org_id where agreement_id = '"+agreementId+"' AND ai.erased = false;";


	var query = client.query(sql);
	pg.connect(conString, function(err, client, done){
		if(err) {
        done();
				res.send(500,err);
				console.log(err);
        return;
	    }

		client.query('BEGIN', function(err) {

			if(err) {
        done();
				res.send(500,err);
				console.log(err); 
        return;  	
	        }

			var query = client.query(sql);
			var agreement={}
			agreement.agreementItem=[];

			query.on("row", function(row, result){

				result.addRow(row);

			});

			query.on("end",function(result){

				async.forEach(result.rows, function(agreementItem, callbackForEach) {
					var agreementItemId=agreementItem.id;


					async.parallel([
						function(callbackInterno){
							var sqlItem="select ac.id, o.short_name, o.original_name, o.web_site, ac.reception_student, ac.sending_student, c.org_id, p.given_name, p.middle_name, p.family_name, p.id as person_id, c.id as contact_id from kuntur.agreement_contact ac join kuntur.contact c on c.id = ac.contact_id join kuntur.person p on p.id = c.person_id join kuntur.org o on o.id = c.org_id where agreement_item_id='"+agreementItemId+"' and ac.erased=false ORDER BY o.original_name;"
							var queryContact = client.query(sqlItem);

							queryContact.on("row", function(row, result){
								result.addRow(row);
							});

							queryContact.on("end", function(result){
								callbackInterno(null, result.rows);
							});

							queryContact.on("error",function(error){
								console.log(error);
                rollback(client, done);
								res.send(500,error.message);
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
								console.log(error);
                rollback(client, done);
								res.send(500,error.message);
								callbackInterno();
							});
						}
					], function(err, results){

						if(err){
							console.log(err);
              rollback(client, done);
							res.send(500,err);
              return;
						}
						agreementItem.contacts=results[0];
						agreementItem.agreementItemOu=results[1];

						agreement.agreementItem.push(agreementItem);
						callbackForEach(null);
					});
				}, function(err){
					if(err){
						console.log(err);
            rollback(client, done)
						res.send(500,err);
						return ;
					}

					//tengo que busar el resto de info del agreement (nombre, fechas, etc...)
					var sqlA="  select a.title, a.from_date, a.to_date, a.agreement_type_id, a.agreement_status_id, ty.name as type_name, st.name as status_name from kuntur.agreement a "+
					" left join kuntur.agreement_type ty on ty.id = a.agreement_type_id"+
					" left join kuntur.agreement_status st on st.id = a.agreement_status_id"+
 					" where a.id = '"+agreementId+"';";
 					var queryA = client.query(sqlA);

 					queryA.on("row", function(row, result){
						result.addRow(row);
					});

					queryA.on("end", function(result){
						agreement.title=result.rows[0].title;
						agreement.from_date=result.rows[0].from_date;
						agreement.to_date=result.rows[0].to_date;
						agreement.agreement_type_id=result.rows[0].agreement_type_id;
						agreement.agreement_status_id=result.rows[0].agreement_status_id;
						agreement.type_name=result.rows[0].type_name;
						agreement.status_name=result.rows[0].status_name;
            client.query('COMMIT', done);
						res.send(200, agreement);
            
						// done();
					});

					queryA.on("error",function(error){
						console.log(error);
            rollback(client, done)
						res.send(500,error.message);
						return ;
					});
				});
			});
	    });
	});
});

server.listen(port ,ip_addr, function(){
	console.log("Listening on "+ip_addr+":"+port);
});
