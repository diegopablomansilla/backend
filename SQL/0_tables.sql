-- Modelo de Datos de Kuntur (Base de Datos PostgreSQL)

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person CASCADE;
CREATE TABLE kuntur.person
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	given_name varchar NOT NULL, -- Nombre de Pila
	middle_name varchar, -- Segundo Nombre
	family_name varchar NOT NULL, -- Apellido
	birth_date date, -- Fecha de Nacimiento
	male boolean, -- Masculino
	url_photo varchar, -- Foto
	comment varchar, -- Comentario
	birth_country_code varchar, -- País Nacimiento - Código ISO 3166-1 Alfa-2
	birth_admin_area_level1_code varchar, -- Provincia Nacimiento - Código ISO 3166-2
	birth_admin_area_level2 varchar, -- Departamento / Distrito Nacimiento
	birth_locality varchar, -- Localidad Nacimiento
	birth_lat double precision, -- Latitud Nacimiento
	birth_lng double precision, -- Longitud Nacimiento

	CONSTRAINT person_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_email CASCADE;
CREATE TABLE kuntur.person_email
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	email varchar NOT NULL, -- Correo Electrónico
	comment varchar, -- Comentario
	person_id varchar NOT NULL, -- Persona Física

	CONSTRAINT person_email_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_phone CASCADE;
CREATE TABLE kuntur.person_phone
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar, -- País - Código ISO 3166-1 Alfa-2
	phone_number varchar NOT NULL, -- Número de Teléfono
	comment varchar, -- Comentario
	person_id varchar NOT NULL, -- Persona Física

	CONSTRAINT person_phone_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_identity_type CASCADE;
CREATE TABLE kuntur.person_identity_type
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar NOT NULL, -- Nombre
	country_code varchar, -- País - Código ISO 3166-1 Alfa-2 (País Emisor)
	comment varchar, -- Comentario

	CONSTRAINT person_identity_type_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_identity CASCADE;
CREATE TABLE kuntur.person_identity
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	identity_number varchar NOT NULL, -- Número de Identificación
	code varchar NOT NULL, -- Código
	name varchar NOT NULL, -- Nombre
	country_code varchar, -- País - Código ISO 3166-1 Alfa-2 (País Emisor)
	comment varchar, -- Comentario
	person_id varchar NOT NULL, -- Persona Física
	person_identity_type_id varchar, -- Tipo de Identificación de Persona Física

	CONSTRAINT person_identity_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_nationality CASCADE;
CREATE TABLE kuntur.person_nationality
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	comment varchar, -- Comentario
	person_id varchar NOT NULL, -- Persona Física

	CONSTRAINT person_nationality_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.person_address CASCADE;
CREATE TABLE kuntur.person_address
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar, -- País - Código ISO 3166-1 Alfa-2
	admin_area_level1_code varchar, -- Provincia - Código ISO 3166-2
	admin_area_level2 varchar, -- Departamento / Distrito
	locality varchar, -- Localidad
	neighbourhood varchar, -- Vecindario
	street varchar, -- Calle
	street_number varchar, -- Número de Calle
	building_floor varchar, -- Planta del Edificio
	building_room varchar, -- Departamento de Edificio
	building varchar, -- Edificio
	postal_code varchar, -- Código Postal
	comment varchar, -- Comentario
	lat double precision, -- Latitud
	lng double precision, -- Longitud
	person_id varchar NOT NULL, -- Persona Física

	CONSTRAINT person_address_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.user_system CASCADE;
