DROP VIEW IF EXISTS kuntur.v_enrrollment_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_json AS 
	SELECT 
		REPLACE((
			'{"org.kuntur.model.organization.agreement.enrrollment.Enrrollment":{'
				 || jston_att_util('id', enrrollment.id::VARCHAR, 1, false, ',')
				 || jston_att_util('erased', enrrollment.erased::VARCHAR, 2, false, ',')
				 || jston_att_util('givenName', enrrollment.given_name::VARCHAR, 1, false, ',')
				 || jston_att_util('middleName', enrrollment.middle_name::VARCHAR, 1, false, ',')
				 || jston_att_util('familyName', enrrollment.family_name::VARCHAR, 1, false, ',')
				 || jston_att_util('birthDate', enrrollment.birth_date::VARCHAR, 3, false, ',')
				 || jston_att_util('male', enrrollment.male::VARCHAR, 2, false, ',')
				 || jston_att_util('urlPhoto', enrrollment.url_photo::VARCHAR, 1, false, ',')
				 || jston_att_util('comment', enrrollment.comment::VARCHAR, 1, false, ',')
				 || jston_att_util('birthCountryCode', enrrollment.birth_country_code::VARCHAR, 1, false, ',')
				 || jston_att_util('birthAdminAreaLevel1Code', enrrollment.birth_admin_area_level1_code::VARCHAR, 1, false, ',')
				 || jston_att_util('birthAdminAreaLevel2', enrrollment.birth_admin_area_level2::VARCHAR, 1, false, ',')
				 || jston_att_util('birthLocality', enrrollment.birth_locality::VARCHAR, 1, false, ',')
				 || jston_att_util('birthLat', enrrollment.birth_lat::VARCHAR, 2, false, ',')
				 || jston_att_util('birthLng', enrrollment.birth_lng::VARCHAR, 2, false, ',')
				 || jston_att_util('institutionOriginalName', enrrollment.institution_original_name::VARCHAR, 1, false, ',')
				 || jston_att_util('institutionWebSite', enrrollment.institution_web_site::VARCHAR, 1, false, ',')
				 || jston_att_util('institutionCountryCode', enrrollment.institution_country_code::VARCHAR, 1, false, ',')
				 || jston_att_util('numberEnrrollment', enrrollment.number_enrrollment::VARCHAR, 2, false, ',')
				 || jston_att_util('checkOutDate', enrrollment.check_out_date::VARCHAR, 4, false, ',')
				|| '"org":{'
					 || jston_att_util('id', org.id::VARCHAR, 1, false, ',')
					 || jston_att_util('erased', org.erased::VARCHAR, 2, false, ',')
					 || jston_att_util('shortName', org.short_name::VARCHAR, 1, false, ',')
					 || jston_att_util('name', org.name::VARCHAR, 1, false, ',')
					 || jston_att_util('originalName', org.original_name::VARCHAR, 1, false, ',')
					 || jston_att_util('urlPhoto', org.url_photo::VARCHAR, 1, false, ',')
					 || jston_att_util('webSite', org.web_site::VARCHAR, 1, false, ',')
					 || jston_att_util('comment', org.comment::VARCHAR, 1, false, ',')
					 || jston_att_util('countryCode', org.country_code::VARCHAR, 1, false, ',')
					 || jston_att_util('primaryOrg', org.primary_org::VARCHAR, 2, false, ',')
					 || jston_att_util('codeOna', org.code_ona::VARCHAR, 2, false, ',')
					 || jston_att_util('codeGuarani', org.code_guarani::VARCHAR, 1, false, ',')
				|| '}, '
				|| '"userSystem":{'
					 || jston_att_util('id', user_system.id::VARCHAR, 1, false, ',')
					 || jston_att_util('erased', user_system.erased::VARCHAR, 2, false, ',')
					 || jston_att_util('name', user_system.name::VARCHAR, 1, false, ',')
					 || jston_att_util('pass', user_system.pass::VARCHAR, 1, false, ',')
					 || jston_att_util('email', user_system.email::VARCHAR, 1, false, ',')
					 || jston_att_util('comment', user_system.comment::VARCHAR, 1, false, ',')
				|| '}, '
				|| '"student":{'
					 || jston_att_util('id', student.id::VARCHAR, 1, false, ',')
					 || jston_att_util('erased', student.erased::VARCHAR, 2, false, ',')
					 || jston_att_util('fileNumber', student.file_number::VARCHAR, 2, false, ',')
					 || jston_att_util('institutionOriginalName', student.institution_original_name::VARCHAR, 1, false, ',')
					 || jston_att_util('institutionWebSite', student.institution_web_site::VARCHAR, 1, false, ',')
					 || jston_att_util('institutionCountryCode', student.institution_country_code::VARCHAR, 1, false, ',')
				|| '}, '
				|| '"admissionPeriod":{'
					 || jston_att_util('id', admission_period.id::VARCHAR, 1, false, ',')
					 || jston_att_util('erased', admission_period.erased::VARCHAR, 2, false, ',')
					 || jston_att_util('numberAdmissionPeriod', admission_period.number_admission_period::VARCHAR, 2, false, ',')
					 || jston_att_util('inType', admission_period.in_type::VARCHAR, 2, false, ',')
					 || jston_att_util('year', admission_period.year::VARCHAR, 2, false, ',')
					 || jston_att_util('semester', admission_period.semester::VARCHAR, 2, false, ',')
					 || jston_att_util('title', admission_period.title::VARCHAR, 1, false, ',')
					 || jston_att_util('fromDate', admission_period.from_date::VARCHAR, 3, false, ',')
					 || jston_att_util('toDate', admission_period.to_date::VARCHAR, 3, false, ',')
					 || jston_att_util('comment', admission_period.comment::VARCHAR, 1, false, ',')
				|| '}, '
				|| '"enrrollmentStatus":{'
					 || jston_att_util('id', enrrollment_status.id::VARCHAR, 1, false, ',')
					 || jston_att_util('erased', enrrollment_status.erased::VARCHAR, 2, false, ',')
					 || jston_att_util('code', enrrollment_status.code::VARCHAR, 1, false, ',')
					 || jston_att_util('name', enrrollment_status.name::VARCHAR, 1, false, ',')
					 || jston_att_util('comment', enrrollment_status.comment::VARCHAR, 1, false, ',')
				|| '}'
			|| '}}'
		), ',}', '}')::TEXT AS json_java_xstream,
		REPLACE((
			'{"org.kuntur.model.organization.agreement.enrrollment.Enrrollment":{'
				 || jston_att_util('id', enrrollment.id::VARCHAR, 1, true, ',')
				 || jston_att_util('erased', enrrollment.erased::VARCHAR, 2, true, ',')
				 || jston_att_util('givenName', enrrollment.given_name::VARCHAR, 1, true, ',')
				 || jston_att_util('middleName', enrrollment.middle_name::VARCHAR, 1, true, ',')
				 || jston_att_util('familyName', enrrollment.family_name::VARCHAR, 1, true, ',')
				 || jston_att_util('birthDate', enrrollment.birth_date::VARCHAR, 3, true, ',')
				 || jston_att_util('male', enrrollment.male::VARCHAR, 2, true, ',')
				 || jston_att_util('urlPhoto', enrrollment.url_photo::VARCHAR, 1, true, ',')
				 || jston_att_util('comment', enrrollment.comment::VARCHAR, 1, true, ',')
				 || jston_att_util('birthCountryCode', enrrollment.birth_country_code::VARCHAR, 1, true, ',')
				 || jston_att_util('birthAdminAreaLevel1Code', enrrollment.birth_admin_area_level1_code::VARCHAR, 1, true, ',')
				 || jston_att_util('birthAdminAreaLevel2', enrrollment.birth_admin_area_level2::VARCHAR, 1, true, ',')
				 || jston_att_util('birthLocality', enrrollment.birth_locality::VARCHAR, 1, true, ',')
				 || jston_att_util('birthLat', enrrollment.birth_lat::VARCHAR, 2, true, ',')
				 || jston_att_util('birthLng', enrrollment.birth_lng::VARCHAR, 2, true, ',')
				 || jston_att_util('institutionOriginalName', enrrollment.institution_original_name::VARCHAR, 1, true, ',')
				 || jston_att_util('institutionWebSite', enrrollment.institution_web_site::VARCHAR, 1, true, ',')
				 || jston_att_util('institutionCountryCode', enrrollment.institution_country_code::VARCHAR, 1, true, ',')
				 || jston_att_util('numberEnrrollment', enrrollment.number_enrrollment::VARCHAR, 2, true, ',')
				 || jston_att_util('checkOutDate', enrrollment.check_out_date::VARCHAR, 4, true, ',')
				|| '"org":{'
					 || jston_att_util('id', org.id::VARCHAR, 1, true, ',')
					 || jston_att_util('erased', org.erased::VARCHAR, 2, true, ',')
					 || jston_att_util('shortName', org.short_name::VARCHAR, 1, true, ',')
					 || jston_att_util('name', org.name::VARCHAR, 1, true, ',')
					 || jston_att_util('originalName', org.original_name::VARCHAR, 1, true, ',')
					 || jston_att_util('urlPhoto', org.url_photo::VARCHAR, 1, true, ',')
					 || jston_att_util('webSite', org.web_site::VARCHAR, 1, true, ',')
					 || jston_att_util('comment', org.comment::VARCHAR, 1, true, ',')
					 || jston_att_util('countryCode', org.country_code::VARCHAR, 1, true, ',')
					 || jston_att_util('primaryOrg', org.primary_org::VARCHAR, 2, true, ',')
					 || jston_att_util('codeOna', org.code_ona::VARCHAR, 2, true, ',')
					 || jston_att_util('codeGuarani', org.code_guarani::VARCHAR, 1, true, ',')
				|| '}, '
				|| '"userSystem":{'
					 || jston_att_util('id', user_system.id::VARCHAR, 1, true, ',')
					 || jston_att_util('erased', user_system.erased::VARCHAR, 2, true, ',')
					 || jston_att_util('name', user_system.name::VARCHAR, 1, true, ',')
					 || jston_att_util('pass', user_system.pass::VARCHAR, 1, true, ',')
					 || jston_att_util('email', user_system.email::VARCHAR, 1, true, ',')
					 || jston_att_util('comment', user_system.comment::VARCHAR, 1, true, ',')
				|| '}, '
				|| '"student":{'
					 || jston_att_util('id', student.id::VARCHAR, 1, true, ',')
					 || jston_att_util('erased', student.erased::VARCHAR, 2, true, ',')
					 || jston_att_util('fileNumber', student.file_number::VARCHAR, 2, true, ',')
					 || jston_att_util('institutionOriginalName', student.institution_original_name::VARCHAR, 1, true, ',')
					 || jston_att_util('institutionWebSite', student.institution_web_site::VARCHAR, 1, true, ',')
					 || jston_att_util('institutionCountryCode', student.institution_country_code::VARCHAR, 1, true, ',')
				|| '}, '
				|| '"admissionPeriod":{'
					 || jston_att_util('id', admission_period.id::VARCHAR, 1, true, ',')
					 || jston_att_util('erased', admission_period.erased::VARCHAR, 2, true, ',')
					 || jston_att_util('numberAdmissionPeriod', admission_period.number_admission_period::VARCHAR, 2, true, ',')
					 || jston_att_util('inType', admission_period.in_type::VARCHAR, 2, true, ',')
					 || jston_att_util('year', admission_period.year::VARCHAR, 2, true, ',')
					 || jston_att_util('semester', admission_period.semester::VARCHAR, 2, true, ',')
					 || jston_att_util('title', admission_period.title::VARCHAR, 1, true, ',')
					 || jston_att_util('fromDate', admission_period.from_date::VARCHAR, 3, true, ',')
					 || jston_att_util('toDate', admission_period.to_date::VARCHAR, 3, true, ',')
					 || jston_att_util('comment', admission_period.comment::VARCHAR, 1, true, ',')
				|| '}, '
				|| '"enrrollmentStatus":{'
					 || jston_att_util('id', enrrollment_status.id::VARCHAR, 1, true, ',')
					 || jston_att_util('erased', enrrollment_status.erased::VARCHAR, 2, true, ',')
					 || jston_att_util('code', enrrollment_status.code::VARCHAR, 1, true, ',')
					 || jston_att_util('name', enrrollment_status.name::VARCHAR, 1, true, ',')
					 || jston_att_util('comment', enrrollment_status.comment::VARCHAR, 1, true, ',')
				|| '}'
			|| '}}'
		), ',}', '}')::TEXT AS json_node,
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
	FROM kuntur.enrrollment
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
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id;