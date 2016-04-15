---------------------ESTADO INICIADA: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='B'),
	(select id from kuntur.group_system where code='student'),
	'Solicitud INICIADA - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>Tu solicitud de admisión ha sido iniciada. Recibirás un mensaje a medida que avance el proceso.</blockquote>
<br>
<blockquote>Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</blockquote>
<br>
<blockquote>En caso de dudas o preguntas, por favor contactá a tu encargado/a de admisión:</blockquote>


<blockquote>
<b style="font-size:small">BRENDA SCHAUVINHOLD</b><br>
<i>International Students - USA, Canada & Europe<br>
brendasch@pri.unc.edu.ar </i>
</blockquote>

<blockquote>
<b style="font-size:small">GUILLERMO FIDELIO</b><br>
<i>Estudiantes Internacionales - América Latina & España<br>
guillermo.fidelio@pri.unc.edu.ar </i>
</blockquote>


</p>

<br>
<p><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO RECHAZADA: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='z'),
	(select id from kuntur.group_system where code='student'),
	'Solicitud RECHAZADA - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>Tu solicitud de admisión como estudiante internacional ha sido rechazada. Para más detalles, por favor, contactar a:</blockquote>
</p>

<blockquote>
<b style="font-size:small">BRENDA SCHAUVINHOLD</b><br>
<i>International Students - USA, Canada & Europe<br>
brendasch@pri.unc.edu.ar </i>
</blockquote>

<blockquote>
<b style="font-size:small">GUILLERMO FIDELIO</b><br>
<i>Estudiantes Internacionales - América Latina & España<br>
guillermo.fidelio@pri.unc.edu.ar </i>
</blockquote>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO INCOMPLETA: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='C'),
	(select id from kuntur.group_system where code='student'),
	'Solicitud INCOMPLETA - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>Tu solicitud de admisión está incompleta. Por favor, ingresá <a href="https://kuntur.unc.edu.ar" target="_blank">aquí</a> para completarla.</blockquote>
</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO MODIFICACION DE PLAN 1: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='E'),
	(select id from kuntur.group_system where code='student'),
	'MODIFICACIÓN DE PLAN - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>El Coordinador Académico solicita que modifiques tu plan de estudios. Por favor, ingresá <a href="https://kuntur.unc.edu.ar" target="_blank">aquí</a>, verifica sus comentarios, y modifica luego tu plan de estudios.</blockquote>
</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO ADMITIDA: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='F'),
	(select id from kuntur.group_system where code='student'),
	'Solicitud ADMITIDA - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<b>ADMISSION LETTER ISSUED TO APPLICANT (DOCUMENT ENCLOSED)</b>
<br>
<br>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>
	Tu solicitud de admisión a la UNC como Estudiante Internacional ha sido aceptada, a continuación: <br>
	<br>
	<blockquote>
	A. Encontrarás adjunta tu Carta de Admisión. Sólo se enviará por correo-e<br>
	B. Verifica en Guía del Estudiante Internacional los pasos a seguir para tu estadía en la UNC<br>
	</blockquote>
</blockquote>
<br>
<blockquote>En caso de dudas o preguntas, por favor contactá a tu encargado/a de admisión:</blockquote>


<blockquote>
<b style="font-size:small">BRENDA SCHAUVINHOLD</b><br>
<i>International Students - USA, Canada & Europe<br>
brendasch@pri.unc.edu.ar </i>
</blockquote>

<blockquote>
<b style="font-size:small">GUILLERMO FIDELIO</b><br>
<i>Estudiantes Internacionales - América Latina & España<br>
guillermo.fidelio@pri.unc.edu.ar </i>
</blockquote>


</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	true)

---------------------ESTADO MODIFICACION DE PLAN 2: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='G'),
	(select id from kuntur.group_system where code='student'),
	'CONFIRMACION DE PLAN DE ESTUDIOS - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote>El Coordinador Académico solicita que ingreses al sistema las materias definitivas que has seleccionado. Por favor, ingresá <a href="https://kuntur.unc.edu.ar" target="_blank">aquí</a> para modificar tu plan de estudios.</blockquote>

<br>
<blockquote>
	Luego deberás ir  a la oficina de alumnos de la facultad para finalizar tu matriculación en las clases seleccionadas.
</blockquote>
</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO EN MATRICULACION: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='H'),
	(select id from kuntur.group_system where code='student'),
	'MATRICULACION - Admisión de Estudiantes Internacionales en la UNC',
	'<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote> Has sido matriculada/o en la Universidad Nacional de Córdoba, para ver las materias en las que fuiste inscripto debes ingresar <a href="https://kuntur.unc.edu.ar" target="_blank">aquí</a><br>
En caso de error, informar a encargado/a de admisión. </blockquote>
</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO FINALIZADA: STUDENT----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='K'),
	(select id from kuntur.group_system where code='student'),
	'CERTIFICADO DE CALIFICACIONES - Admisión de Estudiantes Internacionales en la UNC',
	'<b>ADMISSION LETTER ISSUED TO APPLICANT (DOCUMENT ENCLOSED)</b>
<br>
<br>

<p>
<i>Estimada/o estudiante:</i>
<br>
<blockquote> 
Adjunto a este mensaje encontrarás tu certificado de calificaciones. Sólo se enviará por correo electrónico. Una copia digital ha sido remitida a la universidad de origen también.
<br>

El equipo de la Prosecretaría de Relaciones Internacionales espera que hayas tenido una provechosa estadía con nosotros.
</blockquote>
</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	true,
	false)


------------------COORDINATOR---------------------
---------------------ESTADO INICIADA: COORDINATOR----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='D'),
	(select id from kuntur.group_system where code='coordinator'),
	'EVALUAR PROGRAMA ACADEMICO - Admisión de Estudiantes Internacionales en la UNC',
	'<br>
<br>

<p>
<i>Estimado/a Coordinador/a:</i>
<br>
<blockquote> 
Un estudiante aguarda aprobación de su plan de estudios.
<br>

</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)

---------------------ESTADO INICIADA: COORDINATOR----------------------------------------------------

INSERT INTO kuntur.mail_config 
	values 
	(uuid_generate_v4()::varchar,
	(select id from kuntur.enrrollment_status where code='J'),
	(select id from kuntur.group_system where code='office'),
	'CARGAR ACTUACION ACADEMICA - Admisión de Estudiantes Internacionales en la UNC',
	'<br>
<br>

<p>
<i>Estimado/a encargado/a de oficina de alumnos:</i>
<br>
<blockquote> 
Un estudiante aguarda la carga de su actuación académica.
<br>

</p>

<br>
<p style="text-align:left"><b> Prosecretaría de Relaciones Internacionales<br>
Universidad Nacional de Córdoba</b></p>

<br>
<p style="font-size:x-small">* Este correo es informativo, favor no responder a esta dirección de correo, ya
que no se encuentra habilitada para recibir mensajes.</p>',
	true,
	'kuntur@psi.unc.edu.ar',
	false,
	false)




