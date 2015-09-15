DROP VIEW IF EXISTS kuntur.v_enrrollment CASCADE;

CREATE OR REPLACE VIEW kuntur.v_enrrollment AS 
	SELECT 	
		unc_in_enrrollment.id AS unc_in_enrrollment_id/*id*/,
		unc_in_enrrollment.erased AS unc_in_enrrollment_erased/*erased*/,
		unc_in_enrrollment.agreement AS unc_in_enrrollment_agreement/*Con Convenio*/,
		unc_in_enrrollment.program AS unc_in_enrrollment_program/*Con Programa*/,
		unc_in_enrrollment.amount_paid AS unc_in_enrrollment_amount_paid/*Tasa Pagada*/,
		unc_in_enrrollment.original_doc AS unc_in_enrrollment_original_doc/*Documentación Original*/,
		unc_in_enrrollment.insurance AS unc_in_enrrollment_insurance/*Seguro*/,
		unc_in_enrrollment.language_certificate AS unc_in_enrrollment_language_certificate/*Certificado de Idioma*/,
		unc_in_enrrollment.visa AS unc_in_enrrollment_visa/*Visa*/,
		unc_in_enrrollment.emergency_contact AS unc_in_enrrollment_emergency_contact /*Contacto de Emergencia*/,
		unc_in_enrrollment.credential_code AS unc_in_enrrollment_credential_code/*Código de Credencial*/,
		unc_in_enrrollment.url_origininal_transcript AS unc_in_enrrollment_url_origininal_transcript/*Analítico Académico*/,
		unc_in_enrrollment.url_passport AS unc_in_enrrollment_url_passport/*Pasaporte*/,
		unc_in_enrrollment.url_language_certificate AS unc_in_enrrollment_url_language_certificate/*Certificado de Idioma*/,
		unc_in_enrrollment.url_cv AS unc_in_enrrollment_url_cv/*Curriculumn Vitae*/,
		unc_in_enrrollment.url_application_letter AS unc_in_enrrollment_url_application_letter/*Carta de Postulación*/,
		unc_in_enrrollment.url_certificate_psychophysical AS unc_in_enrrollment_url_certificate_psychophysical/*Certificado Psicofísico*/,
		unc_in_enrrollment.url_admission_act AS unc_in_enrrollment_url_admission_act/*Acta de Admisión*/,
		unc_in_enrrollment.url_admission_act_template AS unc_in_enrrollment_url_admission_act_template/*Template Acta de Admisión*/,
		unc_in_enrrollment.url_transcript AS unc_in_enrrollment_url_transcript/*Certificado Analítico*/,
		unc_in_enrrollment.url_transcript_template AS unc_in_enrrollment_url_transcript_template/*Template de Certificado Analítico*/,
		unc_in_enrrollment.url_university_credential AS unc_in_enrrollment_url_university_credential /*Credencial Universitaria*/,
		unc_in_enrrollment.url_student_report AS unc_in_enrrollment_url_student_report /*Reporte del Estudiante*/,
		unc_in_enrrollment.url_exchange_form AS unc_in_enrrollment_url_exchange_form/*Formulario de Intercambio*/,
		unc_in_enrrollment.comment AS unc_in_enrrollment_comment/*Comentario*/,
		unc_in_enrrollment.observation AS unc_in_enrrollment_observation/*Observaciones*/,
		unc_in_enrrollment.creation_date_postulation AS unc_in_enrrollment_creation_date_postulation /*Observaciones*/,
		unc_in_enrrollment.agreement_name AS unc_in_enrrollment_agreement_name/*Nombre del Acuerdo*/,
		unc_in_enrrollment.agreement_comment AS unc_in_enrrollment_agreement_comment/*Comentario del Acuerdo*/,
		unc_in_enrrollment.agreement_number_students AS unc_in_enrrollment_agreement_number_students/*Cant. Estudiantes del Acuerdo*/,
		unc_in_enrrollment.agreement_org AS unc_in_enrrollment_agreement_org/*Institución del Acuerdo*/,
		unc_in_enrrollment.agreement_org_comment AS unc_in_enrrollment_agreement_org_comment/*Comentario Institución del Acuerdo*/,
		unc_in_enrrollment.agreement_academic_unit AS unc_in_enrrollment_agreement_academic_unit/*Unidad Académica del Acuerdo*/,
		unc_in_enrrollment.exchange_program_name AS unc_in_enrrollment_exchange_program_name /*Nombre del Programa*/,
		unc_in_enrrollment.exchange_program_comment AS unc_in_enrrollment_exchange_program_comment /*Comentario del Programa*/,
		unc_in_enrrollment.exchange_program_number_students AS unc_in_enrrollment_exchange_program_number_students/*Cant. Estudiantes del Programa*/,
		unc_in_enrrollment.exchange_program_initial_number_students AS unc_in_enrrollment_exchange_program_initial_number_students/*Cant. Inicial Estudiantes del Programa*/,

		------------------------------------------
		enrrollment.id /*id*/,
		enrrollment.erased /*erased*/,
		enrrollment.given_name /*Nombre de Pila*/,
		enrrollment.middle_name /*Segundo Nombre*/,
		enrrollment.family_name /*Apellido*/,
		enrrollment.birth_date /*Fecha de Nacimiento*/,
		enrrollment.male /*Masculino*/,
		enrrollment.url_photo /*Foto*/,
		enrrollment.comment /*Comentario*/,
		enrrollment.birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		enrrollment.birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		enrrollment.birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		enrrollment.birth_locality /*Localidad Nacimiento*/,
		enrrollment.birth_lat /*Latitud Nacimiento*/,
		enrrollment.birth_lng /*Longitud Nacimiento*/,
		enrrollment.institution_original_name /*Nombre en el idioma original*/,
		enrrollment.institution_web_site /*Sitio Web*/,
		enrrollment.institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
		enrrollment.number_enrrollment /*N°*/,
		enrrollment.check_out_date /*Fecha Check Out*/,
	------------------------------------------
		org.id AS org_id /*id*/,
		org.erased AS org_erased /*erased*/,
		org.short_name AS org_short_name /*Sigla*/,
		org.name AS org_name /*Nombre*/,
		org.original_name AS org_original_name /*Nombre en el idioma original*/,
		org.url_photo AS org_url_photo /*Logo*/,
		org.web_site AS org_web_site /*Sitio Web*/,
		org.comment AS org_comment /*Comentario*/,
		org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org.primary_org AS org_primary_org /*Institución Primaria del Sistema*/,
		org.code_ona AS org_code_ona /*Código ONA*/,
		org.code_guarani AS org_code_guarani /*Código Guarani*/,
	------------------------------------------
		user_system.id AS user_system_id /*id*/,
		user_system.erased AS user_system_erased /*erased*/,
		user_system.name AS user_system_name /*nombre*/,
		user_system.pass AS user_system_pass /*Contraseña*/,
		user_system.email AS user_system_email /*Correo Electrónico*/,
		user_system.comment AS user_system_comment /*Comentario*/,
	------------------------------------------
		student.id AS student_id /*id*/,
		student.erased AS student_erased /*erased*/,
		student.file_number AS student_file_number /*N° de Estudiante*/,
		student.institution_original_name AS student_institution_original_name /*Nombre en el idioma original*/,
		student.institution_web_site AS student_institution_web_site /*Sitio Web*/,
		student.institution_country_code AS student_institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
	------------------------------------------
		admission_period.id AS admission_period_id /*id*/,
		admission_period.erased AS admission_period_erased /*erased*/,
		admission_period.number_admission_period AS admission_period_number_admission_period /*N°*/,
		admission_period.in_type AS admission_period_in_type /*Tipo*/,
		admission_period.year AS admission_period_year /*Año*/,
		admission_period.semester AS admission_period_semester /*Semestre*/,
		admission_period.title AS admission_period_title /*Título*/,
		admission_period.from_date AS admission_period_from_date /*Fecha Inicio*/,
		admission_period.to_date AS admission_period_to_date /*Fecha Fin*/,
		admission_period.comment AS admission_period_comment /*Comentario*/,
	------------------------------------------
		enrrollment_status.id AS enrrollment_status_id /*id*/,
		enrrollment_status.erased AS enrrollment_status_erased /*erased*/,
		enrrollment_status.code AS enrrollment_status_code /*Código*/,
		enrrollment_status.name AS enrrollment_status_name /*Nombre*/,
		enrrollment_status.comment AS enrrollment_status_comment /*Comentario*/
	FROM 	kuntur.enrrollment
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.enrrollment.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.user_system user_system
		ON kuntur.enrrollment.user_system_id = user_system.id
	------------------------------------------
	LEFT JOIN kuntur.student student
		ON kuntur.enrrollment.student_id = student.id
	------------------------------------------
	LEFT JOIN kuntur.admission_period admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id
	------------------------------------------
	LEFT JOIN kuntur.enrrollment_status enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id
	------------------------------------------	
	JOIN kuntur.unc_in_enrrollment
		ON kuntur.unc_in_enrrollment.id = kuntur.enrrollment.id;

SELECT * FROM kuntur.v_enrrollment WHERE unc_in_enrrollment_program = true;	

SELECT * FROM kuntur.v_enrrollment WHERE unc_in_enrrollment_agreement_name IS NOT NULL;		