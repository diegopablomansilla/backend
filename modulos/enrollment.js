var pg = require("pg");
var fs      = require('fs');
var async = require('async');
var nodemailer = require('nodemailer');
var uuid = require('node-uuid');
var smtpTransport = require('nodemailer-smtp-transport');

var config = JSON.parse(fs.readFileSync('/etc/nodejs-config/kuntur.json'));

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

var log = console.log;
console.log = function () {
  var first_parameter = arguments[0];
  var other_parameters = Array.prototype.slice.call(arguments, 1);

  function formatConsoleDate (date) {
    var hour = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var milliseconds = date.getMilliseconds();
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    return '[' +
    day+
    '/'+
    month+
    '/'+
    year+
    ' '+
    ((hour < 10) ? '0' + hour: hour) +
    ':' +
    ((minutes < 10) ? '0' + minutes: minutes) +
    ':' +
    ((seconds < 10) ? '0' + seconds: seconds) +
    //'.' +
    //('00' + milliseconds).slice(-3) +
    '] ';
  }

  log.apply(console, [formatConsoleDate(new Date()) + first_parameter].concat(other_parameters));
};


var executeSQL = function(sql){
  var pro = new node.Promise(function(resolve, reject){
    pg.connect(conString, function(err, client, done){
      if(err) {
        done();
        console.log(err);
        return ;
      }

      var query = client.query(sql);

      query.on("row", function(row, result){
        result.addRow(row);
      });

      query.on("error",function(error){
        console.log(error);
        done();
        reject(error);
      });

      query.on("end", function(result){
        done();
        resolve(result);
      });

    });
  });//fin promesa
  return(pro);
};

// var promise = new Promise(function(resolve, reject) {
//            wrapper(doc, resolve, reject)
//          });
//          promise.then(function (result) {
//            roots.push(result);
//            callback();
//          }, function (err) {
//            callback(err);
//          })


