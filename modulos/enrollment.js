var pg = require("pg")
var fs      = require('fs');
var async = require('async');

var rollback = function(client, done) {
  client.query('ROLLBACK', function(err) {
    //if there was a problem rolling back the query
    //something is seriously messed up.  Return the error
    //to the done function to close & remove this client from
    //the pool.  If you leave a client in the pool with an unaborted
    //transaction weird, hard to diagnose problems might happen.
    console.log(err);
    return done(err);
  });
};

module.exports = function(server, conString) {
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
        console.log(result.rows[0].f_find_enrrollment_by_id);

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

  var sql = "select year from kuntur.v_enrrollment_list group by year order by year desc"

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
}
