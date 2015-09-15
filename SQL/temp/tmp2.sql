--================================================================================================

DROP VIEW IF EXISTS kuntur.v_unc_in_enrrollment_json CASCADE;
CREATE OR REPLACE VIEW kuntur.v_unc_in_enrrollment_json AS 
	 
		SELECT	'{"UncInEnrrollment":{'
	------------------------------------------	
				|| '"id":{"val":' || COALESCE('"' || enrrollment.id || '"', 'null') || ', "mod":"R"}, '
				|| '"erased":{"val":' || COALESCE((enrrollment.erased || ''), 'null') || ', "mod":"R"}, '
				|| '"given_name":{"val":' || COALESCE('"' || enrrollment.given_name || '"', 'null') || ', "mod":"R"}, '
				|| '"middle_name":{"val":' || COALESCE('"' || enrrollment.middle_name || '"', 'null') || ', "mod":"R"}, '
				|| '"family_name":{"val":' || COALESCE('"' || enrrollment.family_name || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_date":{"val":' || COALESCE('"' || enrrollment.birth_date || '"', 'null') || ', "mod":"R"}, '
				|| '"male":{"val":' || enrrollment.male || ', "mod":"R"}, '
				|| '"url_photo":{"val":' || COALESCE('"' || enrrollment.url_photo || '"', 'null') || ', "mod":"R"}, '
				|| '"comment":{"val":' || COALESCE('"' || enrrollment.comment || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_country_code":{"val":' || COALESCE('"' || enrrollment.birth_country_code || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_admin_area_level1_code":{"val":' || COALESCE('"' || enrrollment.birth_admin_area_level1_code || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_admin_area_level2":{"val":' || COALESCE('"' || enrrollment.birth_admin_area_level2 || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_locality":{"val":' || COALESCE('"' || enrrollment.birth_locality || '"', 'null') || ', "mod":"R"}, '
				|| '"birth_lat":{"val":' || COALESCE((enrrollment.birth_lat || ''), 'null') || ', "mod":"R"}, '
				|| '"birth_lng":{"val":' || COALESCE((enrrollment.birth_lng || ''), 'null') || ', "mod":"R"}, '		
				|| '"institution_original_name":{"val":' || COALESCE('"' || enrrollment.institution_original_name || '"', 'null') || ', "mod":"R"}, '
				|| '"institution_web_site":{"val":' || COALESCE('"' || enrrollment.institution_web_site || '"', 'null') || ', "mod":"R"}, '
				|| '"institution_country_code":{"val":' || COALESCE('"' || enrrollment.institution_country_code || '"', 'null') || ', "mod":"R"}, '
				|| '"number_enrrollment":{"val":' || COALESCE('"' || enrrollment.number_enrrollment || '"', 'null') || ', "mod":"R"}, '
				|| '"check_out_date":{"val":' || COALESCE('"' || enrrollment.check_out_date || '"', 'null') || ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------

				|| '"org":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || org.id || '"', 'null') || ', "mod":"R"}, '
						|| '"erased":{"val":' || COALESCE('' || org.erased || '', 'null') || ', "mod":"R"}, '
						|| '"short_name":{"val":' || COALESCE('"' || org.short_name || '"', 'null') || ', "mod":"R"}, '
						|| '"name":{"val":' || COALESCE('"' || org.name || '"', 'null') || ', "mod":"R"}, '
						|| '"original_name":{"val":' || COALESCE('"' || org.original_name || '"', 'null') || ', "mod":"R"}, '
						|| '"url_photo":{"val":' || COALESCE('"' || org.url_photo || '"', 'null') || ', "mod":"R"}, '
						|| '"web_site":{"val":' || COALESCE('"' || org.web_site || '"', 'null') || ', "mod":"R"}, '
						|| '"comment":{"val":' || COALESCE('"' || org.comment || '"', 'null') || ', "mod":"R"}, '
						|| '"country_code":{"val":' || COALESCE('"' || org.country_code || '"', 'null') || ', "mod":"R"}, '
						|| '"primary_org":{"val":' || COALESCE('' || org.primary_org || '', 'null') || ', "mod":"R"}, '
						|| '"code_ona":{"val":' || COALESCE('' || org.code_ona || '', 'null') || ', "mod":"R"}, '
						|| '"code_guarani":{"val":' || COALESCE('"' || org.code_guarani || '"', 'null') || ', "mod":"R"}'
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
						|| '"file_number":{"val":' || COALESCE('' || student.file_number  || '', 'null') || ', "mod":"R"}, '
						|| '"institution_original_name":{"val":' || COALESCE('"' || student.institution_original_name  || '"', 'null') || ', "mod":"R"}, '
						|| '"institution_web_site":{"val":' || COALESCE('"' || student.institution_web_site  || '"', 'null') || ', "mod":"R"} ,'
						|| '"institution_country_code":{"val":' || COALESCE('"' || student.institution_country_code  || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '

				--------------------------------------------------------------------------------------------------------------------------
				|| '"admissionPeriod":{"val":' 
					|| '{'
						'"id":{"val":' || COALESCE('"' || admission_period.id  || '"', 'null') || ', "mod":"R"}, '
						'"erased":{"val":' || COALESCE('' || student.erased  || '', 'null') || ', "mod":"R"}, '
						'"number_admission_period":{"val":' || COALESCE('' || admission_period.number_admission_period  || '', 'null') || ', "mod":"R"}, '
						'"in_type":{"val":' || COALESCE('' || admission_period.in_type  || '', 'null') || ', "mod":"R"}, '
						'"year":{"val":' || COALESCE('' || admission_period.year  || '', 'null') || ', "mod":"R"}, '
						'"semester":{"val":' || COALESCE('' || admission_period.semester  || '', 'null') || ', "mod":"R"}, '
						'"title":{"val":' || COALESCE('"' || admission_period.title  || '"', 'null') || ', "mod":"R"}, '
						'"from_date":{"val":' || COALESCE('"' || admission_period.from_date  || '"', 'null') || ', "mod":"R"}, '
						'"to_date":{"val":' || COALESCE('"' || admission_period.to_date  || '"', 'null') || ', "mod":"R"}, '
						'"comment":{"val":' || COALESCE('"' || admission_period.comment  || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				|| '"enrrollmentStatus":{"val":' 
					|| '{'
						|| '"status_id":{"val":' || COALESCE('"' || enrrollment_status.id  || '"', 'null') || ', "mod":"R"}, '
						|| '"status_erased":{"val":' || COALESCE('' || enrrollment_status.erased  || '', 'null') || ', "mod":"R"}, '
						|| '"status_code":{"val":' || COALESCE('"' || enrrollment_status.code  || '"', 'null') || ', "mod":"R"}, '
						|| '"status_name":{"val":' || COALESCE('"' || enrrollment_status.name  || '"', 'null') || ', "mod":"R"}, '
						|| '"status_comment":{"val":' || COALESCE('"' || enrrollment_status.comment || '"', 'null') || ', "mod":"R"}'
					|| '}'
				|| ', "mod":"R"}, '
				--------------------------------------------------------------------------------------------------------------------------
				
				--|| '"id":{"val":' || COALESCE('"' || unc_in_enrrollment.id || '"', 'null') || ', "mod":"R"}, '
				|| '"erased":{"val":' || COALESCE('' || unc_in_enrrollment.erased  || '', 'null') || ', "mod":"R"}, '
				|| '"agreement":{"val":' || COALESCE('' || unc_in_enrrollment.agreement  || '', 'null') || ', "mod":"R"}, '
				|| '"program":{"val":' || COALESCE('' || unc_in_enrrollment.program  || '', 'null') || ', "mod":"R"}, '
				|| '"amount_paid":{"val":' || COALESCE('' || unc_in_enrrollment.amount_paid  || '', 'null') || ', "mod":"R"}, '
				|| '"original_doc":{"val":' || COALESCE('"' || unc_in_enrrollment.original_doc  || '"', 'null') || ', "mod":"R"}, '
				|| '"insurance":{"val":' || COALESCE('' || unc_in_enrrollment.insurance  || '', 'null') || ', "mod":"R"}, '
				|| '"language_certificate":{"val":' || COALESCE('' || unc_in_enrrollment.language_certificate  || '', 'null') || ', "mod":"R"}, '
				|| '"visa":{"val":' || COALESCE('"' || unc_in_enrrollment.visa  || '"', 'null') || ', "mod":"R"}, '
				|| '"emergency_contact":{"val":' || COALESCE('"' || unc_in_enrrollment.emergency_contact  || '"', 'null') || ', "mod":"R"}, '
				|| '"credential_code":{"val":' || COALESCE('"' || unc_in_enrrollment.credential_code  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_origininal_transcript":{"val":' || COALESCE('"' || unc_in_enrrollment.url_origininal_transcript  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_passport":{"val":' || COALESCE('"' || unc_in_enrrollment.url_passport  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_language_certificate":{"val":' || COALESCE('"' || unc_in_enrrollment.url_language_certificate  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_cv":{"val":' || COALESCE('"' || unc_in_enrrollment.url_cv  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_application_letter":{"val":' || COALESCE('"' || unc_in_enrrollment.url_application_letter  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_certificate_psychophysical":{"val":' || COALESCE('"' || unc_in_enrrollment.url_certificate_psychophysical  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_admission_act":{"val":' || COALESCE('"' || unc_in_enrrollment.url_admission_act  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_admission_act_template":{"val":' || COALESCE('"' || unc_in_enrrollment.url_admission_act_template  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_transcript":{"val":' || COALESCE('"' || unc_in_enrrollment.url_transcript  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_transcript_template":{"val":' || COALESCE('"' || unc_in_enrrollment.url_transcript_template  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_university_credential":{"val":' || COALESCE('"' || unc_in_enrrollment.url_university_credential  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_student_report":{"val":' || COALESCE('"' || unc_in_enrrollment.url_student_report  || '"', 'null') || ', "mod":"R"}, '
				|| '"url_exchange_form":{"val":' || COALESCE('"' || unc_in_enrrollment.url_exchange_form  || '"', 'null') || ', "mod":"R"}, '
				|| '"comment":{"val":' || COALESCE('"' || unc_in_enrrollment.comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"observation":{"val":' || COALESCE('"' || unc_in_enrrollment.observation  || '"', 'null') || ', "mod":"R"}, '
				|| '"creation_date_postulation":{"val":' || COALESCE('"' || unc_in_enrrollment.creation_date_postulation  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreement_name":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_name  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreement_comment":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreement_number_students":{"val":' || COALESCE('' || unc_in_enrrollment.agreement_number_students  || '', 'null') || ', "mod":"R"}, '
				|| '"agreement_org":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_org  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreement_org_comment":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_org_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"agreement_academic_unit":{"val":' || COALESCE('"' || unc_in_enrrollment.agreement_academic_unit  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchange_program_name":{"val":' || COALESCE('"' || unc_in_enrrollment.exchange_program_name  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchange_program_comment":{"val":' || COALESCE('"' || unc_in_enrrollment.exchange_program_comment  || '"', 'null') || ', "mod":"R"}, '
				|| '"exchange_program_number_students":{"val":' || COALESCE('' || unc_in_enrrollment.exchange_program_number_students  || '', 'null') || ', "mod":"R"}, '
				|| '"exchange_program_initial_number_students":{"val":' || COALESCE('' || unc_in_enrrollment.exchange_program_initial_number_students  || '', 'null') || ', "mod":"R"} '
				
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