module.exports = function(server, conString, activeMail) {


  server.get({path : '/postulacionData', version : '0.0.1'}, function(req,res,next){

    postulacionId=req.params.postulacionId;

    var sql = "SELECT  * FROM kuntur.f_find_enrrollment_by_id ('"+postulacionId+"', '"+req.headers.usersystemid+"');";
    //"(SELECT id FROM kuntur.user_system WHERE name = '" + req.headers.usersystemid + "'));";

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
          // console.log(result.rows[0].f_find_enrrollment_by_id)
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
var htmlCartaDeAdmisionTemplate = fs.readFileSync(path.join(__dirname, '../cartadeadmisiontemplate.html'), 'utf8');
//console.log("Html path nuevo:",htmlCartaDeAdmisionTemplate)
var htmlCartaDeAdmision = fs.readFileSync(path.join(__dirname, '../cartadeadmision.html'),'utf8');
var htmlCertificadoAnaliticoTemplate = fs.readFileSync(path.join(__dirname, '../certificadoanaliticotemplate.html'), 'utf8');
var htmlCertificadoAnalitico = fs.readFileSync(path.join(__dirname, '../certificadoanalitico.html'), 'utf8');
var htmlReporteEstudiante = fs.readFileSync(path.join(__dirname, '../reporteestudiante.html'), 'utf8');

var image = path.join('file://', __dirname, '../logoUncPri.png');

var options = { format: 'A4',
  footer: {
    "height": "20mm",
    "contents": '<span style="color: #444;"></span><span></span>'
  }//,
};



/* ######## CARTA DE ADMISION TEMPLATE ########### */
 server.post({path : '/docs/:postulacionId/cartaDeAdmisionTemplate', version : '0.0.1'}, function(req,res,next){
    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];
    var d = new Date();
    var dia = d.getDate();
    var mes = meses[d.getMonth()];
    var anio = d.getFullYear();
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
    }

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

   pdf.create(html, options).toFile(path.join(__dirname, '../cartadeadmisiontemplate.pdf'), function(err, resPdf) {
     if (err) return console.log(err);

     var postulacionId = req.params.postulacionId;

     var content;
     // First I want to read the file
     fs.readFile(resPdf.filename, function read(err, data) {
       if (err) {
         console.log("Error", err);
         throw err;

       }
       content = data;

       res.setHeader('Content-Type','application/pdf');
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
    var d = new Date();
    var dia = d.getDate();
    var mes = meses[d.getMonth()];
    var anio = d.getFullYear();
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
    }

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

   pdf.create(html, options).toFile(path.join(__dirname, '../cartadeadmision.pdf'), function(err, resPdf) {
     if (err) return console.log(err);

     var postulacionId = req.params.postulacionId;

     var content;
     // First I want to read the file
     fs.readFile(resPdf.filename, function read(err, data) {
       if (err) {
         console.log("Error", err);
         throw err;

       }
       content = data;

       res.setHeader('Content-Type','application/pdf');
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
    var d = new Date();
    var dia = d.getDate();
    var mes = meses[d.getMonth()];
    var anio = d.getFullYear();
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
      filas += "<tr><td>&nbsp;"+(i+1)+"&nbsp;</td>"+
      "<td>&nbsp;"+req.body.uncInAcademicPerformanceList[i].subject+"</td>"+
      "<td>&nbsp;"+req.body.uncInAcademicPerformanceList[i].org.name+"</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber+"</td>"+
      "<td style='text-align: center'>&nbsp;"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateLetter+"&nbsp;</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].hs+"</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInStudiedType.code+"</td>"+
      "</tr>";
    }

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
    } else {
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
    }
   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

   pdf.create(html, options).toFile(path.join(__dirname, '../certificadoanaliticotemplate.pdf'), function(err, resPdf) {
     if (err) return console.log(err);

     var postulacionId = req.params.postulacionId;

     var content;
     // First I want to read the file
     fs.readFile(resPdf.filename, function read(err, data) {
       if (err) {
         console.log("Error", err);
         throw err;

       }
       content = data;
       res.setHeader('Content-Type','application/pdf');
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
    var d = new Date();
    var dia = d.getDate();
    var mes = meses[d.getMonth()];
    var anio = d.getFullYear();
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
      if(req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber<0){
        req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber="-";
      }
      filas += "<tr><td>&nbsp;"+(i+1)+"&nbsp;</td>"+
      "<td>&nbsp;"+req.body.uncInAcademicPerformanceList[i].subject+"</td>"+
      "<td>&nbsp;"+req.body.uncInAcademicPerformanceList[i].org.name+"</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber+"</td>"+
      "<td style='text-align: center'>&nbsp;"+req.body.uncInAcademicPerformanceList[i].uncInGradingScale.rateLetter+"&nbsp;</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].hs+"</td>"+
      "<td style='text-align: center'>"+req.body.uncInAcademicPerformanceList[i].uncInStudiedType.code+"</td>"+
      "</tr>";
    }

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
    }

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

   pdf.create(html, options).toFile(path.join(__dirname, '../certificadoanalitico.pdf'), function(err, resPdf) {
     if (err) return console.log(err);

     var postulacionId = req.params.postulacionId;

     var content;
     // First I want to read the file
     fs.readFile(resPdf.filename, function read(err, data) {
       if (err) {
         console.log("Error", err);
         throw err;
       }
       content = data;
       res.setHeader('Content-Type','application/pdf');
       res.send(200,new Buffer(data).toString('base64'));
     });
   });

});



/*################################*/

/* ###### REPORTE DEL ESTUDIANTE ############# */
server.post({path : '/docs/:postulacionId/reporteEstudiante', version : '0.0.1'}, function(req,res,next){

  var imagePerfil = path.join('file://', __dirname, '../files/'+req.body.urlPhoto.substr(0,2)+'/'+req.body.urlPhoto);
  //var imagePerfil = path.join(__dirname, 'files', req.body.urlPhoto.substr(0,2), req.body.urlPhoto);
  var email = "";
  for (var i = 0; i < req.body.enrrollmentEmailList.length; i++) {
    email+= req.body.enrrollmentEmailList[i].email + " ";
  }

  var telefono = "";
  for (var i = 0; i < req.body.enrrollmentPhoneList.length; i++) {
    telefono+= req.body.enrrollmentPhoneList[i].phoneNumber + "("+req.body.enrrollmentPhoneList[i].countryCode+") &nbsp";
  }

  var contactoEmergencia = req.body.emergencyContact;

  if(contactoEmergencia===null){
    contactoEmergencia="";
  }

  var domicilio = "";

  // console.log(req.body.enrrollmentAddressList)
  for (var i = 0; i < req.body.enrrollmentAddressList.length; i++) {
    console.log(req.body.enrrollmentAddressList[i].countryName);

    if(req.body.enrrollmentAddressList[i].provinceName===undefined || req.body.enrrollmentAddressList[i].provinceName===null ){
      req.body.enrrollmentAddressList[i].provinceName="";
    }

    if(req.body.enrrollmentAddressList[i].buildingFloor===null){
      req.body.enrrollmentAddressList[i].buildingFloor="";
      req.body.enrrollmentAddressList[i].building="";
      req.body.enrrollmentAddressList[i].buildingRoom="";
      domicilio+= "[·] "+req.body.enrrollmentAddressList[i].street + " Nº "+req.body.enrrollmentAddressList[i].streetNumber+"-"+req.body.enrrollmentAddressList[i].locality+", CP: "+req.body.enrrollmentAddressList[i].postalCode+"-"+req.body.enrrollmentAddressList[i].provinceName+"-"+req.body.enrrollmentAddressList[i].countryName+"("+req.body.enrrollmentAddressList[i].countryCode+").<br>";
    }else{
      domicilio+= "[·] "+ req.body.enrrollmentAddressList[i].building+"-"+req.body.enrrollmentAddressList[i].buildingFloor+","+req.body.enrrollmentAddressList[i].buildingRoom +"-"+req.body.enrrollmentAddressList[i].street +" Nº "+ req.body.enrrollmentAddressList[i].streetNumber + " - "+req.body.enrrollmentAddressList[i].locality+", CP: "+req.body.enrrollmentAddressList[i].postalCode+" - " +req.body.enrrollmentAddressList[i].provinceName+" - "+req.body.enrrollmentAddressList[i].countryName+" ("+req.body.enrrollmentAddressList[i].countryCode+") <br>";
    }
  }


  //Generador de fecha actual al momento de realizar la carta de admision template
  var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
  var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];
  var d = new Date();
  var dia = d.getDate();
  var mes = meses[d.getMonth()];
  var anio = d.getFullYear();
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
    .replace('$perfil', imagePerfil)
    .replace('$fechaNacimiento', req.body.birthDate)
    .replace('$email', email)
    .replace('$telefono', telefono)
    .replace('$contactoEmergencia', contactoEmergencia)
    .replace('$domicilio', domicilio)
    .replace('$numeroPostulacion', req.body.numberEnrrollment)
    .replace('$periodoAdmision', req.body.admissionPeriod.year)
    .replace('$convocatoria', req.body.admissionPeriod.title)
    .replace('$numeroEstudiante', req.body.student.fileNumber);
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
    .replace('$perfil', imagePerfil)
    .replace('$fechaNacimiento', req.body.birthDate)
    .replace('$email', email)
    .replace('$telefono', telefono)
    .replace('$contactoEmergencia', contactoEmergencia)
    .replace('$domicilio', domicilio)
    .replace('$numeroPostulacion', req.body.numberEnrrollment)
    .replace('$periodoAdmision', req.body.admissionPeriod.year)
    .replace('$convocatoria', req.body.admissionPeriod.title)
    .replace('$numeroEstudiante', req.body.student.fileNumber);
  }
  // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())

  pdf.create(html, options).toFile(path.join(__dirname, '../reporteestudiante.pdf'), function(err, resPdf) {
    if (err) return console.log(err);

    var postulacionId = req.params.postulacionId;
    var content;
    // First I want to read the file
    fs.readFile(resPdf.filename, function read(err, data) {
      if (err) {
        console.log("Error", err);
        throw err;
      }
      content = data;

      res.setHeader('Content-Type','application/pdf');
      res.send(200,new Buffer(data).toString('base64'));
    });
  });

});


/*################################*/
server.get({path : '/pruebaMail', version : '0.0.1'}, function(req, res, next){
  // var smtpTransport = nodemailer.createTransport("SMTP",{
  //     service: "Gmail",
  //     auth: {
  //         user: "",
  //         pass: ""
  //     }
  // });

  var options = {
    service: "Gmail",
    auth: {
      user: "",
      pass: ""
    }
  };

  var mailOptions = {
    from: "Fred Foo ✔ <anbiagetti@gmail.com>", // sender address
    to: "anbiagetti@gmail.com, abiagetti@unc.edu.ar", // list of receivers
    subject: "Hello ✔", // Subject line
    text: "Hello world ✔", // plaintext body
    html: "<b>Hello world ✔</b>" // html body
  };

  var transporter = nodemailer.createTransport(smtpTransport(options));

  transporter.sendMail(mailOptions, function(error, response){
    if(error){
      console.log(error);
    }else{
      console.log("Message sent: " + response.message);
    }
    // if you don't want to use this transport object anymore, uncomment following line
    //smtpTransport.close(); // shut down the connection pool, no more messages
  });
});



  server.get({path : '/postulaciones', version : '0.0.1'}, function(req,res,next){

    filter=JSON.parse(req.params.filter);

    console.log("USerSYstem:", req.headers.usersystemid);
    console.log("FILTROS:",req.params.filter);
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
    if(filter.namePeriod){
      var namePeriod = "'"+filter.namePeriod+"'";
    }else{
      var namePeriod = null;
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
    if(filter.aunit){
      console.log("aUnits;",filter.aunit);
      var aUnits = "'"+filter.aunit+"'";
    }else{
      var aUnits = null;
    }

    //console.log(req.headers.usersystemid);
    var sql = "SELECT  * FROM kuntur.f_find_enrrollment_list("+year+", "+semester+",(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = "+status+"), "+country+", "+
      ""+name+","+ ""+university+", "+number+", '" + req.headers.usersystemid + "', "+numberAdmissionPeriod+", "+aUnits+",(SELECT ap.id FROM kuntur.admission_period ap WHERE ap.title = "+namePeriod+")) offset "+req.params.offset+" limit "+req.params.pageSize+" ;";

      console.log("SQL", sql);

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

  server.get({path : '/admissionPeriod', version : '0.0.1'}, function(req,res,next){

  var sql = "select id, title, year, semester, number_admission_period from kuntur.admission_period order by year, semester, number_admission_period"


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
  			var logToken = uuid.v4();
  			console.log("BEGIN /agreementData " + logToken);

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
          //         				rollback(client, done);
  								// res.send(500,error.message);
  								callbackInterno(error);
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
  								callbackInterno(error);
  							});
  						}
  					], function(err, results){

  						if(err){
  							console.log(err);
			      //           rollback(client, done);
			  				// res.send(500,err);
			  				callbackForEach(err);
			                return;
  						}else{
	  						agreementItem.contacts=results[0];
	  						agreementItem.agreementItemOu=results[1];

	  						agreement.agreementItem.push(agreementItem);
	  						callbackForEach(null);
  						}
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
              			console.log("COMMIT /agreementData " + logToken);
  						res.send(200, agreement);

  						// done();
  					});

  					queryA.on("error",function(error){
  						console.log(error);
              			rollback(client, done);
              			console.log("ROLLBACK /agreementData " + logToken);
  						res.send(500,error.message);
  						return ;
  					});
  				});
  			});
  	    });
  	});
  });


  // server.put({path:'/userName/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
  //   if(!req.body){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
  //     return next();
  //   }

  //   if(!req.headers.usersystemid){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
  //     return next();
  //   }

  //   if(!req.body.guivenName){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
  //     return next();
  //   }

  //   if(!req.body.familyName){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No familyName found in request.'});
  //     return next();
  //   }

  //   pg.connect(conString, function(err, client, done){
  //     if(err){
  //       done();
  //       console.error('error fetching client from pool', err);
  //       res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  //       return next();
  //     }

  //     client.query('BEGIN', function(err) {

  //       if(err) {
  //         console.log(err);
  //           done();
  //           return res.send(500,err);
  //       }

  //       var sql = {};
  //       sql.text = "select kuntur.f_u_enrrollment_names($1, $2, $3, $4, $5)"
  //       sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.guivenName, req.body.middleName, req.body.familyName];


  //       var query = client.query(sql);

  //       query.on("row", function(row, result){
  //         result.addRow(row);
  //       });

  //       query.on("end", function(result){
  //         done();
  //         if(JSON.parse(result.rows[0].f_u_enrrollment_names)){
  //           res.send(200,"OK");
  //           client.query('COMMIT', done);
  //         }else{
  //           res.send(500,"Error in function f_u_enrrollment_names");
  //           rollback(client, done)
  //         }
  //       });//FIN CB END GUIVEN_NAME

  //       query.on("error",function(error){
  //         console.log(error);
  //         rollback(client, done)
  //         res.send(500,error.message);
  //       });

  //     });//BEGIN

  //   }); //CONNECT

  // });//FUNCION


  // server.put({path:'/userMale/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
  //   if(!req.body){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
  //     return next();
  //   }

  //   if(!req.body.userSystemId){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
  //     return next();
  //   }

  //   if(!req.body.male){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
  //     return next();
  //   }

  //   pg.connect(conString, function(err, client, done){
  //     if(err){
  //       done();
  //       console.error('error fetching client from pool', err);
  //       res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  //       return next();
  //     }

  //     client.query('BEGIN', function(err) {
  //       if(err) {
  //         console.log(err);
  //           done();
  //           return res.send(500,err);
  //       }

  //       var sql = {};
  //       sql.text = "select kuntur.f_u_enrrollment_male($1, $2, $3)"
  //       sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.male];


  //       var query = client.query(sql);

  //       query.on("row", function(row, result){
  //         result.addRow(row);
  //       });

  //       query.on("end", function(result){
  //         done();
  //         if(JSON.parse(result.rows[0].f_u_enrrollment_male)){
  //         	client.query('COMMIT', done);
  //           res.send(200,"OK");
  //         }else{
  //           rollback(client, done)
  //           res.send(500,"Error in function f_u_enrrollment_male");
  //         }
  //       });//FIN CB END GUIVEN_NAME

  //       query.on("error",function(error){
  //         console.log(error);
  //         rollback(client, done);
  //         res.send(500,error.message);
  //       });

  //     });//BEGIN

  //   }); //CONNECT

  // });//FUNCION

  // server.put({path:'/userPhoto/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){
  //   if(!req.body){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
  //     return next();
  //   }

  //   if(!req.body.userSystemId){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
  //     return next();
  //   }

  //   if(!req.body.urlPhoto){
  //     res.send(409, {code: 409, message: 'Conflict', description: 'No guivenName found in request.'});
  //     return next();
  //   }

  //   pg.connect(conString, function(err, client, done){
  //     if(err){
  //       done();
  //       console.error('error fetching client from pool', err);
  //       res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
  //       return next();
  //     }

  //     // client.query('BEGIN', function(err) {
  //     //   if(err) {
  //     //     console.log(err);
  //     //       done();
  //     //       return res.send(500,err);
  //     //   }

  //       var sql = {};
  //       sql.text = "select kuntur.f_u_enrrollment_url_photo($1, $2, $3)"
  //       sql.values = [req.params.inenrrollmentId, req.body.userSystemId, req.body.urlPhoto];


  //       var query = client.query(sql);

  //       query.on("row", function(row, result){
  //         result.addRow(row);
  //       });

  //       query.on("end", function(result){
  //         done();
  //         if(JSON.parse(result.rows[0].f_u_enrrollment_url_photo)){
  //           res.send(200,"OK");
  //         }else{
  //           res.send(500,"Error in function f_u_enrrollment_url_photo");
  //         }
  //       });//FIN CB END GUIVEN_NAME

  //       query.on("error",function(error){
  //         console.log(error);
  //         done();
  //         res.send(500,error.message);
  //       });

  //     // });//BEGIN

  //   }); //CONNECT

  // });//FUNCION



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
      	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/citizenship " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }

        var queryResult=false;

        async.each(req.body.enrrollmentIdentityList,
          function(iden, callback){
            var sql = {};
              iden.name = iden.documentTypes.filter(function(el){
                if(el.code == iden.code)
                  return el;
              })[0].name;
            //console.log("nameeeeeeeeeeeee: ",iden.name);
            if(iden.erased){
              //delete


              sql.text = "select kuntur.f_u_enrrollment_Deletecitizenship($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_citizenship($1, $2, $3, $4, $5, $6, $7) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode, iden.identityNumber, iden.code, iden.name, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertcitizenship($1, $2, $3, $4, $5, $6) as respuesta"
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
              console.log("ROLLBACK /enrrollment/citizenship " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/citizenship " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/nationality " + logToken);
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

              sql.text = "select kuntur.f_u_deleteenrrollment_nationality($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.id];
            }
            else if(iden.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_nationality($1, $2, $3, $4) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, iden.countryCode, iden.id];
            }
            else if(!iden.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertnationality($1, $2, $3) as respuesta"
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
              console.log("ROLLBACK /enrrollment/nationality " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/nationality " + logToken);
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
      	    	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/mails " + logToken);
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
              sql.text = "select kuntur.f_u_enrrollment_Deleteemail($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, mail.id];
            }
            else if(mail.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_email($1, $2, $3, $4) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, mail.email, mail.id];
            }
            else if(!mail.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertemail($1, $2, $3) as respuesta"
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
              console.log("ROLLBACK /enrrollment/mails " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/mails " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/phones " + logToken);
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
              sql.text = "select kuntur.f_u_enrrollment_Deletephone($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, phone.id];
            }
            else if(phone.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_phone($1, $2, $3, $4, $5) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, phone.phoneNumber, phone.countryCode, phone.id];
            }
            else if(!phone.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertphone($1, $2, $3, $4) as respuesta"
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
              console.log("ROLLBACK /enrrollment/phones " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/phones " + logToken);
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
       	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/addresses " + logToken);
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
              sql.text = "select kuntur.f_u_enrrollment_Deleteaddress($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, address.id];

            }
            else if(address.id){
              //delete
              sql.text = "select kuntur.f_u_enrrollment_address($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, address.countryCode, address.adminAreaLevel1Code, address.locality, address.neighbourhood, address.street, address.streetNumber, address.buildingFloor, address.buildingRoom, address.building, address.postalCode, address.comment, address.id];
            }
            else if(!address.erased){
              sql.text = "select kuntur.f_u_enrrollment_Insertaddress($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) as respuesta"
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
              console.log("ROLLBACK /enrrollment/addresses " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/addresses " + logToken);
              res.send(200,queryResult);
            }

          }
        );//end async
      });

    });//connect

  });





  server.put({path:'/enrrollment/:inenrrollmentId', version:'0.0.1'}, function(req, res, next){

    // console.log("llegas")
    // console.log(req.body)

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
      sql.text = "select kuntur.f_u_enrrollment_names($1, $2, $3, $4, $5) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.givenName, req.body.middleName, req.body.familyName];
    }
    else if("male" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_male($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.male];
    }
    else if("urlPhoto" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_photo($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPhoto];
    }
    else if("org" in req.body){//en el caso que el estudiante haya encontrado su universidad cargada en el sistema
      sql.text = "select kuntur.f_u_enrrollment_org_id($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.org.id];
    }
    else if("name" in req.body && "web" in req.body && "country" in req.body){//este es el caso que el estudiante no haya encontrado su universidad y tenga q cargarla manual
      sql.text = "select kuntur.f_u_enrrollment_orgs($1, $2, $3, $4, $5, $6, $7) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.name, req.body.web, req.body.country, req.body.shortName, req.body.institutionName];
      sendMailNewUniversity(req.params.inenrrollmentId, req.headers.usersystemid, req.body.name, req.body.web, req.body.country, req.body.shortName, req.body.institutionName);
    }
    else if("birthCountryCode" in req.body && "birthDate" in req.body){
      // console.log(req.body.birthDate)
      sql.text = "select kuntur.f_u_enrrollment_birth($1, $2, $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.birthDate, req.body.birthCountryCode];
    }
    else if("emergencyContact" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_emergency_contact($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.emergencyContact];
    }
    else if("agreement" in req.body){
      // if(!req.body.agreementName){
      //   req.body.agreementName='null';
      // }
      sql.text = "select kuntur.f_u_enrrollment_agreement($1, $2, $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.agreement, req.body.agreementName];
    }
    else if("program" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_program($1, $2, $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.program, req.body.exchangeProgramName];
    }
    else if("amountPaid" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_amountPaid($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.amountPaid];
    }
    else if("originalDoc" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_originalDoc($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.originalDoc];
    }
    else if("insurance" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_insurance($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.insurance];
    }
    else if("languageCertificate" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_languageCertificate($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.languageCertificate];
    }
    else if("urlOrigininalTranscript" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_origininal_transcript($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlOrigininalTranscript];
    }
    else if("urlCv" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_cv($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlCv];
    }
    else if("urlPassport" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_Passport($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPassport];
    }
    else if("urlApplicationLetter" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_application_letter($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlApplicationLetter];
    }
    else if("urlLanguageCertificate" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_language_certificate($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlLanguageCertificate];
    }
    else if("urlUniversityCredential" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_university_credential($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlUniversityCredential];
    }
    else if("urlCertificatePsychophysical" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_certificate_psychophysical($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlCertificatePsychophysical];
    }
    else if("urlExchangeForm" in req.body){
      sql.text = "select kuntur.f_u_enrrollment_url_exchange_form($1, $2, $3) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlExchangeForm];
    }
    else if("visa" in req.body){
      if(!req.body.visa){
        req.body.visa=null;
      }

      sql.text = "select kuntur.f_u_enrrollment_visa($1, $2, $3) as respuesta"
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

      sql.text = "select kuntur.f_u_enrrollment_comment($1, $2, $3, $4) as respuesta"
      sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.comment, req.body.observation];

    }
    // else if("urlPhoto" in req.body){
    //         sql.text = "select kuntur.f_u_enrrollment_urlPhoto($1, (SELECT id FROM kuntur.user_system WHERE name = $2), $3) as respuesta"
    //         sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, req.body.urlPhoto];
    // }
    else{
      // console.log("Incorrect parameters");
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

    //var sql="SELECT org.id, org.short_name, org.original_name, org.name, org.url_photo, org.primary_org, org.web_site, org.country_code, org.comment, org.erased  FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='F' OR code='F' ";
    //var sql = "select * from kuntur.org where org_id is not null and erased = false";
    var sql = "select 	* from 	kuntur.org where org_id is not null and erased = false AND (code_guarani ilike '%www.efn.unc.edu.ar/escuelas/biolog/%' OR short_name = 'EFN-Ing&Geo' OR code_guarani = '12' OR code_guarani = '95' OR short_name = 'FCC' OR short_name = 'FCS-TS' OR code_guarani = '11' OR code_guarani = '11P' OR short_name = 'FCM-Med' OR code_guarani = '06031' OR code_guarani = '06027' OR code_guarani = '75' OR code_guarani = '14' OR code_guarani = '13' OR code_guarani = '16' OR code_guarani = 'P16' OR code_guarani = '05' OR code_guarani = '19' OR code_guarani = '15' OR code_guarani = '03' OR code_guarani = 'P20') ORDER BY name;"

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
    sql.text = "SELECT  * FROM kuntur.f_find_study_program_by_id ($1, $2)";
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
       	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/studyPlan " + logToken);
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
              sql.text = "select kuntur.f_u_enrrollment_DeleteInStudyProgram($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, studyProgram.id];
            }
            else if(studyProgram.id){
              //update
              sql.text = "select kuntur.f_u_enrrollment_inStudyProgram($1, $2, $3, $4, $5, $6, $7, $8) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, studyProgram.subject, studyProgram.org.id, studyProgram.approved, studyProgram.fileNumber, studyProgram.id, studyProgram.comment];
            }
            else if(!studyProgram.erased){
              sql.text = "select kuntur.f_u_enrrollment_InsertInStudyProgram($1, $2, $3, $4, $5) as respuesta"
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
              // console.log(JSON.parse(result.rows[0].respuesta));
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
              console.log("ROLLBACK /enrrollment/studyPlan " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/studyPlan " + logToken);
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
       	var logToken = uuid.v4();
  		console.log("BEGIN /enrrollment/academicPerformance " + logToken);
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
              sql.text = "select kuntur.f_u_enrrollment_DeleteacademicPerformance($1, $2, $3) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, academicPerformance.id];
            }
            else if(academicPerformance.id){
              //update

              sql.text = "select kuntur.f_u_enrrollment_academicPerformance($1, $2, $3, $4, $5, $6, $7, $8) as respuesta"
              sql.values = [req.params.inenrrollmentId, req.headers.usersystemid, academicPerformance.org.id, academicPerformance.subject, academicPerformance.uncInGradingScale.id, academicPerformance.hs, academicPerformance.uncInStudiedType.id, academicPerformance.id];
            }
            else if(!academicPerformance.erased){
              sql.text = "select kuntur.f_u_enrrollment_InsertAcademicPerformance($1, $2, $3, $4, $5, $6, $7) as respuesta"
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
              console.log("ROLLBACK /enrrollment/academicPerformance " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
              console.log("COMMIT /enrrollment/academicPerformance " + logToken);
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
        // console.log(result.rows[0].respuesta);
        if(result.rows[0].respuesta){// es una negrada pero cuando agarrabamos el valor en el buffer del otro backend volvia siempre con comillas (este servicio solo lo utilizan los alumnos, los otros usuarios van por /rol)
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
      console.log(req.body.user)
      var sql = {};
      sql.text = "select kuntur.f_login_oid($1) as respuesta";
      sql.values = [req.body.user];

      var query = client.query(sql);

      query.on("row", function(row, result){
        result.addRow(row);
      });

      query.on("end", function(result){
        done();
        console.log(result.rows[0].respuesta);
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

  var token = uuid.v4();

  var sql = {};
  sql.text = "select kuntur.f_new_student($1, $2, $3, $4, $5, $6, $7) as respuesta";
  sql.values = [req.body.name, req.body.lastName, req.body.mail, req.body.user, req.body.pass, req.body.country, token];

  var url = config.frontend.protocol+'://'+config.frontend.hostname+'/token/'+token;


  var transporter = nodemailer.createTransport({//smtpTransport(
    host: config.mailServer,
    // logger: true,
    // debug: true,
    tls: {
     "rejectUnauthorized": false
     }
  });//)

  //console.log(queryResult.mailconfig)



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


    var mailOptions = {
      from: 'admin-kuntur@psi.unc.edu.ar', // sender address
      to: req.body.mail, // list of receivers
      subject: 'Verificación de Correo - Estudiantes Internacionales - UNC', // Subject line
      html: 'Bienvenido/a a la Universidad Nacional de Córdoba.<br><br>Estás a punto de registrarte en el Sistema de Admisión de Estudiantes.<br><br> Este mensaje se ha enviado porque generaste una nueva cuenta de usuario. Para confirmar la cuenta, por favor hacé click <a href="'+ url + '"> aquí ('+ url + ')</a>.<br><br>El sistema te guiará en los próximos pasos a seguir.<br><br>Prosecretaría de Relaciones Internacionales - Universidad Nacional de Córdoba'
    };



    transporter.sendMail(mailOptions, function(error, info){
      if(error){
        console.log("mail de confirmacion error:");
        //return console.log(error);
        console.log(error); //saque el return, capaz q por eso no cerraba la conexion
      }else{
                    // console.log('Message sent: ' + info.response);
      	console.log("mail de confirmacion");
     	console.log(info);
	  }
     // console.log("enviado a "+queryResult.stakeholders[j].email+" subj "+queryResult.mailconfig[i].subject)

    });

    res.send(200,result.rows[0].respuesta);


    });//FIN CB END GUIVEN_NAME

    query.on("error",function(error){
      done();
      console.log(error);
      res.send(500,error);
    });


  });


});

