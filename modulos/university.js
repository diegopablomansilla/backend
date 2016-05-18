var pg = require("pg")
var fs      = require('fs');
var async = require('async');
var url = require('url');
var uuid = require('node-uuid');

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

// var log = console.log;

// console.log = function () {
//     var first_parameter = arguments[0];
//     var other_parameters = Array.prototype.slice.call(arguments, 1);

//     function formatConsoleDate (date) {
//         var hour = date.getHours();
//         var minutes = date.getMinutes();
//         var seconds = date.getSeconds();
//         var milliseconds = date.getMilliseconds();
//         var day = date.getDay();
//         var month = date.getMonth();
//         var year = date.getFullYear();

//         return '[' +
//             day+
//             '/'+
//             month+
//             '/'+
//             year+
//             ' '+
//                ((hour < 10) ? '0' + hour: hour) +
//                ':' +
//                ((minutes < 10) ? '0' + minutes: minutes) +
//                ':' +
//                ((seconds < 10) ? '0' + seconds: seconds) +
//                //'.' +
//                //('00' + milliseconds).slice(-3) +
//                '] ';
//     }

//     log.apply(console, [formatConsoleDate(new Date()) + first_parameter].concat(other_parameters));
// };

module.exports = function(server, conString) {
  /**
    * Get universities filtered by the params given.
    *
    * @param {String} countryCode - The iso alpha 3 code of a country.
    * @param {String} searchText - Given text to search
    * @param {Boolean} showErased - Consider erased universities.
    * @param {String} url - Url of the university you are looking for.
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

    if(req.params.url){
      var universityUrl=url.parse(req.params.url);
      if(!universityUrl.hostname){
        aux=universityUrl.href.split("/")
        sql += " AND translate(coalesce(org.web_site::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + aux[0] + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')" ;
      }else{
        sql += " AND translate(coalesce(org.web_site::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') ILIKE translate(coalesce('%" + universityUrl.hostname + "%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')" ;
      }
    }

    if(!req.params.showErased){
  		sql += "AND org.erased=false "; // FIXME when showErased is setted to false, it doesnt add this bit to the sql.
  	}

      sql += ' order by primary_org desc, original_name asc ';


  	if(req.params.offset && req.params.limit){
  		sql += "OFFSET '"+req.params.offset+"' LIMIT '"+req.params.limit+"'";
  	}

  	// var query = client.query(sql);
  
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
          var sql = 'INSERT INTO kuntur.org (id, erased, short_name, original_name, name, web_site, country_code, primary_org, comment, org_type_id) VALUES(uuid_generate_v4()::varchar, false, '; //column id, erased
            if(!!req.body.short_name){ //column short_name
              sql += "'" + req.body.short_name + "', ";
            }
            else {
              sql += "' ', "
            }
              sql += "'" + req.body.original_name + "', ";  // column original_name
              sql += "'" + req.body.original_name + "', ";  // column original_name
              sql += "'" + req.body.web_site + "', ";       // column web_site
              sql += "'" + req.body.country_code + "', ";   // column country_code
              sql += 'false, ';                             // column primary_org
              sql += "'" + req.body.comment + "', ";        // column comment
              sql += "'" + result.rows[0].id + "') RETURNING id";       // column org_type_id

              console.log(sql);

              client.query(sql, function(err, result) {
                done();
                //Return if an error occurs
                if(err) { //connection failed
                  console.error(err);
                  res.send(503, {code: 503, message: 'Database error', description: err});
                  return next();
                }
  			  // res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + result.rows[0].id);
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
  					// res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/mails/' + result.rows[0].id);
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
  					// res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/phones/' + result.rows[0].id);
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
  					// res.header('Location', 'http://'+ip_addr+':' + port + '/universities/' + req.params.unversityId + '/addresses/' + result.rows[0].id);
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
          var logToken = uuid.v4();
          console.log("BEGIN /universities/contacts " + logToken);
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
  							callback(false);
  						});

  						queryContact.on("error",function(error){
  							console.log(error);
                // rollback(client, done)
  							// res.send(500,error);
                callback(error);
  							return ;
  						});

  						// if(err) {
  						// 	console.log(err);
  	     //      				// rollback(client, done);
        //           callback(error);
  	     //      				// return res.send(500,err);
  	     //    			}
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
  								callbackInterno(false);
  							});

  							queryMail.on("error",function(error){
  								console.log(err);
                  callbackInterno(err);
                  // rollback(client, done)
  								// res.send(500,error);
  								return ;
  							});

  							// if(err) {
  							// 	console.log(err);
  		     //      				rollback(client, done);
  		     //      				return res.send(500,err);
  		     //    			}

  						},function(err){
  							if(err){
  								console.log(err);
                  callback(err);
  								// rollback(client, done);
  		          	// return res.send(500,err);
  							}else{
  							 callback(false);
                }
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
                  // rollback(client, done)
  								// res.send(500,error);
                  callbackInterno(error);
  								return ;
  							});

  							// if(err) {
  							// 	console.log(err);
  		     //      				rollback(client, done);
  		     //      				return res.send(500,err);
  		     //    			}

  						},function(err){
  							if(err){
  								console.log(err);
  								// rollback(client, done);
  		      //     				return res.send(500,err);
                  callback(err);
  							}else{
  							 callback(false);
                }
  						});
  					}

  					],function(err){
  					// done();
  					if(err){
  						console.log(err);
  						rollback(client, done);
              console.log("ROLLBACK /universities/contacts " + logToken);
  						return res.send(500,err.message);
  					}else{
  						client.query('COMMIT', done);
              console.log("COMMIT /universities/contacts " + logToken);
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

}
