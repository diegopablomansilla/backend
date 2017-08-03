var pg = require("pg")
var fs      = require('fs');
var async = require('async');
var uuid = require('node-uuid');

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
        var logToken = uuid.v4();
        console.log("BEGIN /getAgreements " + logToken);
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
          console.log("COMMIT /getAgreements " + logToken);
  				res.send(200,result.rows);
  			});

  			query.on("error",function(error){
  				console.log(error);
          rollback(client, done);
          console.log("ROLLBACK /getAgreements " + logToken);
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
        var logToken = uuid.v4();
        console.log("BEGIN /findAgreementById " + logToken);
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
          console.log("COMMIT /findAgreementById " + logToken);
  				res.send(200,result.rows);
  			});

  			query.on("error",function(error){
  				console.log(error)
          rollback(client, done);
          console.log("ROLLBACK /findAgreementById " + logToken);
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

    var agreementTo = req.body.agreement.to;

    if(!agreementTo){
      agreementTo=null;
    }
    else{
      agreementTo="'"+req.body.agreement.to+"'"
    }


  	var sql="INSERT INTO kuntur.agreement("+
              "id, erased, title, from_date, to_date, comment, agreement_type_id, "+
              "agreement_status_id, org_id)"+
  	"VALUES (uuid_generate_v4()::varchar, false,'"+req.body.agreement.name+"', '"+req.body.agreement.from+"', "+agreementTo+", 'asdasd', '"+req.body.agreement.type+"',"+
  	"'"+req.body.agreement.status+"', 'b57e010c-426a-45d4-b218-f819fd1bf4e7') RETURNING id;"

      pg.connect(conString, function(err, client, done){
      	if(err) {
  			console.log(err)
  			done();
  			return res.send(500,err);
          }

      	client.query('BEGIN', function(err) {
          var logToken = uuid.v4();
          console.log("BEGIN /insertarAgreement " + logToken);
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

            var auxIn=agreementItemDetail.in;
            var auxOut=agreementItemDetail.out;

            if(auxIn=='*'){
              auxIn='NULL'
            }
            if(auxOut=='*'){
              auxOut='NULL';
            }

  					var sql="INSERT INTO kuntur.agreement_item("+
  						    "id, erased, in_units, out_units, agreement_id, org_id)"+
  					"VALUES (uuid_generate_v4()::varchar, false, "+auxIn+", "+auxOut+", '"+agreementId+"', '"+elementAgreementItem.id+"')"+
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
                      // rollback(client, done);
  										// res.send(500,error.message);
                      callbackInterno(error);
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
                    // rollback(client, done)
  									// res.send(500,error);
                    callbackInterno(error);
  									return ;
  								});


  							},function(err){
  								if(err){
  									console.log(err);
                    //rollback(client, done);
  									//res.send(500,err.message);
                    callback(err);
  									//return ;
  								}

  								callback();
  							});
  						}], function(err){
  							// done();
  							if(err){
  								console.log(err);
  								rollback(client, done);
                  console.log("ROLLBACK /insertarAgreement " + logToken);
  								return res.send(500,err.message);

  							}else{
  								client.query('COMMIT', done);
                  console.log("COMMIT /insertarAgreement " + logToken);
  								res.send(200,agreementId);
  							}
  						});

  					});



  					query2.on("end",function(result){
  					});

  					query2.on("error",function(error){
  						console.log(error);
              rollback(client, done);
              console.log("ROLLBACK /insertarAgreement " + logToken);
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

// console.log(sql);

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


    for(var i = 0; i < array.length;i++){
    //for(i in array){
//console.log(array);
//console.log("id:", id)
// console.log("id: "+id+" vs "+array[i].id)
        if(array[i].id==id){


          return i;
        }
        // else{
        //   console.log("id: "+id);
        //   console.log("array: "+array[i].id);
          // console.log("arrai:"+array[i].id);

        // }
      }

        console.log("id:"+id);
          return null;
  }



  var recursiva = function(originalTree, nodo){
//console.log(originalTree)
  // nodo.children.forEach()
  //console.log(originalTree)
  if(nodo.children.length>0){//completar

    for(i in nodo.children){
      (function(p){

        if(p=='first'){

        }

        var j = findId(nodo.id, originalTree.children);//.children[p]


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

  var recursiva2 = function(originalTree, nodo){
//  if(originalTree.length>1)
//  console.log("nodo+")
// console.log(nodo)
  // nodo.children.forEach()
  //console.log(originalTree)
  //if(nodo.length>0){//completar

    for(var i = 0; i < nodo.length;i++){
    //for(i in nodo){
      (function(p){

        // if(p=='first'){

        // }
                // console.log(p)
        var j = findId(nodo[p].id, originalTree);//.children[p]
        if(nodo[p].id=='ff808082385897cc01387c4e53270065'){
                        // ff808082385897cc01387c4e53270065
         //  console.log("pushhhhhhhhhhhhhh")
         // console.log(originalTree)
         // console.log(j)
        }
//console.log(j)
        if(j!=null){
          // console.log(j)
          if(nodo[p].children.length>0){
            // console.log(nodo[p]);
            // for(var x = 0; x < nodo[p].children.length;x++){
            //for(x in nodo[p].children){
              // (function(g){
                 // console.log(originalTree[j].children)
                recursiva2(originalTree[j].children,nodo[p].children);//[g]
               // })(x);
            // }
          }else{
            return;
          }
        }else{
          // console.log("j:"+j)
          // console.log(nodo[push])
          // if(nodo[p].id=='ff808082385897cc01387c4e53270065')
          //   console.log("pushhhhhhhhhh")
          // console.log(originalTree)
          originalTree.push(nodo[p]);//.children

          return;
        }
      })(i);
    }
  //}else{

  //}
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
  			var original=[];
        original.push(result.rows[0]);
        // console.log(original)
  			// for(var i=1;i<result.rows.length;i++){

  			// 	recursiva(original,result.rows[i])
  			// }

  			for(var i = 1; i < result.rows.length;i++){

  		        (function(j){
 // console.log(j)
                var auxArray = [];
                auxArray.push(result.rows[j])
  		        	recursiva2(original,auxArray);

  		        })(i);
    			}

  			//res.send(200,result.rows);
  			res.send(200,original[0]);
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
        var logToken = uuid.v4();
        console.log("BEGIN /updateAgreement " + logToken);
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
          console.log("COMMIT /updateAgreement " + logToken);
  				res.send(200,"OK");
  			});

  			query.on("error",function(error){
  				console.log(error);
          rollback(client, done);
          console.log("ROLLBACK /updateAgreement " + logToken);
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
        var logToken = uuid.v4();
        console.log("BEGIN /updateAgreementData " + logToken);
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

  			});

  			queryCount.on("end",function(result){//fin del count

          //var cantidad = row.count;
          var cantidad = result.rows[0];

          if(cantidad.count>0){//El acuerdo no se puede borrar porque tiene convocatorias
            rollback(client, done);
            console.log("ROLLBACK /updateAgreementData " + logToken);
            res.send(403,"El acuerdo no puede editarse debido a que tiene convocatorias");

          }else{//El acuerdo no tiene convocatorias, se puede borrar

            var sqlAgreement = "UPDATE kuntur.agreement "+
              "SET title='"+req.body.agreement.title+"', from_date='"+req.body.agreement.from_date+"', to_date='"+req.body.agreement.to_date+"', agreement_type_id='"+req.body.agreement.agreement_type_id+
              "', agreement_status_id='"+req.body.agreement.agreement_status_id+"'"+
            " WHERE id='"+req.body.agreement.id+"';"

            // console.log(sqlAgreement);

            //var queryAgreement = client.query(sqlAgreement);

            client.query(sqlAgreement, function(err, result) {

              if(err){
                console.log(error);
                rollback(client, done);
                console.log("ROLLBACK /updateAgreementData " + logToken);
                res.send(500,error.message);
                return ;
              }else{


              var agreementId=req.body.agreement.id;
              //req.body.agreement.agreementItem.forEach(function(elementAgreementItem){
              async.each(req.body.agreement.agreementItem,function(elementAgreementItem, callbackItem){


              // var agreementItemDetail = elementAgreementItem.agreementItemOu.first(function(i) { return i.id === 'UNC' });
                var agreementItemDetail = findFirstOccurrence(elementAgreementItem.agreementItemOu,'id','UNC');
                var newAgreementItem=false;

                if(findFirstOccurrence(req.body.agreement.universitiesInsert,'id',elementAgreementItem.id)!=-1){// se debe crear un nuevo agreement_item porque la universidad vino en el arreglo de insersiones
                  var sql="select kuntur.f_insertAgreementItem('"+agreementId+"', '"+elementAgreementItem.id+"','"+agreementItemDetail.in+"','"+agreementItemDetail.out+"');";//function que inserta el agreement si no exsite (puede estar borrado y en ese caso se revive)
                  newAgreementItem=true;
                }else if(findFirstOccurrence(req.body.agreement.universitiesDelete,'id',elementAgreementItem.id)!=-1){// se debe borrar el agreement intem (erased = true)
                  // var sql="UPDATE kuntur.agreement_item "+
                //        "SET erased=true "+
                //    "WHERE agreement_id = '"+agreementId+"' and org_id = '"+elementAgreementItem.id+"' and erased = false RETURNING id;"
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

                    async.each(elementAgreementItem.agreementItemOu,function(elementAgreementItemOu, callbackInterno){
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
                          var sqlAgItOu="DELETE from kuntur.agreement_item_ou "+
                          "WHERE agreement_item_id = '"+agreementItemId+"' and org_id='"+elementAgreementItemOu.id+"';"

                          //console.log("SQL AgItOu",sqlAgItOu);
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
                          callbackInterno(null);
                        });

                        queryAgItOu.on("error",function(error){
                          callbackInterno(error);
                          console.log(error);
                          // rollback(client, done);
                          // res.send(500,error.message);
                          // return ;
                        });

                      }else{
                        callbackInterno(null);//Para que termine el elemento UNC
                      }
                    },function(err){// callback del each agreement item
                      if(err){
                        console.log(err);
                        //res.send(500,err);
                        callback(err);
                      }else{
                        callback(null);
                      }
                    });
                  },
                  function(callback){
                    async.each(elementAgreementItem.contacts,function(contacts, callbackInterno){
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
                        callbackInterno(null);
                      });

                      queryAgrCon.on("error",function(error){
                        console.log(error);
                        callbackInterno(error);
                        // rollback(client, done);
                        // res.send(500,error);
                        // return ;
                      });


                    },function(err){//callback del each de contact
                      if(err){
                        console.log(err);
                        // rollback(client, done);
                        // res.send(500,err.message);
                        callback(err);
                      }else{
                        callback(null);
                      }
                    });
                  }], function(err){//callback del parallel
                    // done();
                     // callbackItem(err);
                     if(err){
                      callbackItem(err);
                     }else{
                      callbackItem(null);
                     }
                  });

                });// fin del callback de row de agreement item



                query2.on("end",function(result){// no se hace nada porque esta todo dentro del on row

                });

                query2.on("error",function(error){
                  // rollback(client, done);
                  console.log(error);
                  callbackItem(error);
                  // res.send(500,error.message);
                  // return ;

                });


              }, function(err){//callback del primer each (el de agreement item)

                if(err){
                      console.log(err);
                      rollback(client, done);
                      console.log("ROLLBACK /updateAgreementData " + logToken);
                      return res.send(500,err.message);

                }else{
                      client.query('COMMIT', function(err, result) {
                        console.log("COMMIT /updateAgreementData " + logToken);
                        if(err){
                          console.log(err);
                        }
                        done();
                      });
                      res.send(200,agreementId);
                }




              });


              }

            });//fin de la query que actualiza los datos basicos del agreement

            // queryAgreement.on("row", function(row, result){
            //   result.addRow(row);
            // });