CREATE TABLE kuntur.user_system
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	name varchar UNIQUE  NOT NULL, -- nombre
	pass varchar NOT NULL, -- Contraseña
	email varchar NOT NULL, -- Correo Electrónico
	comment varchar, -- Comentario

	CONSTRAINT user_system_pkey PRIMARY KEY (id),

	CONSTRAINT user_system_id_fkey FOREIGN KEY (id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.org_type CASCADE;
CREATE TABLE kuntur.org_type
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT org_type_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.org CASCADE;
CREATE TABLE kuntur.org
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	short_name varchar, -- Sigla
	name varchar, -- Nombre
	original_name varchar NOT NULL, -- Nombre en el idioma original
	url_photo varchar, -- Logo
	web_site varchar UNIQUE  NOT NULL, -- Sitio Web
	comment varchar, -- Comentario
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	primary_org boolean NOT NULL, -- Institución Primaria del Sistema
	code_ona integer UNIQUE , -- Código ONA
	code_guarani varchar UNIQUE , -- Código Guarani
	org_type_id varchar NOT NULL, -- Tipo de Unidad Organizativa
	org_id varchar, -- Institución Educativa

	CONSTRAINT org_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.org_email CASCADE;
CREATE TABLE kuntur.org_email
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	email varchar NOT NULL, -- Correo Electrónico
	comment varchar, -- Comentario
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT org_email_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.org_phone CASCADE;
CREATE TABLE kuntur.org_phone
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	phone_number varchar NOT NULL, -- Número de Teléfono
	comment varchar, -- Comentario
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT org_phone_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.org_address CASCADE;
CREATE TABLE kuntur.org_address
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	admin_area_level1_code varchar NOT NULL, -- Provincia - Código ISO 3166-2
	admin_area_level2 varchar, -- Departamento / Distrito
	locality varchar NOT NULL, -- Localidad
	neighbourhood varchar, -- Vecindario
	street varchar NOT NULL, -- Calle
	street_number varchar, -- Número de Calle
	building_floor varchar, -- Planta del Edificio
	building_room varchar, -- Departamento de Edificio
	building varchar, -- Edificio
	postal_code varchar NOT NULL, -- Código Postal
	comment varchar, -- Comentario
	lat double precision, -- Latitud
	lng double precision, -- Longitud
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT org_address_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.contact CASCADE;
CREATE TABLE kuntur.contact
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	org_id varchar NOT NULL, -- Institución Educativa
	person_id varchar NOT NULL, -- Persona Física

	CONSTRAINT contact_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.student CASCADE;
CREATE TABLE kuntur.student
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	file_number bigint UNIQUE  NOT NULL, -- N° de Estudiante
	institution_original_name varchar NOT NULL, -- Nombre en el idioma original
	institution_web_site varchar NOT NULL, -- Sitio Web
	institution_country_code varchar, -- País Nacionalidad - Código ISO 3166-1 Alfa-2
	org_id varchar, -- Institución Educativa

	CONSTRAINT student_pkey PRIMARY KEY (id),

	CONSTRAINT student_id_fkey FOREIGN KEY (id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement_contact CASCADE;
CREATE TABLE kuntur.agreement_contact
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	reception_student boolean NOT NULL, -- Responsable de Estudiantes a Recibir
	sending_student boolean NOT NULL, -- Responsable de Estudiantes a Enviar
	agreement_item_id varchar NOT NULL, -- Item de Convenio
	contact_id varchar NOT NULL, -- Persona de Contacto

	CONSTRAINT agreement_contact_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement_type CASCADE;
CREATE TABLE kuntur.agreement_type
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT agreement_type_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement_status CASCADE;
CREATE TABLE kuntur.agreement_status
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT agreement_status_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement CASCADE;
CREATE TABLE kuntur.agreement
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	number_agreement bigint UNIQUE  NOT NULL, -- N°
	title varchar NOT NULL, -- Título
	from_date date NOT NULL, -- Fecha Inicio
	to_date date, -- Fecha Fin
	comment varchar, -- Comentario
	agreement_type_id varchar NOT NULL, -- Tipo de Convenio
	agreement_status_id varchar NOT NULL, -- Estado de Convenio
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT agreement_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement_item CASCADE;
CREATE TABLE kuntur.agreement_item
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	in_units integer, -- Cantidad Plazas de Estudiantes a Recibir
	out_units integer, -- Cantidad de Estudiantes a Enviar
	agreement_id varchar NOT NULL, -- Convenio
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT agreement_item_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.agreement_item_ou CASCADE;
CREATE TABLE kuntur.agreement_item_ou
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	in_units integer, -- Cantidad Plazas de Estudiantes a Recibir
	out_units integer, -- Cantidad de Estudiantes a Enviar
	agreement_item_id varchar NOT NULL, -- Item de Convenio
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT agreement_item_ou_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period_item_ou CASCADE;
CREATE TABLE kuntur.admission_period_item_ou
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	in_units integer, -- Cantidad Plazas de Estudiantes a Recibir
	out_units integer, -- Cantidad de Estudiantes a Enviar
	admission_period_item_id varchar NOT NULL, -- Item de Convocatoria
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT admission_period_item_ou_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period_status CASCADE;
CREATE TABLE kuntur.admission_period_status
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT admission_period_status_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period CASCADE;
CREATE TABLE kuntur.admission_period
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	number_admission_period bigint UNIQUE  NOT NULL, -- N°
	in_type boolean NOT NULL, -- Tipo
	year integer NOT NULL, -- Año
	semester integer NOT NULL, -- Semestre
	title varchar NOT NULL, -- Título
	from_date date NOT NULL, -- Fecha Inicio
	to_date date NOT NULL, -- Fecha Fin
	comment varchar, -- Comentario
	admission_period_status_id varchar NOT NULL, -- Estado de Convocatoria

	CONSTRAINT admission_period_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period_agreement CASCADE;
CREATE TABLE kuntur.admission_period_agreement
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	agreement_id varchar NOT NULL, -- Convenio
	admission_period_id varchar NOT NULL, -- Convocatoria (Periodo de Admisión)

	CONSTRAINT admission_period_agreement_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period_item CASCADE;
CREATE TABLE kuntur.admission_period_item
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	in_units integer, -- Cantidad Plazas de Estudiantes a Recibir
	out_units integer, -- Cantidad de Estudiantes a Enviar
	admission_period_id varchar NOT NULL, -- Convocatoria (Periodo de Admisión)
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT admission_period_item_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.admission_period_contact CASCADE;
CREATE TABLE kuntur.admission_period_contact
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	admission_period_item_id varchar NOT NULL, -- Item de Convocatoria
	contact_id varchar NOT NULL, -- Persona de Contacto

	CONSTRAINT admission_period_contact_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_status CASCADE;
CREATE TABLE kuntur.enrrollment_status
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT enrrollment_status_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment CASCADE;
CREATE TABLE kuntur.enrrollment
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	given_name varchar NOT NULL, -- Nombre de Pila
	middle_name varchar, -- Segundo Nombre
	family_name varchar NOT NULL, -- Apellido
	birth_date date NOT NULL, -- Fecha de Nacimiento
	male boolean, -- Masculino
	url_photo varchar, -- Foto
	comment varchar, -- Comentario
	birth_country_code varchar, -- País Nacimiento - Código ISO 3166-1 Alfa-2
	birth_admin_area_level1_code varchar, -- Provincia Nacimiento - Código ISO 3166-2
	birth_admin_area_level2 varchar, -- Departamento / Distrito Nacimiento
	birth_locality varchar, -- Localidad Nacimiento
	birth_lat double precision, -- Latitud Nacimiento
	birth_lng double precision, -- Longitud Nacimiento
	institution_original_name varchar NOT NULL, -- Nombre en el idioma original
	institution_web_site varchar NOT NULL, -- Sitio Web
	institution_country_code varchar NOT NULL, -- País Nacionalidad - Código ISO 3166-1 Alfa-2
	number_enrrollment bigint UNIQUE  NOT NULL, -- N°
	check_out_date timestamp, -- Fecha Check Out
	org_id varchar, -- Institución Educativa
	user_system_id varchar, -- Usuario del Sistema
	student_id varchar NOT NULL, -- Estudiante
	admission_period_id varchar NOT NULL, -- Convocatoria (Periodo de Admisión)
	enrrollment_status_id varchar NOT NULL, -- Estado de la Postulación

	CONSTRAINT enrrollment_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_chat CASCADE;
CREATE TABLE kuntur.enrrollment_chat
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	chat_time timestamp NOT NULL, -- Chat Time
	chat varchar NOT NULL, -- Chat
	user_system_a_id varchar NOT NULL, -- Usuario del Sistema
	user_system_b_id varchar NOT NULL, -- Usuario del Sistema
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_chat_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_stakeholder CASCADE;
CREATE TABLE kuntur.enrrollment_stakeholder
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code integer NOT NULL, -- Código de Tipo de Permiso (Relación)
	user_system_id varchar NOT NULL, -- Usuario del Sistema
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_stakeholder_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_email CASCADE;
CREATE TABLE kuntur.enrrollment_email
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	email varchar NOT NULL, -- Correo Electrónico
	comment varchar, -- Comentario
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_email_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_phone CASCADE;
CREATE TABLE kuntur.enrrollment_phone
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	phone_number varchar NOT NULL, -- Número de Teléfono
	comment varchar, -- Comentario
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_phone_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_identity CASCADE;
CREATE TABLE kuntur.enrrollment_identity
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	identity_number varchar NOT NULL, -- Número de Identificación
	code varchar NOT NULL, -- Código
	name varchar NOT NULL, -- Nombre
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2 (País Emisor)
	comment varchar, -- Comentario
	enrrollment_id varchar NOT NULL, -- Postulación
	person_identity_type_id varchar, -- Tipo de Identificación de Persona Física

	CONSTRAINT enrrollment_identity_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_nationality CASCADE;
CREATE TABLE kuntur.enrrollment_nationality
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	comment varchar, -- Comentario
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_nationality_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_address CASCADE;
CREATE TABLE kuntur.enrrollment_address
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	country_code varchar NOT NULL, -- País - Código ISO 3166-1 Alfa-2
	admin_area_level1_code varchar, -- Provincia - Código ISO 3166-2
	admin_area_level2 varchar, -- Departamento / Distrito
	locality varchar NOT NULL, -- Localidad
	neighbourhood varchar, -- Vecindario
	street varchar NOT NULL, -- Calle
	street_number varchar, -- Número de Calle
	building_floor varchar, -- Planta del Edificio
	building_room varchar, -- Departamento de Edificio
	building varchar, -- Edificio
	postal_code varchar NOT NULL, -- Código Postal
	comment varchar, -- Comentario
	lat double precision, -- Latitud
	lng double precision, -- Longitud
	enrrollment_id varchar NOT NULL, -- Postulación

	CONSTRAINT enrrollment_address_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.enrrollment_log CASCADE;
CREATE TABLE kuntur.enrrollment_log
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code_start varchar NOT NULL, -- Código
	name_start varchar NOT NULL, -- Nombre
	code_end varchar NOT NULL, -- Código
	name_end varchar NOT NULL, -- Nombre
	promotion_date timestamp NOT NULL, -- Fecha Promoción de Estado
	enrrollment_status_a_id varchar NOT NULL, -- Estado de la Postulación
	enrrollment_status_b_id varchar NOT NULL, -- Estado de la Postulación
	enrrollment_id varchar NOT NULL, -- Postulación
	user_system_id varchar NOT NULL, -- Usuario del Sistema

	CONSTRAINT enrrollment_log_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_enrrollment CASCADE;
CREATE TABLE kuntur.unc_in_enrrollment
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	agreement boolean NOT NULL, -- Con Convenio
	program boolean NOT NULL, -- Con Programa
	amount_paid double precision NOT NULL, -- Tasa Pagada
	original_doc boolean NOT NULL, -- Documentación Original
	insurance boolean NOT NULL, -- Seguro
	language_certificate boolean NOT NULL, -- Certificado de Idioma
	visa varchar, -- Visa
	emergency_contact varchar, -- Contacto de Emergencia
	credential_code varchar, -- Código de Credencial
	url_origininal_transcript varchar, -- Analítico Académico
	url_passport varchar, -- Pasaporte
	url_language_certificate varchar, -- Certificado de Idioma
	url_cv varchar, -- Curriculumn Vitae
	url_application_letter varchar, -- Carta de Postulación
	url_certificate_psychophysical varchar, -- Certificado Psicofísico
	url_admission_act varchar, -- Acta de Admisión
	url_admission_act_template varchar, -- Template Acta de Admisión
	url_transcript varchar, -- Certificado Analítico
	url_transcript_template varchar, -- Template de Certificado Analítico
	url_university_credential varchar, -- Credencial Universitaria
	url_student_report varchar, -- Reporte del Estudiante
	url_exchange_form varchar, -- Formulario de Intercambio
	comment varchar, -- Comentario
	observation varchar, -- Observaciones
	creation_date_postulation date, -- Observaciones
	agreement_name varchar, -- Nombre del Acuerdo
	agreement_comment varchar, -- Comentario del Acuerdo
	agreement_number_students integer, -- Cant. Estudiantes del Acuerdo
	agreement_org varchar, -- Institución del Acuerdo
	agreement_org_comment varchar, -- Comentario Institución del Acuerdo
	agreement_academic_unit varchar, -- Unidad Académica del Acuerdo
	exchange_program_name varchar, -- Nombre del Programa
	exchange_program_comment varchar, -- Comentario del Programa
	exchange_program_number_students integer, -- Cant. Estudiantes del Programa
	exchange_program_initial_number_students integer, -- Cant. Inicial Estudiantes del Programa

	CONSTRAINT unc_in_enrrollment_pkey PRIMARY KEY (id),

	CONSTRAINT unc_in_enrrollment_id_fkey FOREIGN KEY (id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_study_program CASCADE;
CREATE TABLE kuntur.unc_in_study_program
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	subject varchar NOT NULL, -- Materias
	approved boolean, -- Aprobado
	approved_by varchar, -- Aprobado por
	file_number varchar, -- Legajo Guarani
	comment varchar, -- Comentario
	unc_in_enrrollment_id varchar NOT NULL, -- Postulación
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT unc_in_study_program_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_grading_scale CASCADE;
CREATE TABLE kuntur.unc_in_grading_scale
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	rate_number integer UNIQUE  NOT NULL, -- Calificación Numérica
	rate_letter varchar NOT NULL, -- Calificación con Letras
	comment varchar, -- Comentario

	CONSTRAINT unc_in_grading_scale_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_studied_type CASCADE;
CREATE TABLE kuntur.unc_in_studied_type
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	code varchar UNIQUE  NOT NULL, -- Código
	name varchar UNIQUE  NOT NULL, -- Nombre
	comment varchar, -- Comentario

	CONSTRAINT unc_in_studied_type_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_academic_performance CASCADE;
CREATE TABLE kuntur.unc_in_academic_performance
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	subject varchar NOT NULL, -- Materias
	approved boolean, -- Aprobado
	approved_by varchar, -- Aprobado por
	file_number varchar, -- Legajo Guarani
	hs double precision NOT NULL, -- Horas
	unc_in_enrrollment_id varchar NOT NULL, -- Postulación
	unc_in_grading_scale_id varchar NOT NULL, -- Escala de Calificaciones
	unc_in_studied_type_id varchar NOT NULL, -- Tipo de cursado
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT unc_in_academic_performance_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_academic_coordinator CASCADE;
CREATE TABLE kuntur.unc_in_academic_coordinator
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	person_id varchar NOT NULL, -- Persona Física
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT unc_in_academic_coordinator_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS kuntur.unc_in_academic_office CASCADE;
CREATE TABLE kuntur.unc_in_academic_office
(
	id varchar NOT NULL, -- id
	erased boolean NOT NULL, -- erased
	person_id varchar NOT NULL, -- Persona Física
	org_id varchar NOT NULL, -- Institución Educativa

	CONSTRAINT unc_in_academic_office_pkey PRIMARY KEY (id)
);

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_email ADD CONSTRAINT person_email_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_phone ADD CONSTRAINT person_phone_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_identity ADD CONSTRAINT person_identity_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_identity ADD CONSTRAINT person_identity_person_identity_type_id_fkey FOREIGN KEY (person_identity_type_id) REFERENCES kuntur.person_identity_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_nationality ADD CONSTRAINT person_nationality_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.person_address ADD CONSTRAINT person_address_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org ADD CONSTRAINT org_org_type_id_fkey FOREIGN KEY (org_type_id) REFERENCES kuntur.org_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org ADD CONSTRAINT org_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_email ADD CONSTRAINT org_email_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_phone ADD CONSTRAINT org_phone_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.org_address ADD CONSTRAINT org_address_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.contact ADD CONSTRAINT contact_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.contact ADD CONSTRAINT contact_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.student ADD CONSTRAINT student_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_agreement_type_id_fkey FOREIGN KEY (agreement_type_id) REFERENCES kuntur.agreement_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_agreement_status_id_fkey FOREIGN KEY (agreement_status_id) REFERENCES kuntur.agreement_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement ADD CONSTRAINT agreement_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item ADD CONSTRAINT agreement_item_agreement_id_fkey FOREIGN KEY (agreement_id) REFERENCES kuntur.agreement (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item ADD CONSTRAINT agreement_item_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_contact ADD CONSTRAINT agreement_contact_agreement_item_id_fkey FOREIGN KEY (agreement_item_id) REFERENCES kuntur.agreement_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_contact ADD CONSTRAINT agreement_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES kuntur.contact (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item_ou ADD CONSTRAINT agreement_item_ou_agreement_item_id_fkey FOREIGN KEY (agreement_item_id) REFERENCES kuntur.agreement_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.agreement_item_ou ADD CONSTRAINT agreement_item_ou_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period ADD CONSTRAINT admission_period_admission_period_status_id_fkey FOREIGN KEY (admission_period_status_id) REFERENCES kuntur.admission_period_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_agreement ADD CONSTRAINT admission_period_agreement_agreement_id_fkey FOREIGN KEY (agreement_id) REFERENCES kuntur.agreement (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_agreement ADD CONSTRAINT admission_period_agreement_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item ADD CONSTRAINT admission_period_item_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item ADD CONSTRAINT admission_period_item_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_contact ADD CONSTRAINT admission_period_contact_admission_period_item_id_fkey FOREIGN KEY (admission_period_item_id) REFERENCES kuntur.admission_period_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_contact ADD CONSTRAINT admission_period_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES kuntur.contact (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item_ou ADD CONSTRAINT admission_period_item_ou_admission_period_item_id_fkey FOREIGN KEY (admission_period_item_id) REFERENCES kuntur.admission_period_item (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.admission_period_item_ou ADD CONSTRAINT admission_period_item_ou_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES kuntur.student (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_admission_period_id_fkey FOREIGN KEY (admission_period_id) REFERENCES kuntur.admission_period (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment ADD CONSTRAINT enrrollment_enrrollment_status_id_fkey FOREIGN KEY (enrrollment_status_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_user_system_a_id_fkey FOREIGN KEY (user_system_a_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_user_system_b_id_fkey FOREIGN KEY (user_system_b_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_chat ADD CONSTRAINT enrrollment_chat_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_stakeholder ADD CONSTRAINT enrrollment_stakeholder_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_stakeholder ADD CONSTRAINT enrrollment_stakeholder_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_email ADD CONSTRAINT enrrollment_email_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_phone ADD CONSTRAINT enrrollment_phone_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_identity ADD CONSTRAINT enrrollment_identity_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_identity ADD CONSTRAINT enrrollment_identity_person_identity_type_id_fkey FOREIGN KEY (person_identity_type_id) REFERENCES kuntur.person_identity_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_nationality ADD CONSTRAINT enrrollment_nationality_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_address ADD CONSTRAINT enrrollment_address_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_status_a_id_fkey FOREIGN KEY (enrrollment_status_a_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_status_b_id_fkey FOREIGN KEY (enrrollment_status_b_id) REFERENCES kuntur.enrrollment_status (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_enrrollment_id_fkey FOREIGN KEY (enrrollment_id) REFERENCES kuntur.enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.enrrollment_log ADD CONSTRAINT enrrollment_log_user_system_id_fkey FOREIGN KEY (user_system_id) REFERENCES kuntur.user_system (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_study_program ADD CONSTRAINT unc_in_study_program_unc_in_enrrollment_id_fkey FOREIGN KEY (unc_in_enrrollment_id) REFERENCES kuntur.unc_in_enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_study_program ADD CONSTRAINT unc_in_study_program_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_enrrollment_id_fkey FOREIGN KEY (unc_in_enrrollment_id) REFERENCES kuntur.unc_in_enrrollment (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_grading_scale_id_fkey FOREIGN KEY (unc_in_grading_scale_id) REFERENCES kuntur.unc_in_grading_scale (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_unc_in_studied_type_id_fkey FOREIGN KEY (unc_in_studied_type_id) REFERENCES kuntur.unc_in_studied_type (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_performance ADD CONSTRAINT unc_in_academic_performance_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_coordinator ADD CONSTRAINT unc_in_academic_coordinator_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_coordinator ADD CONSTRAINT unc_in_academic_coordinator_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_office ADD CONSTRAINT unc_in_academic_office_person_id_fkey FOREIGN KEY (person_id) REFERENCES kuntur.person (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

----------------------------------------------------------------------------------------
ALTER TABLE kuntur.unc_in_academic_office ADD CONSTRAINT unc_in_academic_office_org_id_fkey FOREIGN KEY (org_id) REFERENCES kuntur.org (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION