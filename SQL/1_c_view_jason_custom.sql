--SET search_path to kuntur;

-- DROP FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.json_att_util(att_name VARCHAR, att_val VARCHAR, att_cd VARCHAR, att_end VARCHAR, coalescef BOOLEAN ) RETURNS VARCHAR AS $$
	BEGIN
		att_val = REPLACE(att_val, '
', '\\n');
		
		IF coalescef = true THEN
			RETURN '"' || att_name || '":' || COALESCE(att_cd || att_val|| att_cd, 'null') 	|| att_end;
		ELSE
			RETURN '"' || att_name || '":' || att_cd || att_val|| att_cd			 || att_end;
	END IF;
END;
$$  LANGUAGE plpgsql;

-- select '\\n'

-- probar con el 897

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

DROP FUNCTION IF EXISTS kuntur.gui_type(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.gui_type(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$
	
		SELECT 	
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
		;
$$ LANGUAGE SQL;

-------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$
	
		SELECT 	('{ ' || '"guiView":"' || kuntur.gui_type($1, $2) || '", ' || '"data":' ||  COALESCE(e.json, 'null') || '} ') AS json
		--FROM 	kuntur.v_unc_in_enrrollment_json_a e	
		FROM 	(


	SELECT 
		--================================================================================================================================
		'{'
			|| kuntur.json_att_util('id', enrrollment.id::VARCHAR, '"', ', ', false)
			|| kuntur.json_att_util('erased', enrrollment.erased::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('givenName', enrrollment.given_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('middleName', enrrollment.middle_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('familyName', enrrollment.family_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthDate', enrrollment.birth_date::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('male', enrrollment.male::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('urlPhoto', enrrollment.url_photo::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('comment', enrrollment.comment::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthCountryCode', kuntur.json_att_util(enrrollment.birth_country_code)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthAdminAreaLevel1Code', enrrollment.birth_admin_area_level1_code::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthAdminAreaLevel2', enrrollment.birth_admin_area_level2::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthLocality', enrrollment.birth_locality::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('birthLat', enrrollment.birth_lat::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('birthLng', enrrollment.birth_lng::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('institutionShortName', enrrollment.institution_short_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionName', enrrollment.institution_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionOriginalName', enrrollment.institution_original_name::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionWebSite', kuntur.json_att_util(enrrollment.institution_web_site)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('institutionCountryCode', kuntur.json_att_util(enrrollment.institution_country_code)::VARCHAR, '"', ', ' , true)
			|| kuntur.json_att_util('numberEnrrollment', enrrollment.number_enrrollment::VARCHAR, '', ', ' , true)
			|| kuntur.json_att_util('checkOutDate', enrrollment.check_out_date::VARCHAR, '"', ', ' , true)
			-------------------------------------------------------------------------------------------------------------				
			|| '"org":' ||  COALESCE('{'
				|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
				|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
				|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
				|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
			|| '}', 'null') || ', '
			-------------------------------------------------------------------------------------------------------------			
			|| '"admissionPeriod":' ||  COALESCE('{'
				|| kuntur.json_att_util('id', admission_period.id::VARCHAR, '"', ', ', false)
				|| kuntur.json_att_util('erased', admission_period.erased::VARCHAR, '', ', ' , true)
				|| kuntur.json_att_util('numberAdmissionPeriod', admission_period.number_admission_period::VARCHAR, '', ', ' , true)
				|| kuntur.json_att_util('inType', admission_period.in_type::VARCHAR, '', ', ' , true)
				|| kuntur.json_att_util('year', admission_period.year::VARCHAR, '', ', ' , true)
				|| kuntur.json_att_util('semester', admission_period.semester::VARCHAR, '', ', ' , true)
				|| kuntur.json_att_util('title', admission_period.title::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('fromDate', admission_period.from_date::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('toDate', admission_period.to_date::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('comment', admission_period.comment::VARCHAR, '"', ' ' , true)
			|| '}', 'null') || ', '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentStatus":' ||  COALESCE('{'
				|| kuntur.json_att_util('id', enrrollment_status.id::VARCHAR, '"', ', ', false)
				|| kuntur.json_att_util('code', enrrollment_status.code::VARCHAR, '"', ', ' , true)
				|| kuntur.json_att_util('name', enrrollment_status.name::VARCHAR, '"', ' ' , true)
			|| '}', 'null') || ', '
			-------------------------------------------------------------------------------------------------------------			
			|| '"enrrollmentStakeholderList":[' || COALESCE((	
				SELECT STRING_AGG( '{'
						|| kuntur.json_att_util('id', enrrollment_stakeholder.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('code', enrrollment_stakeholder.code::VARCHAR, '', ', ' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"userSystem":' ||  COALESCE(
							'{'						
								|| kuntur.json_att_util('id', person.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('givenName', person.given_name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('middleName', person.middle_name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('familyName', person.family_name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('urlPhoto', person.url_photo::VARCHAR, '"', ', ' , true)	
								-------------------------------------------------------------------------------------------------------------
								|| kuntur.json_att_util('name', user_system.name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('email', user_system.email::VARCHAR, '"', ' ' , true)

							|| '}', 'null') || ' '			
						-------------------------------------------------------------------------------------------------------------
					|| '}', ', ') AS json	
				FROM kuntur.enrrollment_stakeholder
				------------------------------------------
				LEFT JOIN kuntur.user_system
					ON kuntur.enrrollment_stakeholder.user_system_id = user_system.id
				LEFT JOIN kuntur.person
					ON kuntur.user_system.id = person.id
				------------------------------------------
				WHERE enrrollment.id = enrrollment_stakeholder.enrrollment_id 	
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentEmailList":[' || COALESCE((
				SELECT STRING_AGG( '{'
						|| kuntur.json_att_util('id', enrrollment_email.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('email', enrrollment_email.email::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('comment', enrrollment_email.comment::VARCHAR, '"', ' ' , true)
					|| '}', ', ') AS json	
				FROM kuntur.enrrollment_email
				WHERE enrrollment.id = enrrollment_email.enrrollment_id 
			), '')  || '], '
			--------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentPhoneList":[' || COALESCE((
					SELECT STRING_AGG(
						'{'
							|| kuntur.json_att_util('id', enrrollment_phone.id::VARCHAR, '"', ', ', false)
							|| kuntur.json_att_util('erased', enrrollment_phone.erased::VARCHAR, '', ', ' , true)
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(enrrollment_phone.country_code)::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('phoneNumber', enrrollment_phone.phone_number::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('comment', enrrollment_phone.comment::VARCHAR, '"', ' ' , true)						
						|| '}', ', ') AS json		
					FROM kuntur.enrrollment_phone
					WHERE enrrollment.id = enrrollment_phone.enrrollment_id 
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------
			|| '"enrrollmentIdentityList":['  || COALESCE((
					SELECT STRING_AGG(
						'{'
							|| kuntur.json_att_util('id', enrrollment_identity.id::VARCHAR, '"', ', ', false)
							|| kuntur.json_att_util('erased', enrrollment_identity.erased::VARCHAR, '', ', ' , true)
							|| kuntur.json_att_util('identityNumber', enrrollment_identity.identity_number::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('code', enrrollment_identity.code::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', enrrollment_identity.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(enrrollment_identity.country_code)::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('comment', enrrollment_identity.comment::VARCHAR, '"', ', ' , true)
							-------------------------------------------------------------------------------------------------------------
							|| '"personIdentityType":' ||  COALESCE(
								'{'
									|| kuntur.json_att_util('id', person_identity_type.id::VARCHAR, '"', ', ', false)
									|| kuntur.json_att_util('code', person_identity_type.code::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('name', person_identity_type.name::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('countryCode', kuntur.json_att_util(person_identity_type.country_code)::VARCHAR, '"', ' ' , true)
								|| '}', 'null') || ' '
						|| '}', ', ') AS json		
					------------------------------------------
					FROM kuntur.enrrollment_identity
					------------------------------------------
					LEFT JOIN kuntur.person_identity_type
						ON kuntur.enrrollment_identity.person_identity_type_id = person_identity_type.id
					------------------------------------------
					WHERE enrrollment.id = enrrollment_identity.enrrollment_id 
			), '')  || '], '			
			--------------------------------------------------------------------------------------------------------------			
			|| '"enrrollmentNationalityList":['  || COALESCE((

					SELECT STRING_AGG(
						'{'
							|| kuntur.json_att_util('id', enrrollment_nationality.id::VARCHAR, '"', ', ', false)
							|| kuntur.json_att_util('erased', enrrollment_nationality.erased::VARCHAR, '', ', ' , true)
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(enrrollment_nationality.country_code)::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('comment', enrrollment_nationality.comment::VARCHAR, '"', '' , true)
							-------------------------------------------------------------------------------------------------------------
						|| '}', ', ') AS json		
					FROM kuntur.enrrollment_nationality
					------------------------------------------
					WHERE enrrollment.id = enrrollment_nationality.enrrollment_id 
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------			
			|| '"enrrollmentAddressList":['  || COALESCE((
					SELECT STRING_AGG(
						'{'
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
						|| '}', ', ') AS json		
					FROM kuntur.enrrollment_address
					------------------------------------------
					WHERE enrrollment.id = enrrollment_address.enrrollment_id 
			), '')  || '], '
			
			-------------------------------------------------------------------------------------------------------------			
			|| '"enrrollmentLogList":[' || COALESCE((
				SELECT STRING_AGG( '{'
							|| kuntur.json_att_util('id', enrrollment_log.id::VARCHAR, '"', ', ', false)
							|| kuntur.json_att_util('codeStart', enrrollment_log.code_start::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('nameStart', enrrollment_log.name_start::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('codeEnd', enrrollment_log.code_end::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('nameEnd', enrrollment_log.name_end::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', ',' , true)
							-------------------------------------------------------------------------------------------------------------
							|| '"userSystem":' ||  COALESCE(
								'{'						
									|| kuntur.json_att_util('id', person.id::VARCHAR, '"', ', ', false)
									|| kuntur.json_att_util('givenName', person.given_name::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('middleName', person.middle_name::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('familyName', person.family_name::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('urlPhoto', person.url_photo::VARCHAR, '"', ', ' , true)	
									-------------------------------------------------------------------------------------------------------------
									|| kuntur.json_att_util('name', user_system.name::VARCHAR, '"', ', ' , true)
									|| kuntur.json_att_util('email', user_system.email::VARCHAR, '"', ' ' , true)

							|| '}', 'null') || ' '			
						-------------------------------------------------------------------------------------------------------------
							

						|| '}', ', ') AS json		
					FROM kuntur.enrrollment_log	
					------------------------------------------
					LEFT JOIN kuntur.user_system
						ON kuntur.enrrollment_log.user_system_id = user_system.id
					LEFT JOIN kuntur.person
						ON kuntur.user_system.id = person.id
					------------------------------------------
					WHERE enrrollment.id = enrrollment_log.enrrollment_id 
			), '')  || '], '			
			--_______________________________________________________________________________________________________
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
			|| '"uncInStudyProgramList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_study_program.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_study_program.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_study_program.subject::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('approved', unc_in_study_program.approved::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('approvedBy', unc_in_study_program.approved_by::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('fileNumber', unc_in_study_program.file_number::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('comment', unc_in_study_program.comment::VARCHAR, '"', ', ' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '
						-------------------------------------------------------------------------------------------------------------		

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_study_program
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_study_program.org_id = org.id
				------------------------------------------
				WHERE unc_in_enrrollment.id = unc_in_study_program.unc_in_enrrollment_id 
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------			
			|| '"uncInAcademicPerformanceList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('hs', unc_in_academic_performance.hs::VARCHAR, '', ',' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInGradingScale":' ||  COALESCE(
							'{'
								|| kuntur.json_att_util('id', unc_in_grading_scale.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_grading_scale.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateNumber', unc_in_grading_scale.rate_number::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateLetter', unc_in_grading_scale.rate_letter::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_grading_scale.comment::VARCHAR, '"', ' ' , true)
							|| '}'
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInStudiedType":' ||  COALESCE(

							'{'
								|| kuntur.json_att_util('id', unc_in_studied_type.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_studied_type.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('code', unc_in_studied_type.code::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('name', unc_in_studied_type.name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_studied_type.comment::VARCHAR, '"', ' ' , true)
							|| '}' 
							
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------			
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_academic_performance
				------------------------------------------
				LEFT JOIN kuntur.unc_in_grading_scale
					ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.id
				------------------------------------------
				LEFT JOIN kuntur.unc_in_studied_type
					ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.id
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_academic_performance.org_id = org.id
				------------------------------------------
				WHERE unc_in_enrrollment.id = unc_in_academic_performance.unc_in_enrrollment_id 
			), '')  || '] '
		--================================================================================================================================	
		|| '}' AS json,
		unc_in_enrrollment.id AS unc_in_enrrollment_id /*id*/
	--=================================================================================================================================
	FROM kuntur.unc_in_enrrollment	
	------------------------------------------
	JOIN kuntur.enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.id		
	------------------------------------------
	LEFT JOIN kuntur.org
		ON kuntur.enrrollment.org_id = org.id		
	------------------------------------------
	LEFT JOIN kuntur.admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id	
	------------------------------------------
	LEFT JOIN kuntur.enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id	
	--================================================================================================
	WHERE unc_in_enrrollment.id  = $1
			
		) e
	--------------------------------------------------------------------------------------		
		
		INNER JOIN
			(	
				SELECT	count(*) as canti, x.enrrollment_id 
				FROM 	kuntur.enrrollment_stakeholder x 
				WHERE 	x.user_system_id = $2::VARCHAR  
					AND x.enrrollment_id = $1
					AND (x.code = 1 OR x.code = 2 OR x.code = 3)	
				GROUP BY x.enrrollment_id 
				HAVING count(*) > 0

			) x
		ON	x.enrrollment_id = $1
		WHERE 	$1 IS NOT NULL 
			AND CHAR_LENGTH(TRIM($1)) > 0 
			AND TRIM($1) = e.unc_in_enrrollment_id
			
		;
$$ LANGUAGE SQL;



-- SELECT id FROM kuntur.user_system WHERE name = '46385'

-- SELECT  * FROM kuntur.f_find_enrrollment_by_id ((SELECT x.id FROM kuntur.enrrollment x LIMIT 1), (SELECT id FROM kuntur.user_system WHERE name = '46385'));

-- SELECT * FROM 	kuntur.f_find_enrrollment_by_id ('489090264c037dd8014c99e1b3fe036b', (SELECT id FROM kuntur.user_system WHERE name = '46385'));

/*

COPY (SELECT json FROM kuntur.v_unc_in_enrrollment_json_a) TO '/home/java/Descargas/json.sql';



COPY (SELECT  * FROM kuntur.f_find_enrrollment_by_id ((SELECT x.id FROM kuntur.enrrollment x LIMIT 1), (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';
	

COPY (SELECT  * FROM kuntur.f_find_enrrollment_by_id ('489090264c037dd8014c99e1b3fe036b', (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';

COPY (SELECT  * FROM kuntur.f_find_enrrollment_by_id ('000000003ed279e4013ed2f017000376', (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';

select 	unc_in_enrrollment.* 
from 	kuntur.unc_in_enrrollment 
join 	kuntur.unc_in_academic_performance 
	on unc_in_enrrollment.id = unc_in_academic_performance.unc_in_enrrollment_id 

*/
-- Function: kuntur.f_find_study_program_by_id(character varying, character varying)

-- DROP FUNCTION kuntur.f_find_study_program_by_id(character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_find_study_program_by_id(inenrrollment_id character varying, user_system_id character varying)
  RETURNS SETOF character varying AS
$BODY$
	
		
		SELECT 	('{ ' || '"guiView":"' || kuntur.gui_type($1, $2) || '", ' || '"data":' ||  COALESCE(e.json, 'null') || '} ') AS json		
		FROM 	(

	SELECT 
		--================================================================================================================================
		'{'
			
			-------------------------------------------------------------------------------------------------------------			
			|| '"uncInStudyProgramList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_study_program.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_study_program.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_study_program.subject::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('approved', unc_in_study_program.approved::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('approvedBy', unc_in_study_program.approved_by::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('fileNumber', unc_in_study_program.file_number::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('comment', unc_in_study_program.comment::VARCHAR, '"', ', ' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '
						-------------------------------------------------------------------------------------------------------------		

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_study_program
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_study_program.org_id = org.id				
				------------------------------------------
				WHERE 	unc_in_enrrollment.id = unc_in_study_program.unc_in_enrrollment_id 
					
					AND (
						(SELECT kuntur.gui_type($1, $2)) = '0' 
						OR (
							SELECT 	COUNT(*)
							FROM	kuntur.unc_in_academic_coordinator x
							WHERE	x.person_id = $2
								AND x.org_id = org.id						

						) > 0
						OR (
							SELECT 	COUNT(*)
							FROM	kuntur.unc_in_academic_office x
							WHERE	x.person_id = $2
								AND x.org_id = org.id						

						) > 0
						OR enrrollment.student_id = $2
					)
						
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------			
			|| '"uncInAcademicPerformanceList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('hs', unc_in_academic_performance.hs::VARCHAR, '', ',' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInGradingScale":' ||  COALESCE(
							'{'
								|| kuntur.json_att_util('id', unc_in_grading_scale.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_grading_scale.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateNumber', unc_in_grading_scale.rate_number::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateLetter', unc_in_grading_scale.rate_letter::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_grading_scale.comment::VARCHAR, '"', ' ' , true)
							|| '}'
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInStudiedType":' ||  COALESCE(

							'{'
								|| kuntur.json_att_util('id', unc_in_studied_type.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_studied_type.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('code', unc_in_studied_type.code::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('name', unc_in_studied_type.name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_studied_type.comment::VARCHAR, '"', ' ' , true)
							|| '}' 
							
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------			
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_academic_performance
				------------------------------------------
				LEFT JOIN kuntur.unc_in_grading_scale
					ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.id
				------------------------------------------
				LEFT JOIN kuntur.unc_in_studied_type
					ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.id
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_academic_performance.org_id = org.id
				------------------------------------------
				WHERE unc_in_enrrollment.id = unc_in_academic_performance.unc_in_enrrollment_id 
				AND (
						(SELECT kuntur.gui_type($1, $2)) = '0' 
						OR (
							SELECT 	COUNT(*)
							FROM	kuntur.unc_in_academic_office x
							WHERE	x.person_id = $2
								AND x.org_id = org.id						

						) > 0
					)
				
			), '')  || '] '
		--================================================================================================================================	
		|| '}' AS json,
		unc_in_enrrollment.id AS unc_in_enrrollment_id /*id*/
	--=================================================================================================================================
	FROM kuntur.unc_in_enrrollment	
	------------------------------------------
	JOIN kuntur.enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.id		
	------------------------------------------
	LEFT JOIN kuntur.org
		ON kuntur.enrrollment.org_id = org.id		
	------------------------------------------
	LEFT JOIN kuntur.admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id	
	------------------------------------------
	LEFT JOIN kuntur.enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id	
	--================================================================================================
	WHERE unc_in_enrrollment.id  = $1
			
		) e
	--------------------------------------------------------------------------------------		
		
		INNER JOIN
			(	
				SELECT	count(*) as canti, x.enrrollment_id 
				FROM 	kuntur.enrrollment_stakeholder x 
				WHERE 	x.user_system_id = $2::VARCHAR  
					AND x.enrrollment_id = $1
					AND (x.code = 1 OR x.code = 2 OR x.code = 3)	
				GROUP BY x.enrrollment_id 
				HAVING count(*) > 0

			) x
		ON	x.enrrollment_id = $1
		WHERE 	$1 IS NOT NULL 
			AND CHAR_LENGTH(TRIM($1)) > 0 
			AND TRIM($1) = e.unc_in_enrrollment_id
			
		;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION kuntur.f_find_study_program_by_id(character varying, character varying)
  OWNER TO postgres;


/*
SELECT * 
FROM kuntur.enrrollment_stakeholder 
JOIN kuntur.person
	ON person.id = enrrollment_stakeholder.user_system_id
WHERE enrrollment_id = '489090264c037dd8014d1e72dc3f0666'

SELECT * FROM kuntur.enrrollment WHERE number_enrrollment = 898

COPY (SELECT  * FROM kuntur.f_find_study_program_by_id ('489090264c037dd8014d1e72dc3f0666', (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';

COPY (SELECT  * FROM kuntur.f_find_study_program_by_id ('489090264c037dd8014d1e72dc3f0666', 'f1cc9355-2288-45d1-9537-9f38cab18aaf'))
TO '/home/java/Descargas/json.sql';
*/

DROP FUNCTION IF EXISTS kuntur.f_role_stakeholder(inenrrollment_id VARCHAR, user_system_id VARCHAR, ukey VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_role_stakeholder(inenrrollment_id VARCHAR, user_system_id VARCHAR, ukey VARCHAR) RETURNS VARCHAR AS
$$
DECLARE    	

	gui_type VARCHAR = -1;	
    	update_ok BOOLEAN = false;

	cant_coordintator INTEGER = 0;
	cant_office INTEGER = 0;
	studenid VARCHAR = 0;
    
BEGIN

	SELECT  kuntur.gui_type($1, $2) INTO gui_type; 

	SELECT  kuntur.is_update_by_gui_type(gui_type, $3) INTO update_ok; 

	IF update_ok = true THEN

		SELECT COUNT(*) INTO cant_coordintator FROM kuntur.unc_in_academic_coordinator WHERE person_id = $2 ;

		SELECT COUNT(*) INTO cant_office FROM kuntur.unc_in_academic_office WHERE person_id = $2 ;

		SELECT student_id INTO studenid FROM kuntur.enrrollment WHERE id = $1 ;

		

		IF gui_type = '0' THEN
			RETURN 'ALL';

		ELSEIF studenid = $2 THEN
			RETURN 'STUDENT';
		ELSEIF cant_coordintator > 0 THEN
			RETURN 'COORDINATOR';	
		ELSEIF cant_office > 0 THEN
			RETURN 'OFFICE';
		ELSE
			RETURN 'NONE';
		END IF;

	END IF;

    RETURN 'NONE';
    
END;
$$ LANGUAGE plpgsql;


/*
--

SELECT * FROM kuntur.enrrollment WHERE number_enrrollment = 4;

SELECT * 
FROM kuntur.enrrollment_stakeholder 
JOIN kuntur.person
	ON person.id = enrrollment_stakeholder.user_system_id
WHERE enrrollment_id = '489090264c037dd8014c5179114f01f2'


SELECT kuntur.f_role_stakeholder('489090264c037dd8014d1e72dc3f0666', (SELECT id FROM kuntur.user_system WHERE name = '46385'), 'unc_in_study_program');

SELECT kuntur.f_role_stakeholder('489090264c037dd8014c5179114f01f2', '765b0068-8916-4d1b-a69d-d9537c1fdfcf', 'unc_in_study_program'); -- ESUDIANTE
SELECT kuntur.f_role_stakeholder('489090264c037dd8014c5179114f01f2', 'ad43f3a9-aee0-413e-88ca-5e97ae932812', 'unc_in_study_program'); -- ALL

SELECT * FROM kuntur.enrrollment WHERE number_enrrollment = 906;

SELECT * 
FROM kuntur.enrrollment_stakeholder 
JOIN kuntur.person
	ON person.id = enrrollment_stakeholder.user_system_id
WHERE enrrollment_id = '489090264c037dd8014c368f54710170'

SELECT kuntur.f_role_stakeholder('489090264c037dd8014c368f54710170', (SELECT id FROM kuntur.user_system WHERE name = '46385'), 'unc_in_study_program');

SELECT kuntur.f_role_stakeholder('489090264c037dd8014c368f54710170', 'a059ce67-4c3f-464a-bdd5-7869da608f79', 'unc_in_study_program'); -- NONE
SELECT kuntur.f_role_stakeholder('489090264c037dd8014c368f54710170', 'ad43f3a9-aee0-413e-88ca-5e97ae932812', 'unc_in_study_program'); -- ALL
SELECT kuntur.f_role_stakeholder('489090264c037dd8014c368f54710170', 'a44509a7-e027-48c3-a56c-a132780da487', 'unc_in_study_program'); -- OFFICE

SELECT name FROM kuntur.user_system WHERE id= 'a44509a7-e027-48c3-a56c-a132780da487'
SELECT name FROM kuntur.user_system WHERE id= 'ad43f3a9-aee0-413e-88ca-5e97ae932812'
SELECT name FROM kuntur.user_system WHERE id= 'a44509a7-e027-48c3-a56c-a132780da487'
*/

DROP FUNCTION IF EXISTS kuntur.f_q_enrrollment_log_json(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_q_enrrollment_log_json(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$

--......................................................................................................................

SELECT
	'{'

		|| kuntur.json_att_util('id', enrrollment_log.id::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('erased', enrrollment_log.erased::VARCHAR, '', ', ', true)

		|| kuntur.json_att_util('codeStart', enrrollment_log.code_start::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('nameStart', enrrollment_log.name_start::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('codeEnd', enrrollment_log.code_end::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('nameEnd', enrrollment_log.name_end::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', ', ', true)

		-------------------------------------------------------------------------------------------------------------

		|| '"userSystem":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', user_system.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', user_system.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('name', user_system.name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('email', user_system.email::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('givenName', person.given_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('middleName', person.middle_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('familyName', person.family_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('male', person.male::VARCHAR, '', ' ', true)
			|| '}', 'null') || ', '

		-------------------------------------------------------------------------------------------------------------

		-------------------------------------------------------------------------------------------------------------

		|| '"enrrollmentStatusA":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', enrrollment_status_a.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', enrrollment_status_a.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('code', enrrollment_status_a.code::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('name', enrrollment_status_a.name::VARCHAR, '"', ' ', true)
			|| '}', 'null') || ', '

		-------------------------------------------------------------------------------------------------------------

		-------------------------------------------------------------------------------------------------------------

		|| '"enrrollmentStatusB":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', enrrollment_status_b.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', enrrollment_status_b.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('code', enrrollment_status_b.code::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('name', enrrollment_status_b.name::VARCHAR, '"', ' ', true)
			|| '}', 'null') || ' '

		-------------------------------------------------------------------------------------------------------------
	|| '}'
FROM kuntur.enrrollment_log
	LEFT JOIN kuntur.enrrollment_status enrrollment_status_a
		ON enrrollment_status_a.id = enrrollment_log.enrrollment_status_b_id 
	LEFT JOIN kuntur.enrrollment_status enrrollment_status_b
		ON enrrollment_status_b.id = enrrollment_log.enrrollment_status_a_id 
	LEFT JOIN kuntur.user_system
		ON user_system.id = enrrollment_log.user_system_id 
		LEFT JOIN kuntur.person
			ON user_system.id = person.id 
			
WHERE kuntur.enrrollment_log.id = $1

ORDER BY enrrollment_log.promotion_date ASC;

--......................................................................................................................			
$$ LANGUAGE SQL;
			
-- SELECT kuntur.f_q_enrrollment_log_json('489090264c037dd8014c368f54710170', 'a44509a7-e027-48c3-a56c-a132780da487');