//             queryAgreement.on("end",function(result){

// //forEach principal


//             });//FIN EDL END DE AGREEMENT



            // queryAgreement.on("error",function(error){
            //   console.log(error);
            //   rollback(client, done);
            //   res.send(500,error.message);
            //   return ;
            // });

            // if(err) {//del queryAgreement
            //   rollback(client, done);
            //   console.log(err);
            //       res.send(500,err);
            //       return ;
            //     }


          }//fin del else que valida que el agreement pueda usarse


  			});//fin del count para ver si se puede editar el acuerdo

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
        var logToken = uuid.v4();
        console.log("BEGIN /getSelectedOrgs " + logToken);
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
          console.log("COMMIT /getSelectedOrgs " + logToken);
  				res.send(200,result.rows);
  			});

  			query.on("error",function(error){
          rollback(client, done);
          console.log("ROLLBACK /getSelectedOrgs " + logToken);
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
        var logToken = uuid.v4();
        console.log("BEGIN /deleteAgreement " + logToken);
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
              console.log("COMMIT /deleteAgreement " + logToken);
  						res.send(200,result);
  					});

  					query.on("error",function(error){
              rollback(client, done);
              console.log("ROLLBACK /deleteAgreement " + logToken);
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
        var logToken = uuid.v4();
        console.log("BEGIN /reinsertAgreement " + logToken);
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
          console.log("COMMIT /reinsertAgreement " + logToken);
  				res.send(200,result);
  			});

  			query.on("error",function(error){
  				console.log(error)
          rollback(client, done);
          console.log("ROLLBACK /reinsertAgreement " + logToken);
  				res.send(500,error.message);

  			});

  		});
  	});

  });

  //Historial






  server.get({path : '/getHistory', version : '0.0.1'} , function(req, res , next){
    var sql={};
    sql.text = "SELECT kuntur.f_q_enrrollment_log_json ($1, $2)";
    sql.values = [req.params.inenrrollment_id, req.params.userSystemId];





    pg.connect(conString, function(err, client, done){

      if(err) {
        done();
          res.send(500,err);
          console.log(err);
                return ;
        }

      client.query('BEGIN', function(err) {
        var logToken = uuid.v4();
        console.log("BEGIN /getHistory " + logToken);
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
          console.log("COMMIT /getHistory " + logToken);
          res.send(200,result.rows);
        });

        query.on("error",function(error){
          rollback(client, done);
          console.log("ROLLBACK /getHistory " + logToken);
          console.log(error);
          res.send(500,error.message);
          return ;
        });

        });
    });
  });

//Fin Historial









}
