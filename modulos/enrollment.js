var pg = require("pg")
var fs      = require('fs');
var async = require('async');
var nodemailer = require('nodemailer');
// var smtpTransport = require('nodemailer-smtp-transport');

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

module.exports = function(server, conString, activeMail) {

  server.get({path : '/postulacionData', version : '0.0.1'}, function(req,res,next){

    postulacionId=req.params.postulacionId;

    var sql = "SELECT  * FROM kuntur.f_find_enrrollment_by_id ('"+postulacionId+"', "+
      "(SELECT id FROM kuntur.user_system WHERE name = '" + req.headers.usersystemid + "'));";

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
        //console.log(result.rows[0].f_find_enrrollment_by_id);

        done();
        if(result.rows.length > 0){
          res.send(200,JSON.parse(result.rows[0].f_find_enrrollment_by_id));
        }
        else{
          res.send(200,result.rows);
        }

      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);

      });
    });


  });


/*################################*/
var fs = require('fs');
var path = require('path');
var pdf = require('html-pdf');
var htmlCartaDeAdmisionTemplate = fs.readFileSync('cartadeadmisiontemplate.html', 'utf8');
var htmlCartaDeAdmision = fs.readFileSync('cartadeadmision.html','utf8');
var htmlCertificadoAnaliticoTemplate = fs.readFileSync('certificadoanaliticotemplate.html', 'utf8');
var htmlCertificadoAnalitico = fs.readFileSync('certificadoanalitico.html', 'utf8');
var htmlReporteEstudiante = fs.readFileSync('reporteestudiante.html', 'utf8');

var image = path.join('file://', __dirname, '../logoUncPri.png')
var options = { format: 'Letter'};
 


/* ######## CARTA DE ADMISION TEMPLATE ########### */
 server.post({path : '/docs/:postulacionId/cartaDeAdmisionTemplate', version : '0.0.1'}, function(req,res,next){
    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];     
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()
    /*var html  =  htmlCartaDeAdmisionTemplate
                      .replace("$apellidoPostulante",req.body.familyName)
                      .replace("$nombrePostulante",req.body.givenName)
                      .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                      .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                      .replace("$universidadOrigen",req.body.org.name)
                      .replace("$paisOrigen",req.body.org.countryCode)
                      .replace("$semestre",req.body.admissionPeriod.semester)
                      .replace("$anioPostulacion",req.body.admissionPeriod.year)
                      .replace("$mesCreacion",mes)
                      .replace("$anioCreacion",anio);*/

    if (dia==1) {
      var html = htmlCartaDeAdmisionTemplate.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image);

    }else{
      var html = htmlCartaDeAdmisionTemplate.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image);
    };

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

    pdf.create(html, options).toFile('cartadeadmisiontemplate.pdf', function(err, resPdf) {
      if (err) return console.log(err);
      
      var postulacionId = req.params.postulacionId
      
      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error", err)  
              throw err;

          }
          content = data;

          res.setHeader('Content-Type','application/pdf') 
          res.send(200,new Buffer(data).toString('base64'));
              
      });

    });

});

/*################################*/

/* ###### CARTA DE ADMISION ############# */
 server.post({path : '/docs/:postulacionId/cartaDeAdmision', version : '0.0.1'}, function(req,res,next){
    


    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];     
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()
    /*var html  =  htmlCartaDeAdmisionTemplate
                      .replace("$apellidoPostulante",req.body.familyName)
                      .replace("$nombrePostulante",req.body.givenName)
                      .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                      .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                      .replace("$universidadOrigen",req.body.org.name)
                      .replace("$paisOrigen",req.body.org.countryCode)
                      .replace("$semestre",req.body.admissionPeriod.semester)
                      .replace("$anioPostulacion",req.body.admissionPeriod.year)
                      .replace("$mesCreacion",mes)
                      .replace("$anioCreacion",anio);*/

    if (dia==1) {
      var html = htmlCartaDeAdmision.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image);

    }else{
      var html = htmlCartaDeAdmision.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image);
    };

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

    pdf.create(html, options).toFile('cartadeadmision.pdf', function(err, resPdf) {
      if (err) return console.log(err);
      
      var postulacionId = req.params.postulacionId
      
      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error", err)  
              throw err;

          }
          content = data;

          res.setHeader('Content-Type','application/pdf') 
          res.send(200,new Buffer(data).toString('base64'));
              
      });

    });

});

/*################################*/

/* ######## CERTIFICADO ANALITICO TEMPLATE########### */
 server.post({path : '/docs/:postulacionId/certificadoAnaliticoTemplate', version : '0.0.1'}, function(req,res,next){
    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];     
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()
    /*var html  =  htmlCartaDeAdmisionTemplate
                      .replace("$apellidoPostulante",req.body.familyName)
                      .replace("$nombrePostulante",req.body.givenName)
                      .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                      .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                      .replace("$universidadOrigen",req.body.org.name)
                      .replace("$paisOrigen",req.body.org.countryCode)
                      .replace("$semestre",req.body.admissionPeriod.semester)
                      .replace("$anioPostulacion",req.body.admissionPeriod.year)
                      .replace("$mesCreacion",mes)
                      .replace("$anioCreacion",anio);*/


                      /*armado de las filas*/
    var filas = "";                  


    for (var i = 0; i < req.body.uncInAcademicPerformanceList.length; i++) {
      //postulacionData.data.uncInAcademicPerformanceList[i]
      filas += "<tr><td>"+i+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].subject+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].org.name+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateLetter+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].hs+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInStudiedType.code+"</td>"+
                "</tr>"
      

    };

    if (dia==1) {

      var html = htmlCertificadoAnaliticoTemplate.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image)
                             .replace('$fila', filas);




    }else{
      
      var html = htmlCertificadoAnaliticoTemplate.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image)
                             .replace('$fila', filas);
    };
    
    console.log(html)

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

    pdf.create(html, options).toFile('certificadoanaliticotemplate.pdf', function(err, resPdf) {
      if (err) return console.log(err);
      
      var postulacionId = req.params.postulacionId
      
      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error", err)  
              throw err;

          }
          content = data;

          res.setHeader('Content-Type','application/pdf') 
          res.send(200,new Buffer(data).toString('base64'));
              
      });

    });

});