server.get({path: '/validateMail/:token', version: '0.0.1'}, function(req, res, next){

    var sql = {};
    sql.text = "update kuntur.user_system set checked_mail = true where token_validation = $1 RETURNING id";
    sql.values = [req.params.token];


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

        // console.log(result)
        // console.log(result);
        done();
        if(result.rows.length>0){
          res.send(200,true);
        }
        else{
          res.send(200,false);
        }
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });



    });


});

server.post({path: '/recover', version: '0.0.1'}, function(req, res, next){

  var sql = {};
  sql.text = "SELECT us.name, us.pass FROM kuntur.user_system us JOIN kuntur.user_group ug ON ug.user_system_id = us.id JOIN kuntur.group_system gs ON gs.id = ug.group_system_id WHERE email = $1 AND checked_mail = true AND gs.code = 'student'";
  sql.values = [req.body.email];


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
      if(result.rows.length>0){//mandar mail
        // res.send(200,result);

        var mailOptions = {
          from: 'admin-kuntur@psi.unc.edu.ar', // sender address
          to: req.body.email, // list of receivers
          subject: 'Recuperacion de contraseña - Estudiantes Internacionales - UNC', // Subject line
          html: 'Ha solicitado la recuperacion de la cuenta asociada a este email en el sistema kuntur.unc.edu.ar.<br><br>Sus datos son los siguientes:<br>Usuario: '+result.rows[0].name+'<br>Contraseña: '+result.rows[0].pass+'<br><br>Si usted no ha hecho esto, porfavor ignore este mail.<br><br>Prosecretaría de Relaciones Internacionales - Universidad Nacional de Córdoba'
        };

        var options = {
          host: config.mailServer,
          // logger: true,
          // debug: true,
          tls: {
           "rejectUnauthorized": false
           }
        };

        var transporter = nodemailer.createTransport(smtpTransport(options));

        transporter.sendMail(mailOptions, function(error, info){


          if(error){
            console.log("Mail recuperacion de datos error ambos");
            return console.log(error);
          }else{
            console.log("Mail recuperacion de datos: ", info)
            res.send(200,true);
          }
        });

      }
      else{
        res.send(200,false);
      }
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

  });


});

