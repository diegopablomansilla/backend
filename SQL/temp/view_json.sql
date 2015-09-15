CREATE OR REPLACE FUNCTION json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) RETURNS VARCHAR AS $$
	BEGIN
		IF coalescef = true THEN
			RETURN '"' || att_name || '":' || COALESCE(att_cd || att_val|| att_cd, 'null') 	|| att_end;
		ELSE
			RETURN '"' || att_name || '":' || att_cd || att_val|| att_cd			 || att_end;
	END IF;
END;
$$  LANGUAGE plpgsql;



-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_email_json_a CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_email_json_a AS 

	SELECT '{'
			|| json_att_util('PersonEmail.id', person_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonEmail.erased', person_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonEmail.email', person_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonEmail.comment', person_email.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonEmail.person":null'

		|| '}' AS json, 
		person_email.id,
		person_email.person_id

	FROM kuntur.person_email;
	------------------------------------------
	


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
			|| '"Person.personEmailList":[' || (SELECT COALESCE(STRING_AGG(x.json, ', '), '') FROM kuntur.v_person_email_json_a x WHERE x.person_id = person.id)  || '], '
			--| '"Person.personEmailList":[' || (SELECT COALESCE(x.json, '') FROM kuntur.v_person_email_json x WHERE x.person_id = person.id)  || '], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.personPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.personNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.personAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Person.uncInAcademicOfficeList":[]'

		|| '}' AS json, 
		person.id

	FROM kuntur.person;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_email_json AS 

	SELECT '{'
			|| json_att_util('PersonEmail.id', person_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonEmail.erased', person_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonEmail.email', person_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonEmail.comment', person_email.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonEmail.person":' ||  COALESCE(person.json, 'null') || ''

		|| '}' AS json, 
		person_email.id,
		person_email.person_id

	FROM kuntur.person_email
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_email.person_id = person.id;	

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_phone_json AS 

	SELECT '{'
			|| json_att_util('PersonPhone.id', person_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonPhone.erased', person_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonPhone.countryCode', person_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonPhone.phoneNumber', person_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonPhone.comment', person_phone.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonPhone.person":' ||  COALESCE(person.json, 'null') || ''

		|| '}' AS json, 
		person_phone.id

	FROM kuntur.person_phone
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_phone.person_id = person.id;

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
			|| '"PersonIdentityType.personIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonIdentityType.enrrollmentIdentityList":[]'

		|| '}' AS json, 
		person_identity_type.id

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
			|| json_att_util('PersonIdentity.comment', person_identity.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonIdentity.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonIdentity.personIdentityType":' ||  COALESCE(person_identity_type.json, 'null') || ''

		|| '}' AS json, 
		person_identity.id

	FROM kuntur.person_identity
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_identity.person_id = person.id
	------------------------------------------
	LEFT JOIN kuntur.v_person_identity_type_json person_identity_type
		ON kuntur.person_identity.person_identity_type_id = person_identity_type.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_person_nationality_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_person_nationality_json AS 

	SELECT '{'
			|| json_att_util('PersonNationality.id', person_nationality.id::VARCHAR, '"', ', ', false)
			|| json_att_util('PersonNationality.erased', person_nationality.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('PersonNationality.countryCode', person_nationality.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('PersonNationality.comment', person_nationality.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonNationality.person":' ||  COALESCE(person.json, 'null') || ''

		|| '}' AS json, 
		person_nationality.id

	FROM kuntur.person_nationality
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_nationality.person_id = person.id;

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
			|| json_att_util('PersonAddress.lng', person_address.lng::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"PersonAddress.person":' ||  COALESCE(person.json, 'null') || ''

		|| '}' AS json, 
		person_address.id

	FROM kuntur.person_address
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.person_address.person_id = person.id;

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
			|| '"UserSystem.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"UserSystem.enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"UserSystem.enrrollmentLogList":[]'

		|| '}' AS json, 
		user_system.id

	FROM kuntur.user_system
	JOIN kuntur.v_person_json person
		ON kuntur.user_system.id = person.id;

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
			|| '"OrgType.orgList":[]'

		|| '}' AS json, 
		org_type.id

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
			|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.orgList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.orgEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.orgPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.orgAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.contactList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.studentList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.agreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.agreementItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.agreementItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.admissionPeriodItemOuList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.enrrollmentList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.uncInAcademicPerformanceList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.uncInAcademicCoordinatorList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Org.uncInAcademicOfficeList":[]'

		|| '}' AS json, 
		org.id

	FROM kuntur.org
	------------------------------------------
	LEFT JOIN kuntur.v_org_type_json org_type
		ON kuntur.org.org_type_id = org_type.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_email_json AS 

	SELECT '{'
			|| json_att_util('OrgEmail.id', org_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgEmail.erased', org_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgEmail.email', org_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgEmail.comment', org_email.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgEmail.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		org_email.id

	FROM kuntur.org_email
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_email.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_org_phone_json AS 

	SELECT '{'
			|| json_att_util('OrgPhone.id', org_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('OrgPhone.erased', org_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('OrgPhone.countryCode', org_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgPhone.phoneNumber', org_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('OrgPhone.comment', org_phone.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgPhone.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		org_phone.id

	FROM kuntur.org_phone
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_phone.org_id = org.id;

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
			|| json_att_util('OrgAddress.lng', org_address.lng::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"OrgAddress.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		org_address.id

	FROM kuntur.org_address
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.org_address.org_id = org.id;

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
			|| '"Contact.agreementContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Contact.admissionPeriodContactList":[]'

		|| '}' AS json, 
		contact.id

	FROM kuntur.contact
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.contact.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.contact.person_id = person.id;

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
			|| '"Student.enrrollmentList":[]'

		|| '}' AS json, 
		student.id

	FROM kuntur.student
	JOIN kuntur.v_person_json person
		ON kuntur.student.id = person.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.student.org_id = org.id;

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
			|| '"AgreementType.agreementList":[]'

		|| '}' AS json, 
		agreement_type.id

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
			|| '"AgreementStatus.agreementList":[]'

		|| '}' AS json, 
		agreement_status.id

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
			|| '"Agreement.agreementItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Agreement.admissionPeriodAgreementList":[]'

		|| '}' AS json, 
		agreement.id

	FROM kuntur.agreement
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_type_json agreement_type
		ON kuntur.agreement.agreement_type_id = agreement_type.id
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_status_json agreement_status
		ON kuntur.agreement.agreement_status_id = agreement_status.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement.org_id = org.id;

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
			|| '"AgreementItem.agreementContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItem.agreementItemOuList":[]'

		|| '}' AS json, 
		agreement_item.id

	FROM kuntur.agreement_item
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_json agreement
		ON kuntur.agreement_item.agreement_id = agreement.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement_item.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_contact_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_contact_json AS 

	SELECT '{'
			|| json_att_util('AgreementContact.id', agreement_contact.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementContact.erased', agreement_contact.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementContact.receptionStudent', agreement_contact.reception_student::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementContact.sendingStudent', agreement_contact.sending_student::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementContact.agreementItem":' ||  COALESCE(agreement_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementContact.contact":' ||  COALESCE(contact.json, 'null') || ''

		|| '}' AS json, 
		agreement_contact.id

	FROM kuntur.agreement_contact
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_item_json agreement_item
		ON kuntur.agreement_contact.agreement_item_id = agreement_item.id
	------------------------------------------
	LEFT JOIN kuntur.v_contact_json contact
		ON kuntur.agreement_contact.contact_id = contact.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_agreement_item_ou_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_agreement_item_ou_json AS 

	SELECT '{'
			|| json_att_util('AgreementItemOu.id', agreement_item_ou.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AgreementItemOu.erased', agreement_item_ou.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItemOu.inUnits', agreement_item_ou.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AgreementItemOu.outUnits', agreement_item_ou.out_units::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItemOu.agreementItem":' ||  COALESCE(agreement_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AgreementItemOu.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		agreement_item_ou.id

	FROM kuntur.agreement_item_ou
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_item_json agreement_item
		ON kuntur.agreement_item_ou.agreement_item_id = agreement_item.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.agreement_item_ou.org_id = org.id;

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
			|| '"AdmissionPeriodStatus.admissionPeriodList":[]'

		|| '}' AS json, 
		admission_period_status.id

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
			|| '"AdmissionPeriod.admissionPeriodAgreementList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriod.admissionPeriodItemList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriod.enrrollmentList":[]'

		|| '}' AS json, 
		admission_period.id

	FROM kuntur.admission_period
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_status_json admission_period_status
		ON kuntur.admission_period.admission_period_status_id = admission_period_status.id;

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
			|| '"AdmissionPeriodItem.admissionPeriodContactList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItem.admissionPeriodItemOuList":[]'

		|| '}' AS json, 
		admission_period_item.id

	FROM kuntur.admission_period_item
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.admission_period_item.admission_period_id = admission_period.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.admission_period_item.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_item_ou_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_item_ou_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodItemOu.id', admission_period_item_ou.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodItemOu.erased', admission_period_item_ou.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItemOu.inUnits', admission_period_item_ou.in_units::VARCHAR, '', ', ' , true)
			|| json_att_util('AdmissionPeriodItemOu.outUnits', admission_period_item_ou.out_units::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItemOu.admissionPeriodItem":' ||  COALESCE(admission_period_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodItemOu.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		admission_period_item_ou.id

	FROM kuntur.admission_period_item_ou
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_item_json admission_period_item
		ON kuntur.admission_period_item_ou.admission_period_item_id = admission_period_item.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.admission_period_item_ou.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_agreement_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_agreement_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodAgreement.id', admission_period_agreement.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodAgreement.erased', admission_period_agreement.erased::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodAgreement.agreement":' ||  COALESCE(agreement.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodAgreement.admissionPeriod":' ||  COALESCE(admission_period.json, 'null') || ''

		|| '}' AS json, 
		admission_period_agreement.id

	FROM kuntur.admission_period_agreement
	------------------------------------------
	LEFT JOIN kuntur.v_agreement_json agreement
		ON kuntur.admission_period_agreement.agreement_id = agreement.id
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.admission_period_agreement.admission_period_id = admission_period.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_contact_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_admission_period_contact_json AS 

	SELECT '{'
			|| json_att_util('AdmissionPeriodContact.id', admission_period_contact.id::VARCHAR, '"', ', ', false)
			|| json_att_util('AdmissionPeriodContact.erased', admission_period_contact.erased::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodContact.admissionPeriodItem":' ||  COALESCE(admission_period_item.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"AdmissionPeriodContact.contact":' ||  COALESCE(contact.json, 'null') || ''

		|| '}' AS json, 
		admission_period_contact.id

	FROM kuntur.admission_period_contact
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_item_json admission_period_item
		ON kuntur.admission_period_contact.admission_period_item_id = admission_period_item.id
	------------------------------------------
	LEFT JOIN kuntur.v_contact_json contact
		ON kuntur.admission_period_contact.contact_id = contact.id;

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
			|| '"EnrrollmentStatus.enrrollmentList":[]'

		|| '}' AS json, 
		enrrollment_status.id

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
			|| '"Enrrollment.enrrollmentStakeholderList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentEmailList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentPhoneList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentIdentityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentNationalityList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentAddressList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"Enrrollment.enrrollmentLogList":[]'

		|| '}' AS json, 
		enrrollment.id

	FROM kuntur.enrrollment
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.enrrollment.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment.user_system_id = user_system.id
	------------------------------------------
	LEFT JOIN kuntur.v_student_json student
		ON kuntur.enrrollment.student_id = student.id
	------------------------------------------
	LEFT JOIN kuntur.v_admission_period_json admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_status_json enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_stakeholder_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_stakeholder_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentStakeholder.id', enrrollment_stakeholder.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentStakeholder.erased', enrrollment_stakeholder.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentStakeholder.code', enrrollment_stakeholder.code::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentStakeholder.userSystem":' ||  COALESCE(user_system.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentStakeholder.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_stakeholder.id

	FROM kuntur.enrrollment_stakeholder
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment_stakeholder.user_system_id = user_system.id
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_stakeholder.enrrollment_id = enrrollment.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_email_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_email_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentEmail.id', enrrollment_email.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentEmail.erased', enrrollment_email.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentEmail.email', enrrollment_email.email::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentEmail.comment', enrrollment_email.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentEmail.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_email.id

	FROM kuntur.enrrollment_email
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_email.enrrollment_id = enrrollment.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_phone_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_phone_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentPhone.id', enrrollment_phone.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentPhone.erased', enrrollment_phone.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentPhone.countryCode', enrrollment_phone.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentPhone.phoneNumber', enrrollment_phone.phone_number::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentPhone.comment', enrrollment_phone.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentPhone.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_phone.id

	FROM kuntur.enrrollment_phone
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_phone.enrrollment_id = enrrollment.id;

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
			|| json_att_util('EnrrollmentIdentity.comment', enrrollment_identity.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentIdentity.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentIdentity.personIdentityType":' ||  COALESCE(person_identity_type.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_identity.id

	FROM kuntur.enrrollment_identity
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_identity.enrrollment_id = enrrollment.id
	------------------------------------------
	LEFT JOIN kuntur.v_person_identity_type_json person_identity_type
		ON kuntur.enrrollment_identity.person_identity_type_id = person_identity_type.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_enrrollment_nationality_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_enrrollment_nationality_json AS 

	SELECT '{'
			|| json_att_util('EnrrollmentNationality.id', enrrollment_nationality.id::VARCHAR, '"', ', ', false)
			|| json_att_util('EnrrollmentNationality.erased', enrrollment_nationality.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('EnrrollmentNationality.countryCode', enrrollment_nationality.country_code::VARCHAR, '"', ', ' , true)
			|| json_att_util('EnrrollmentNationality.comment', enrrollment_nationality.comment::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentNationality.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_nationality.id

	FROM kuntur.enrrollment_nationality
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_nationality.enrrollment_id = enrrollment.id;

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
			|| json_att_util('EnrrollmentAddress.lng', enrrollment_address.lng::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentAddress.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_address.id

	FROM kuntur.enrrollment_address
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_address.enrrollment_id = enrrollment.id;

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
			|| json_att_util('EnrrollmentLog.promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentLog.enrrollment":' ||  COALESCE(enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"EnrrollmentLog.userSystem":' ||  COALESCE(user_system.json, 'null') || ''

		|| '}' AS json, 
		enrrollment_log.id

	FROM kuntur.enrrollment_log
	------------------------------------------
	LEFT JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.enrrollment_log.enrrollment_id = enrrollment.id
	------------------------------------------
	LEFT JOIN kuntur.v_user_system_json user_system
		ON kuntur.enrrollment_log.user_system_id = user_system.id;

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
			|| '"UncInEnrrollment.uncInStudyProgramList":[], '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInEnrrollment.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_enrrollment.id

	FROM kuntur.unc_in_enrrollment
	JOIN kuntur.v_enrrollment_json enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.id;

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
			|| '"UncInStudyProgram.uncInStudyProgramSubjectList":[]'

		|| '}' AS json, 
		unc_in_study_program.id

	FROM kuntur.unc_in_study_program
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
		ON kuntur.unc_in_study_program.unc_in_enrrollment_id = unc_in_enrrollment.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_study_program.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_study_program_subject_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_study_program_subject_json AS 

	SELECT '{'
			|| json_att_util('UncInStudyProgramSubject.id', unc_in_study_program_subject.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInStudyProgramSubject.erased', unc_in_study_program_subject.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInStudyProgramSubject.subject', unc_in_study_program_subject.subject::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInStudyProgramSubject.uncInStudyProgram":' ||  COALESCE(unc_in_study_program.json, 'null') || ''

		|| '}' AS json, 
		unc_in_study_program_subject.id

	FROM kuntur.unc_in_study_program_subject
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_study_program_json unc_in_study_program
		ON kuntur.unc_in_study_program_subject.unc_in_study_program_id = unc_in_study_program.id;

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
			|| '"UncInGradingScale.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_grading_scale.id

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
			|| '"UncInStudiedType.uncInAcademicPerformanceList":[]'

		|| '}' AS json, 
		unc_in_studied_type.id

	FROM kuntur.unc_in_studied_type;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_performance_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_performance_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicPerformance.id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicPerformance.erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
			|| json_att_util('UncInAcademicPerformance.subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
			|| json_att_util('UncInAcademicPerformance.hs', unc_in_academic_performance.hs::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInEnrrollment":' ||  COALESCE(unc_in_enrrollment.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInGradingScale":' ||  COALESCE(unc_in_grading_scale.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.uncInStudiedType":' ||  COALESCE(unc_in_studied_type.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicPerformance.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		unc_in_academic_performance.id

	FROM kuntur.unc_in_academic_performance
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_enrrollment_json unc_in_enrrollment
		ON kuntur.unc_in_academic_performance.unc_in_enrrollment_id = unc_in_enrrollment.id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_grading_scale_json unc_in_grading_scale
		ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.id
	------------------------------------------
	LEFT JOIN kuntur.v_unc_in_studied_type_json unc_in_studied_type
		ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_performance.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_coordinator_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_coordinator_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicCoordinator.id', unc_in_academic_coordinator.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicCoordinator.erased', unc_in_academic_coordinator.erased::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicCoordinator.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicCoordinator.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		unc_in_academic_coordinator.id

	FROM kuntur.unc_in_academic_coordinator
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.unc_in_academic_coordinator.person_id = person.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_coordinator.org_id = org.id;

-------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_unc_in_academic_office_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_academic_office_json AS 

	SELECT '{'
			|| json_att_util('UncInAcademicOffice.id', unc_in_academic_office.id::VARCHAR, '"', ', ', false)
			|| json_att_util('UncInAcademicOffice.erased', unc_in_academic_office.erased::VARCHAR, '', ', ' , true)
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicOffice.person":' ||  COALESCE(person.json, 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"UncInAcademicOffice.org":' ||  COALESCE(org.json, 'null') || ''

		|| '}' AS json, 
		unc_in_academic_office.id

	FROM kuntur.unc_in_academic_office
	------------------------------------------
	LEFT JOIN kuntur.v_person_json person
		ON kuntur.unc_in_academic_office.person_id = person.id
	------------------------------------------
	LEFT JOIN kuntur.v_org_json org
		ON kuntur.unc_in_academic_office.org_id = org.id;