/*################################*/

/* ######## CERTIFICADO ANALITICO ########### */
 server.post({path : '/docs/:postulacionId/certificadoAnalitico', version : '0.0.1'}, function(req,res,next){
    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];     
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()
    /*var html  =  htmlCartaDeAdmisionTemplate
                      .replace("$apellidoPostulante",req.body.familyName)
                      .replace("$nombrePostulante",req.body.givenName)
                      .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                      .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                      .replace("$universidadOrigen",req.body.org.name)
                      .replace("$paisOrigen",req.body.org.countryCode)
                      .replace("$semestre",req.body.admissionPeriod.semester)
                      .replace("$anioPostulacion",req.body.admissionPeriod.year)
                      .replace("$mesCreacion",mes)
                      .replace("$anioCreacion",anio);*/


                      /*armado de las filas*/
    var filas = "";                  


    for (var i = 0; i < req.body.uncInAcademicPerformanceList.length; i++) {
      //postulacionData.data.uncInAcademicPerformanceList[i]
      filas += "<tr><td>"+i+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].subject+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].org.name+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber+"</td>"+
                    "<td>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateLetter+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].hs+"</td>"+
                    "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInStudiedType.code+"</td>"+
                "</tr>"
      

    };

    if (dia==1) {

      var html = htmlCertificadoAnalitico.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image)
                             .replace('$fila', filas);




    }else{
      
      var html = htmlCertificadoAnalitico.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image)
                             .replace('$fila', filas);
    };
    
    console.log(html)

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

    pdf.create(html, options).toFile('certificadoanalitico.pdf', function(err, resPdf) {
      if (err) return console.log(err);
      
      var postulacionId = req.params.postulacionId
      
      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error", err)  
              throw err;

          }
          content = data;

          res.setHeader('Content-Type','application/pdf') 
          res.send(200,new Buffer(data).toString('base64'));
              
      });

    });

});

/*################################*/

/* ###### REPORTE DEL ESTUDIANTE ############# */
 server.post({path : '/docs/:postulacionId/reporteEstudiante', version : '0.0.1'}, function(req,res,next){
    
    var imagePerfil = path.join('file://', __dirname, '../file/'+req.body.urlPhoto)

    var email = "";
    for (var i = 0; i < req.body.enrrollmentEmailList.length; i++) {
      email+= req.body.enrrollmentEmailList[i].email + " <br>"
    };

    var telefono = "";
    for (var i = 0; i < req.body.enrrollmentPhoneList.length; i++) {
      telefono+= req.body.enrrollmentPhoneList[i].phoneNumber + "("+req.body.enrrollmentPhoneList[i].countryCode+") &nbsp"
    };

    var contactoEmergencia = req.body.emergencyContact;

    if(contactoEmergencia==null){
      contactoEmergencia="";
    }


    var domicilio = "";
    if(req.body.enrrollmentAddressList.buildingFloor==null){
      for (var i = 0; i < req.body.enrrollmentAddressList.length; i++) {
        domicilio+= req.body.enrrollmentAddressList[i].street + " Nº "+req.body.enrrollmentAddressList[i].streetNumber+", CP: "+req.body.enrrollmentAddressList[i].postalCode+" ("+req.body.enrrollmentAddressList[i].countryCode+")<br>"
      };
    }else{
      for (var i = 0; i < req.body.enrrollmentAddressList.length; i++) {
        domicilio+= req.body.enrrollmentAddressList[i].building+"-"+req.body.enrrollmentAddressList[i].buildingFloor+","+req.body.enrrollmentAddressList[i].buildingRoom +"-"+req.body.enrrollmentAddressList[i].street + " "+req.body.enrrollmentAddressList[i].streetNumber+", CP: "+req.body.enrrollmentAddressList[i].postalCode+" ("+req.body.enrrollmentAddressList[i].countryCode+")<br>"
      };
    }

    


    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];     
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()
    /*var html  =  htmlCartaDeAdmisionTemplate
                      .replace("$apellidoPostulante",req.body.familyName)
                      .replace("$nombrePostulante",req.body.givenName)
                      .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                      .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                      .replace("$universidadOrigen",req.body.org.name)
                      .replace("$paisOrigen",req.body.org.countryCode)
                      .replace("$semestre",req.body.admissionPeriod.semester)
                      .replace("$anioPostulacion",req.body.admissionPeriod.year)
                      .replace("$mesCreacion",mes)
                      .replace("$anioCreacion",anio);*/

    if (dia==1) {
      var html = htmlReporteEstudiante.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image)
                             .replace('$imagePerfil', imagePerfil)
                             .replace('$fechaNacimiento', req.body.birthDate)
                             .replace('$email', email)
                             .replace('$telefono', telefono)
                             .replace('$contactoEmergencia', contactoEmergencia)
                             .replace('$domicilio', domicilio)
                             .replace('$numeroPostulacion', req.body.numberEnrrollment)
                             .replace('$periodoAdmision', req.body.admissionPeriod.year)
                             .replace('$convocatoria', req.body.admissionPeriod.title);


    }else{
      var html = htmlReporteEstudiante.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.body.familyName)
                             .replace("$nombrePostulante",req.body.givenName)
                             .replace("$tipoDocumento",req.body.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.body.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.body.org.name)
                             .replace("$paisOrigen",req.body.org.countryCode)
                             .replace("$semestre",req.body.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.body.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image)
                             .replace('$imagePerfil', imagePerfil)
                             .replace('$fechaNacimiento', req.body.birthDate)
                             .replace('$email', email)
                             .replace('$telefono', telefono)
                             .replace('$contactoEmergencia', contactoEmergencia)
                             .replace('$domicilio', domicilio)
                             .replace('$numeroPostulacion', req.body.numberEnrrollment)
                             .replace('$periodoAdmision', req.body.admissionPeriod.year)
                             .replace('$convocatoria', req.body.admissionPeriod.title);
    };

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

    pdf.create(html, options).toFile('reporteestudiante.pdf', function(err, resPdf) {
      if (err) return console.log(err);
      
      var postulacionId = req.params.postulacionId
      
      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error", err)  
              throw err;

          }
          content = data;

          res.setHeader('Content-Type','application/pdf') 
          res.send(200,new Buffer(data).toString('base64'));
              
      });

    });

});

