--SET search_path to kuntur;

-- DROP FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) RETURNS VARCHAR AS $$
	BEGIN
		att_val = REPLACE(att_val, '
', E'\\n');
		
		IF coalescef = true THEN
			RETURN '"' || att_name || '":' || COALESCE(att_cd || att_val|| att_cd, 'null') 	|| att_end;
		ELSE
			RETURN '"' || att_name || '":' || att_cd || att_val|| att_cd			 || att_end;
	END IF;
END;
$$  LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_identity_type_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_identity_type_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', person_identity_type.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', person_identity_type.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', person_identity_type.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', person_identity_type.name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('countryCode', person_identity_type.country_code::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', person_identity_type.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"PersonIdentityType.personIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_identity_json_a x WHERE x.person_identity_id = person_identity_type.id)  || '], '
			--|| '"PersonIdentityType.personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"PersonIdentityType.enrrollmentIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_identity_json_a x WHERE x.enrrollment_identity_id = person_identity_type.id)  || '], '
			--|| '"PersonIdentityType.enrrollmentIdentityList":[]'

		|| '}' AS json, 
		person_identity_type.id AS person_identity_type_id /*id*/
		--person_identity_type.erased AS person_identity_type_erased /*erased*/,
		--person_identity_type.code AS person_identity_type_code /*Código*/,
		--person_identity_type.name AS person_identity_type_name /*Nombre*/,
		--person_identity_type.country_code AS person_identity_type_country_code /*País - Código ISO 3166-1 Alfa-2 (País Emisor)*/,
		--person_identity_type.comment AS person_identity_type_comment /*Comentario*/

	FROM kuntur.person_identity_type;

-------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS kuntur.v_person_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', person.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', person.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('givenName', person.given_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('middleName', person.middle_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('familyName', person.family_name::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthDate', person.birth_date::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('male', person.male::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('urlPhoto', person.url_photo::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', person.comment::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthCountryCode', person.birth_country_code::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthAdminAreaLevel1Code', person.birth_admin_area_level1_code::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthAdminAreaLevel2', person.birth_admin_area_level2::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthLocality', person.birth_locality::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('birthLat', person.birth_lat::VARCHAR, '', ', ' , true)
			--|| kuntur.json_att_util('birthLng', person.birth_lng::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_email_json_a x WHERE x.person_email_id = person.id)  || '], '
			--|| '"personEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_phone_json_a x WHERE x.person_phone_id = person.id)  || '], '
			--|| '"personPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_identity_json_a x WHERE x.person_identity_id = person.id)  || '], '
			--|| '"personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personNationalityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_nationality_json_a x WHERE x.person_nationality_id = person.id)  || '], '
			--|| '"personNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_address_json_a x WHERE x.person_address_id = person.id)  || '], '
			--|| '"personAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.contactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_contact_json_a x WHERE x.contact_id = person.id)  || '], '
			--|| '"contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.uncInAcademicCoordinatorList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_coordinator_json_a x WHERE x.unc_in_academic_coordinator_id = person.id)  || '], '
			--|| '"uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.uncInAcademicOfficeList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_office_json_a x WHERE x.unc_in_academic_office_id = person.id)  || '], '
			--|| '"uncInAcademicOfficeList":[]'

		|| '}' AS json, 
		person.id AS person_id /*id*/
		--person.erased AS person_erased /*erased*/,
		--person.given_name AS person_given_name /*Nombre de Pila*/,
		--person.middle_name AS person_middle_name /*Segundo Nombre*/,
		--person.family_name AS person_family_name /*Apellido*/,
		--person.birth_date AS person_birth_date /*Fecha de Nacimiento*/,
		--person.male AS person_male /*Masculino*/,
		--person.url_photo AS person_url_photo /*Foto*/,
		--person.comment AS person_comment /*Comentario*/,
		--person.birth_country_code AS person_birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		--person.birth_admin_area_level1_code AS person_birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		--person.birth_admin_area_level2 AS person_birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		--person.birth_locality AS person_birth_locality /*Localidad Nacimiento*/,
		--person.birth_lat AS person_birth_lat /*Latitud Nacimiento*/,
		--person.birth_lng AS person_birth_lng /*Longitud Nacimiento*/

	FROM kuntur.person;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_user_system_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_user_system_json_a AS 

	SELECT '{'
			|| SUBSTRING(person.json FROM 2 FOR CHAR_LENGTH(person.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| kuntur.json_att_util('name', user_system.name::VARCHAR, '"', ', ' , true)
			--|| kuntur.json_att_util('pass', user_system.pass::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('email', user_system.email::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', user_system.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = user_system.id)  || '], '
			--|| '"UserSystem.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentStakeholderList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_stakeholder_json_a x WHERE x.enrrollment_stakeholder_id = user_system.id)  || '], '
			--|| '"UserSystem.enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentLogList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_log_json_a x WHERE x.enrrollment_log_id = user_system.id)  || '], '
			--|| '"UserSystem.enrrollmentLogList":[]'

		|| '}' AS json, 
		user_system.id AS user_system_id /*id*/
		--user_system.erased AS user_system_erased /*erased*/,
		--user_system.name AS user_system_name /*nombre*/,
		--user_system.pass AS user_system_pass /*Contraseña*/,
		--user_system.email AS user_system_email /*Correo Electrónico*/,
		--user_system.comment AS user_system_comment /*Comentario*/

	FROM kuntur.user_system
	JOIN kuntur.v_person_json_a person
		ON kuntur.user_system.id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------





DROP VIEW IF EXISTS kuntur.v_org_type_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_type_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', org_type.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', org_type.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', org_type.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', org_type.name::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', org_type.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"OrgType.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org_type.id)  || '], '
			--|| '"OrgType.orgList":[]'

		|| '}' AS json, 
		org_type.id AS org_type_id /*id*/
		--org_type.erased AS org_type_erased /*erased*/,
		--org_type.code AS org_type_code /*Código*/,
		--org_type.name AS org_type_name /*Nombre*/,
		--org_type.comment AS org_type_comment /*Comentario*/

	FROM kuntur.org_type;