// server.post({path: '/recover', version: '0.0.1'}, function(req, res, next){

//   var n = 0;

//   var saveToken = function(){

//     if(n===40){
//       return res.send(500,'No se pudo generar token');
//     }

//     var token = uuid.v4();

//     var sql = {};
//     sql.text = "INSERT INTO kuntur.token VALUES ($1, (select id from kuntur.user_system where email = $2), 'recover', false, null);";
//     sql.values = [token, req.body.email];

//     pg.connect(conString, function(err, client, done) {
//       if(err) {
//         return console.error('error fetching client from pool', err);
//       }
//       client.query(sql, function(err, result) {
//         // console.log("res: ", result);
//         // console.log("err: ", err);
//         // console.log("res: ", res);
//         // console.log("n: ", n);
//         //call `done()` to release the client back to the pool
//         done();
//         n++;
//         if(err) {
//           return saveToken();
//         }else{
//           var url = config.frontend.protocol+'://'+config.frontend.hostname+'/recover/'+token;
//           return res.send(200,url);
//         }
//       });
//     });

//   }

//   saveToken();

// });

// server.get({path: 'recover/:token', version: '0.0.1'}, function(req, res, next){

//   var sql = {};
//   sql.text = "update kuntur.token set used = true where id = $1 AND type = 'recover' AND used = false RETURNING id";
//   sql.values = [req.params.token];

//   pg.connect(conString, function(err, client, done){
//     if(err) {
//       done();
//       res.send(500,err);
//       console.log(err);
//     }

//     var query = client.query(sql);

//     query.on("row", function(row, result){
//       result.addRow(row);
//     });

//     query.on("end",function(result){
//       done();
//       if(result.rows.length>0){
//         res.send(200,true);
//       }
//       else{
//         res.send(200,false);
//       }
//     });

//     query.on("error",function(error){
//       console.log(error);
//       done();
//       res.send(500,error);
//     });

//   });

// });