/*################################*/



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
    if(filter.numberAdmissionPeriod){
      var numberAdmissionPeriod = filter.numberAdmissionPeriod;
    }else{
      var numberAdmissionPeriod = null;
    }

    //console.log(req.headers.usersystemid);
    var sql = "SELECT  * FROM kuntur.f_find_enrrollment_list("+year+", "+semester+",(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = "+status+"), "+country+", "+
      ""+name+"," +
      ""+university+", "+number+", (SELECT id FROM kuntur.user_system WHERE name = '" + req.headers.usersystemid + "'), "+numberAdmissionPeriod+") offset "+req.params.offset+" limit "+req.params.pageSize+" ;";



    console.log(sql);
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

  server.get({path : '/documentTypes', version : '0.0.1'}, function(req,res,next){

  var sql = "SELECT code, name, country_code FROM kuntur.person_identity_type;"

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


  	// var query = client.query(sql);
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


  server.put({path:'/userName/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.guivenName){
      res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
      return next();
    }

    if(!req.body.familyName){
      res.send(409, {code: 409, message: 'Conflict', description: 'No familyName found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var sql = {};
        sql.text = "select kuntur.f_u_enrrollment_names($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5)"
        sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.guivenName, req.body.middleName, req.body.familyName];


        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){
          done();
          if(JSON.parse(result.rows[0].f_u_enrrollment_names)){
            res.send(200,"OK");
          }else{
            res.send(500,"Error in function f_u_enrrollment_names");
          }
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error.message);
        });

      });//BEGIN

    }); //CONNECT

  });//FUNCION


  server.put({path:'/userMale/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.body.userSystemId){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.male){
      res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var sql = {};
        sql.text = "select kuntur.f_u_enrrollment_male($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3)"
        sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.male];


        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){
          done();
          if(JSON.parse(result.rows[0].f_u_enrrollment_male)){
            res.send(200,"OK");
          }else{
            res.send(500,"Error in function f_u_enrrollment_male");
          }
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error.message);
        });

      });//BEGIN

    }); //CONNECT

  });//FUNCION

  server.put({path:'/userPhoto/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.body.userSystemId){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.urlPhoto){
      res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      // client.query('BEGIN', function(err) {
      //   if(err) {
      //     console.log(err);
      //       done();
      //       return res.send(500,err);
      //   }

        var sql = {};
        sql.text = "select kuntur.f_u_enrrollment_url_photo($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3)"
        sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.urlPhoto];


        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){
          done();
          if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
            res.send(200,"OK");
          }else{
            res.send(500,"Error in function f_u_enrrollment_url_photo");
          }
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error.message);
        });

      // });//BEGIN

    }); //CONNECT

  });//FUNCION



  server.put({path:'/enrrollment/:inenrrollmentId/citizenship', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.enrrollmentIdentityList,
          function(iden, callback){
            var sql = {};
            if(iden.erased){
              //delete
          
              sql.text = "select kuntur.f_u_enrrollment_Deletecitizenship($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_citizenship($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode, iden.identityNumber, iden.code, iden.name, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertcitizenship($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode, iden.identityNumber, iden.code, iden.name];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              // done();
              // if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
              //   res.send(200,"OK");
              // }else{
              //   res.send(500,"Error in function f_u_enrrollment_url_photo");
              // }
              //hacer cosac cuando termine
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });//FUNCION



  server.put({path:'/enrrollment/:inenrrollmentId/nationality', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    // if(!req.body.userSystemId){
    //   // req.headers.usersystemidH=46385;
    //   res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
    //   return next();
    // }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.enrrollmentNationalityList,
          function(iden, callback){
            var sql = {};
            if(iden.erased){
              //delete
          
              sql.text = "select kuntur.f_u_deleteenrrollment_nationality($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_nationality($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertnationality($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){

              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);

            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });//FUNCION






  server.put({path:'/enrrollment/:inenrrollmentId/mails', version:'0.0.1'}, function(req, res, next){


    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.enrrollmentEmailList){
      res.send(409, {code: 409, message: 'Conflict', description: 'No enrrollmentEmailList found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.enrrollmentEmailList,
          function(mail, callback){
            var sql = {};
            if(mail.erased){
              //update
              sql.text = "select kuntur.f_u_enrrollment_Deleteemail($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, mail.id];
            }
            else if(mail.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_email($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, mail.email, mail.id];
            }
            else if(!mail.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertemail($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, mail.email];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              // done();
              // if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
              //   res.send(200,"OK");
              // }else{
              //   res.send(500,"Error in function f_u_enrrollment_url_photo");
              // }
              //hacer cosac cuando termine
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect


        // var sql = {};
    // sql.text = "select kuntur.f_u_enrrollment_mails($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
    // sql.values = [req.params.inenrrollmentId, req.headers.usersystemidH, req.body.givenName, req.body.middleName, req.body.familyName];



  });






server.put({path:'/enrrollment/:inenrrollmentId/phones', version:'0.0.1'}, function(req, res, next){



    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.enrrollmentPhoneList){
      res.send(409, {code: 409, message: 'Conflict', description: 'No enrrollmentPhoneList found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }


        var queryResult=false;
        async.each(req.body.enrrollmentPhoneList,
          function(phone, callback){
            var sql = {};
            if(phone.erased){
              //update
              sql.text = "select kuntur.f_u_enrrollment_Deletephone($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, phone.id];
            }
            else if(phone.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_phone($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, phone.phoneNumber, phone.countryCode, phone.id];
            }
            else if(!phone.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertphone($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, phone.phoneNumber, phone.countryCode];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              // done();
              // if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
              //   res.send(200,"OK");
              // }else{
              //   res.send(500,"Error in function f_u_enrrollment_url_photo");
              // }
              //hacer cosac cuando termine
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect


        // var sql = {};
    // sql.text = "select kuntur.f_u_enrrollment_mails($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
    // sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.givenName, req.body.middleName, req.body.familyName];



  });


server.put({path:'/enrrollment/:inenrrollmentId/addresses', version:'0.0.1'}, function(req, res, next){



    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.enrrollmentAddressList){
      res.send(409, {code: 409, message: 'Conflict', description: 'No enrrollmentAddressList found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }


        var queryResult=false;
        async.each(req.body.enrrollmentAddressList,
          function(address, callback){
            var sql = {};
            if(address.erased){
              //update
              sql.text = "select kuntur.f_u_enrrollment_Deleteaddress($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, address.id];

            }
            else if(address.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_address($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, address.countryCode, address.adminAreaLevel1Code, address.locality, address.neighbourhood, address.street, address.streetNumber, address.buildingFloor, address.buildingRoom, address.building, address.postalCode, address.comment, address.id];
            }
            else if(!address.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertaddress($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, address.countryCode, address.adminAreaLevel1Code, address.locality, address.neighbourhood, address.street, address.streetNumber, address.buildingFloor, address.buildingRoom, address.building, address.postalCode, address.comment];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){

              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });





  server.put({path:'/enrrollment/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){

    console.log("llegas")
    console.log(req.body)

    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    var sql = {};
    if("givenName" in req.body && "familyName" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_names($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.givenName, req.body.middleName, req.body.familyName];
    }
    else if("male" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_male($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.male];
    }
    else if("urlPhoto" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_photo($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPhoto];
    }
    else if("org" in req.body){//en el caso que el estudiante haya encontrado su universidad cargada en el sistema
      sql.text = "select kuntur.f_u_enrrollment_org_id($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.org.id];
    }
    else if("name" in req.body && "web" in req.body && "country" in req.body){//este es el caso que el estudiante no haya encontrado su universidad y tenga q cargarla manual
      sql.text = "select kuntur.f_u_enrrollment_orgs($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.name, req.body.web, req.body.country, req.body.shortName, req.body.institutionName];
    }
    else if("birthCountryCode" in req.body && "birthDate" in req.body){
      console.log(req.body.birthDate)
      sql.text = "select kuntur.f_u_enrrollment_birth($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.birthDate, req.body.birthCountryCode];
    }
    else if("emergencyContact" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_emergency_contact($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.emergencyContact];
    }
    else if("agreement" in req.body){
      // if(!req.body.agreementName){
      //   req.body.agreementName='null';
      // }
      sql.text = "select kuntur.f_u_enrrollment_agreement($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.agreement, req.body.agreementName];
    }
    else if("program" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_program($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.program, req.body.exchangeProgramName];
    }
    else if("amountPaid" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_amountPaid($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.amountPaid];
    }
    else if("originalDoc" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_originalDoc($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.originalDoc];
    }
    else if("insurance" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_insurance($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.insurance];
    }
    else if("languageCertificate" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_languageCertificate($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.languageCertificate];
    }
    else if("urlOrigininalTranscript" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_origininal_transcript($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlOrigininalTranscript];
    }
    else if("urlCv" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_cv($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlCv];
    }
    else if("urlPassport" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_Passport($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPassport];
    }
    else if("urlApplicationLetter" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_application_letter($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlApplicationLetter];
    }
    else if("urlLanguageCertificate" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_language_certificate($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlLanguageCertificate];
    }
    else if("urlCertificatePsychophysical" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_certificate_psychophysical($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlCertificatePsychophysical];
    }
    else if("visa" in req.body){
      if(!req.body.visa){
        req.body.visa=null;
      }

      sql.text = "select kuntur.f_u_enrrollment_visa($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.visa];

    }
    else if("observation" in req.body && "comment" in req.body){
      if(!req.body.observation){
        req.body.observation=null;
      }
      else{
        req.body.observation="'"+req.body.observation+"'";
      }
      if(!req.body.comment){
        req.body.comment=null;
      }else{
        req.body.comment="'"+req.body.comment+"'";
      }

      sql.text = "select kuntur.f_u_enrrollment_comment($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.comment, req.body.observation];

    }
    // else if("urlPhoto" in req.body){
    //         sql.text = "select kuntur.f_u_enrrollment_urlPhoto($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
    //         sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPhoto];
    // }
    else{
      console.log("Incorrect parameters");
      res.send(409, {code: 409, message: 'Conflict', description: 'Incorrect parameters.'});
      return;
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].respuesta));

        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error.message);
        });


    });

  });


  server.get({path : '/academicUnits', version : '0.0.1'} , function(req, res , next){

    var sql="SELECT org.id, org.short_name, org.original_name, org.name, org.url_photo, org.primary_org, org.web_site, org.country_code, org.comment, org.erased  FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='F' OR code='F' ";

  
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

  server.get({path : '/grades', version : '0.0.1'} , function(req, res , next){

    var sql="select * from kuntur.unc_in_grading_scale ";

  
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


  server.get({path : '/coursesTypes', version : '0.0.1'} , function(req, res , next){

    var sql="select * from kuntur.unc_in_studied_type";

  
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


  server.get({path : '/enrrollment/:inenrrollmentId/studyPlan', version : '0.0.1'} , function(req, res , next){


    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    var sql = {};
    sql.text = "SELECT  * FROM kuntur.f_find_study_program_by_id ($1, (SELECT id FROM kuntur.user_system WHERE name = $2))";
    sql.values = [req.params.inenrrollmentId, req.headers.usersystemid];
  
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
        console.log(result)
        res.send(200,JSON.parse(result.rows[0].f_find_study_program_by_id));
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });



    });
  });


  server.put({path:'/enrrollment/:inenrrollmentId/studyPlan', version:'0.0.1'}, function(req, res, next){

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }
  
    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }


        var queryResult=false;
        async.each(req.body.uncInStudyProgramList,
          function(studyProgram, callback){
            var sql = {};
            if("id" in studyProgram && studyProgram.erased){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_DeleteInStudyProgram($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, studyProgram.id];
            }
            else if(studyProgram.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_inStudyProgram($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7, $8) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, studyProgram.subject, studyProgram.org.id, studyProgram.approved, studyProgram.fileNumber, studyProgram.id, studyProgram.comment];
            }
            else if(!studyProgram.erased){
              sql.text = "select kuntur.f_u_enrrollment_InsertInStudyProgram($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, studyProgram.subject, studyProgram.org.id, studyProgram.comment];
              //insert
            }else{
              callback(false);
            }
            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              console.log(JSON.parse(result.rows[0].respuesta));
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect



  });



  server.put({path:'/enrrollment/:inenrrollmentId/academicPerformance', version:'0.0.1'}, function(req, res, next){

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }
  
    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }


        var queryResult=false;
        async.each(req.body.uncInAcademicPerformanceList,
          function(academicPerformance, callback){
            var sql = {};
            if("id" in academicPerformance && academicPerformance.erased){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_DeleteacademicPerformance($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, academicPerformance.id];
            }
            else if(academicPerformance.id){
              //update
 
              sql.text = "select kuntur.f_u_enrrollment_academicPerformance($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7, $8) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, academicPerformance.org.id, academicPerformance.subject, academicPerformance.uncInGradingScale.id, academicPerformance.hs, academicPerformance.uncInStudiedType.id, academicPerformance.id];
            }
            else if(!academicPerformance.erased){
              sql.text = "select kuntur.f_u_enrrollment_InsertAcademicPerformance($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5, $6, $7) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, academicPerformance.org.id, academicPerformance.subject, academicPerformance.uncInGradingScale.id, academicPerformance.hs, academicPerformance.uncInStudiedType.id];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

            query.on("error",function(error){
              console.log(error);
              // done();
              // res.send(500,error.message);
              callback(error);
            });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect



  });


  server.post({path:'/login', version:'0.0.1'}, function(req, res, next){

    // console.log(req.body.user);
    if(!req.body.user){
      res.send(409, {code: 409, message: 'Conflict', description: 'No user found in request.'});
      return next();
    }

    if(!req.body.pass){
      res.send(409, {code: 409, message: 'Conflict', description: 'No pass found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      var sql = {};
      sql.text = "select kuntur.f_login($1,$2) as respuesta";
      sql.values = [req.body.user, req.body.pass];

      var query = client.query(sql);

      query.on("row", function(row, result){
        result.addRow(row);
      });

      query.on("end", function(result){
        done();
        console.log(result.rows[0].respuesta);
        if(result.rows[0].respuesta){// es una negrada pero cuando agarrabamos el balor en el buffer del otro backend volvia siempre con comillas (este servicio solo lo utilizan los alumnos, los otros usuarios van por /rol)
          res.send(200,result.rows[0].respuesta);
        }else{
          res.send(200,null);
        }
        // res.send(200,"ale");

      });//FIN CB END GUIVEN_NAME

      query.on("error",function(error){
        done();
        console.log(error);
        res.send(500,error);
      });

    });


  });


  server.post({path:'/rol', version:'0.0.1'}, function(req, res, next){

    // console.log(req.body.user);
    if(!req.body.user){
      res.send(409, {code: 409, message: 'Conflict', description: 'No user found in request.'});
      return next();
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      var sql = {};
      sql.text = "select kuntur.f_login_oid($1) as respuesta";
      sql.values = [req.body.user];

      var query = client.query(sql);

      query.on("row", function(row, result){
        result.addRow(row);
      });

      query.on("end", function(result){
        done();
        res.send(200,result.rows[0].respuesta);
        // res.send(200,"ale");

      });//FIN CB END GUIVEN_NAME

      query.on("error",function(error){
        done();
        console.log(error);
        res.send(500,error);
      });

    });


  });

server.post({path:'/student', version:'0.0.1'}, function(req, res, next){

  if(!req.body){
    res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
    return next();
  }

  if(!req.body.name){
    res.send(409, {code: 409, message: 'Conflict', description: 'No name found in request.'});
    return next();
  }

  if(!req.body.lastName){
    res.send(409, {code: 409, message: 'Conflict', description: 'No lastName found in request.'});
    return next();
  }

  if(!req.body.mail){
    res.send(409, {code: 409, message: 'Conflict', description: 'No mail found in request.'});
    return next();
  }

  if(!req.body.user){
    res.send(409, {code: 409, message: 'Conflict', description: 'No user found in request.'});
    return next();
  }

  if(!req.body.pass){
    res.send(409, {code: 409, message: 'Conflict', description: 'No pass found in request.'});
    return next();
  }

  if(!req.body.country){
    res.send(409, {code: 409, message: 'Conflict', description: 'No country found in request.'});
    return next();
  }

  var sql = {};
  sql.text = "select kuntur.f_new_student($1, $2, $3, $4, $5, $6) as respuesta";
  sql.values = [req.body.name, req.body.lastName, req.body.mail, req.body.user, req.body.pass, req.body.country];


  pg.connect(conString, function(err, client, done){
    if(err){
      done();
      console.error('error fetching client from pool', err);
      res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
      return next();
    }

    var query = client.query(sql);

    query.on("row", function(row, result){
      result.addRow(row);
    });

    query.on("end", function(result){
      done();
      res.send(200,result.rows[0].respuesta);
    });//FIN CB END GUIVEN_NAME

    query.on("error",function(error){
      done();
      console.log(error);
      res.send(500,error);
    });


  });


});


server.get({path : '/student', version : '0.0.1'} , function(req, res , next){

  // console.log(req.headers);
    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    var sql = {};
    sql.text = "SELECT  * FROM kuntur.perfilArray($1)";
    sql.values = [req.headers.usersystemid,];
  
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
//JSON.parse(result.rows[0].perfilArray)
      query.on("end",function(result){
        done();
        res.send(200,JSON.parse(result.rows[0].perfilarray));
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });



    });
  });

  server.put({path : '/student', version : '0.0.1'}, function(req, res, next){

    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body.person){
      res.send(409, {code: 409, message: 'Conflict', description: 'No person found in request.'});
      return next();
    }

    var orgId = null;
    var shortName=null;
    var originalName=null;
    var name=null;
    var web=null;
    var country=null; 
    // console.log(req.body.person.person_given_name, req.body.person.person_middle_name, req.body.person.person_family_name, req.body.person.person_male, req.body.person.person_birth_date, req.body.person.person_birth_country_code, req.body.person.student_org_id, req.body.person.student_short_name, req.body.person.student_institution_original_name, req.body.person.student_institution_name, req.body.person.student_institution_web_site, req.body.person.student_institution_country_code, req.headers.usersystemid, req.body.person.person_id)
    if(req.body.person.student_org_id){
      orgId=req.body.person.student_org_id;

      var sql = {};
      sql.text = "SELECT kuntur.f_u_studentProfile($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)";
      sql.values = [req.body.person.person_given_name, req.body.person.person_middle_name, req.body.person.person_family_name, req.body.person.person_male, req.body.person.person_birth_date, req.body.person.person_birth_country_code, orgId, null, null, null, null, null, req.headers.usersystemid, req.body.person.person_id, req.body.person.person_url_photo];

    }else{
      shortName=req.body.person.student_short_name;
      originalName=req.body.person.student_institution_original_name;
      name=req.body.person.student_institution_name;
      web=req.body.person.student_institution_web_site;
      country=req.body.person.student_institution_country_code; 
      var sql = {};
      sql.text = "SELECT kuntur.f_u_studentProfile($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)";
      sql.values = [req.body.person.person_given_name, req.body.person.person_middle_name, req.body.person.person_family_name, req.body.person.person_male, req.body.person.person_birth_date, req.body.person.person_birth_country_code, null, shortName, name, originalName, web, country, req.headers.usersystemid, req.body.person.person_id, req.body.person.person_url_photo];

    }

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
//JSON.parse(result.rows[0].perfilArray)
    query.on("end",function(result){
      // console.log(result);
      done();
      res.send(200,result.rows[0].f_u_studentProfile);//JSON.parse(
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });



    });



  });


server.put({path:'/student/mails', version:'0.0.1'}, function(req, res, next){
// console.log("headers")
//   console.log(req.headers);
    
    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.person.emails,
          function(mail, callback){
            var sql = {};
            if(mail.erased){
              //delete
              sql.text = "select kuntur.f_d_student_email($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, mail.id];
            }
            else if(mail.id){
              //update
              sql.text = "select kuntur.f_u_student_email($1, $2, $3, $4) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, mail.email, mail.id];
            }
            else if(!mail.erased){
              sql.text = "select kuntur.f_i_student_email($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, mail.email];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              // done();
              // if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
              //   res.send(200,"OK");
              // }else{
              //   res.send(500,"Error in function f_u_enrrollment_url_photo");
              // }
              //hacer cosac cuando termine
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect


  });

server.put({path:'/student/phones', version:'0.0.1'}, function(req, res, next){
    
    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.person.phones,
          function(phone, callback){
            var sql = {};
            if(phone.erased){
              //delete
              sql.text = "select kuntur.f_d_student_phone($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, phone.id];
            }
            else if(phone.id){
              //update
              sql.text = "select kuntur.f_u_student_phone($1, $2, $3, $4, $5) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, phone.country_code,  phone.phone_number, phone.id];
            }
            else if(!phone.erased){
              sql.text = "select kuntur.f_i_student_phone($1, $2, $3, $4) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, phone.country_code, phone.phone_number];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){
              // done();
              // if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
              //   res.send(200,"OK");
              // }else{
              //   res.send(500,"Error in function f_u_enrrollment_url_photo");
              // }
              //hacer cosac cuando termine
              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);
            // done();
            // res.send(500,error.message);
            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect


  });


server.put({path:'/student/nationality', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.headers.usersystemidH=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.each(req.body.person.nationalities,
          function(iden, callback){
            var sql = {};
            if(iden.erased){
              //delete
              sql.text = "select kuntur.f_d_student_nationality($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_student_nationality($1, $2, $3, $4) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.country_code, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_i_student_nationality($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.country_code];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){

              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);

            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });//FUNCION

server.put({path:'/student/identity', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.headers.usersystemidH=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        // console.log(req.body.person.identities)
        var queryResult=false;
        async.each(req.body.person.identities,
          function(iden, callback){
            var sql = {};
            console.log(req.headers.usersystemid);
            if(iden.erased){
              //delete
              console.log(iden);
              sql.text = "select kuntur.f_d_student_document($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_student_document($1, $2, $3, $4, $5, $6, $7) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.code, iden.identity_number, iden.name, iden.country_code, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_i_student_document($1, $2, $3, $4, $5, $6) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.code, iden.identity_number, iden.name, iden.country_code];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){

              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);

            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{

              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });//FUNCION

server.put({path:'/student/address', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    if(!req.headers.usersystemid){
      // req.headers.usersystemidH=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }


    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        // console.log(req.body.person.identities)
        var queryResult=false;
        async.each(req.body.person.addresses,
          function(iden, callback){
            var sql = {};
            console.log(req.headers.usersystemid);
            if(iden.erased){
              //delete
              console.log(iden);
              sql.text = "select kuntur.f_d_student_address($1, $2, $3) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_student_address($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.country_code, iden.admin_area_level1_code, iden.locality, iden.neighbourhood, iden.street, iden.street_number, iden.building_floor, iden.building_room, iden.building, iden.postal_code, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_i_student_address($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) as respuesta"
              sql.values = [req.params.person.person_id, req.headers.usersystemid, iden.country_code, iden.admin_area_level1_code, iden.locality, iden.neighbourhood, iden.street, iden.street_number, iden.building_floor, iden.building_room, iden.building, iden.postal_code];
              //insert
            }else{
              callback(false);
            }

            var query = client.query(sql);

            query.on("row", function(row, result){
             result.addRow(row);
            });

            query.on("end", function(result){

              queryResult=JSON.parse(result.rows[0].respuesta);
              callback(false)
            });//FIN CB END GUIVEN_NAME

          query.on("error",function(error){
            console.log(error);

            callback(error);
          });

          },
          function(err){
            //termine!
            if(err){
              console.log(err);
              rollback(client, done);
              res.send(500,err);
            }else{
              
              client.query('COMMIT', done);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });//FUNCION


  server.get({path : '/enrrollment/status', version : '0.0.1'} , function(req, res , next){

    // console.log(req.headers);
      if(!req.headers.usersystemid){
        res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
        return next();
      }

      var sql = {};
      sql.text = "SELECT  * FROM kuntur.f_enrrollment_status($1, $2)";
      sql.values = [req.headers.usersystemid, req.params.enrrollmentId];
    
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
  //JSON.parse(result.rows[0].perfilArray)
        query.on("end",function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].f_enrrollment_status));
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });


  server.get({path : '/userSystem/org', version : '0.0.1'} , function(req, res , next){

    // console.log(req.headers);
      if(!req.headers.usersystemid){
        res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
        return next();
      }

      var sql = {};
      sql.text = "SELECT  * FROM kuntur.f_get_org_academic_performance($1)";
      sql.values = [req.headers.usersystemid];
    
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
  //JSON.parse(result.rows[0].perfilArray)
        query.on("end",function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].f_get_org_academic_performance));
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });
  
  


    server.get({path : '/state', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);

      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        console.log(req.params);
        var sql = {};
        sql.text = "select kuntur.f_change_state($1, $2, $3) as respuesta"
        sql.values = [req.params.enrrollmentId, req.headers.usersystemid, req.params.statusCode];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          // var transporter = nodemailer.createTransport({//smtpTransport(
          //     host: 'titan.unc.edu.ar',
          //     tls: {
          //           "rejectUnauthorized": false
          //     }
          // });//)

          // var mailOptions = {
          // from: 'Fred Foo <foo@blurdybloop.com>', // sender address
          // to: 'alejandro_1564@hotmail.com, abiagetti@unc.edu.ar', // list of receivers
          // subject: 'Hello', // Subject line
          // text: 'Hello world', // plaintext body
          // html: '<b>Hello world</b>' // html body
          // };

          // transporter.sendMail(mailOptions, function(error, info){
          // if(error){
          //     return console.log(error);
          // }
          // console.log('Message sent: ' + info.response);

          // });

          sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });



        
    });

  });
 //else if("name" in req.body && "web" in req.body && "country" in req.body){

  var sendMail = function(enrrollmentId){

    if(activeMail){// se activa/desactiva el mail desde el archivo config


      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_info_mails($1) as respuesta"
        sql.values = [enrrollmentId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){


          queryResult=JSON.parse(result.rows[0].respuesta);
          done();



          for(var i in queryResult.mailconfig){

            for(var j in queryResult.stakeholders){

              if(queryResult.mailconfig[i].group_id == queryResult.stakeholders[j].group_system_id){



                var transporter = nodemailer.createTransport({//smtpTransport(
                  host: 'titan.unc.edu.ar',
                  tls: {
                  "rejectUnauthorized": false
                  }
                });//)

               console.log(queryResult.mailconfig)

                var mailOptions = {
                  from: 'Fred Foo <foo@blurdybloop.com>', // sender address
                  to: queryResult.stakeholders[j].email, // list of receivers
                  subject: queryResult.mailConfig[i].subject, // Subject line
                  text: queryResult.mailConfig[i].body // plaintext body
                  /*html: '<b>Hello world</b>'*/ // html body
                };

                

                transporter.sendMail(mailOptions, function(error, info){
                  if(error){
                    return console.log(error);
                  }
                  // console.log('Message sent: ' + info.response);

                  console.log("enviado a "+queryResult.stakeholders[j].email+" subj "+queryResult.mailconfig[i].subject)

                });                

              }

            }


          }


        });

        query.on("error",function(error){
          done();
          console.log(error);
        });



        
    });






        // var transporter = nodemailer.createTransport({//smtpTransport(
        //   host: 'titan.unc.edu.ar',
        //   tls: {
        //   "rejectUnauthorized": false
        //   }
        // });//)

        // var mailOptions = {
        //   from: 'Fred Foo <foo@blurdybloop.com>', // sender address
        //   to: 'alejandro_1564@hotmail.com, abiagetti@unc.edu.ar', // list of receivers
        //   subject: 'Hello', // Subject line
        //   text: 'Hello world', // plaintext body
        //   html: '<b>Hello world</b>' // html body
        // };

        // transporter.sendMail(mailOptions, function(error, info){
        //   if(error){
        //     return console.log(error);
        //   }
        // console.log('Message sent: ' + info.response);

        // });


    }


  }


      server.get({path : '/nextState', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.nextstep($1, $2) as respuesta"
        sql.values = [req.headers.usersystemid, req.params.enrrollmentId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });



        
    });

  });


  server.get({path : '/admissionPeriodAvaible', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_get_admission_period_by_org($1, (select id from kuntur.user_system where name = $2)) as respuesta"
        sql.values = [req.params.orgId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });



        
    });

  });

  server.post({path : '/enrrollment', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_insert_enrrollment($1, (select id from kuntur.user_system where name = $2)) as respuesta"
        sql.values = [req.body.admissionPeriodId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });



        
    });

  });




    server.get({path : '/groups', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_get_groups() as respuesta"
        //sql.values = [req.body.admissionPeriodId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          //sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });
        
    });

  });


  server.get({path : '/usersnotstudents', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_get_users_not_students() as respuesta"
        //sql.values = [req.body.admissionPeriodId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          //sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });
        
    });

  });

  server.get({path : '/usergroup/:groupId', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_get_usersby_group($1) as respuesta"
        sql.values = [req.params.groupId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          //sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });
        
    });

  });


  server.post({path : '/usergroup', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_add_to_group($1, $2) as respuesta"
        sql.values = [req.params.user_system_id, req.params.groupId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          //sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });
        
    });

  });


  server.del({path : '/usergroup', version : '0.0.1'}, function(req, res, next){

    req.body=JSON.parse(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        sql.text = "select kuntur.f_remove_from_group($1, $2) as respuesta"
        sql.values = [req.body.user_system_id, req.body.groupId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          //sendMail(req.params.enrrollmentId);

          queryResult=JSON.parse(result.rows[0].respuesta);
          done();
          res.send(200, queryResult);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });
        
    });

  });