-------------------------------------------------------------------------------------------------------------------------

-- DROP FUNCTION kuntur.json_att_util(v1 VARCHAR, v2 VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.json_att_util(v1 VARCHAR, v2 VARCHAR) RETURNS VARCHAR AS $$
	BEGIN
		IF TRIM(v1) ILIKE TRIM(v2) THEN
			RETURN null;
		ELSE
			RETURN $2;
	END IF;
END;
$$  LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------

-- DROP FUNCTION kuntur.json_att_util(v1 VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.json_att_util(v1 VARCHAR) RETURNS VARCHAR AS $$
	BEGIN
		IF TRIM(v1) ILIKE 'Sin Especificar' THEN
			RETURN null;
		ELSE
			RETURN $1;
	END IF;
END;
$$  LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', org.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)

			
			|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)
			
			--|| kuntur.json_att_util('comment', org.comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('countryCode', org.country_code::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('primaryOrg', org.primary_org::VARCHAR, '', ', ' , true)
			--|| kuntur.json_att_util('codeOna', org.code_ona::VARCHAR, '', ', ' , true)
			--|| kuntur.json_att_util('codeGuarani', org.code_guarani::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"orgType":' ||  COALESCE(org_type.json, 'null') || ' '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org.id)  || '], '
			--|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org.id)  || '], '
			--|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_email_json_a x WHERE x.org_email_id = org.id)  || '], '
			--|| '"Org.orgEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_phone_json_a x WHERE x.org_phone_id = org.id)  || '], '
			--|| '"Org.orgPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_address_json_a x WHERE x.org_address_id = org.id)  || '], '
			--|| '"Org.orgAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.contactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_contact_json_a x WHERE x.contact_id = org.id)  || '], '
			--|| '"Org.contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.studentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_student_json_a x WHERE x.student_id = org.id)  || '], '
			--|| '"Org.studentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_json_a x WHERE x.agreement_id = org.id)  || '], '
			--|| '"Org.agreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_json_a x WHERE x.agreement_item_id = org.id)  || '], '
			--|| '"Org.agreementItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_ou_json_a x WHERE x.agreement_item_ou_id = org.id)  || '], '
			--|| '"Org.agreementItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.admissionPeriodItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_json_a x WHERE x.admission_period_item_id = org.id)  || '], '
			--|| '"Org.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.admissionPeriodItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_ou_json_a x WHERE x.admission_period_item_ou_id = org.id)  || '], '
			--|| '"Org.admissionPeriodItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = org.id)  || '], '
			--|| '"Org.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInStudyProgramList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_study_program_json_a x WHERE x.unc_in_study_program_id = org.id)  || '], '
			--|| '"Org.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = org.id)  || '], '
			--|| '"Org.uncInAcademicPerformanceList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicCoordinatorList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_coordinator_json_a x WHERE x.unc_in_academic_coordinator_id = org.id)  || '], '
			--|| '"Org.uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicOfficeList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_office_json_a x WHERE x.unc_in_academic_office_id = org.id)  || '], '
			--|| '"Org.uncInAcademicOfficeList":[]'

		|| '}' AS json, 
		org.id AS org_id /*id*/
		--org.erased AS org_erased /*erased*/,
		--org.short_name AS org_short_name /*Sigla*/,
		--org.name AS org_name /*Nombre*/,
		--org.original_name AS org_original_name /*Nombre en el idioma original*/,
		--org.url_photo AS org_url_photo /*Logo*/,
		--org.web_site AS org_web_site /*Sitio Web*/,
		--org.comment AS org_comment /*Comentario*/,
		--org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		--org.primary_org AS org_primary_org /*Institución Primaria del Sistema*/,
		--org.code_ona AS org_code_ona /*Código ONA*/,
		--org.code_guarani AS org_code_guarani /*Código Guarani*/,
	------------------------------------------
		--org.org_type_id /*Tipo de Unidad Organizativa*/

	FROM kuntur.org
	------------------------------------------
	LEFT JOIN kuntur.v_org_type_json_a org_type
		ON kuntur.org.org_type_id = org_type.org_type_id;
		