server.get({path : '/student', version : '0.0.1'} , function(req, res , next){

  // console.log(req.headers);
    if(!req.headers.usersystemid){
      res.send(409, {code: 409, message: 'Conflict', description: 'No userSystemId found in request.'});
      return next();
    }
    //ERRORUSID
    //arreglado
    var sql = {};
    sql.text = "SELECT  * FROM kuntur.perfilArray($1)";
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
        res.send(200,JSON.parse(result.rows[0].perfilarray));
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });



    });
  });

  server.put({path: '/studentPassword', version: '0.0.1'}, function(req, res, next){

    var sql = {};
    sql.text = 'UPDATE kuntur.user_system SET pass = $1 WHERE id = $2 AND pass = $3 RETURNING id';
    sql.values = [req.body.person.newPass, req.body.person.student_id, req.body.person.oldPass];

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

         // console.log(result.rows.length);
        // console.log(result);
        done();
        if(result.rows.length>0){
          res.send(200,true);
        }
        else{
          res.send(200,false);
        }
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });

    });

  });

  server.put({path: '/admissionPeriod', version: '0.0.1'}, function(req, res, next){

    var sql = {};
    sql.text = 'UPDATE kuntur.enrrollment SET admission_period_id = $2 WHERE id = $1 RETURNING id';
    sql.values = [req.body.params.enrrollmentId, req.body.params.newAdmissionPeriod];

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
        if(result.rows.length>0){
          res.send(200,true);
        }
        else{
          res.send(200,false);
        }
      });

      query.on("error",function(error){
        console.log(error);
        done();
        res.send(500,error);
      });
    });
  });

  server.put({path: '/studentPricipalMail', version: '0.0.1'}, function(req, res, next){

    var token = uuid.v4();

    var sql = {};
    sql.text = 'UPDATE kuntur.user_system set email = $1, checked_mail = false, token_validation = $2 WHERE id = $3';
    sql.values = [req.body.person.principalMail, token, req.body.person.student_id];

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


      var url = config.frontend.protocol+'://'+config.frontend.hostname+'/token/'+token;

      var mailOptions = {
        from: 'admin-kuntur@psi.unc.edu.ar', // sender address
        to: req.body.person.principalMail, // list of receivers
        subject: 'Verificación de Correo - Estudiantes Internacionales - UNC', // Subject line
        html: '<br><br> Este mensaje se ha enviado porque ingresaste un nuevo email de usuario. Para confirmar el mismo, por favor hacé click <a href="'+ url + '"> aquí ('+ url + ')</a>.<br><br>El sistema te guiará en los próximos pasos a seguir.<br><br>Prosecretaría de Relaciones Internacionales - Universidad Nacional de Córdoba'
      };

      var options = {
        host: config.mailServer,
          // logger: true,
          // debug: true,
        tls: {
          "rejectUnauthorized": false
        }

        // service: "Gmail",
        // auth: {
        //     user: "",
        //     pass: ""
        // }
      };

      var transporter = nodemailer.createTransport(smtpTransport(options));

      transporter.sendMail(mailOptions, function(error, info){


        if(error){
          console.log("Mail recuperacion de datos error ambos");
          return console.log(error);
        }else{
          console.log("Mail recuperacion de datos: ", info)
          res.send(200,true);
        }
      });



      res.send(200,result.rows);//JSON.parse(
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
    console.log("put student");
    console.log(req.body);

    console.log("header");
    console.log(req.headers.usersystemid);
    //ERRORUSID
    //ARREGLADO
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
      sql.text = "SELECT kuntur.f_u_studentProfile($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)";
      sql.values = [req.body.person.person_given_name, req.body.person.person_middle_name, req.body.person.person_family_name, req.body.person.person_male, req.body.person.person_birth_date, req.body.person.person_birth_country_code, orgId, null, null, null, null, null, req.headers.usersystemid, req.headers.usersystemid, req.body.person.person_url_photo, req.body.person.username];

    }else{
      shortName=req.body.person.student_short_name;
      originalName=req.body.person.student_institution_original_name;
      name=req.body.person.student_institution_name;
      web=req.body.person.student_institution_web_site;
      country=req.body.person.student_institution_country_code;
      var sql = {};
      sql.text = "SELECT kuntur.f_u_studentProfile($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)";
      sql.values = [req.body.person.person_given_name, req.body.person.person_middle_name, req.body.person.person_family_name, req.body.person.person_male, req.body.person.person_birth_date, req.body.person.person_birth_country_code, null, shortName, name, originalName, web, country, req.headers.usersystemid, req.headers.usersystemid, req.body.person.person_url_photo, req.body.person.username];

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
      //console.log(result);
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
       	var logToken = uuid.v4();
  		console.log("BEGIN /student/mails " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        //ERRORUSID
        //arreglado
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

  			  console.log("ROLLBACK /student/mails " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
  			  console.log("COMMIT /student/mails " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /student/phones " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        //ERRORUSID
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
  			  console.log("ROLLBACK /student/phones " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
  			  console.log("COMMIT /student/phones " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /student/nationality " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        //ERRORUSID
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
  			  console.log("ROLLBACK /student/nationality " + logToken);
              res.send(500,err);
            }else{
              client.query('COMMIT', done);
  			  console.log("COMMIT /student/nationality " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /student/identity " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        //ERRORUSID
        // console.log(req.body.person.identities)
        var queryResult=false;
        async.each(req.body.person.identities,
          function(iden, callback){
            var sql = {};
            // console.log(req.headers.usersystemid);
            if(!iden.code || !iden.identity_number || !iden.country_code){
              return callback("No se introdujeron todos los campos");
            }
            iden.name = iden.documentTypes.filter(function(el){
              if(el.code == iden.code)
                return el;
            })[0].name;
            if(iden.erased){
              //delete
              // console.log(iden);
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
              // console.log(err);
              rollback(client, done);
              console.log("ROLLBACK /student/identity " + logToken);
              res.send(500,err);
            }else{

              client.query('COMMIT', done);
              console.log("COMMIT /student/identity " + logToken);
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
      	var logToken = uuid.v4();
  		console.log("BEGIN /student/addresses " + logToken);
        if(err) {
          console.log(err);
            done();
            return res.send(500,err);
        }
        //ERRORUSID
        // console.log(req.body.person.identities)
        var queryResult=false;
        async.each(req.body.person.addresses,
          function(iden, callback){
            var sql = {};
            // console.log(req.headers.usersystemid);
            if(iden.erased){
              //delete
              // console.log(iden);
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
              console.log("ROLLBACK /student/addresses " + logToken);
              res.send(500,err);
            }else{

              client.query('COMMIT', done);
              console.log("COMMIT /student/addresses " + logToken);
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
      //ERRORUSID
      var sql = {};
      sql.text = "SELECT  * FROM kuntur.f_enrrollment_status($1, $2)";//NO HACE FALTA PASARLE PAREMETROS
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

      //ERRORUSID
      //arreglado
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

        //ERRORUSID
        //arreglado
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


          sendMail(req.params.enrrollmentId, req.headers.usersystemid);

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

  var sendMailNewUniversity = function(inenrrollmentId, usersystemid, name, web, country, shortName, institutionName){

    if(activeMail){

      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }

        var sql = {};
        //sql.text = "select kuntur.f_info_mails($1) as respuesta"

        sql.text = "select kuntur.f_send_mail_new_university($1, $2) as respuesta"
        sql.values = [inenrrollmentId, usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){


          queryResult=JSON.parse(result.rows[0].respuesta);
          done();

          for(var i in queryResult.mailadmins){

              // if(queryResult.mailconfig[i].group_id == queryResult.stakeholders[j].group_system_id){

                var transporter = nodemailer.createTransport({//smtpTransport(
                  host: config.mailServer,
                  tls: {
                  "rejectUnauthorized": false
                  }
                });//)



                var mailOptions = {
                  from: 'admin-kuntur@psi.unc.edu.ar', // sender address
                  to: queryResult.mailadmins[i].email, // list of receivers
                  subject: 'Nueva universidad solicitada', // Subject line
                  html: 'El alumno número '+ queryResult.numberstudent + ' ha cargado los siguientes datos como su universidad\n'+
                  'nombre en español: '+ name + '\n'+
                  'web: '+ web + '\n'+
                  'pais: '+ country + '\n'+
                  'siglas: '+ shortName + '\n'+
                  'nombre original: '+ institutionName + '\n'+
                  'en la postulación número: '+queryResult.numberenrrollment// plaintext body
                };




                transporter.sendMail(mailOptions, function(error, info){
                  console.log("Info de mail de nueva  universidad:", info);
                  if(error){
                    console.log("Error de nueva universidad")
                    return console.log(error);
                  }
                  // console.log('Message sent: ' + info.response);

                  // console.log("enviado a "+queryResult.stakeholders[j].email+" subj "+queryResult.mailconfig[i].subject)

                });

              // }


          }


        });


      });

    }

  }



   var generateAnalitico = function(req, cb){
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
    // console.log("estoy en generarAnalitico", req)

    for (var i = 0; i < req.uncInAcademicPerformanceList.length; i++) {
      //postulacionData.data.uncInAcademicPerformanceList[i]
      filas += "<tr><td>"+(i+1)+"</td>"+
                    "<td>"+req.uncInAcademicPerformanceList[i].subject+"</td>"+
                    "<td>"+req.uncInAcademicPerformanceList[i].org.name+"</td>"+
                    "<td style='text-align: center'>"+req.uncInAcademicPerformanceList[i].uncInGradingScale.rateNumber+"</td>"+
                    "<td>"+req.uncInAcademicPerformanceList[i].uncInGradingScale.rateLetter+"</td>"+
                    "<td style='text-align: center'>"+req.uncInAcademicPerformanceList[i].hs+"</td>"+
                    "<td style='text-align: center'>"+req.uncInAcademicPerformanceList[i].uncInStudiedType.code+"</td>"+
                "</tr>"


    };

    if (dia==1) {

      var html = htmlCertificadoAnalitico.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.familyName)
                             .replace("$nombrePostulante",req.givenName)
                             .replace("$tipoDocumento",req.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.org.name)
                             .replace("$paisOrigen",req.org.countryCode)
                             .replace("$semestre",req.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image)
                             .replace('$fila', filas);




    }else{

      var html = htmlCertificadoAnalitico.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.familyName)
                             .replace("$nombrePostulante",req.givenName)
                             .replace("$tipoDocumento",req.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.org.name)
                             .replace("$paisOrigen",req.org.countryCode)
                             .replace("$semestre",req.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image)
                             .replace('$fila', filas);
    };



    // console.log("html")
        // console.log(html)
   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())
    pdf.create(html, options).toFile(path.join(__dirname, '../certificadoanalitico.pdf'), function(err, resPdf) {
      if (err) return console.log("error creando pdf", err);



      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error leyendo pdf", err)
              throw err;

          }
          content = data;
          // console.log("PDFNUEvo")
          // console.log(new Buffer(data).toString('base64'))
          pdfAle = new Buffer(data).toString('base64');

          cb(pdfAle, "analitico");

      });
      // fs.readFile(resPdf.filename,cb);

    });

}


  var generateAdmissionAct = function(req, cb){



    //Generador de fecha actual al momento de realizar la carta de admision template
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
    var dias = ["Domingo","Lunes","Martes", "Miercoles", "Jueves", "Viernes", "Sábado"];
    var d = new Date()
    var dia = d.getDate();
    var mes = meses[d.getMonth()]
    var anio = d.getFullYear()



    if (dia==1) {
      var html = htmlCartaDeAdmision.replace("$diaCreacion2","al primer día")
                             .replace("$rotulosDias","")
                             .replace("$apellidoPostulante",req.familyName)
                             .replace("$nombrePostulante",req.givenName)
                             .replace("$tipoDocumento",req.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.org.name)
                             .replace("$paisOrigen",req.org.countryCode)
                             .replace("$semestre",req.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "")
                             .replace('$image', image);

    }else{
      var html = htmlCartaDeAdmision.replace("$rotulosDias","a los")
                             .replace("$diaCreacion2",dia)
                             .replace("$apellidoPostulante",req.familyName)
                             .replace("$nombrePostulante",req.givenName)
                             .replace("$tipoDocumento",req.enrrollmentIdentityList[0].name)
                             .replace("$numeroDocumento",req.enrrollmentIdentityList[0].identityNumber)
                             .replace("$universidadOrigen",req.org.name)
                             .replace("$paisOrigen",req.org.countryCode)
                             .replace("$semestre",req.admissionPeriod.semester)
                             .replace("$anioPostulacion",req.admissionPeriod.year)
                             .replace("$mesCreacion",mes)
                             .replace("$anioCreacion",anio)
                             .replace("$dia", "días")
                             .replace('$image', image);
    };

   // console.log("FECHAAAAAA--->",dias[d.getDay()] + ", " + d.getDate() + " de " + meses[d.getMonth()] + " de " + d.getFullYear())
   // console.log(html);
    // pdf.create(html, options).toFile('cartadeadmision.pdf', function(err, resPdf) {
      //var prueba = path.join(__dirname, '../cartadeadmision.pdf');
      pdf.create(html, options).toFile(path.join(__dirname, '../cartadeadmision.pdf'), function(err, resPdf) {
      // path.join(__dirname, '../cartadeadmision.pdf'
      if (err) return console.log("error creando pdf", err);

      //var postulacionId = req.params.postulacionId

      var content;
// First I want to read the file
      fs.readFile(resPdf.filename, function read(err, data) {
          if (err) {
              console.log("Error leyendo pdf", err)
              throw err;

          }
          content = data;

          pdfAle =  new Buffer(data).toString('base64');

          cb(pdfAle, "carta");

      });
      // fs.readFile(resPdf.filename,cb);

    });


    // pdf.create(html, options).toBuffer(function(err, buff){
    //   if (err) return console.log("error creando pdf", err);
    //   pruebaPdf = buff.toString('base64');
    //   cb(pruebaPdf, "carta");
    // });

  }



  var sendMail = function(enrrollmentId, us){

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

          if(queryResult.contacts){
            var mailReceivers = queryResult.stakeholders.concat(queryResult.contacts);
          }else{
            var mailReceivers = queryResult.stakeholders;
          }

          // var admissionAct;
          // var academicPerformance;

          // console.log(queryResult)

          // for(var i in queryResult.mailconfig){
          //   (function(x){
          async.eachSeries(queryResult.mailconfig, function(x, callbackPrimero){

              var analitico = null;
              var acta = null;

              //async.eachSeries(queryResult.stakeholders, function (item, callback2) {
              async.eachSeries(mailReceivers, function (item, callback2) {

            //for(var j in ){
              //(function(y){


             // if(queryResult.mailconfig[x].group_id == queryResult.stakeholders[y].group_system_id){
              //if(queryResult.mailconfig[x].group_id == item.group_system_id){
              if(x.group_id == item.group_system_id){

              // console.log(queryResult.mailconfig[x].group_id)
              // console.log(queryResult.stakeholders[y].group_system_id)

                var options = {
                  //service: 'gmail',
                  host: config.mailServer,
                  tls: {
                  "rejectUnauthorized": false
                  }
                  // service: "Gmail",
                  // auth: {
                  //   user: "",
                  //   pass: ""
                  // }
                };

                var transporter = nodemailer.createTransport(smtpTransport(options
                  // host: config.mailServer,
                  // tls: {
                  // "rejectUnauthorized": false
                  // }

                ));


                console.log("enviado a ", item);
                var mailOptions = {
                  //from: queryResult.mailconfig[x].from, // sender address
                  from: x.from,
                  // from: 'anbiagetti@gmail.com',
                  //to: queryResult.consolestakeholders[y].email, // list of receivers
                  to: item.email,
                  // to: 'anbiagetti@gmail.com',
                  //subject: queryResult.mailconfig[x].subject, // Subject line
                  subject: x.subject,
                  //html: queryResult.mailconfig[x].body, // plaintext body
                  html: x.body, // plaintext body
                  attachments: []
                  /*html: '<b>Hello world</b>'*/ // html body
                };
                // console.log("mailconfig", queryResult.mailconfig[x]);
                //if(queryResult.mailconfig[x].sendacademicperformance || queryResult.mailconfig[x].sendadmissionact){
                if(x.sendacademicperformance || x.sendadmissionact){

                  // console.log("se mansda mail adjunto")

                  var sql2 = "SELECT  * FROM kuntur.f_find_enrrollment_by_id_email ('"+enrrollmentId+"', "+
                    "(SELECT id FROM kuntur.user_system WHERE id = '" + us + "'));";

                    var query2 = client.query(sql2);

                    query2.on("row", function(row, result){
                      result.addRow(row);
                    });

                    query2.on("end", function(result){
                      // console.log(result.rows[0].f_find_enrrollment_by_id);

                      //done();
                      // console.log("rows: ", result.rows.length)
                      if(result.rows.length > 0){


                        var pdfCallback = function(pdf, documento) {
                          console.log("enviado generado")
                          mailOptions.attachments=[];

                          if(documento === "analitico"){
                            analitico = pdf;
                            mailOptions.attachments.push({
                              filename: 'CertificadoAnalitico.pdf',//configurar nombre del adjuno
                              content: analitico,//contenido
                              encoding: 'base64',//codificancion
                              contentType: 'application/pdf'
                            });
                          }

                          if(documento === "carta"){
                            acta = pdf;
                            mailOptions.attachments.push({
                              filename: 'CartadeAdmision.pdf',//configurar nombre del adjuno
                              content: acta,//contenido
                              encoding: 'base64',//codificancion
                              contentType: 'application/pdf'
                            });
                          }


                          callback2();



                          transporter.sendMail(mailOptions, function(error, info){

                            console.log("Mail cambio de estado adjunto info: ", info)
                            console.log(mailOptions);
                            if(error){
                              console.log("Mail cambio de estado error adjunto");
                              console.log(error);
                            }

                          });



                          callback2();
                        }


                        //if(queryResult.mailconfig[x].sendadmissionact && !acta){
                        if(x.sendadmissionact && !acta){
                          generateAdmissionAct(JSON.parse(result.rows[0].f_find_enrrollment_by_id_email).data, pdfCallback);
                          // console.log(admissionAct)
                        }

                        //if(queryResult.mailconfig[x].sendadmissionact && acta){
                          if(x.sendadmissionact && acta){
                          console.log("enviado sin generar")
                            mailOptions.attachments.push({
                              filename: 'CartadeAdmision.pdf',//configurar nombre del adjuno
                              content: acta,//contenido
                              encoding: 'base64',//codificancion
                              contentType: 'application/pdf'
                            });

                            transporter.sendMail(mailOptions, function(error, info){


                            console.log("Mail cambio de estado info: ", info)

                            console.log("Mail cambio de estado carta info: ", info)
                            if(error){
                              console.log("Mail cambio de estado error carta");
                              return console.log(error);
                            }

                          });
                            callback2();
                        }

                        // console.log("queryResult.mailconfig[i].sendacademicperformance", queryResult.mailconfig[i].sendacademicperformance)
                        //if(queryResult.mailconfig[x].sendacademicperformance && !analitico){
                        if(x.sendacademicperformance && !analitico){
                          generateAnalitico(JSON.parse(result.rows[0].f_find_enrrollment_by_id_email).data, pdfCallback)
                          // console.log(academicPerformance)
                        }

                        //if(queryResult.mailconfig[x].sendacademicperformance && analitico){
                        if(x.sendacademicperformance && analitico){
                          console.log("enviado sin generar")
                            mailOptions.attachments.push({
                              filename: 'CertificadoAnalitico.pdf',//configurar nombre del adjuno
                              content: analitico,//contenido
                              encoding: 'base64',//codificancion
                              contentType: 'application/pdf'
                            });

                            transporter.sendMail(mailOptions, function(error, info){

                            console.log("Mail cambio de estado info: ", info)
                            if(error){
                              console.log("Mail cambio de estado error certificado");
                              return console.log(error);
                            }

                          });
                            callback2();
                        }


                      }



                    });

                    query2.on("error",function(error){
                      console.log(error);
                      // done();
                      // res.send(500,error);
                      callback2();
                    });




              }else{

                transporter.sendMail(mailOptions, function(error, info){
                  console.log("Mail cambio de estado info: ", info)
                  if(error){
                    console.log("Mail cambio de estado error");
                    return console.log(error);
                  }
                  // console.log('Message sent: ' + info.response);

                  // console.log("enviado a "+queryResult.stakeholders[j].email+" subj "+queryResult.mailconfig[i].subject)

                });
                callback2();
                }

            }else{//if
            callback2();
          }
          //})(j);
           //}//segund for
         }, function(err){
          // console.log("termine")
          // done();
          // res.send(500,error);
          console.log("termino");
          // console.log(x);
          callbackPrimero();
         });//async

        }, function(error){
          console.log("termine")
          done();
          res.send(200,"ok");
        })
          // })(i);
          // }//primer


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

        //ERRORUSID
        //arreglado
        var sql = {};
        sql.text = "select kuntur.nextstep($1, $2) as respuesta"
        sql.values = [req.headers.usersystemid, req.params.enrrollmentId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId, req.headers.usersystemid);

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
        sql.text = "select kuntur.f_get_admission_period_by_org($1, $2) as respuesta"
        sql.values = [req.params.orgId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId, req.headers.usersystemid);

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
        console.log("req.headers.usersystemid")
        console.log(req.headers.usersystemid)
        var sql = {};
        sql.text = "select kuntur.f_insert_enrrollment($1, $2) as respuesta"
        sql.values = [req.body.admissionPeriodId, req.headers.usersystemid];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          sendMail(req.params.enrrollmentId, req.headers.usersystemid);

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


  server.post({path : '/chat', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }
        console.log("req.headers.usersystemid")
        console.log(req.headers.usersystemid)


        var sql = {};
        sql.text = "INSERT INTO kuntur.enrrollment_chat VALUES(uuid_generate_v4()::varchar, false, now(), $1, $2, '1', $3) RETURNING id;"
        sql.values = [req.params.message, req.headers.usersystemid, req.params.enrrollmentId];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){
          done();
          res.send(200, true);
        });//FIN CB END GUIVEN_NAME

        query.on("error",function(error){
          done();
          console.log(error);
          res.send(500,error);
        });

    });

  });

  server.get({path : '/chat', version : '0.0.1'}, function(req, res, next){

    // console.log(req.body);
      pg.connect(conString, function(err, client, done){
        if(err){
          done();
          console.error('error fetching client from pool', err);
          res.send(503, {code: 503, message: 'Service Unavailable', description: 'Error fetching client from pool. Try again later'});
          return next();
        }


        var sql = {};
        //sql.text = "select ec.chat_time, p.given_name, p.family_name, ec.chat, p.url_photo from kuntur.enrrollment_chat ec join kuntur.person p on p.id = ec.user_system_a_id where enrrollment_id = $1"
        sql.text= "SELECT	ec.chat_time, p.given_name, p.family_name, ec.chat, p.url_photo, gs.code FROM kuntur.enrrollment_chat ec JOIN kuntur.person p ON p.id = ec.user_system_a_id JOIN kuntur.user_system us ON us.id = p.id JOIN kuntur.user_group ug ON ug.user_system_id = us.id JOIN kuntur.group_system gs ON gs.id = ug.group_system_id WHERE enrrollment_id = $1 ORDER BY ec.chat_time"
        sql.values = [req.params.enrrollment_id];

        var query = client.query(sql);

        query.on("row", function(row, result){
          result.addRow(row);
        });

        query.on("end", function(result){

          queryResult=result.rows;
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
        sql.text = "select kuntur.f_get_usersby_group($1, $2, $3) as respuesta"
        sql.values = [req.params.groupId, req.params.offset, req.params.limit];

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


// ##### CONVOCATORIAS   ######  //

server.get({path : '/convocatorias', version : '0.0.1'} , function(req, res , next){



      var sql = {};
      var pageSize = req.params.pageSize;
    	var offset = req.params.offset;
      //sql.text = "SELECT * FROM kuntur.admission_period ";
      sql.text = "SELECT * FROM kuntur.admission_period ap2 LEFT JOIN (SELECT ap.id as tid, count (*) as Cantidad FROM kuntur.admission_period ap JOIN kuntur.admission_period_agreement apa ON apa.admission_period_id = ap.id JOIN kuntur.agreement a ON a.id = apa.agreement_id JOIN  kuntur.agreement_item ai ON ai.agreement_id = a.id GROUP BY ap.id) AS t ON ap2.id = t.tid OFFSET '"+offset+"' LIMIT '"+pageSize+"'"




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
          // console.log("HOLA",result.rows)
          res.send(200,result.rows);


        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });

    server.post({path: "/editConvocatoria", version: '0.0.1'}, function(req, res, next){
      pg.connect(conString, function(err, client, done){
        if(err) {
          done();
          res.send(500,err);
          console.log(err);
        }

        client.query('BEGIN', function(err) {
          var logToken = uuid.v4();
          console.log("BEGIN /editConvocatoria " + logToken);
          if(err) {
              console.log(err)
              done();
              return res.send(500,err);
          }
          var sql={};
          console.log("SEMESTRE", req.body.admissionPeriod)
          sql.text="UPDATE kuntur.admission_period SET year = $1, semester = $9, title = $2, from_date= $3, to_date= $4, admission_period_status_id= $5, is_agreement= $6,in_type= $7 WHERE id = $8 ;"
          sql.values=[req.body.admissionPeriod.year, req.body.admissionPeriod.title, req.body.admissionPeriod.from_date, req.body.admissionPeriod.to_date,null,req.body.admissionPeriod.status, req.body.admissionPeriod.type, req.body.admissionPeriod.id, req.body.admissionPeriod.semestre ];

          var query = client.query(sql);

          query.on("row", function(row, result){
            result.addRow(row);
          });//fin row query admission_period

          query.on("end",function(result){

            async.series([
              function(cbSeries){//asin serie insertar
                if(req.body.admissionPeriod.acuerdosInsert.length>0){//hay q insertart admission_period_agreement

                    async.forEach(req.body.admissionPeriod.acuerdosInsert,function(acuerdoInsert, cbInsert){

                      var sqlInsert = {};
                      sqlInsert.text = "INSERT INTO kuntur.admission_period_agreement VALUES (uuid_generate_v4()::varchar, false, $1, $2)";
                      sqlInsert.values = [acuerdoInsert.id, req.body.admissionPeriod.id];

                      var queryInsert = client.query(sqlInsert);

                      queryInsert.on("row", function(row, result){
                        result.addRow(row);
                      });//fin row queryInsert insert agreement

                      queryInsert.on("end",function(result){
                        cbSeries(null);
                      });//fin end queryInsert insert agreement

                      queryInsert.on("error",function(error){
                        console.log(error);
                        cbSeries(error);
                      });//fin error queryInsert insert agreement

                    });// fin  foreach insert

                }else{//no hay q insertart admission_period_agreement
                  cbSeries(null);
                }
              },
              function(cbSeries){//asyn serie eliminar
                if(req.body.admissionPeriod.acuerdosDelete.length>0){//hay acuerdos para eliminar
                  async.forEach(req.body.admissionPeriod.acuerdosDelete,function(acuerdoDelete, cbDelete){

                    var sqlDelete = {};
                    sqlDelete.text = "DELETE FROM kuntur.admission_period_agreement WHERE agreement_id = $1 AND admission_period_id = $2";
                    sqlDelete.values = [acuerdoDelete.id, req.body.admissionPeriod.id];

                    var queryDelete = client.query(sqlDelete);

                    queryDelete.on("row", function(row, result){
                      result.addRow(row);
                    });//fin row queryDelete delete agreement

                    queryDelete.on("end",function(result){
                      cbSeries(null);
                    });//fin end queryDelete delete agreement

                    queryDelete.on("error",function(error){
                      console.log(error);
                      cbSeries(error);
                    });//fin error queryDelete delete agreement

                  });//fin for each delete
                }else{//no hay que eliminar acuerdos
                  cbSeries(null);
                }
              }//fin async series eliminar
            ], function(error){//callback del series
              if(error){
                console.log(error);
                rollback(client, done);
                console.log("ROLLBACK /editConvocatoria " + logToken);
                res.send(500,err);
              }else{
                client.query('COMMIT', done);
                console.log("COMMIT /editConvocatoria" + logToken);
                res.send(200,true);
              }
            });//fin async series

          });//fin end query admission_period

          query.on("error",function(error){
            console.log(error);
            rollback(client, done);
            console.log("ROLLBACK /convocatorias " + logToken);
            res.send(500,err);
          });//fin error query admission_period


        });//fin begin

      });//fin connect
    });


    server.post({path: "/insertarConvocatoria",version: '0.0.1'}, function(req,res){

      console.log("PRIMERO", req.body.convocatoriaFinal)
      var convocatoriaTo = req.body.convocatoriaFinal.to;

      pg.connect(conString, function(err, client, done){
        console.log("----------DENTRO DEL PG.CONNECT-----");
        if(err) {
          done();
          res.send(500,err);
          console.log(err);
        }



        client.query('BEGIN', function(err) {
          console.log("DENTRO DE BEGIN");
          var logToken = uuid.v4();
          console.log("BEGIN /insertarConvocatoria " + logToken);
            if(err) {
                console.log(err)
                  done();
                  return res.send(500,err);
          }

          var sql="INSERT INTO kuntur.admission_period(id, erased, in_type, year, semester,title, from_date, to_date,admission_period_status_id, is_agreement)"+
          "VALUES (uuid_generate_v4()::varchar, false,"+req.body.convocatoriaFinal.type+","+req.body.convocatoriaFinal.year+","+req.body.convocatoriaFinal.semestre+",'"+req.body.convocatoriaFinal.title+"','"+req.body.convocatoriaFinal.from_date+"','"+req.body.convocatoriaFinal.to_date+"','6f7d1de2-79bf-48d6-b4bd-926bb90bff24',"+req.body.convocatoriaFinal.status+") RETURNING id;"

          console.log("--------PRIMER SQL:", sql);

          var convocatoriaId;
          var query = client.query(sql);

          query.on("row", function(row, result){
            console.log("--QUERY 1---");

            convocatoriaId=row.id;

          var queryResult2=false;

          async.series([


          function(callback){
            console.log("ADENTRO DE ASYNC");
            async.forEach(req.body.convocatoriaFinal.acuerdosInsert,function(acuerdosInsert, callbackInterno){
              console.log("--------ADENTRO DEL ASYNC------");

              var sql="INSERT INTO kuntur.admission_period_agreement("+
                    "id, erased, agreement_id, admission_period_id)"+
              "VALUES (uuid_generate_v4()::varchar, false, '"+acuerdosInsert.id+"','"+convocatoriaId+"')"+
              "RETURNING id;"

                var query = client.query(sql, function(error){
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
          } //callback
          ], function(error){
          done();
           if(error){
                console.log(error);
                rollback(client, done);
                console.log("ROLLBACK /convocatorias " + logToken);
                res.send(500,err);
              }else{
                client.query('COMMIT', done);
                console.log("COMMIT /convocatorias" + logToken);
                res.send(200,queryResult2);
            }
          }); //series

        }); //query.on*/

      }); //begin

    }); //pg connect

  });


  server.get({path : '/deleteConvocatoria', version : '0.0.1'} , function(req, res , next){
    var convId=req.params.convocatoriaId;

/*
    var sqlCount = "select count(*) from kuntur.admission_period_agreement where agreement_id = '"+req.params.agrId+"';";
*/

    var sql = {};
    sql.text = "SELECT  * FROM kuntur.f_delete_admission_period($1)";
    sql.values = [req.params.admissionPeriodId];

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
  //JSON.parse(result.rows[0].perfilArray)
        query.on("end",function(result){
          done();
          res.send(200,JSON.parse(result.rows[0].f_delete_admission_period));
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });

    });

  });




server.get({path : '/admissionPeriodAgreement', version : '0.0.1'}, function(req, res, next){
  var sql = {};
  sql.text = "SELECT a.* FROM kuntur.admission_period_agreement apa JOIN kuntur.agreement a ON a.id = apa.agreement_id WHERE apa.admission_period_id = $1";
  sql.values = [req.params.admissionPeriodId];

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
      res.send(200,result.rows);

    });

    query.on("error",function(error){
      console.log(error);
      done();
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

server.get({path : '/checkUser', version : '0.0.1'} , function(req, res , next){


      var sql = {};
      sql.text = "SELECT  * FROM kuntur.user_system WHERE name = $1";
      sql.values = [req.params.user];


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
          if(result.rows.length  < 1){
            res.send(200,true);
          }
          else{
            res.send(200,false);
          }
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });

server.get({path : '/checkEmail', version : '0.0.1'} , function(req, res , next){


      var sql = {};
      sql.text = "SELECT  * FROM kuntur.user_system WHERE email = $1";
      sql.values = [req.params.email];


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
          if(result.rows.length  < 1){
            res.send(200,true);
          }
          else{
            res.send(200,false);
          }
        });

        query.on("error",function(error){
          console.log(error);
          done();
          res.send(500,error);
        });



      });
    });

server.post({path:'/newUNCUser', version:'0.0.1'}, function(req, res, next){
    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }

    var sql={};

    sql.text = "SELECT  * FROM kuntur.f_new_unc_user($1, $2, $3, $4)";
    sql.values = [req.body.guiven_name, req.body.last_name, req.body.us, req.body.mail];

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
  //JSON.parse(result.rows[0].perfilArray)
    query.on("end",function(result){
      done();
      res.send(200,JSON.parse(result.rows[0].f_new_unc_user));
    });

    query.on("error",function(error){
      console.log(error);
      done();
      res.send(500,error);
    });

    });

});

server.get({path : '/dataExport', version : '0.0.1'} , function(req, res , next){
  filter=JSON.parse(req.params.filter);

  var sql="WITH t AS ("+
    "SELECT DISTINCT " +
    "e.number_enrrollment as NroPostulacion,"+
    "s.file_number as NroEstudiante, "+
    "e.family_name as Apellido, "+
    "e.given_name as Nombre, "+
    "e.family_name || ' ' || e.given_name as Estudiante, "+
    "e.birth_date as FechadeNacimiento, "+
    "e.birth_country_code as LugardeNacimiento, "+
    "pi.name as Documento, "+
    "pi.identity_number as NroDocumento, "+
    "pi.country_code as PaísEmisor, "+
    "e.institution_name as Universidad, "+
    "e.institution_country_code, "+
    "us.email as Email, "+
    "ap.title as Convocatoria, "+
    "es.code as Estado, "+
    "es.name, "+
    "("+
      "select string_agg(distinct o.name, '  |  ' order by o.name) "+
      "from kuntur.unc_in_study_program uisp "+
      "join  kuntur.org o "+
        "on o.id = uisp.org_id "+
      "where uisp.unc_in_enrrollment_id = e.id "+
    ") as UnidadAcadémica, "+
    "(SELECT string_agg(uisp2.subject, '  |  ' order by uisp2.subject) FROM kuntur.unc_in_study_program uisp2 WHERE e.id = uisp2.unc_in_enrrollment_id) as Materias "+
    "FROM  kuntur.enrrollment e " +
    "JOIN  kuntur.admission_period ap "+
    "ON e.admission_period_id = ap.id "+
    "JOIN  kuntur.enrrollment_status es "+
    "ON es.id = e.enrrollment_status_id "+
    "LEFT JOIN  kuntur.user_system us "+
    "ON us.id = e.user_system_id "+
    "LEFT JOIN  kuntur.person p "+
    "ON p.id = us.id "+
    "LEFT JOIN  kuntur.person_identity pi "+
    "ON p.id = pi.person_id "+
    "LEFT JOIN  kuntur.student s "+
    "ON s.id = e.student_id "+
    "LEFT JOIN  kuntur.unc_in_enrrollment uie "+
    "ON uie.id = e.id "+
    "LEFT JOIN  kuntur.unc_in_study_program uisp "+
    "ON uisp.unc_in_enrrollment_id = uie.id "+
    "LEFT JOIN  kuntur.org o "+
    "ON o.id = uisp.org_id WHERE '"+
    req.headers.usersystemid +
    "' IN (SELECT	x.user_system_id " +
      "FROM kuntur.enrrollment_stakeholder x " +
      "WHERE x.user_system_id = '" + req.headers.usersystemid +
	    "' AND x.enrrollment_id = e.id) ";

    /*
    number: numero de postulacion
    namePeriod: nombre de convocatoria
    year: año de convocatoria
    semester: semestre de convocatoria
    status: codigo de estado de postulacion
    country: pais de postulacion
    name: nombre de postulante
    university: universidad de postulante
    email: email de postulante
    aunit: id de unidad academica de la postulacion
    */


  if(filter.number){
    sql += " AND e.number_enrrollment = '"+filter.number+"'";
  }

  if(filter.namePeriod){
    sql += " AND ap.title = '"+filter.namePeriod+"'";
  }

  if(filter.year){
    sql += " AND ap.year = "+filter.year;
  }

  if(filter.semester){
    sql += " AND ap.semester = "+filter.semester;
  }

  if(filter.aunit){
    sql += " AND uisp.org_id = '"+filter.aunit+"'";
  }

  if(filter.status){
    sql += " AND es.code = '"+filter.status+"'";
  }

  if(filter.country){
    sql += " AND e.birth_country_code = '"+filter.country+"'";
  }

  if(filter.university){
    sql += " AND o.name = '"+filter.university+"'";
  }


  //cierro la tabla temporal
  sql+=") SELECT * FROM t "



  //busqueda por nombre
  if(filter.name){
    sql += "WHERE estudiante ILIKE '%" + filter.name + "%' ";
  }

  //var query = client.query(sql);

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

server.put({path:'/unidadesAcademicas/:auId/directivos', version:'0.0.1'}, function(req, res, next){


    if(!req.body){
      res.send(409, {code: 409, message: 'Conflict', description: 'No body found in request.'});
      return next();
    }


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
      	var logToken = uuid.v4();
  		console.log("BEGIN /unidadesAcademicas/directivos " + logToken);
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
              }else{//AGREGO LAS PERSONAS A STAKEHOLders
                var sql = "SELECT kuntur.f_add_user_stakeholder($1, $2 )";
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
              }else{//AGREGO LAS PERSONAS A STAKEHOLDERS
                var sql = "SELECT kuntur.f_add_user_stakeholder($1, $2 )";
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
                console.log("ROLLBACK /unidadesAcademicas/directivos " + logToken);
                res.send(500,err);
              }else{
                client.query('COMMIT', done);
                console.log("COMMIT /unidadesAcademicas/directivos " + logToken);
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