// ##### COORDINADORES Y DESPACHO ###### //

server.get({path : '/coordinators', version : '0.0.1'} , function(req, res , next){

    // console.log(req.headers);
      if(!req.headers.usersystemid){
        res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
        return next();
      }

      var sql = {};
      sql.text = "SELECT  * FROM kuntur.f_get_directivos($1)";
      sql.values = [req.params.orgId];

    
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
  //JSON.parse(result.rows[0].perfilArray)
        query.on("end",function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].f_get_directivos));
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });

server.get({path : '/allCoordinators', version : '0.0.1'} , function(req, res , next){

    // console.log(req.headers);
      if(!req.headers.usersystemid){
        res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
        return next();
      }

      var sql = {};
      sql.text = "SELECT  * FROM kuntur.f_get_all_directivos()";
      //sql.values = [req.params.orgId];

    
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
  //JSON.parse(result.rows[0].perfilArray)
        query.on("end",function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].f_get_all_directivos));
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });

server.put({path:'/unidadesAcademicas/:auId/directivos', version:'0.0.1'}, function(req, res, next){


    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    console.log(req.body.coordinadoresNuevos)

    if(!req.headers.usersystemid){
      // req.body.userSystemId=46385;
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }

   
   

    pg.connect(conString, function(err, client, done){
      if(err){
        done();
        console.error('error fetching client from pool', err);
        res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
        return next();
      }

      client.query('BEGIN', function(err) {
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;
        async.series([
          function(callback){
            var sql = "DELETE FROM kuntur.unc_in_academic_coordinator WHERE org_id=$1"; 
            var params =[
                  req.params.auId
            ]
            

            var query = client.query(sql,params, function(error){

              if(error){
                callback(error);
              }else{
                callback(null);
              }

            });
          }, function(callback){
            var sql = "DELETE FROM kuntur.unc_in_academic_office WHERE org_id=$1"; 
            var params =[
                  req.params.auId
            ]
            

            var query = client.query(sql,params, function(error){

              if(error){
                callback(error);
              }else{
                callback(null);
              }

            });
          }, function(callback){

            async.forEach(req.body.coordinadoresNuevos, function(person,callbackInterno){

               var sql = "INSERT INTO kuntur.unc_in_academic_coordinator VALUES (uuid_generate_v4()::varchar, false, $1, $2 )";
               var params = [
                  person.id,
                  req.params.auId
               ]


              var query = client.query(sql,params, function(error){

              if(error){
                callbackInterno(error);
              }else{
                callbackInterno(null);
              }

            });

            }, function(error){
              if(error){
                callback(error);
              }else{
                callback(null);
              }

            })

           

           
          }, function(callback){

            async.forEach(req.body.despachoNuevo, function(person,callbackInterno){

               var sql = "INSERT INTO kuntur.unc_in_academic_office VALUES (uuid_generate_v4()::varchar, false, $1, $2 )";
               var params = [
                  person.id,
                  req.params.auId
               ]


              var query = client.query(sql,params, function(error){

              if(error){
                callbackInterno(error);
              }else{
                callbackInterno(null);
              }

            });

            }, function(error){
              if(error){
                callback(error);
              }else{
                callback(null);
              }

            })

           

           
          }
        ],function(error){
          done();
           if(error){
                console.log(error);
                rollback(client, done);
                res.send(500,err);
              }else{
                client.query('COMMIT', done);
                res.send(200,queryResult);
            }
        });//end async
      });

    });//connect

        // var sql = {};
    // sql.text = "select kuntur.f_u_enrrollment_mails($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3, $4, $5) as respuesta"
    // sql.values = [req.params.auId, req.headers.usersystemidH, req.body.givenName, req.body.middleName, req.body.familyName];



  });




}




