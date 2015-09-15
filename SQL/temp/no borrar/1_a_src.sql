--================================================================================================

DROP VIEW IF EXISTS kuntur.v_unc_in_enrrollment_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_enrrollment_json AS 
	 
		SELECT	'{"UncInEnrrollment":{'
	------------------------------------------	
				|| '"id":{"val":' || COALESCE('"' || enrrollment.id || '"', 'null') || ', "mod":"R"}, '
				|| '"erased":{"val":' || COALESCE((enrrollment.erased || ''), 'null') || ', "mod":"R"}, '
				|| '"givenName":{"val":' || COALESCE('"' || enrrollment.given_name || '"', 'null') || ', "mod":"R"}, '
				|| '"middleName":{"val":' || COALESCE('"' || enrrollment.middle_name || '"', 'null') || ', "mod":"R"}, '
				|| '"familyName":{"val":' || COALESCE('"' || enrrollment.family_name || '"', 'null') || ', "mod":"R"}, '
				|| '"birthDate":{"val":' || COALESCE('"' || enrrollment.birth_date || '"', 'null') || ', "mod":"R"}, '
				|| '"male":{"val":' || enrrollment.male || ', "mod":"R"}, '
				|| '"urlPhoto":{"val":' || COALESCE('"' || enrrollment.url_photo || '"', 'null') || ', "mod":"R"}, '
				|| '"comment":{"val":' || COALESCE('"' || enrrollment.comment || '"', 'null') || ', "mod":"R"}, '
				|| '"birthCountryCode":{"val":' || COALESCE('"' || enrrollment.birth_country_code || '"', 'null') || ', "mod":"R"}, '
				|| '"birthAdminAreaLevel1Code":{"val":' || COALESCE('"' || enrrollment.birth_admin_area_level1_code || '"', 'null') || ', "mod":"R"}, '
				|| '"birthAdminAreaLevel2":{"val":' || COALESCE('"' || enrrollment.birth_admin_area_level2 || '"', 'null') || ', "mod":"R"}, '
				|| '"birthLocality":{"val":' || COALESCE('"' || enrrollment.birth_locality || '"', 'null') || ', "mod":"R"}, '
				|| '"birthLat":{"val":' || COALESCE((enrrollment.birth_lat || ''), 'null') || ', "mod":"R"}, '
				|| '"birthLng":{"val":' || COALESCE((enrrollment.birth_lng || ''), 'null') || ', "mod":"R"}, '		
				|| '"institutionOriginalName":{"val":' || COALESCE('"' || enrrollment.institution_original_name || '"', 'null') || ', "mod":"R"}, '
				|| '"institutionWebSite":{"val":' || COALESCE('"' || enrrollment.institution_web_site || '"', 'null') || ', "mod":"R"}, '
				|| '"institutionCountryCode":{"val":' || COALESCE('"' || enrrollment.institution_country_code || '"', 'null') || ', "mod":"R"}, '
				|| '"numberEnrrollment":{"val":' || COALESCE('"' || enrrollment.number_enrrollment || '"', 'null') || ', "mod":"R"}, '
				|| '"checkOutDate":{"val":' || COALESCE('"' || enrrollment.check_out_date || '"', 'null') || ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------

				|| '"enrrollmentStakeholderList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_stakeholder_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_stakeholder_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------

				|| '"enrrollmentEmailList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_email_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_email_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------

				|| '"enrrollmentPhoneList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_phone_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_phone_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------

				|| '"enrrollmentIdentityList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_identity_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_identity_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				
				|| '"enrrollmentNationalityList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_nationality_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_nationality_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				
				|| '"enrrollmentAddressList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_address_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_address_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				
				|| '"enrrollmentLogList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_enrrollment_log_list, ', '), '')  || ']' FROM kuntur.f_find_enrrollment_log_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '
				
				--------------------------------------------------------------------------------------------------------------------------

				|| '"org":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || org.id || '"', 'null') || ', "mod":"R"}, '
						|| '"erased":{"val":' || COALESCE('' || org.erased || '', 'null') || ', "mod":"R"}, '
						|| '"shortName":{"val":' || COALESCE('"' || org.short_name || '"', 'null') || ', "mod":"R"}, '
						|| '"name":{"val":' || COALESCE('"' || org.name || '"', 'null') || ', "mod":"R"}, '
						|| '"originalName":{"val":' || COALESCE('"' || org.original_name || '"', 'null') || ', "mod":"R"}, '
						|| '"urlPhoto":{"val":' || COALESCE('"' || org.url_photo || '"', 'null') || ', "mod":"R"}, '
						|| '"webSite":{"val":' || COALESCE('"' || org.web_site || '"', 'null') || ', "mod":"R"}, '
						|| '"comment":{"val":' || COALESCE('"' || org.comment || '"', 'null') || ', "mod":"R"}, '
						|| '"countryCode":{"val":' || COALESCE('"' || org.country_code || '"', 'null') || ', "mod":"R"}, '
						|| '"primaryOrg":{"val":' || COALESCE('' || org.primary_org || '', 'null') || ', "mod":"R"}, '
						|| '"codeOna":{"val":' || COALESCE('' || org.code_ona || '', 'null') || ', "mod":"R"}, '
						|| '"codeGuarani":{"val":' || COALESCE('"' || org.code_guarani || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
		
				--------------------------------------------------------------------------------------------------------------------------
				|| '"userSystem":{"val":' 
					|| '{'

						|| '"id":{"val":' || COALESCE('"' || user_system.id  || '"', 'null') || ', "mod":"R"}, '
						|| '"erased":{"val":' || COALESCE('' || user_system.erased  || '', 'null') || ', "mod":"R"}, '
						|| '"name":{"val":' || COALESCE('"' || user_system.name  || '"', 'null') || ', "mod":"R"}, '
						|| '"pass":{"val":' || COALESCE('"' || user_system.pass  || '"', 'null') || ', "mod":"R"}, '
						|| '"email":{"val":' || COALESCE('"' || user_system.email  || '"', 'null') || ', "mod":"R"}, '
						|| '"comment":{"val":' || COALESCE('"' || user_system.comment  || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				|| '"student":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || student.id  || '"', 'null') || ', "mod":"R"}, '
						|| '"erased":{"val":' || COALESCE('' || student.erased  || '', 'null') || ', "mod":"R"}, '
						|| '"fileNumber":{"val":' || COALESCE('' || student.file_number  || '', 'null') || ', "mod":"R"}, '
						|| '"institutionOriginalName":{"val":' || COALESCE('"' || student.institution_original_name  || '"', 'null') || ', "mod":"R"}, '
						|| '"institutionWebSite":{"val":' || COALESCE('"' || student.institution_web_site  || '"', 'null') || ', "mod":"R"} ,'
						|| '"institutionCountryCode":{"val":' || COALESCE('"' || student.institution_country_code  || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				|| '"admissionPeriod":{"val":' 
					|| '{'
						'"id":{"val":' || COALESCE('"' || admission_period.id  || '"', 'null') || ', "mod":"R"}, '
						'"erased":{"val":' || COALESCE('' || student.erased  || '', 'null') || ', "mod":"R"}, '
						'"numberAdmissionPeriod":{"val":' || COALESCE('' || admission_period.number_admission_period  || '', 'null') || ', "mod":"R"}, '
						'"inType":{"val":' || COALESCE('' || admission_period.in_type  || '', 'null') || ', "mod":"R"}, '
						'"year":{"val":' || COALESCE('' || admission_period.year  || '', 'null') || ', "mod":"R"}, '
						'"semester":{"val":' || COALESCE('' || admission_period.semester  || '', 'null') || ', "mod":"R"}, '
						'"title":{"val":' || COALESCE('"' || admission_period.title  || '"', 'null') || ', "mod":"R"}, '
						'"fromDate":{"val":' || COALESCE('"' || admission_period.from_date  || '"', 'null') || ', "mod":"R"}, '
						'"toDate":{"val":' || COALESCE('"' || admission_period.to_date  || '"', 'null') || ', "mod":"R"}, '
						'"comment":{"val":' || COALESCE('"' || admission_period.comment  || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				|| '"enrrollmentStatus":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || enrrollment_status.id  || '"', 'null') || ', "mod":"R"}, '
						|| '"erased":{"val":' || COALESCE('' || enrrollment_status.erased  || '', 'null') || ', "mod":"R"}, '
						|| '"code":{"val":' || COALESCE('"' || enrrollment_status.code  || '"', 'null') || ', "mod":"R"}, '
						|| '"name":{"val":' || COALESCE('"' || enrrollment_status.name  || '"', 'null') || ', "mod":"R"}, '
						|| '"comment":{"val":' || COALESCE('"' || enrrollment_status.comment || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				
				--|| '"id":{"val":' || COALESCE('"' || unc_in_enrrollment.id || '"', 'null') || ', "mod":"R"}, '
				|| '"erased":{"val":' || COALESCE('' || unc_in_enrrollment.erased  || '', 'null') || ', "mod":"R"}, '
				|| '"agreement":{"val":' || COALESCE('' || unc_in_enrrollment.agreement  || '', 'null') || ', "mod":"R"}, '
				|| '"program":{"val":' || COALESCE('' || unc_in_enrrollment.program  || '', 'null') || ', "mod":"R"}, '
				|| '"amountPaid":{"val":' || COALESCE('' || unc_in_enrrollment.amount_paid  || '', 'null') || ', "mod":"R"}, '
				|| '"originalDoc":{"val":' || COALESCE('"' || unc_in_enrrollment.original_doc  || '"', 'null') || ', "mod":"R"}, '
				|| '"insurance":{"val":' || COALESCE('' || unc_in_enrrollment.insurance  || '', 'null') || ', "mod":"R"}, '
				|| '"languageCertificate":{"val":' || COALESCE('' || unc_in_enrrollment.language_certificate  || '', 'null') || ', "mod":"R"}, '
				|| '"visa":{"val":' || COALESCE('"' || unc_in_enrrollment.visa  || '"', 'null') || ', "mod":"R"}, '
				|| '"emergencyContact":{"val":' || COALESCE('"' || unc_in_enrrollment.emergency_contact  || '"', 'null') || ', "mod":"R"}, '
				|| '"credentialCode":{"val":' || COALESCE('"' || unc_in_enrrollment.credential_code  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlOrigininalTranscript":{"val":' || COALESCE('"' || unc_in_enrrollment.url_origininal_transcript  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlPassport":{"val":' || COALESCE('"' || unc_in_enrrollment.url_passport  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlLanguageCertificate":{"val":' || COALESCE('"' || unc_in_enrrollment.url_language_certificate  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlCv":{"val":' || COALESCE('"' || unc_in_enrrollment.url_cv  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlApplicationLetter":{"val":' || COALESCE('"' || unc_in_enrrollment.url_application_letter  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlCertificatePsychophysical":{"val":' || COALESCE('"' || unc_in_enrrollment.url_certificate_psychophysical  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlAdmissionAct":{"val":' || COALESCE('"' || unc_in_enrrollment.url_admission_act  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlAdmissionActTemplate":{"val":' || COALESCE('"' || unc_in_enrrollment.url_admission_act_template  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlTranscript":{"val":' || COALESCE('"' || unc_in_enrrollment.url_transcript  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlTranscriptTemplate":{"val":' || COALESCE('"' || unc_in_enrrollment.url_transcript_template  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlUniversityCredential":{"val":' || COALESCE('"' || unc_in_enrrollment.url_university_credential  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlStudentReport":{"val":' || COALESCE('"' || unc_in_enrrollment.url_student_report  || '"', 'null') || ', "mod":"R"}, '
				|| '"urlExchangeForm":{"val":' || COALESCE('"' || unc_in_enrrollment.url_exchange_form  || '"', 'null') || ', "mod":"R"}, '
				|| '"comment":{"val":' || COALESCE('"' || unc_in_enrrollment.comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"observation":{"val":' || COALESCE('"' || unc_in_enrrollment.observation  || '"', 'null') || ', "mod":"R"}, '
				|| '"creationDatePostulation":{"val":' || COALESCE('"' || unc_in_enrrollment.creation_date_postulation  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreementName":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_name  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreementComment":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreementNumberStudents":{"val":' || COALESCE('' || unc_in_enrrollment.agreement_number_students  || '', 'null') || ', "mod":"R"}, '
				|| '"agreementOrg":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_org  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreementOrgComment":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_org_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreementAcademicUnit":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_academic_unit  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchangeProgramName":{"val":' || COALESCE('"' || unc_in_enrrollment.exchange_program_name  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchangeProgramComment":{"val":' || COALESCE('"' || unc_in_enrrollment.exchange_program_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchangeProgramNumberStudents":{"val":' || COALESCE('' || unc_in_enrrollment.exchange_program_number_students  || '', 'null') || ', "mod":"R"}, '
				|| '"exchangeProgramInitialNumberStudents":{"val":' || COALESCE('' || unc_in_enrrollment.exchange_program_initial_number_students  || '', 'null') || ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				
				|| '"uncInStudyProgramList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_unc_in_study_program_list, ', '), '')  || ']' FROM kuntur.f_find_unc_in_study_program_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				
				|| '"uncInAcademicPerformanceList":{"val":' 
				
					|| (SELECT '[' || COALESCE(STRING_AGG(f_find_unc_in_academic_performance_list, ', '), '')  || ']' FROM kuntur.f_find_unc_in_academic_performance_list(unc_in_enrrollment.id, 'R'))
					
				|| ', "mod":"R"} '
				
			|| '}}' AS json,
			
			unc_in_enrrollment.id		
		
	------------------------------------------	
	FROM 	kuntur.unc_in_enrrollment
	------------------------------------------
	JOIN kuntur.enrrollment
		ON kuntur.unc_in_enrrollment.id = kuntur.enrrollment.id
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.enrrollment.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.user_system user_system
		ON kuntur.enrrollment.user_system_id = user_system.id
	------------------------------------------
	JOIN kuntur.student student
		ON kuntur.enrrollment.student_id = student.id
	------------------------------------------
	JOIN kuntur.admission_period admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id
	------------------------------------------
	JOIN kuntur.enrrollment_status enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id

	WHERE	kuntur.unc_in_enrrollment.id = '489090263ec1c856013ec1d1f0450003';	

SELECT * FROM kuntur.v_unc_in_enrrollment_json;	