-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_status_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_status_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_status.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', enrrollment_status.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', enrrollment_status.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', enrrollment_status.name::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', enrrollment_status.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentStatus.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = enrrollment_status.id)  || '], '
			--|| '"EnrrollmentStatus.enrrollmentList":[]'

		|| '}' AS json, 
		enrrollment_status.id AS enrrollment_status_id /*id*/
		--enrrollment_status.erased AS enrrollment_status_erased /*erased*/,
		--enrrollment_status.code AS enrrollment_status_code /*Código*/,
		--enrrollment_status.name AS enrrollment_status_name /*Nombre*/,
		--enrrollment_status.comment AS enrrollment_status_comment /*Comentario*/

	FROM kuntur.enrrollment_status;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_student_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_student_json_a AS 

	SELECT '{'
			|| SUBSTRING(person.json FROM 2 FOR CHAR_LENGTH(person.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| kuntur.json_att_util('fileNumber', student.file_number::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('institutionOriginalName', student.institution_original_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionWebSite', student.institution_web_site::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionCountryCode', student.institution_country_code::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"org":' ||  COALESCE(org.json, 'null') || ' '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Student.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = student.id)  || '], '
			--|| '"Student.enrrollmentList":[]'

		|| '}' AS json, 
		student.id AS student_id /*id*/
		--student.erased AS student_erased /*erased*/,
		--student.file_number AS student_file_number /*N° de Estudiante*/,
		--student.institution_original_name AS student_institution_original_name /*Nombre en el idioma original*/,
		--student.institution_web_site AS student_institution_web_site /*Sitio Web*/,
		--student.institution_country_code AS student_institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
	------------------------------------------
		--student.org_id /*Institución Educativa*/

	FROM kuntur.student
	JOIN kuntur.v_person_json_a person
		ON kuntur.student.id = person.person_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json_a org
		ON kuntur.student.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS kuntur.v_admission_period_status_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_status_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', admission_period_status.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', admission_period_status.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', admission_period_status.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', admission_period_status.name::VARCHAR, '"', ' ' , true)
			--|| kuntur.json_att_util('comment', admission_period_status.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriodStatus.admissionPeriodList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_json_a x WHERE x.admission_period_id = admission_period_status.id)  || '], '
			--|| '"AdmissionPeriodStatus.admissionPeriodList":[]'

		|| '}' AS json,
		admission_period_status.id AS admission_period_status_id /*id*/
		--admission_period_status.erased AS admission_period_status_erased /*erased*/,
		--admission_period_status.code AS admission_period_status_code /*Código*/,
		--admission_period_status.name AS admission_period_status_name /*Nombre*/,
		--admission_period_status.comment AS admission_period_status_comment /*Comentario*/

	FROM kuntur.admission_period_status;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', admission_period.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', admission_period.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('numberAdmissionPeriod', admission_period.number_admission_period::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('inType', admission_period.in_type::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('year', admission_period.year::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('semester', admission_period.semester::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('title', admission_period.title::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('fromDate', admission_period.from_date::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('toDate', admission_period.to_date::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', admission_period.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"admissionPeriodStatus":' ||  COALESCE(admission_period_status.json, 'null') || ' '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.admissionPeriodAgreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_agreement_json_a x WHERE x.admission_period_agreement_id = admission_period.id)  || '], '
			--|| '"AdmissionPeriod.admissionPeriodAgreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.admissionPeriodItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_json_a x WHERE x.admission_period_item_id = admission_period.id)  || '], '
			--|| '"AdmissionPeriod.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = admission_period.id)  || '], '
			--|| '"AdmissionPeriod.enrrollmentList":[]'

		|| '}' AS json, 
		admission_period.id AS admission_period_id /*id*/
		--admission_period.erased AS admission_period_erased /*erased*/,
		--admission_period.number_admission_period AS admission_period_number_admission_period /*N°*/,
		--admission_period.in_type AS admission_period_in_type /*Tipo*/,
		--admission_period.year AS admission_period_year /*Año*/,
		--admission_period.semester AS admission_period_semester /*Semestre*/,
		--admission_period.title AS admission_period_title /*Título*/,
		--admission_period.from_date AS admission_period_from_date /*Fecha Inicio*/,
		--admission_period.to_date AS admission_period_to_date /*Fecha Fin*/,
		--admission_period.comment AS admission_period_comment /*Comentario*/,
	------------------------------------------
		--admission_period.admission_period_status_id /*Estado de Convocatoria*/

	FROM kuntur.admission_period
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_status_json_a admission_period_status
		ON kuntur.admission_period.admission_period_status_id = admission_period_status.admission_period_status_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_stakeholder_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_stakeholder_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_stakeholder.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', enrrollment_stakeholder.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', enrrollment_stakeholder.code::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"userSystem":' ||  COALESCE(user_system.json, 'null') || ' '
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentStakeholder.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_stakeholder.id AS enrrollment_stakeholder_id /*id*/,
		--enrrollment_stakeholder.erased AS enrrollment_stakeholder_erased /*erased*/,
		--enrrollment_stakeholder.code AS enrrollment_stakeholder_code /*Código de Tipo de Permiso (Relación)*/,
	------------------------------------------
		--enrrollment_stakeholder.user_system_id /*Usuario del Sistema*/,
	------------------------------------------
		enrrollment_stakeholder.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_stakeholder
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json_a user_system
		ON kuntur.enrrollment_stakeholder.user_system_id = user_system.user_system_id;
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_stakeholder.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_email_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_email_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_email.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', enrrollment_email.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('email', enrrollment_email.email::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment_email.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentEmail.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_email.id AS enrrollment_email_id /*id*/,
		--enrrollment_email.erased AS enrrollment_email_erased /*erased*/,
		--enrrollment_email.email AS enrrollment_email_email /*Correo Electrónico*/,
		--enrrollment_email.comment AS enrrollment_email_comment /*Comentario*/,
	------------------------------------------
		enrrollment_email.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_email;
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_email.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_phone_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_phone_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_phone.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment_phone.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('countryCode', enrrollment_phone.country_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('phoneNumber', enrrollment_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment_phone.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentPhone.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_phone.id AS enrrollment_phone_id /*id*/,
		--enrrollment_phone.erased AS enrrollment_phone_erased /*erased*/,
		--enrrollment_phone.country_code AS enrrollment_phone_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		--enrrollment_phone.phone_number AS enrrollment_phone_phone_number /*Número de Teléfono*/,
		--enrrollment_phone.comment AS enrrollment_phone_comment /*Comentario*/,
	------------------------------------------
		enrrollment_phone.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_phone;
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_phone.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_identity_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_identity_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_identity.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment_identity.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('identityNumber', enrrollment_identity.identity_number::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('code', enrrollment_identity.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', enrrollment_identity.name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('countryCode', enrrollment_identity.country_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment_identity.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentIdentity.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"personIdentityType":' ||  COALESCE(person_identity_type.json, 'null') || ' '

		|| '}' AS json, 
		--enrrollment_identity.id AS enrrollment_identity_id /*id*/,
		--enrrollment_identity.erased AS enrrollment_identity_erased /*erased*/,
		--enrrollment_identity.identity_number AS enrrollment_identity_identity_number /*Número de Identificación*/,
		--enrrollment_identity.code AS enrrollment_identity_code /*Código*/,
		--enrrollment_identity.name AS enrrollment_identity_name /*Nombre*/,
		--enrrollment_identity.country_code AS enrrollment_identity_country_code /*País - Código ISO 3166-1 Alfa-2 (País Emisor)*/,
		--enrrollment_identity.comment AS enrrollment_identity_comment /*Comentario*/,
	------------------------------------------
		enrrollment_identity.enrrollment_id /*Postulación*/
	------------------------------------------
		--enrrollment_identity.person_identity_type_id /*Tipo de Identificación de Persona Física*/

	FROM kuntur.enrrollment_identity
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_identity.enrrollment_id = enrrollment.enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_person_identity_type_json_a person_identity_type
		ON kuntur.enrrollment_identity.person_identity_type_id = person_identity_type.person_identity_type_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_nationality_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_nationality_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_nationality.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment_nationality.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('countryCode', enrrollment_nationality.country_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment_nationality.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentNationality.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_nationality.id AS enrrollment_nationality_id /*id*/,
		--enrrollment_nationality.erased AS enrrollment_nationality_erased /*erased*/,
		--enrrollment_nationality.country_code AS enrrollment_nationality_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		--enrrollment_nationality.comment AS enrrollment_nationality_comment /*Comentario*/,
	------------------------------------------
		enrrollment_nationality.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_nationality;
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_nationality.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_address_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_address_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_address.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment_address.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('countryCode', kuntur.json_att_util(enrrollment_address.country_code)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('adminAreaLevel1Code', enrrollment_address.admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('adminAreaLevel2', enrrollment_address.admin_area_level2::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('locality', kuntur.json_att_util(enrrollment_address.locality)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('neighbourhood', enrrollment_address.neighbourhood::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('street', enrrollment_address.street::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('streetNumber', enrrollment_address.street_number::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('buildingFloor', enrrollment_address.building_floor::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('buildingRoom', enrrollment_address.building_room::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('building', enrrollment_address.building::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('postalCode', kuntur.json_att_util(enrrollment_address.postal_code)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment_address.comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('lat', enrrollment_address.lat::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('lng', enrrollment_address.lng::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentAddress.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_address.id AS enrrollment_address_id /*id*/,
		--enrrollment_address.erased AS enrrollment_address_erased /*erased*/,
		--enrrollment_address.country_code AS enrrollment_address_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		--enrrollment_address.admin_area_level1_code AS enrrollment_address_admin_area_level1_code /*Provincia - Código ISO 3166-2*/,
		--enrrollment_address.admin_area_level2 AS enrrollment_address_admin_area_level2 /*Departamento / Distrito*/,
		--enrrollment_address.locality AS enrrollment_address_locality /*Localidad*/,
		--enrrollment_address.neighbourhood AS enrrollment_address_neighbourhood /*Vecindario*/,
		--enrrollment_address.street AS enrrollment_address_street /*Calle*/,
		--enrrollment_address.street_number AS enrrollment_address_street_number /*Número de Calle*/,
		--enrrollment_address.building_floor AS enrrollment_address_building_floor /*Planta del Edificio*/,
		--enrrollment_address.building_room AS enrrollment_address_building_room /*Departamento de Edificio*/,
		--enrrollment_address.building AS enrrollment_address_building /*Edificio*/,
		--enrrollment_address.postal_code AS enrrollment_address_postal_code /*Código Postal*/,
		--enrrollment_address.comment AS enrrollment_address_comment /*Comentario*/,
		--enrrollment_address.lat AS enrrollment_address_lat /*Latitud*/,
		--enrrollment_address.lng AS enrrollment_address_lng /*Longitud*/,
	------------------------------------------
		enrrollment_address.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_address;
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_address.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_log_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_log_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment_log.id::VARCHAR, '"', ', ', false)
			--|| kuntur.json_att_util('erased', enrrollment_log.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('codeStart', enrrollment_log.code_start::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('nameStart', enrrollment_log.name_start::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('codeEnd', enrrollment_log.code_end::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('nameEnd', enrrollment_log.name_end::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"userSystem":' ||  COALESCE(user_system.json, 'null') || ', '

		|| '}' AS json, 
		--enrrollment_log.id AS enrrollment_log_id /*id*/,
		--enrrollment_log.erased AS enrrollment_log_erased /*erased*/,
		--enrrollment_log.code_start AS enrrollment_log_code_start /*Código*/,
		--enrrollment_log.name_start AS enrrollment_log_name_start /*Nombre*/,
		--enrrollment_log.code_end AS enrrollment_log_code_end /*Código*/,
		--enrrollment_log.name_end AS enrrollment_log_name_end /*Nombre*/,
		--enrrollment_log.promotion_date AS enrrollment_log_promotion_date /*Fecha Promoción de Estado*/,
	------------------------------------------
		enrrollment_log.enrrollment_id /*Postulación*/
	------------------------------------------
		--enrrollment_log.user_system_id /*Usuario del Sistema*/

	FROM kuntur.enrrollment_log
	------------------------------------------
	--LEFT JOIN kuntur.v_enrrollment_json enrrollment
	--	ON kuntur.enrrollment_log.enrrollment_id = enrrollment.enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json_a user_system
		ON kuntur.enrrollment_log.user_system_id = user_system.user_system_id;

-------------------------------------------------------------------------------------------------------------------------



DROP VIEW IF EXISTS kuntur.v_enrrollment_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', enrrollment.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('givenName', enrrollment.given_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('middleName', enrrollment.middle_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('familyName', enrrollment.family_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthDate', enrrollment.birth_date::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('male', enrrollment.male::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('urlPhoto', enrrollment.url_photo::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment.comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthCountryCode', enrrollment.birth_country_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthAdminAreaLevel1Code', enrrollment.birth_admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthAdminAreaLevel2', enrrollment.birth_admin_area_level2::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthLocality', enrrollment.birth_locality::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthLat', enrrollment.birth_lat::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('birthLng', enrrollment.birth_lng::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('institutionOriginalName', enrrollment.institution_original_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionWebSite', kuntur.json_att_util(enrrollment.institution_web_site)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionCountryCode', enrrollment.institution_country_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('numberEnrrollment', enrrollment.number_enrrollment::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('checkOutDate', enrrollment.check_out_date::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"userSystem":' ||  COALESCE(user_system.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"student":' ||  COALESCE(student.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"admissionPeriod":' ||  COALESCE(admission_period.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentStatus":' ||  COALESCE(enrrollment_status.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentStakeholderList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_stakeholder_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_email_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentEmailList":[], '
			--------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_phone_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_identity_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentIdentityList":[], '
			--------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentNationalityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_nationality_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_address_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '], '
			--|| '"enrrollmentAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentLogList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_log_json_a x WHERE x.enrrollment_id = enrrollment.id)  || '] '
			--|| '"enrrollmentLogList":[]'

		|| '}' AS json, 
		enrrollment.id AS enrrollment_id /*id*/
		--enrrollment.erased AS enrrollment_erased /*erased*/,
		--enrrollment.given_name AS enrrollment_given_name /*Nombre de Pila*/,
		--enrrollment.middle_name AS enrrollment_middle_name /*Segundo Nombre*/,
		--enrrollment.family_name AS enrrollment_family_name /*Apellido*/,
		--enrrollment.birth_date AS enrrollment_birth_date /*Fecha de Nacimiento*/,
		--enrrollment.male AS enrrollment_male /*Masculino*/,
		--enrrollment.url_photo AS enrrollment_url_photo /*Foto*/,
		--enrrollment.comment AS enrrollment_comment /*Comentario*/,
		--enrrollment.birth_country_code AS enrrollment_birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		--enrrollment.birth_admin_area_level1_code AS enrrollment_birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		--enrrollment.birth_admin_area_level2 AS enrrollment_birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		--enrrollment.birth_locality AS enrrollment_birth_locality /*Localidad Nacimiento*/,
		--enrrollment.birth_lat AS enrrollment_birth_lat /*Latitud Nacimiento*/,
		--enrrollment.birth_lng AS enrrollment_birth_lng /*Longitud Nacimiento*/,
		--enrrollment.institution_original_name AS enrrollment_institution_original_name /*Nombre en el idioma original*/,
		--enrrollment.institution_web_site AS enrrollment_institution_web_site /*Sitio Web*/,
		--enrrollment.institution_country_code AS enrrollment_institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
		--enrrollment.number_enrrollment AS enrrollment_number_enrrollment /*N°*/,
		--enrrollment.check_out_date AS enrrollment_check_out_date /*Fecha Check Out*/,
	------------------------------------------
		--enrrollment.org_id /*Institución Educativa*/,
	------------------------------------------
		--enrrollment.user_system_id /*Usuario del Sistema*/,
	------------------------------------------
		--enrrollment.student_id /*Estudiante*/,
	------------------------------------------
		--enrrollment.admission_period_id /*Convocatoria (Periodo de Admisión)*/,
	------------------------------------------
		--enrrollment.enrrollment_status_id /*Estado de la Postulación*/

	FROM kuntur.enrrollment
	------------------------------------------
	LEFT JOIN kuntur.v_org_json_a org
		ON kuntur.enrrollment.org_id = org.org_id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json_a user_system
		ON kuntur.enrrollment.user_system_id = user_system.user_system_id
	------------------------------------------
	LEFT JOIN kuntur.v_student_json_a student
		ON kuntur.enrrollment.student_id = student.student_id
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json_a admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.admission_period_id
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_status_json_a enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.enrrollment_status_id;


-- SELECT * FROM kuntur.v_enrrollment_json_a LIMIT 1



-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_grading_scale_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_grading_scale_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', unc_in_grading_scale.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', unc_in_grading_scale.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('rateNumber', unc_in_grading_scale.rate_number::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('rateLetter', unc_in_grading_scale.rate_letter::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', unc_in_grading_scale.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInGradingScale.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = unc_in_grading_scale.id)  || '], '
			--|| '"uncInAcademicPerformanceList":[]'

		|| '}' AS json,
		unc_in_grading_scale.id AS unc_in_grading_scale_id /*id*/
		--unc_in_grading_scale.erased AS unc_in_grading_scale_erased /*erased*/,
		--unc_in_grading_scale.rate_number AS unc_in_grading_scale_rate_number /*Calificación Numérica*/,
		--unc_in_grading_scale.rate_letter AS unc_in_grading_scale_rate_letter /*Calificación con Letras*/,
		--unc_in_grading_scale.comment AS unc_in_grading_scale_comment /*Comentario*/

	FROM kuntur.unc_in_grading_scale;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_studied_type_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_studied_type_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', unc_in_studied_type.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', unc_in_studied_type.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('code', unc_in_studied_type.code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('name', unc_in_studied_type.name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', unc_in_studied_type.comment::VARCHAR, '"', ' ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInStudiedType.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = unc_in_studied_type.id)  || '], '
			--|| '"UncInStudiedType.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_studied_type.id AS unc_in_studied_type_id /*id*/
		--unc_in_studied_type.erased AS unc_in_studied_type_erased /*erased*/,
		--unc_in_studied_type.code AS unc_in_studied_type_code /*Código*/,
		--unc_in_studied_type.name AS unc_in_studied_type_name /*Nombre*/,
		--unc_in_studied_type.comment AS unc_in_studied_type_comment /*Comentario*/

	FROM kuntur.unc_in_studied_type;

-------------------------------------------------------------------------------------------------------------------------



DROP VIEW IF EXISTS kuntur.v_unc_in_academic_performance_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_performance_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('hs', unc_in_academic_performance.hs::VARCHAR, '', ',' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInAcademicPerformance.uncInEnrrollment":' ||  COALESCE(unc_in_enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"uncInGradingScale":' ||  COALESCE(unc_in_grading_scale.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"uncInStudiedType":' ||  COALESCE(unc_in_studied_type.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"org":' ||  COALESCE(org.json, 'null') || ' '

		|| '}' AS json, 
		--unc_in_academic_performance.id AS unc_in_academic_performance_id /*id*/,
		--unc_in_academic_performance.erased AS unc_in_academic_performance_erased /*erased*/,
		--unc_in_academic_performance.subject AS unc_in_academic_performance_subject /*Materia*/,
		--unc_in_academic_performance.hs AS unc_in_academic_performance_hs /*Horas*/,
	------------------------------------------
		unc_in_academic_performance.unc_in_enrrollment_id /*Postulación*/
	------------------------------------------
		--unc_in_academic_performance.unc_in_grading_scale_id /*Escala de Calificaciones*/,
	----------------------------------------
		--unc_in_academic_performance.unc_in_studied_type_id /*Tipo de cursado*/,
	------------------------------------------
		--unc_in_academic_performance.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_academic_performance
	------------------------------------------
	--LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
	--	ON kuntur.unc_in_academic_performance.unc_in_enrrollment_id = unc_in_enrrollment.unc_in_enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_grading_scale_json_a unc_in_grading_scale
		ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.unc_in_grading_scale_id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_studied_type_json_a unc_in_studied_type
		ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.unc_in_studied_type_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json_a org
		ON kuntur.unc_in_academic_performance.org_id = org.org_id;





-------------------------------------------------------------------------------------------------------------------------




DROP VIEW IF EXISTS kuntur.v_unc_in_study_program_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_study_program_json_a AS 

	SELECT '{'
			|| kuntur.json_att_util('id', unc_in_study_program.id::VARCHAR, '"', ', ', false)			
			|| kuntur.json_att_util('erased', unc_in_study_program.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('subject', unc_in_study_program.subject::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('approved', unc_in_study_program.approved::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('approvedBy', unc_in_study_program.approved_by::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('fileNumber', unc_in_study_program.file_number::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', unc_in_study_program.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInStudyProgram.uncInEnrrollment":' ||  COALESCE(unc_in_enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"org":' ||  COALESCE(org.json, 'null') || ' '
			-------------------------------------------------------------------------------------------------------------
			
			--|| '"uncInStudyProgramSubjectList":[]'

		|| '}' AS json, 
		--unc_in_study_program.id AS unc_in_study_program_id /*id*/,
		--unc_in_study_program.erased AS unc_in_study_program_erased /*erased*/,
		--unc_in_study_program.approved AS unc_in_study_program_approved /*Aprobado*/,
		--unc_in_study_program.approved_by AS unc_in_study_program_approved_by /*Aprobado por*/,
		--unc_in_study_program.file_number AS unc_in_study_program_file_number /*Legajo Guarani*/,
		--unc_in_study_program.comment AS unc_in_study_program_comment /*Comentario*/,
	------------------------------------------
		unc_in_study_program.unc_in_enrrollment_id /*Postulación*/
	------------------------------------------
		--unc_in_study_program.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_study_program
	------------------------------------------
	--LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
	--	ON kuntur.unc_in_study_program.unc_in_enrrollment_id = unc_in_enrrollment.unc_in_enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json_a org
		ON kuntur.unc_in_study_program.org_id = org.org_id;

 -- SELECT * FROM kuntur.v_unc_in_study_program_json_a x WHERE x.unc_in_enrrollment_id = '489090263ec1c856013ec1d1f0450003';	

-------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS kuntur.v_unc_in_enrrollment_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_enrrollment_json_a AS 

	SELECT '{'
			|| SUBSTRING(enrrollment.json FROM 2 FOR CHAR_LENGTH(enrrollment.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| kuntur.json_att_util('agreement', unc_in_enrrollment.agreement::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('program', unc_in_enrrollment.program::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('amountPaid', unc_in_enrrollment.amount_paid::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('originalDoc', unc_in_enrrollment.original_doc::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('insurance', unc_in_enrrollment.insurance::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('languageCertificate', unc_in_enrrollment.language_certificate::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('visa', unc_in_enrrollment.visa::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('emergencyContact', unc_in_enrrollment.emergency_contact::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('credentialCode', unc_in_enrrollment.credential_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlOrigininalTranscript', unc_in_enrrollment.url_origininal_transcript::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlPassport', unc_in_enrrollment.url_passport::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlLanguageCertificate', unc_in_enrrollment.url_language_certificate::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlCv', unc_in_enrrollment.url_cv::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlApplicationLetter', unc_in_enrrollment.url_application_letter::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlCertificatePsychophysical', unc_in_enrrollment.url_certificate_psychophysical::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlAdmissionAct', unc_in_enrrollment.url_admission_act::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlAdmissionActTemplate', unc_in_enrrollment.url_admission_act_template::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlTranscript', unc_in_enrrollment.url_transcript::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlTranscriptTemplate', unc_in_enrrollment.url_transcript_template::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlUniversityCredential', unc_in_enrrollment.url_university_credential::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlStudentReport', unc_in_enrrollment.url_student_report::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('urlExchangeForm', unc_in_enrrollment.url_exchange_form::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', unc_in_enrrollment.comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('observation', unc_in_enrrollment.observation::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('creation_date_postulation', unc_in_enrrollment.creation_date_postulation::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('agreementName', unc_in_enrrollment.agreement_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('agreementComment', unc_in_enrrollment.agreement_comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('agreementNumberStudents', unc_in_enrrollment.agreement_number_students::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('agreementOrg', unc_in_enrrollment.agreement_org::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('agreementOrgComment', unc_in_enrrollment.agreement_org_comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('agreementAcademicUnit', unc_in_enrrollment.agreement_academic_unit::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('exchangeProgramName', unc_in_enrrollment.exchange_program_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('exchangeProgramComment', unc_in_enrrollment.exchange_program_comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('exchangeProgramNumberStudents', unc_in_enrrollment.exchange_program_number_students::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('exchangeProgramInitialNumberStudents', unc_in_enrrollment.exchange_program_initial_number_students::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"uncInStudyProgramList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_study_program_json_a x WHERE x.unc_in_enrrollment_id = unc_in_enrrollment.id)  || '], '
			--|| '"UncInEnrrollment.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_enrrollment_id = unc_in_enrrollment.id)  || '] '
			--|| '"UncInEnrrollment.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_enrrollment.id AS unc_in_enrrollment_id /*id*/
		--unc_in_enrrollment.erased AS unc_in_enrrollment_erased /*erased*/,
		--unc_in_enrrollment.agreement AS unc_in_enrrollment_agreement /*Con Convenio*/,
		--unc_in_enrrollment.program AS unc_in_enrrollment_program /*Con Programa*/,
		--unc_in_enrrollment.amount_paid AS unc_in_enrrollment_amount_paid /*Tasa Pagada*/,
		--unc_in_enrrollment.original_doc AS unc_in_enrrollment_original_doc /*Documentación Original*/,
		--unc_in_enrrollment.insurance AS unc_in_enrrollment_insurance /*Seguro*/,
		--unc_in_enrrollment.language_certificate AS unc_in_enrrollment_language_certificate /*Certificado de Idioma*/,
		--unc_in_enrrollment.visa AS unc_in_enrrollment_visa /*Visa*/,
		--unc_in_enrrollment.emergency_contact AS unc_in_enrrollment_emergency_contact /*Contacto de Emergencia*/,
		--unc_in_enrrollment.credential_code AS unc_in_enrrollment_credential_code /*Código de Credencial*/,
		--unc_in_enrrollment.url_origininal_transcript AS unc_in_enrrollment_url_origininal_transcript /*Analítico Académico*/,
		--u-nc_in_enrrollment.url_passport AS unc_in_enrrollment_url_passport /*Pasaporte*/,
		--unc_in_enrrollment.url_language_certificate AS unc_in_enrrollment_url_language_certificate /*Certificado de Idioma*/,
		--unc_in_enrrollment.url_cv AS unc_in_enrrollment_url_cv /*Curriculumn Vitae*/,
		--unc_in_enrrollment.url_application_letter AS unc_in_enrrollment_url_application_letter /*Carta de Postulación*/,
		--unc_in_enrrollment.url_certificate_psychophysical AS unc_in_enrrollment_url_certificate_psychophysical /*Certificado Psicofísico*/,
		--unc_in_enrrollment.url_admission_act AS unc_in_enrrollment_url_admission_act /*Acta de Admisión*/,
		--unc_in_enrrollment.url_admission_act_template AS unc_in_enrrollment_url_admission_act_template /*Template Acta de Admisión*/,
		--unc_in_enrrollment.url_transcript AS unc_in_enrrollment_url_transcript /*Certificado Analítico*/,
		--unc_in_enrrollment.url_transcript_template AS unc_in_enrrollment_url_transcript_template /*Template de Certificado Analítico*/,
		--unc_in_enrrollment.url_university_credential AS unc_in_enrrollment_url_university_credential /*Credencial Universitaria*/,
		--unc_in_enrrollment.url_student_report AS unc_in_enrrollment_url_student_report /*Reporte del Estudiante*/,
		--unc_in_enrrollment.url_exchange_form AS unc_in_enrrollment_url_exchange_form /*Formulario de Intercambio*/,
		--unc_in_enrrollment.comment AS unc_in_enrrollment_comment /*Comentario*/,
		--unc_in_enrrollment.observation AS unc_in_enrrollment_observation /*Observaciones*/,
		--unc_in_enrrollment.creation_date_postulation AS unc_in_enrrollment_creation_date_postulation /*Observaciones*/,
		--unc_in_enrrollment.agreement_name AS unc_in_enrrollment_agreement_name /*Nombre del Acuerdo*/,
		--unc_in_enrrollment.agreement_comment AS unc_in_enrrollment_agreement_comment /*Comentario del Acuerdo*/,
		--unc_in_enrrollment.agreement_number_students AS unc_in_enrrollment_agreement_number_students /*Cant. Estudiantes del Acuerdo*/,
		--unc_in_enrrollment.agreement_org AS unc_in_enrrollment_agreement_org /*Institución del Acuerdo*/,
		--unc_in_enrrollment.agreement_org_comment AS unc_in_enrrollment_agreement_org_comment /*Comentario Institución del Acuerdo*/,
		--unc_in_enrrollment.agreement_academic_unit AS unc_in_enrrollment_agreement_academic_unit /*Unidad Académica del Acuerdo*/,
		--unc_in_enrrollment.exchange_program_name AS unc_in_enrrollment_exchange_program_name /*Nombre del Programa*/,
		--unc_in_enrrollment.exchange_program_comment AS unc_in_enrrollment_exchange_program_comment /*Comentario del Programa*/,
		--unc_in_enrrollment.exchange_program_number_students AS unc_in_enrrollment_exchange_program_number_students /*Cant. Estudiantes del Programa*/,
		--unc_in_enrrollment.exchange_program_initial_number_students AS unc_in_enrrollment_exchange_program_initial_number_students /*Cant. Inicial Estudiantes del Programa*/

	FROM kuntur.unc_in_enrrollment	
	JOIN kuntur.v_enrrollment_json_a enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.enrrollment_id;
	--WHERE unc_in_enrrollment.id = '489090263ec1c856013ec1d1f0450003';	

-- SELECT * FROM kuntur.v_enrrollment_json_a enrrollment
-- SELECT * FROM kuntur.v_unc_in_enrrollment_json_a;	

-------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.gui_type(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.gui_type(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$
	
		SELECT 	--s.code AS status_code, 
			--es.code AS stakeholder_code,
			CASE 	
			
				WHEN  s.code = 'A' AND es.code = '2' THEN '1A'
				WHEN  s.code = 'A' AND es.code = '3' THEN '0'

				--WHEN  s.code = 'B' AND es.code = '3' THEN '2B'
				WHEN  s.code = 'B' AND es.code = '3' THEN '0'

				WHEN  s.code = 'C' AND es.code = '2' THEN '3C'
				WHEN  s.code = 'C' AND es.code = '3' THEN '0'

				WHEN  s.code = 'D' AND es.code = '2' THEN '4D'
				WHEN  s.code = 'D' AND es.code = '3' THEN '0'

				WHEN  s.code = 'E' AND es.code = '2' THEN '5E'
				WHEN  s.code = 'E' AND es.code = '3' THEN '0'

				--WHEN  s.code = 'F' AND es.code = '3' THEN '6F'
				WHEN  s.code = 'F' AND es.code = '3' THEN '0'

				WHEN  s.code = 'G' AND es.code = '2' THEN '7G'
				WHEN  s.code = 'G' AND es.code = '3' THEN '0'

				WHEN  s.code = 'H' AND es.code = '2' THEN '8H'
				WHEN  s.code = 'H' AND es.code = '3' THEN '0'

				--WHEN  s.code = 'I' AND es.code = '3' THEN '9I'
				WHEN  s.code = 'I' AND es.code = '3' THEN '0'

				WHEN  s.code = 'J' AND es.code = '2' THEN '10J'
				WHEN  s.code = 'J' AND es.code = '3' THEN '0'

				--WHEN  s.code = 'K' AND es.code = '2' THEN '11K'
				WHEN  s.code = 'K' AND es.code = '3' THEN '-1'

				-- WHEN  s.code = 'Z' AND es.code = '2' THEN '12Z'
				WHEN  s.code = 'Z' AND es.code = '3' THEN '-1'

				ELSE '-1'
				
			END AS gui_type	

		FROM	kuntur.enrrollment_stakeholder es
		JOIN	kuntur.enrrollment e
			ON e.id = es.enrrollment_id
		JOIN	kuntur.enrrollment_status s
			ON s.id = e.enrrollment_status_id	
		WHERE	es.enrrollment_id = $1	
			AND es.user_system_id = $2
		--WHERE	es.enrrollment_id = '000000003f337709013f33cac635000e'
			--AND es.user_system_id = '4900a83e-af5f-49c8-9cc8-ca31f739691d'
			-- AND es.user_system_id = '4d47d7df-b6aa-48ce-9075-918d10a9da99'
			-- AND es.user_system_id = 'f6da808d-f231-4f0f-b068-ee65efedd337'
			-- AND es.user_system_id = '8af11fc2-2be1-4882-939f-e8d56703f8ae'
			-- AND es.user_system_id = '9431f54e-654a-46a7-82f1-7be9fc9b6f6e'
			-- AND es.user_system_id = '4e6a13cf-106c-4400-af44-99ff50b7ee1e'
			-- AND es.user_system_id = '187c2999-2533-4ca2-9d58-6f9aa366f281'
			-- AND es.user_system_id = '82be2216-2761-4746-94f8-82965a8ffea5'
			-- AND es.user_system_id = '8990c66d-9b70-4736-bff6-6f653582016c'
		--ORDER BY es.code

			
		;
$$ LANGUAGE SQL;

-------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$
	
		SELECT 	('{ ' || '"guiView":' || kuntur.gui_type($1, $2) || ', ' || '"data":' ||  COALESCE(e.json, 'null') || '} ') AS json
		FROM 	kuntur.v_unc_in_enrrollment_json_a e
		WHERE 	$1 IS NOT NULL 
			AND CHAR_LENGTH(TRIM($1)) > 0 
			AND TRIM($1) = e.unc_in_enrrollment_id
			
			AND TRIM($2)::VARCHAR IN (

				SELECT 	x.user_system_id::VARCHAR
				FROM 	kuntur.enrrollment_stakeholder x 
				WHERE 	x.user_system_id = $2::VARCHAR --(SELECT id FROM kuntur.user_system WHERE name = '46385')--
					AND x.enrrollment_id = e.unc_in_enrrollment_id --(SELECT id FROM kuntur.enrrollment WHERE number_enrrollment = 272)--
					AND (x.code = 1 OR x.code = 2 OR x.code = 3)	

			)
			
		;
$$ LANGUAGE SQL;



-- SELECT id FROM kuntur.user_system WHERE name = '46385'

-- SELECT  * FROM kuntur.f_find_enrrollment_by_id ((SELECT x.id FROM kuntur.enrrollment x LIMIT 1), (SELECT id FROM kuntur.user_system WHERE name = '46385'));

-- SELECT  * FROM kuntur.f_find_enrrollment_by_id ( '489090263a0d8ad7013a128696ef0067', '82be2216-2761-4746-94f8-82965a8ffea5');

/*

COPY (SELECT json FROM kuntur.v_unc_in_enrrollment_json_a) TO '/home/java/Descargas/json.sql';

*/

COPY (SELECT  * FROM kuntur.f_find_enrrollment_by_id ((SELECT x.id FROM kuntur.enrrollment x LIMIT 1), (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';
	

