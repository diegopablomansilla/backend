-- DROP FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) CASCADE;

SET search_path to kuntur;

CREATE OR REPLACE FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) RETURNS VARCHAR AS $$
	BEGIN
		IF coalescef = true THEN
			RETURN '"' || att_name || '":' || COALESCE(att_cd || att_val|| att_cd, 'null') 	|| att_end;
		ELSE
			RETURN '"' || att_name || '":' || att_cd || att_val|| att_cd			 || att_end;
	END IF;
END;
$$  LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_json AS 

	SELECT '{'
			|| json_att_util('Person.id', person.id::VARCHAR, '"', ', ', false)
			|| json_att_util('Person.erased', person.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('Person.givenName', person.given_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.middleName', person.middle_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.familyName', person.family_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthDate', person.birth_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.male', person.male::VARCHAR, '', ', ' , true)
			|| json_att_util('Person.urlPhoto', person.url_photo::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.comment', person.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthCountryCode', person.birth_country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthAdminAreaLevel1Code', person.birth_admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthAdminAreaLevel2', person.birth_admin_area_level2::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthLocality', person.birth_locality::VARCHAR, '"', ', ' , true)
			|| json_att_util('Person.birthLat', person.birth_lat::VARCHAR, '', ', ' , true)
			|| json_att_util('Person.birthLng', person.birth_lng::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_email_json_a x WHERE x.person_email_id = person.id)  || '], '
			|| '"Person.personEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_phone_json_a x WHERE x.person_phone_id = person.id)  || '], '
			|| '"Person.personPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_identity_json_a x WHERE x.person_identity_id = person.id)  || '], '
			|| '"Person.personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personNationalityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_nationality_json_a x WHERE x.person_nationality_id = person.id)  || '], '
			|| '"Person.personNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.personAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_address_json_a x WHERE x.person_address_id = person.id)  || '], '
			|| '"Person.personAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.contactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_contact_json_a x WHERE x.contact_id = person.id)  || '], '
			|| '"Person.contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.uncInAcademicCoordinatorList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_coordinator_json_a x WHERE x.unc_in_academic_coordinator_id = person.id)  || '], '
			|| '"Person.uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Person.uncInAcademicOfficeList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_office_json_a x WHERE x.unc_in_academic_office_id = person.id)  || '], '
			|| '"Person.uncInAcademicOfficeList":[]'

		|| '}' AS json, 
		person.id AS person_id /*id*/,
		person.erased AS person_erased /*erased*/,
		person.given_name AS person_given_name /*Nombre de Pila*/,
		person.middle_name AS person_middle_name /*Segundo Nombre*/,
		person.family_name AS person_family_name /*Apellido*/,
		person.birth_date AS person_birth_date /*Fecha de Nacimiento*/,
		person.male AS person_male /*Masculino*/,
		person.url_photo AS person_url_photo /*Foto*/,
		person.comment AS person_comment /*Comentario*/,
		person.birth_country_code AS person_birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		person.birth_admin_area_level1_code AS person_birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		person.birth_admin_area_level2 AS person_birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		person.birth_locality AS person_birth_locality /*Localidad Nacimiento*/,
		person.birth_lat AS person_birth_lat /*Latitud Nacimiento*/,
		person.birth_lng AS person_birth_lng /*Longitud Nacimiento*/

	FROM kuntur.person;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_email_json AS 

	SELECT '{'
			|| json_att_util('PersonEmail.id', person_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonEmail.erased', person_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonEmail.email', person_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonEmail.comment', person_email.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonEmail.person":' ||  COALESCE(person.json, 'null') || ', '

		|| '}' AS json, 
		person_email.id AS person_email_id /*id*/,
		person_email.erased AS person_email_erased /*erased*/,
		person_email.email AS person_email_email /*Correo Electrónico*/,
		person_email.comment AS person_email_comment /*Comentario*/,
	------------------------------------------
		person_email.person_id /*Persona Física*/

	FROM kuntur.person_email
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_email.person_id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_phone_json AS 

	SELECT '{'
			|| json_att_util('PersonPhone.id', person_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonPhone.erased', person_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonPhone.countryCode', person_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonPhone.phoneNumber', person_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonPhone.comment', person_phone.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonPhone.person":' ||  COALESCE(person.json, 'null') || ', '

		|| '}' AS json, 
		person_phone.id AS person_phone_id /*id*/,
		person_phone.erased AS person_phone_erased /*erased*/,
		person_phone.country_code AS person_phone_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		person_phone.phone_number AS person_phone_phone_number /*Número de Teléfono*/,
		person_phone.comment AS person_phone_comment /*Comentario*/,
	------------------------------------------
		person_phone.person_id /*Persona Física*/

	FROM kuntur.person_phone
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_phone.person_id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_identity_type_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_identity_type_json AS 

	SELECT '{'
			|| json_att_util('PersonIdentityType.id', person_identity_type.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonIdentityType.erased', person_identity_type.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonIdentityType.code', person_identity_type.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentityType.name', person_identity_type.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentityType.countryCode', person_identity_type.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentityType.comment', person_identity_type.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"PersonIdentityType.personIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_identity_json_a x WHERE x.person_identity_id = person_identity_type.id)  || '], '
			|| '"PersonIdentityType.personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"PersonIdentityType.enrrollmentIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_identity_json_a x WHERE x.enrrollment_identity_id = person_identity_type.id)  || '], '
			|| '"PersonIdentityType.enrrollmentIdentityList":[]'

		|| '}' AS json, 
		person_identity_type.id AS person_identity_type_id /*id*/,
		person_identity_type.erased AS person_identity_type_erased /*erased*/,
		person_identity_type.code AS person_identity_type_code /*Código*/,
		person_identity_type.name AS person_identity_type_name /*Nombre*/,
		person_identity_type.country_code AS person_identity_type_country_code /*País - Código ISO 3166-1 Alfa-2 (País Emisor)*/,
		person_identity_type.comment AS person_identity_type_comment /*Comentario*/

	FROM kuntur.person_identity_type;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_identity_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_identity_json AS 

	SELECT '{'
			|| json_att_util('PersonIdentity.id', person_identity.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonIdentity.erased', person_identity.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonIdentity.identityNumber', person_identity.identity_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentity.code', person_identity.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentity.name', person_identity.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentity.countryCode', person_identity.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonIdentity.comment', person_identity.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonIdentity.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonIdentity.personIdentityType":' ||  COALESCE(person_identity_type.json, 'null') || ', '

		|| '}' AS json, 
		person_identity.id AS person_identity_id /*id*/,
		person_identity.erased AS person_identity_erased /*erased*/,
		person_identity.identity_number AS person_identity_identity_number /*Número de Identificación*/,
		person_identity.code AS person_identity_code /*Código*/,
		person_identity.name AS person_identity_name /*Nombre*/,
		person_identity.country_code AS person_identity_country_code /*País - Código ISO 3166-1 Alfa-2 (País Emisor)*/,
		person_identity.comment AS person_identity_comment /*Comentario*/,
	------------------------------------------
		person_identity.person_id /*Persona Física*/,
	------------------------------------------
		person_identity.person_identity_type_id /*Tipo de Identificación de Persona Física*/

	FROM kuntur.person_identity
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_identity.person_id = person.person_id
	------------------------------------------
	LEFT JOIN kuntur.v_person_identity_type_json person_identity_type
		ON kuntur.person_identity.person_identity_type_id = person_identity_type.person_identity_type_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_nationality_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_nationality_json AS 

	SELECT '{'
			|| json_att_util('PersonNationality.id', person_nationality.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonNationality.erased', person_nationality.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonNationality.countryCode', person_nationality.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonNationality.comment', person_nationality.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonNationality.person":' ||  COALESCE(person.json, 'null') || ', '

		|| '}' AS json, 
		person_nationality.id AS person_nationality_id /*id*/,
		person_nationality.erased AS person_nationality_erased /*erased*/,
		person_nationality.country_code AS person_nationality_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		person_nationality.comment AS person_nationality_comment /*Comentario*/,
	------------------------------------------
		person_nationality.person_id /*Persona Física*/

	FROM kuntur.person_nationality
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_nationality.person_id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_address_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_address_json AS 

	SELECT '{'
			|| json_att_util('PersonAddress.id', person_address.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonAddress.erased', person_address.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonAddress.countryCode', person_address.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.adminAreaLevel1Code', person_address.admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.adminAreaLevel2', person_address.admin_area_level2::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.locality', person_address.locality::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.neighbourhood', person_address.neighbourhood::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.street', person_address.street::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.streetNumber', person_address.street_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.buildingFloor', person_address.building_floor::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.buildingRoom', person_address.building_room::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.building', person_address.building::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.postalCode', person_address.postal_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.comment', person_address.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonAddress.lat', person_address.lat::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonAddress.lng', person_address.lng::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonAddress.person":' ||  COALESCE(person.json, 'null') || ', '

		|| '}' AS json, 
		person_address.id AS person_address_id /*id*/,
		person_address.erased AS person_address_erased /*erased*/,
		person_address.country_code AS person_address_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		person_address.admin_area_level1_code AS person_address_admin_area_level1_code /*Provincia - Código ISO 3166-2*/,
		person_address.admin_area_level2 AS person_address_admin_area_level2 /*Departamento / Distrito*/,
		person_address.locality AS person_address_locality /*Localidad*/,
		person_address.neighbourhood AS person_address_neighbourhood /*Vecindario*/,
		person_address.street AS person_address_street /*Calle*/,
		person_address.street_number AS person_address_street_number /*Número de Calle*/,
		person_address.building_floor AS person_address_building_floor /*Planta del Edificio*/,
		person_address.building_room AS person_address_building_room /*Departamento de Edificio*/,
		person_address.building AS person_address_building /*Edificio*/,
		person_address.postal_code AS person_address_postal_code /*Código Postal*/,
		person_address.comment AS person_address_comment /*Comentario*/,
		person_address.lat AS person_address_lat /*Latitud*/,
		person_address.lng AS person_address_lng /*Longitud*/,
	------------------------------------------
		person_address.person_id /*Persona Física*/

	FROM kuntur.person_address
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_address.person_id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_user_system_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_user_system_json AS 

	SELECT '{'
			|| SUBSTRING(person.json FROM 2 FOR CHAR_LENGTH(person.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| json_att_util('UserSystem.name', user_system.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('UserSystem.pass', user_system.pass::VARCHAR, '"', ', ' , true)
			|| json_att_util('UserSystem.email', user_system.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('UserSystem.comment', user_system.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = user_system.id)  || '], '
			|| '"UserSystem.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentStakeholderList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_stakeholder_json_a x WHERE x.enrrollment_stakeholder_id = user_system.id)  || '], '
			|| '"UserSystem.enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UserSystem.enrrollmentLogList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_log_json_a x WHERE x.enrrollment_log_id = user_system.id)  || '], '
			|| '"UserSystem.enrrollmentLogList":[]'

		|| '}' AS json, 
		user_system.id AS user_system_id /*id*/,
		user_system.erased AS user_system_erased /*erased*/,
		user_system.name AS user_system_name /*nombre*/,
		user_system.pass AS user_system_pass /*Contraseña*/,
		user_system.email AS user_system_email /*Correo Electrónico*/,
		user_system.comment AS user_system_comment /*Comentario*/

	FROM kuntur.user_system
	JOIN kuntur.v_person_json person
		ON kuntur.user_system.id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_type_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_type_json AS 

	SELECT '{'
			|| json_att_util('OrgType.id', org_type.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgType.erased', org_type.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgType.code', org_type.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgType.name', org_type.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgType.comment', org_type.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"OrgType.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org_type.id)  || '], '
			|| '"OrgType.orgList":[]'

		|| '}' AS json, 
		org_type.id AS org_type_id /*id*/,
		org_type.erased AS org_type_erased /*erased*/,
		org_type.code AS org_type_code /*Código*/,
		org_type.name AS org_type_name /*Nombre*/,
		org_type.comment AS org_type_comment /*Comentario*/

	FROM kuntur.org_type;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_json AS 

	SELECT '{'
			|| json_att_util('Org.id', org.id::VARCHAR, '"', ', ', false)
			|| json_att_util('Org.erased', org.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('Org.shortName', org.short_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.name', org.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.originalName', org.original_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.webSite', org.web_site::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.comment', org.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.countryCode', org.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Org.primaryOrg', org.primary_org::VARCHAR, '', ', ' , true)
			|| json_att_util('Org.codeOna', org.code_ona::VARCHAR, '', ', ' , true)
			|| json_att_util('Org.codeGuarani', org.code_guarani::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.orgType":' ||  COALESCE(org_type.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org.id)  || '], '
			|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_json_a x WHERE x.org_id = org.id)  || '], '
			|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_email_json_a x WHERE x.org_email_id = org.id)  || '], '
			|| '"Org.orgEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_phone_json_a x WHERE x.org_phone_id = org.id)  || '], '
			|| '"Org.orgPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.orgAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_org_address_json_a x WHERE x.org_address_id = org.id)  || '], '
			|| '"Org.orgAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.contactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_contact_json_a x WHERE x.contact_id = org.id)  || '], '
			|| '"Org.contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.studentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_student_json_a x WHERE x.student_id = org.id)  || '], '
			|| '"Org.studentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_json_a x WHERE x.agreement_id = org.id)  || '], '
			|| '"Org.agreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_json_a x WHERE x.agreement_item_id = org.id)  || '], '
			|| '"Org.agreementItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.agreementItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_ou_json_a x WHERE x.agreement_item_ou_id = org.id)  || '], '
			|| '"Org.agreementItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.admissionPeriodItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_json_a x WHERE x.admission_period_item_id = org.id)  || '], '
			|| '"Org.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.admissionPeriodItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_ou_json_a x WHERE x.admission_period_item_ou_id = org.id)  || '], '
			|| '"Org.admissionPeriodItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = org.id)  || '], '
			|| '"Org.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInStudyProgramList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_study_program_json_a x WHERE x.unc_in_study_program_id = org.id)  || '], '
			|| '"Org.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = org.id)  || '], '
			|| '"Org.uncInAcademicPerformanceList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicCoordinatorList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_coordinator_json_a x WHERE x.unc_in_academic_coordinator_id = org.id)  || '], '
			|| '"Org.uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Org.uncInAcademicOfficeList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_office_json_a x WHERE x.unc_in_academic_office_id = org.id)  || '], '
			|| '"Org.uncInAcademicOfficeList":[]'

		|| '}' AS json, 
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
		org.org_type_id /*Tipo de Unidad Organizativa*/

	FROM kuntur.org
	------------------------------------------
	LEFT JOIN kuntur.v_org_type_json org_type
		ON kuntur.org.org_type_id = org_type.org_type_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_email_json AS 

	SELECT '{'
			|| json_att_util('OrgEmail.id', org_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgEmail.erased', org_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgEmail.email', org_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgEmail.comment', org_email.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgEmail.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		org_email.id AS org_email_id /*id*/,
		org_email.erased AS org_email_erased /*erased*/,
		org_email.email AS org_email_email /*Correo Electrónico*/,
		org_email.comment AS org_email_comment /*Comentario*/,
	------------------------------------------
		org_email.org_id /*Institución Educativa*/

	FROM kuntur.org_email
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_email.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_phone_json AS 

	SELECT '{'
			|| json_att_util('OrgPhone.id', org_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgPhone.erased', org_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgPhone.countryCode', org_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgPhone.phoneNumber', org_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgPhone.comment', org_phone.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgPhone.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		org_phone.id AS org_phone_id /*id*/,
		org_phone.erased AS org_phone_erased /*erased*/,
		org_phone.country_code AS org_phone_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org_phone.phone_number AS org_phone_phone_number /*Número de Teléfono*/,
		org_phone.comment AS org_phone_comment /*Comentario*/,
	------------------------------------------
		org_phone.org_id /*Institución Educativa*/

	FROM kuntur.org_phone
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_phone.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_address_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_address_json AS 

	SELECT '{'
			|| json_att_util('OrgAddress.id', org_address.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgAddress.erased', org_address.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgAddress.countryCode', org_address.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.adminAreaLevel1Code', org_address.admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.adminAreaLevel2', org_address.admin_area_level2::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.locality', org_address.locality::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.neighbourhood', org_address.neighbourhood::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.street', org_address.street::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.streetNumber', org_address.street_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.buildingFloor', org_address.building_floor::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.buildingRoom', org_address.building_room::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.building', org_address.building::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.postalCode', org_address.postal_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.comment', org_address.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgAddress.lat', org_address.lat::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgAddress.lng', org_address.lng::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgAddress.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		org_address.id AS org_address_id /*id*/,
		org_address.erased AS org_address_erased /*erased*/,
		org_address.country_code AS org_address_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org_address.admin_area_level1_code AS org_address_admin_area_level1_code /*Provincia - Código ISO 3166-2*/,
		org_address.admin_area_level2 AS org_address_admin_area_level2 /*Departamento / Distrito*/,
		org_address.locality AS org_address_locality /*Localidad*/,
		org_address.neighbourhood AS org_address_neighbourhood /*Vecindario*/,
		org_address.street AS org_address_street /*Calle*/,
		org_address.street_number AS org_address_street_number /*Número de Calle*/,
		org_address.building_floor AS org_address_building_floor /*Planta del Edificio*/,
		org_address.building_room AS org_address_building_room /*Departamento de Edificio*/,
		org_address.building AS org_address_building /*Edificio*/,
		org_address.postal_code AS org_address_postal_code /*Código Postal*/,
		org_address.comment AS org_address_comment /*Comentario*/,
		org_address.lat AS org_address_lat /*Latitud*/,
		org_address.lng AS org_address_lng /*Longitud*/,
	------------------------------------------
		org_address.org_id /*Institución Educativa*/

	FROM kuntur.org_address
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_address.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_contact_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_contact_json AS 

	SELECT '{'
			|| json_att_util('Contact.id', contact.id::VARCHAR, '"', ', ', false)
			|| json_att_util('Contact.erased', contact.erased::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"Contact.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Contact.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Contact.agreementContactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_contact_json_a x WHERE x.agreement_contact_id = contact.id)  || '], '
			|| '"Contact.agreementContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Contact.admissionPeriodContactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_contact_json_a x WHERE x.admission_period_contact_id = contact.id)  || '], '
			|| '"Contact.admissionPeriodContactList":[]'

		|| '}' AS json, 
		contact.id AS contact_id /*id*/,
		contact.erased AS contact_erased /*erased*/,
	------------------------------------------
		contact.org_id /*Institución Educativa*/,
	------------------------------------------
		contact.person_id /*Persona Física*/

	FROM kuntur.contact
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.contact.org_id = org.org_id
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.contact.person_id = person.person_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_student_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_student_json AS 

	SELECT '{'
			|| SUBSTRING(person.json FROM 2 FOR CHAR_LENGTH(person.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| json_att_util('Student.fileNumber', student.file_number::VARCHAR, '', ', ' , true)
			|| json_att_util('Student.institutionOriginalName', student.institution_original_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Student.institutionWebSite', student.institution_web_site::VARCHAR, '"', ', ' , true)
			|| json_att_util('Student.institutionCountryCode', student.institution_country_code::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"Student.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Student.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = student.id)  || '], '
			|| '"Student.enrrollmentList":[]'

		|| '}' AS json, 
		student.id AS student_id /*id*/,
		student.erased AS student_erased /*erased*/,
		student.file_number AS student_file_number /*N° de Estudiante*/,
		student.institution_original_name AS student_institution_original_name /*Nombre en el idioma original*/,
		student.institution_web_site AS student_institution_web_site /*Sitio Web*/,
		student.institution_country_code AS student_institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
	------------------------------------------
		student.org_id /*Institución Educativa*/

	FROM kuntur.student
	JOIN kuntur.v_person_json person
		ON kuntur.student.id = person.person_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.student.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_type_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_type_json AS 

	SELECT '{'
			|| json_att_util('AgreementType.id', agreement_type.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementType.erased', agreement_type.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementType.code', agreement_type.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('AgreementType.name', agreement_type.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('AgreementType.comment', agreement_type.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"AgreementType.agreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_json_a x WHERE x.agreement_id = agreement_type.id)  || '], '
			|| '"AgreementType.agreementList":[]'

		|| '}' AS json, 
		agreement_type.id AS agreement_type_id /*id*/,
		agreement_type.erased AS agreement_type_erased /*erased*/,
		agreement_type.code AS agreement_type_code /*Código*/,
		agreement_type.name AS agreement_type_name /*Nombre*/,
		agreement_type.comment AS agreement_type_comment /*Comentario*/

	FROM kuntur.agreement_type;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_status_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_status_json AS 

	SELECT '{'
			|| json_att_util('AgreementStatus.id', agreement_status.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementStatus.erased', agreement_status.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementStatus.code', agreement_status.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('AgreementStatus.name', agreement_status.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('AgreementStatus.comment', agreement_status.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"AgreementStatus.agreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_json_a x WHERE x.agreement_id = agreement_status.id)  || '], '
			|| '"AgreementStatus.agreementList":[]'

		|| '}' AS json, 
		agreement_status.id AS agreement_status_id /*id*/,
		agreement_status.erased AS agreement_status_erased /*erased*/,
		agreement_status.code AS agreement_status_code /*Código*/,
		agreement_status.name AS agreement_status_name /*Nombre*/,
		agreement_status.comment AS agreement_status_comment /*Comentario*/

	FROM kuntur.agreement_status;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_json AS 

	SELECT '{'
			|| json_att_util('Agreement.id', agreement.id::VARCHAR, '"', ', ', false)
			|| json_att_util('Agreement.erased', agreement.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('Agreement.numberAgreement', agreement.number_agreement::VARCHAR, '', ', ' , true)
			|| json_att_util('Agreement.title', agreement.title::VARCHAR, '"', ', ' , true)
			|| json_att_util('Agreement.fromDate', agreement.from_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('Agreement.toDate', agreement.to_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('Agreement.comment', agreement.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"Agreement.agreementType":' ||  COALESCE(agreement_type.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Agreement.agreementStatus":' ||  COALESCE(agreement_status.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Agreement.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Agreement.agreementItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_json_a x WHERE x.agreement_item_id = agreement.id)  || '], '
			|| '"Agreement.agreementItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Agreement.admissionPeriodAgreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_agreement_json_a x WHERE x.admission_period_agreement_id = agreement.id)  || '], '
			|| '"Agreement.admissionPeriodAgreementList":[]'

		|| '}' AS json, 
		agreement.id AS agreement_id /*id*/,
		agreement.erased AS agreement_erased /*erased*/,
		agreement.number_agreement AS agreement_number_agreement /*N°*/,
		agreement.title AS agreement_title /*Título*/,
		agreement.from_date AS agreement_from_date /*Fecha Inicio*/,
		agreement.to_date AS agreement_to_date /*Fecha Fin*/,
		agreement.comment AS agreement_comment /*Comentario*/,
	------------------------------------------
		agreement.agreement_type_id /*Tipo de Convenio*/,
	------------------------------------------
		agreement.agreement_status_id /*Estado de Convenio*/,
	------------------------------------------
		agreement.org_id /*Institución Educativa*/

	FROM kuntur.agreement
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_type_json agreement_type
		ON kuntur.agreement.agreement_type_id = agreement_type.agreement_type_id
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_status_json agreement_status
		ON kuntur.agreement.agreement_status_id = agreement_status.agreement_status_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_item_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_item_json AS 

	SELECT '{'
			|| json_att_util('AgreementItem.id', agreement_item.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementItem.erased', agreement_item.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItem.inUnits', agreement_item.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItem.outUnits', agreement_item.out_units::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItem.agreement":' ||  COALESCE(agreement.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItem.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AgreementItem.agreementContactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_contact_json_a x WHERE x.agreement_contact_id = agreement_item.id)  || '], '
			|| '"AgreementItem.agreementContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AgreementItem.agreementItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_agreement_item_ou_json_a x WHERE x.agreement_item_ou_id = agreement_item.id)  || '], '
			|| '"AgreementItem.agreementItemOuList":[]'

		|| '}' AS json, 
		agreement_item.id AS agreement_item_id /*id*/,
		agreement_item.erased AS agreement_item_erased /*erased*/,
		agreement_item.in_units AS agreement_item_in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		agreement_item.out_units AS agreement_item_out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		agreement_item.agreement_id /*Convenio*/,
	------------------------------------------
		agreement_item.org_id /*Institución Educativa*/

	FROM kuntur.agreement_item
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_json agreement
		ON kuntur.agreement_item.agreement_id = agreement.agreement_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement_item.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_contact_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_contact_json AS 

	SELECT '{'
			|| json_att_util('AgreementContact.id', agreement_contact.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementContact.erased', agreement_contact.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementContact.receptionStudent', agreement_contact.reception_student::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementContact.sendingStudent', agreement_contact.sending_student::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementContact.agreementItem":' ||  COALESCE(agreement_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementContact.contact":' ||  COALESCE(contact.json, 'null') || ', '

		|| '}' AS json, 
		agreement_contact.id AS agreement_contact_id /*id*/,
		agreement_contact.erased AS agreement_contact_erased /*erased*/,
		agreement_contact.reception_student AS agreement_contact_reception_student /*Responsable de Estudiantes a Recibir*/,
		agreement_contact.sending_student AS agreement_contact_sending_student /*Responsable de Estudiantes a Enviar*/,
	------------------------------------------
		agreement_contact.agreement_item_id /*Item de Convenio*/,
	------------------------------------------
		agreement_contact.contact_id /*Persona de Contacto*/

	FROM kuntur.agreement_contact
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_item_json agreement_item
		ON kuntur.agreement_contact.agreement_item_id = agreement_item.agreement_item_id
	------------------------------------------
	LEFT JOIN kuntur.v_contact_json contact
		ON kuntur.agreement_contact.contact_id = contact.contact_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_item_ou_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_item_ou_json AS 

	SELECT '{'
			|| json_att_util('AgreementItemOu.id', agreement_item_ou.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementItemOu.erased', agreement_item_ou.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItemOu.inUnits', agreement_item_ou.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItemOu.outUnits', agreement_item_ou.out_units::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItemOu.agreementItem":' ||  COALESCE(agreement_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItemOu.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		agreement_item_ou.id AS agreement_item_ou_id /*id*/,
		agreement_item_ou.erased AS agreement_item_ou_erased /*erased*/,
		agreement_item_ou.in_units AS agreement_item_ou_in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		agreement_item_ou.out_units AS agreement_item_ou_out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		agreement_item_ou.agreement_item_id /*Item de Convenio*/,
	------------------------------------------
		agreement_item_ou.org_id /*Institución Educativa*/

	FROM kuntur.agreement_item_ou
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_item_json agreement_item
		ON kuntur.agreement_item_ou.agreement_item_id = agreement_item.agreement_item_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement_item_ou.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_status_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_status_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodStatus.id', admission_period_status.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodStatus.erased', admission_period_status.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodStatus.code', admission_period_status.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('AdmissionPeriodStatus.name', admission_period_status.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('AdmissionPeriodStatus.comment', admission_period_status.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriodStatus.admissionPeriodList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_json_a x WHERE x.admission_period_id = admission_period_status.id)  || '], '
			|| '"AdmissionPeriodStatus.admissionPeriodList":[]'

		|| '}' AS json, 
		admission_period_status.id AS admission_period_status_id /*id*/,
		admission_period_status.erased AS admission_period_status_erased /*erased*/,
		admission_period_status.code AS admission_period_status_code /*Código*/,
		admission_period_status.name AS admission_period_status_name /*Nombre*/,
		admission_period_status.comment AS admission_period_status_comment /*Comentario*/

	FROM kuntur.admission_period_status;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriod.id', admission_period.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriod.erased', admission_period.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriod.numberAdmissionPeriod', admission_period.number_admission_period::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriod.inType', admission_period.in_type::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriod.year', admission_period.year::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriod.semester', admission_period.semester::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriod.title', admission_period.title::VARCHAR, '"', ', ' , true)
			|| json_att_util('AdmissionPeriod.fromDate', admission_period.from_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('AdmissionPeriod.toDate', admission_period.to_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('AdmissionPeriod.comment', admission_period.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriod.admissionPeriodStatus":' ||  COALESCE(admission_period_status.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.admissionPeriodAgreementList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_agreement_json_a x WHERE x.admission_period_agreement_id = admission_period.id)  || '], '
			|| '"AdmissionPeriod.admissionPeriodAgreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.admissionPeriodItemList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_json_a x WHERE x.admission_period_item_id = admission_period.id)  || '], '
			|| '"AdmissionPeriod.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriod.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = admission_period.id)  || '], '
			|| '"AdmissionPeriod.enrrollmentList":[]'

		|| '}' AS json, 
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
		admission_period.admission_period_status_id /*Estado de Convocatoria*/

	FROM kuntur.admission_period
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_status_json admission_period_status
		ON kuntur.admission_period.admission_period_status_id = admission_period_status.admission_period_status_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_item_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_item_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodItem.id', admission_period_item.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodItem.erased', admission_period_item.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItem.inUnits', admission_period_item.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItem.outUnits', admission_period_item.out_units::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItem.admissionPeriod":' ||  COALESCE(admission_period.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItem.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriodItem.admissionPeriodContactList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_contact_json_a x WHERE x.admission_period_contact_id = admission_period_item.id)  || '], '
			|| '"AdmissionPeriodItem.admissionPeriodContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"AdmissionPeriodItem.admissionPeriodItemOuList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_admission_period_item_ou_json_a x WHERE x.admission_period_item_ou_id = admission_period_item.id)  || '], '
			|| '"AdmissionPeriodItem.admissionPeriodItemOuList":[]'

		|| '}' AS json, 
		admission_period_item.id AS admission_period_item_id /*id*/,
		admission_period_item.erased AS admission_period_item_erased /*erased*/,
		admission_period_item.in_units AS admission_period_item_in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		admission_period_item.out_units AS admission_period_item_out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		admission_period_item.admission_period_id /*Convocatoria (Periodo de Admisión)*/,
	------------------------------------------
		admission_period_item.org_id /*Institución Educativa*/

	FROM kuntur.admission_period_item
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.admission_period_item.admission_period_id = admission_period.admission_period_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.admission_period_item.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_item_ou_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_item_ou_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodItemOu.id', admission_period_item_ou.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodItemOu.erased', admission_period_item_ou.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItemOu.inUnits', admission_period_item_ou.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItemOu.outUnits', admission_period_item_ou.out_units::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItemOu.admissionPeriodItem":' ||  COALESCE(admission_period_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItemOu.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		admission_period_item_ou.id AS admission_period_item_ou_id /*id*/,
		admission_period_item_ou.erased AS admission_period_item_ou_erased /*erased*/,
		admission_period_item_ou.in_units AS admission_period_item_ou_in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		admission_period_item_ou.out_units AS admission_period_item_ou_out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		admission_period_item_ou.admission_period_item_id /*Item de Convocatoria*/,
	------------------------------------------
		admission_period_item_ou.org_id /*Institución Educativa*/

	FROM kuntur.admission_period_item_ou
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_item_json admission_period_item
		ON kuntur.admission_period_item_ou.admission_period_item_id = admission_period_item.admission_period_item_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.admission_period_item_ou.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_agreement_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_agreement_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodAgreement.id', admission_period_agreement.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodAgreement.erased', admission_period_agreement.erased::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodAgreement.agreement":' ||  COALESCE(agreement.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodAgreement.admissionPeriod":' ||  COALESCE(admission_period.json, 'null') || ', '

		|| '}' AS json, 
		admission_period_agreement.id AS admission_period_agreement_id /*id*/,
		admission_period_agreement.erased AS admission_period_agreement_erased /*erased*/,
	------------------------------------------
		admission_period_agreement.agreement_id /*Convenio*/,
	------------------------------------------
		admission_period_agreement.admission_period_id /*Convocatoria (Periodo de Admisión)*/

	FROM kuntur.admission_period_agreement
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_json agreement
		ON kuntur.admission_period_agreement.agreement_id = agreement.agreement_id
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.admission_period_agreement.admission_period_id = admission_period.admission_period_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_contact_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_contact_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodContact.id', admission_period_contact.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodContact.erased', admission_period_contact.erased::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodContact.admissionPeriodItem":' ||  COALESCE(admission_period_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodContact.contact":' ||  COALESCE(contact.json, 'null') || ', '

		|| '}' AS json, 
		admission_period_contact.id AS admission_period_contact_id /*id*/,
		admission_period_contact.erased AS admission_period_contact_erased /*erased*/,
	------------------------------------------
		admission_period_contact.admission_period_item_id /*Item de Convocatoria*/,
	------------------------------------------
		admission_period_contact.contact_id /*Persona de Contacto*/

	FROM kuntur.admission_period_contact
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_item_json admission_period_item
		ON kuntur.admission_period_contact.admission_period_item_id = admission_period_item.admission_period_item_id
	------------------------------------------
	LEFT JOIN kuntur.v_contact_json contact
		ON kuntur.admission_period_contact.contact_id = contact.contact_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_status_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_status_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentStatus.id', enrrollment_status.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentStatus.erased', enrrollment_status.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentStatus.code', enrrollment_status.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentStatus.name', enrrollment_status.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentStatus.comment', enrrollment_status.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"EnrrollmentStatus.enrrollmentList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_json_a x WHERE x.enrrollment_id = enrrollment_status.id)  || '], '
			|| '"EnrrollmentStatus.enrrollmentList":[]'

		|| '}' AS json, 
		enrrollment_status.id AS enrrollment_status_id /*id*/,
		enrrollment_status.erased AS enrrollment_status_erased /*erased*/,
		enrrollment_status.code AS enrrollment_status_code /*Código*/,
		enrrollment_status.name AS enrrollment_status_name /*Nombre*/,
		enrrollment_status.comment AS enrrollment_status_comment /*Comentario*/

	FROM kuntur.enrrollment_status;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_json AS 

	SELECT '{'
			|| json_att_util('Enrrollment.id', enrrollment.id::VARCHAR, '"', ', ', false)
			|| json_att_util('Enrrollment.erased', enrrollment.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('Enrrollment.givenName', enrrollment.given_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.middleName', enrrollment.middle_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.familyName', enrrollment.family_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthDate', enrrollment.birth_date::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.male', enrrollment.male::VARCHAR, '', ', ' , true)
			|| json_att_util('Enrrollment.urlPhoto', enrrollment.url_photo::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.comment', enrrollment.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthCountryCode', enrrollment.birth_country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthAdminAreaLevel1Code', enrrollment.birth_admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthAdminAreaLevel2', enrrollment.birth_admin_area_level2::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthLocality', enrrollment.birth_locality::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.birthLat', enrrollment.birth_lat::VARCHAR, '', ', ' , true)
			|| json_att_util('Enrrollment.birthLng', enrrollment.birth_lng::VARCHAR, '', ', ' , true)
			|| json_att_util('Enrrollment.institutionOriginalName', enrrollment.institution_original_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.institutionWebSite', enrrollment.institution_web_site::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.institutionCountryCode', enrrollment.institution_country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('Enrrollment.numberEnrrollment', enrrollment.number_enrrollment::VARCHAR, '', ', ' , true)
			|| json_att_util('Enrrollment.checkOutDate', enrrollment.check_out_date::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.userSystem":' ||  COALESCE(user_system.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.student":' ||  COALESCE(student.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.admissionPeriod":' ||  COALESCE(admission_period.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentStatus":' ||  COALESCE(enrrollment_status.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentStakeholderList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_stakeholder_json_a x WHERE x.enrrollment_stakeholder_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_email_json_a x WHERE x.enrrollment_email_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentPhoneList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_phone_json_a x WHERE x.enrrollment_phone_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentIdentityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_identity_json_a x WHERE x.enrrollment_identity_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentNationalityList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_nationality_json_a x WHERE x.enrrollment_nationality_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentAddressList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_address_json_a x WHERE x.enrrollment_address_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"Enrrollment.enrrollmentLogList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_enrrollment_log_json_a x WHERE x.enrrollment_log_id = enrrollment.id)  || '], '
			|| '"Enrrollment.enrrollmentLogList":[]'

		|| '}' AS json, 
		enrrollment.id AS enrrollment_id /*id*/,
		enrrollment.erased AS enrrollment_erased /*erased*/,
		enrrollment.given_name AS enrrollment_given_name /*Nombre de Pila*/,
		enrrollment.middle_name AS enrrollment_middle_name /*Segundo Nombre*/,
		enrrollment.family_name AS enrrollment_family_name /*Apellido*/,
		enrrollment.birth_date AS enrrollment_birth_date /*Fecha de Nacimiento*/,
		enrrollment.male AS enrrollment_male /*Masculino*/,
		enrrollment.url_photo AS enrrollment_url_photo /*Foto*/,
		enrrollment.comment AS enrrollment_comment /*Comentario*/,
		enrrollment.birth_country_code AS enrrollment_birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		enrrollment.birth_admin_area_level1_code AS enrrollment_birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		enrrollment.birth_admin_area_level2 AS enrrollment_birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		enrrollment.birth_locality AS enrrollment_birth_locality /*Localidad Nacimiento*/,
		enrrollment.birth_lat AS enrrollment_birth_lat /*Latitud Nacimiento*/,
		enrrollment.birth_lng AS enrrollment_birth_lng /*Longitud Nacimiento*/,
		enrrollment.institution_original_name AS enrrollment_institution_original_name /*Nombre en el idioma original*/,
		enrrollment.institution_web_site AS enrrollment_institution_web_site /*Sitio Web*/,
		enrrollment.institution_country_code AS enrrollment_institution_country_code /*País Nacionalidad - Código ISO 3166-1 Alfa-2*/,
		enrrollment.number_enrrollment AS enrrollment_number_enrrollment /*N°*/,
		enrrollment.check_out_date AS enrrollment_check_out_date /*Fecha Check Out*/,
	------------------------------------------
		enrrollment.org_id /*Institución Educativa*/,
	------------------------------------------
		enrrollment.user_system_id /*Usuario del Sistema*/,
	------------------------------------------
		enrrollment.student_id /*Estudiante*/,
	------------------------------------------
		enrrollment.admission_period_id /*Convocatoria (Periodo de Admisión)*/,
	------------------------------------------
		enrrollment.enrrollment_status_id /*Estado de la Postulación*/

	FROM kuntur.enrrollment
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.enrrollment.org_id = org.org_id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment.user_system_id = user_system.user_system_id
	------------------------------------------
	LEFT JOIN kuntur.v_student_json student
		ON kuntur.enrrollment.student_id = student.student_id
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.admission_period_id
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_status_json enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.enrrollment_status_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_stakeholder_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_stakeholder_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentStakeholder.id', enrrollment_stakeholder.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentStakeholder.erased', enrrollment_stakeholder.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentStakeholder.code', enrrollment_stakeholder.code::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentStakeholder.userSystem":' ||  COALESCE(user_system.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentStakeholder.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_stakeholder.id AS enrrollment_stakeholder_id /*id*/,
		enrrollment_stakeholder.erased AS enrrollment_stakeholder_erased /*erased*/,
		enrrollment_stakeholder.code AS enrrollment_stakeholder_code /*Código de Tipo de Permiso (Relación)*/,
	------------------------------------------
		enrrollment_stakeholder.user_system_id /*Usuario del Sistema*/,
	------------------------------------------
		enrrollment_stakeholder.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_stakeholder
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment_stakeholder.user_system_id = user_system.user_system_id
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_stakeholder.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_email_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentEmail.id', enrrollment_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentEmail.erased', enrrollment_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentEmail.email', enrrollment_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentEmail.comment', enrrollment_email.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentEmail.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_email.id AS enrrollment_email_id /*id*/,
		enrrollment_email.erased AS enrrollment_email_erased /*erased*/,
		enrrollment_email.email AS enrrollment_email_email /*Correo Electrónico*/,
		enrrollment_email.comment AS enrrollment_email_comment /*Comentario*/,
	------------------------------------------
		enrrollment_email.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_email
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_email.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_phone_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentPhone.id', enrrollment_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentPhone.erased', enrrollment_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentPhone.countryCode', enrrollment_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentPhone.phoneNumber', enrrollment_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentPhone.comment', enrrollment_phone.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentPhone.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_phone.id AS enrrollment_phone_id /*id*/,
		enrrollment_phone.erased AS enrrollment_phone_erased /*erased*/,
		enrrollment_phone.country_code AS enrrollment_phone_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		enrrollment_phone.phone_number AS enrrollment_phone_phone_number /*Número de Teléfono*/,
		enrrollment_phone.comment AS enrrollment_phone_comment /*Comentario*/,
	------------------------------------------
		enrrollment_phone.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_phone
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_phone.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_identity_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_identity_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentIdentity.id', enrrollment_identity.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentIdentity.erased', enrrollment_identity.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentIdentity.identityNumber', enrrollment_identity.identity_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentIdentity.code', enrrollment_identity.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentIdentity.name', enrrollment_identity.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentIdentity.countryCode', enrrollment_identity.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentIdentity.comment', enrrollment_identity.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentIdentity.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentIdentity.personIdentityType":' ||  COALESCE(person_identity_type.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_identity.id AS enrrollment_identity_id /*id*/,
		enrrollment_identity.erased AS enrrollment_identity_erased /*erased*/,
		enrrollment_identity.identity_number AS enrrollment_identity_identity_number /*Número de Identificación*/,
		enrrollment_identity.code AS enrrollment_identity_code /*Código*/,
		enrrollment_identity.name AS enrrollment_identity_name /*Nombre*/,
		enrrollment_identity.country_code AS enrrollment_identity_country_code /*País - Código ISO 3166-1 Alfa-2 (País Emisor)*/,
		enrrollment_identity.comment AS enrrollment_identity_comment /*Comentario*/,
	------------------------------------------
		enrrollment_identity.enrrollment_id /*Postulación*/,
	------------------------------------------
		enrrollment_identity.person_identity_type_id /*Tipo de Identificación de Persona Física*/

	FROM kuntur.enrrollment_identity
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_identity.enrrollment_id = enrrollment.enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_person_identity_type_json person_identity_type
		ON kuntur.enrrollment_identity.person_identity_type_id = person_identity_type.person_identity_type_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_nationality_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_nationality_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentNationality.id', enrrollment_nationality.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentNationality.erased', enrrollment_nationality.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentNationality.countryCode', enrrollment_nationality.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentNationality.comment', enrrollment_nationality.comment::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentNationality.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_nationality.id AS enrrollment_nationality_id /*id*/,
		enrrollment_nationality.erased AS enrrollment_nationality_erased /*erased*/,
		enrrollment_nationality.country_code AS enrrollment_nationality_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		enrrollment_nationality.comment AS enrrollment_nationality_comment /*Comentario*/,
	------------------------------------------
		enrrollment_nationality.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_nationality
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_nationality.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_address_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_address_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentAddress.id', enrrollment_address.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentAddress.erased', enrrollment_address.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentAddress.countryCode', enrrollment_address.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.adminAreaLevel1Code', enrrollment_address.admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.adminAreaLevel2', enrrollment_address.admin_area_level2::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.locality', enrrollment_address.locality::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.neighbourhood', enrrollment_address.neighbourhood::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.street', enrrollment_address.street::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.streetNumber', enrrollment_address.street_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.buildingFloor', enrrollment_address.building_floor::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.buildingRoom', enrrollment_address.building_room::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.building', enrrollment_address.building::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.postalCode', enrrollment_address.postal_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.comment', enrrollment_address.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentAddress.lat', enrrollment_address.lat::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentAddress.lng', enrrollment_address.lng::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentAddress.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_address.id AS enrrollment_address_id /*id*/,
		enrrollment_address.erased AS enrrollment_address_erased /*erased*/,
		enrrollment_address.country_code AS enrrollment_address_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		enrrollment_address.admin_area_level1_code AS enrrollment_address_admin_area_level1_code /*Provincia - Código ISO 3166-2*/,
		enrrollment_address.admin_area_level2 AS enrrollment_address_admin_area_level2 /*Departamento / Distrito*/,
		enrrollment_address.locality AS enrrollment_address_locality /*Localidad*/,
		enrrollment_address.neighbourhood AS enrrollment_address_neighbourhood /*Vecindario*/,
		enrrollment_address.street AS enrrollment_address_street /*Calle*/,
		enrrollment_address.street_number AS enrrollment_address_street_number /*Número de Calle*/,
		enrrollment_address.building_floor AS enrrollment_address_building_floor /*Planta del Edificio*/,
		enrrollment_address.building_room AS enrrollment_address_building_room /*Departamento de Edificio*/,
		enrrollment_address.building AS enrrollment_address_building /*Edificio*/,
		enrrollment_address.postal_code AS enrrollment_address_postal_code /*Código Postal*/,
		enrrollment_address.comment AS enrrollment_address_comment /*Comentario*/,
		enrrollment_address.lat AS enrrollment_address_lat /*Latitud*/,
		enrrollment_address.lng AS enrrollment_address_lng /*Longitud*/,
	------------------------------------------
		enrrollment_address.enrrollment_id /*Postulación*/

	FROM kuntur.enrrollment_address
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_address.enrrollment_id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_log_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_log_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentLog.id', enrrollment_log.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentLog.erased', enrrollment_log.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentLog.codeStart', enrrollment_log.code_start::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentLog.nameStart', enrrollment_log.name_start::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentLog.codeEnd', enrrollment_log.code_end::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentLog.nameEnd', enrrollment_log.name_end::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentLog.promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentLog.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentLog.userSystem":' ||  COALESCE(user_system.json, 'null') || ', '

		|| '}' AS json, 
		enrrollment_log.id AS enrrollment_log_id /*id*/,
		enrrollment_log.erased AS enrrollment_log_erased /*erased*/,
		enrrollment_log.code_start AS enrrollment_log_code_start /*Código*/,
		enrrollment_log.name_start AS enrrollment_log_name_start /*Nombre*/,
		enrrollment_log.code_end AS enrrollment_log_code_end /*Código*/,
		enrrollment_log.name_end AS enrrollment_log_name_end /*Nombre*/,
		enrrollment_log.promotion_date AS enrrollment_log_promotion_date /*Fecha Promoción de Estado*/,
	------------------------------------------
		enrrollment_log.enrrollment_id /*Postulación*/,
	------------------------------------------
		enrrollment_log.user_system_id /*Usuario del Sistema*/

	FROM kuntur.enrrollment_log
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_log.enrrollment_id = enrrollment.enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment_log.user_system_id = user_system.user_system_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_enrrollment_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_enrrollment_json AS 

	SELECT '{'
			|| SUBSTRING(enrrollment.json FROM 2 FOR CHAR_LENGTH(enrrollment.json)-2) || ', '
			-------------------------------------------------------------------------------------------------------------
			|| json_att_util('UncInEnrrollment.agreement', unc_in_enrrollment.agreement::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.program', unc_in_enrrollment.program::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.amountPaid', unc_in_enrrollment.amount_paid::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.originalDoc', unc_in_enrrollment.original_doc::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.insurance', unc_in_enrrollment.insurance::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.languageCertificate', unc_in_enrrollment.language_certificate::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.visa', unc_in_enrrollment.visa::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.emergencyContact', unc_in_enrrollment.emergency_contact::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.credentialCode', unc_in_enrrollment.credential_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlOrigininalTranscript', unc_in_enrrollment.url_origininal_transcript::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlPassport', unc_in_enrrollment.url_passport::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlLanguageCertificate', unc_in_enrrollment.url_language_certificate::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlCv', unc_in_enrrollment.url_cv::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlApplicationLetter', unc_in_enrrollment.url_application_letter::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlCertificatePsychophysical', unc_in_enrrollment.url_certificate_psychophysical::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlAdmissionAct', unc_in_enrrollment.url_admission_act::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlAdmissionActTemplate', unc_in_enrrollment.url_admission_act_template::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlTranscript', unc_in_enrrollment.url_transcript::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlTranscriptTemplate', unc_in_enrrollment.url_transcript_template::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlUniversityCredential', unc_in_enrrollment.url_university_credential::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlStudentReport', unc_in_enrrollment.url_student_report::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.urlExchangeForm', unc_in_enrrollment.url_exchange_form::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.comment', unc_in_enrrollment.comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.observation', unc_in_enrrollment.observation::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.creation_date_postulation', unc_in_enrrollment.creation_date_postulation::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementName', unc_in_enrrollment.agreement_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementComment', unc_in_enrrollment.agreement_comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementNumberStudents', unc_in_enrrollment.agreement_number_students::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementOrg', unc_in_enrrollment.agreement_org::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementOrgComment', unc_in_enrrollment.agreement_org_comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.agreementAcademicUnit', unc_in_enrrollment.agreement_academic_unit::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.exchangeProgramName', unc_in_enrrollment.exchange_program_name::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.exchangeProgramComment', unc_in_enrrollment.exchange_program_comment::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInEnrrollment.exchangeProgramNumberStudents', unc_in_enrrollment.exchange_program_number_students::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInEnrrollment.exchangeProgramInitialNumberStudents', unc_in_enrrollment.exchange_program_initial_number_students::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInEnrrollment.uncInStudyProgramList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_study_program_json_a x WHERE x.unc_in_study_program_id = unc_in_enrrollment.id)  || '], '
			|| '"UncInEnrrollment.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInEnrrollment.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = unc_in_enrrollment.id)  || '], '
			|| '"UncInEnrrollment.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_enrrollment.id AS unc_in_enrrollment_id /*id*/,
		unc_in_enrrollment.erased AS unc_in_enrrollment_erased /*erased*/,
		unc_in_enrrollment.agreement AS unc_in_enrrollment_agreement /*Con Convenio*/,
		unc_in_enrrollment.program AS unc_in_enrrollment_program /*Con Programa*/,
		unc_in_enrrollment.amount_paid AS unc_in_enrrollment_amount_paid /*Tasa Pagada*/,
		unc_in_enrrollment.original_doc AS unc_in_enrrollment_original_doc /*Documentación Original*/,
		unc_in_enrrollment.insurance AS unc_in_enrrollment_insurance /*Seguro*/,
		unc_in_enrrollment.language_certificate AS unc_in_enrrollment_language_certificate /*Certificado de Idioma*/,
		unc_in_enrrollment.visa AS unc_in_enrrollment_visa /*Visa*/,
		unc_in_enrrollment.emergency_contact AS unc_in_enrrollment_emergency_contact /*Contacto de Emergencia*/,
		unc_in_enrrollment.credential_code AS unc_in_enrrollment_credential_code /*Código de Credencial*/,
		unc_in_enrrollment.url_origininal_transcript AS unc_in_enrrollment_url_origininal_transcript /*Analítico Académico*/,
		unc_in_enrrollment.url_passport AS unc_in_enrrollment_url_passport /*Pasaporte*/,
		unc_in_enrrollment.url_language_certificate AS unc_in_enrrollment_url_language_certificate /*Certificado de Idioma*/,
		unc_in_enrrollment.url_cv AS unc_in_enrrollment_url_cv /*Curriculumn Vitae*/,
		unc_in_enrrollment.url_application_letter AS unc_in_enrrollment_url_application_letter /*Carta de Postulación*/,
		unc_in_enrrollment.url_certificate_psychophysical AS unc_in_enrrollment_url_certificate_psychophysical /*Certificado Psicofísico*/,
		unc_in_enrrollment.url_admission_act AS unc_in_enrrollment_url_admission_act /*Acta de Admisión*/,
		unc_in_enrrollment.url_admission_act_template AS unc_in_enrrollment_url_admission_act_template /*Template Acta de Admisión*/,
		unc_in_enrrollment.url_transcript AS unc_in_enrrollment_url_transcript /*Certificado Analítico*/,
		unc_in_enrrollment.url_transcript_template AS unc_in_enrrollment_url_transcript_template /*Template de Certificado Analítico*/,
		unc_in_enrrollment.url_university_credential AS unc_in_enrrollment_url_university_credential /*Credencial Universitaria*/,
		unc_in_enrrollment.url_student_report AS unc_in_enrrollment_url_student_report /*Reporte del Estudiante*/,
		unc_in_enrrollment.url_exchange_form AS unc_in_enrrollment_url_exchange_form /*Formulario de Intercambio*/,
		unc_in_enrrollment.comment AS unc_in_enrrollment_comment /*Comentario*/,
		unc_in_enrrollment.observation AS unc_in_enrrollment_observation /*Observaciones*/,
		unc_in_enrrollment.creation_date_postulation AS unc_in_enrrollment_creation_date_postulation /*Observaciones*/,
		unc_in_enrrollment.agreement_name AS unc_in_enrrollment_agreement_name /*Nombre del Acuerdo*/,
		unc_in_enrrollment.agreement_comment AS unc_in_enrrollment_agreement_comment /*Comentario del Acuerdo*/,
		unc_in_enrrollment.agreement_number_students AS unc_in_enrrollment_agreement_number_students /*Cant. Estudiantes del Acuerdo*/,
		unc_in_enrrollment.agreement_org AS unc_in_enrrollment_agreement_org /*Institución del Acuerdo*/,
		unc_in_enrrollment.agreement_org_comment AS unc_in_enrrollment_agreement_org_comment /*Comentario Institución del Acuerdo*/,
		unc_in_enrrollment.agreement_academic_unit AS unc_in_enrrollment_agreement_academic_unit /*Unidad Académica del Acuerdo*/,
		unc_in_enrrollment.exchange_program_name AS unc_in_enrrollment_exchange_program_name /*Nombre del Programa*/,
		unc_in_enrrollment.exchange_program_comment AS unc_in_enrrollment_exchange_program_comment /*Comentario del Programa*/,
		unc_in_enrrollment.exchange_program_number_students AS unc_in_enrrollment_exchange_program_number_students /*Cant. Estudiantes del Programa*/,
		unc_in_enrrollment.exchange_program_initial_number_students AS unc_in_enrrollment_exchange_program_initial_number_students /*Cant. Inicial Estudiantes del Programa*/

	FROM kuntur.unc_in_enrrollment
	JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.enrrollment_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_study_program_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_study_program_json AS 

	SELECT '{'
			|| json_att_util('UncInStudyProgram.id', unc_in_study_program.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInStudyProgram.erased', unc_in_study_program.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInStudyProgram.approved', unc_in_study_program.approved::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInStudyProgram.approvedBy', unc_in_study_program.approved_by::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInStudyProgram.fileNumber', unc_in_study_program.file_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInStudyProgram.comment', unc_in_study_program.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInStudyProgram.uncInEnrrollment":' ||  COALESCE(unc_in_enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInStudyProgram.org":' ||  COALESCE(org.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInStudyProgram.uncInStudyProgramSubjectList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_study_program_subject_json_a x WHERE x.unc_in_study_program_subject_id = unc_in_study_program.id)  || '], '
			|| '"UncInStudyProgram.uncInStudyProgramSubjectList":[]'

		|| '}' AS json, 
		unc_in_study_program.id AS unc_in_study_program_id /*id*/,
		unc_in_study_program.erased AS unc_in_study_program_erased /*erased*/,
		unc_in_study_program.approved AS unc_in_study_program_approved /*Aprobado*/,
		unc_in_study_program.approved_by AS unc_in_study_program_approved_by /*Aprobado por*/,
		unc_in_study_program.file_number AS unc_in_study_program_file_number /*Legajo Guarani*/,
		unc_in_study_program.comment AS unc_in_study_program_comment /*Comentario*/,
	------------------------------------------
		unc_in_study_program.unc_in_enrrollment_id /*Postulación*/,
	------------------------------------------
		unc_in_study_program.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_study_program
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
		ON kuntur.unc_in_study_program.unc_in_enrrollment_id = unc_in_enrrollment.unc_in_enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_study_program.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_study_program_subject_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_study_program_subject_json AS 

	SELECT '{'
			|| json_att_util('UncInStudyProgramSubject.id', unc_in_study_program_subject.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInStudyProgramSubject.erased', unc_in_study_program_subject.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInStudyProgramSubject.subject', unc_in_study_program_subject.subject::VARCHAR, '"', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInStudyProgramSubject.uncInStudyProgram":' ||  COALESCE(unc_in_study_program.json, 'null') || ', '

		|| '}' AS json, 
		unc_in_study_program_subject.id AS unc_in_study_program_subject_id /*id*/,
		unc_in_study_program_subject.erased AS unc_in_study_program_subject_erased /*erased*/,
		unc_in_study_program_subject.subject AS unc_in_study_program_subject_subject /*Materia*/,
	------------------------------------------
		unc_in_study_program_subject.unc_in_study_program_id /*Programa de Estudio*/

	FROM kuntur.unc_in_study_program_subject
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_study_program_json unc_in_study_program
		ON kuntur.unc_in_study_program_subject.unc_in_study_program_id = unc_in_study_program.unc_in_study_program_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_grading_scale_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_grading_scale_json AS 

	SELECT '{'
			|| json_att_util('UncInGradingScale.id', unc_in_grading_scale.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInGradingScale.erased', unc_in_grading_scale.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInGradingScale.rateNumber', unc_in_grading_scale.rate_number::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInGradingScale.rateLetter', unc_in_grading_scale.rate_letter::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInGradingScale.comment', unc_in_grading_scale.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInGradingScale.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = unc_in_grading_scale.id)  || '], '
			|| '"UncInGradingScale.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_grading_scale.id AS unc_in_grading_scale_id /*id*/,
		unc_in_grading_scale.erased AS unc_in_grading_scale_erased /*erased*/,
		unc_in_grading_scale.rate_number AS unc_in_grading_scale_rate_number /*Calificación Numérica*/,
		unc_in_grading_scale.rate_letter AS unc_in_grading_scale_rate_letter /*Calificación con Letras*/,
		unc_in_grading_scale.comment AS unc_in_grading_scale_comment /*Comentario*/

	FROM kuntur.unc_in_grading_scale;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_studied_type_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_studied_type_json AS 

	SELECT '{'
			|| json_att_util('UncInStudiedType.id', unc_in_studied_type.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInStudiedType.erased', unc_in_studied_type.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInStudiedType.code', unc_in_studied_type.code::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInStudiedType.name', unc_in_studied_type.name::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInStudiedType.comment', unc_in_studied_type.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			--|| '"UncInStudiedType.uncInAcademicPerformanceList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_unc_in_academic_performance_json_a x WHERE x.unc_in_academic_performance_id = unc_in_studied_type.id)  || '], '
			|| '"UncInStudiedType.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_studied_type.id AS unc_in_studied_type_id /*id*/,
		unc_in_studied_type.erased AS unc_in_studied_type_erased /*erased*/,
		unc_in_studied_type.code AS unc_in_studied_type_code /*Código*/,
		unc_in_studied_type.name AS unc_in_studied_type_name /*Nombre*/,
		unc_in_studied_type.comment AS unc_in_studied_type_comment /*Comentario*/

	FROM kuntur.unc_in_studied_type;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_performance_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_performance_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicPerformance.id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicPerformance.erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInAcademicPerformance.subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInAcademicPerformance.hs', unc_in_academic_performance.hs::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInEnrrollment":' ||  COALESCE(unc_in_enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInGradingScale":' ||  COALESCE(unc_in_grading_scale.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInStudiedType":' ||  COALESCE(unc_in_studied_type.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		unc_in_academic_performance.id AS unc_in_academic_performance_id /*id*/,
		unc_in_academic_performance.erased AS unc_in_academic_performance_erased /*erased*/,
		unc_in_academic_performance.subject AS unc_in_academic_performance_subject /*Materia*/,
		unc_in_academic_performance.hs AS unc_in_academic_performance_hs /*Horas*/,
	------------------------------------------
		unc_in_academic_performance.unc_in_enrrollment_id /*Postulación*/,
	------------------------------------------
		unc_in_academic_performance.unc_in_grading_scale_id /*Escala de Calificaciones*/,
	------------------------------------------
		unc_in_academic_performance.unc_in_studied_type_id /*Tipo de cursado*/,
	------------------------------------------
		unc_in_academic_performance.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_academic_performance
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
		ON kuntur.unc_in_academic_performance.unc_in_enrrollment_id = unc_in_enrrollment.unc_in_enrrollment_id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_grading_scale_json unc_in_grading_scale
		ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.unc_in_grading_scale_id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_studied_type_json unc_in_studied_type
		ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.unc_in_studied_type_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_performance.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_coordinator_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_coordinator_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicCoordinator.id', unc_in_academic_coordinator.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicCoordinator.erased', unc_in_academic_coordinator.erased::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicCoordinator.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicCoordinator.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		unc_in_academic_coordinator.id AS unc_in_academic_coordinator_id /*id*/,
		unc_in_academic_coordinator.erased AS unc_in_academic_coordinator_erased /*erased*/,
	------------------------------------------
		unc_in_academic_coordinator.person_id /*Persona Física*/,
	------------------------------------------
		unc_in_academic_coordinator.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_academic_coordinator
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.unc_in_academic_coordinator.person_id = person.person_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_coordinator.org_id = org.org_id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_office_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_office_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicOffice.id', unc_in_academic_office.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicOffice.erased', unc_in_academic_office.erased::VARCHAR, '', '' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicOffice.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicOffice.org":' ||  COALESCE(org.json, 'null') || ', '

		|| '}' AS json, 
		unc_in_academic_office.id AS unc_in_academic_office_id /*id*/,
		unc_in_academic_office.erased AS unc_in_academic_office_erased /*erased*/,
	------------------------------------------
		unc_in_academic_office.person_id /*Persona Física*/,
	------------------------------------------
		unc_in_academic_office.org_id /*Institución Educativa*/

	FROM kuntur.unc_in_academic_office
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.unc_in_academic_office.person_id = person.person_id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_office.org_id = org.org_id;