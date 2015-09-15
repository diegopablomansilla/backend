	SELECT 	'{' 
			|| '"unc_in_enrrollment":{'
				|| enrrollment_id || ','			
				|| enrrollment_erased || ',' 
				|| enrrollment_given_name || ',' 
				|| enrrollment_middle_name || ',' 
				|| enrrollment_family_name || ',' 
				|| enrrollment_birth_date || ',' 
				|| enrrollment_male || ',' 
				|| enrrollment_url_photo || ',' 
				|| enrrollment_comment || ',' 
				|| enrrollment_birth_country_code || ',' 
				|| enrrollment_birth_admin_area_level1_code || ',' 
				|| enrrollment_birth_admin_area_level2 || ',' 
				|| enrrollment_birth_locality || ',' 
				|| enrrollment_birth_lat || ',' 
				|| enrrollment_birth_lng || ',' 
				|| enrrollment_institution_original_name || ',' 
				|| enrrollment_institution_web_site || ',' 
				|| enrrollment_institution_country_code || ',' 
				|| enrrollment_number_enrrollment || ',' 
				|| enrrollment_check_out_date || ',' 
				-------------------------------------------------------------

				|| '"admissionPeriod":{"val":' 					
					|| '{'
						
					|| '}' 
				|| ', "mod":"R"}' || ',' 

				-------------------------------------------------------------

				|| unc_in_enrrollment_id || ',' 
				|| unc_in_enrrollment_erased || ',' 
				|| unc_in_enrrollment_agreement || ',' 
				|| unc_in_enrrollment_program || ',' 
				|| unc_in_enrrollment_amount_paid || ',' 
				|| unc_in_enrrollment_original_doc || ',' 
				|| unc_in_enrrollment_insurance || ',' 
				|| unc_in_enrrollment_language_certificate || ',' 
				|| unc_in_enrrollment_visa || ',' 
				|| unc_in_enrrollment_emergency_contact || ',' 
				|| unc_in_enrrollment_credential_code || ',' 
				|| unc_in_enrrollment_url_origininal_transcript || ',' 
				|| unc_in_enrrollment_url_passport || ',' 
				|| unc_in_enrrollment_url_language_certificate || ',' 
				|| unc_in_enrrollment_url_cv || ',' 
				|| unc_in_enrrollment_url_application_letter || ',' 
				|| unc_in_enrrollment_url_certificate_psychophysical || ','  
				|| unc_in_enrrollment_url_admission_act || ',' 
				|| unc_in_enrrollment_url_admission_act_template || ','  
				|| unc_in_enrrollment_url_transcript || ',' 
				|| unc_in_enrrollment_url_transcript_template || ',' 
				|| unc_in_enrrollment_url_university_credential || ',' 
				|| unc_in_enrrollment_url_student_report || ',' 
				|| unc_in_enrrollment_url_exchange_form || ',' 
				|| unc_in_enrrollment_comment || ',' 
				|| unc_in_enrrollment_observation || ',' 
				|| unc_in_enrrollment_creation_date_postulation || ',' 
				|| unc_in_enrrollment_agreement_name || ',' 
				|| unc_in_enrrollment_agreement_comment || ',' 
				|| unc_in_enrrollment_agreement_number_students || ',' 
				|| unc_in_enrrollment_agreement_org || ',' 
				|| unc_in_enrrollment_agreement_org_comment || ',' 
				|| unc_in_enrrollment_agreement_academic_unit || ',' 
				|| unc_in_enrrollment_exchange_program_name || ',' 
				|| unc_in_enrrollment_exchange_program_comment || ',' 
				|| unc_in_enrrollment_exchange_program_number_students || ',' 
				|| unc_in_enrrollment_exchange_program_initial_number_students 

				-------------------------------------------------------------
			|| '}'
		|| '}' AS unc_in_enrrollment_json,

			
			
		       
			org_id, 
			org_erased, 
			org_short_name, 			
			org_name, 
			org_original_name, 
			org_url_photo, 
			org_web_site, 
			org_comment, 			
			org_country_code, 
			org_primary_org, 
			org_code_ona, 
			org_code_guarani, 
			
		       user_system_id, 
			user_system_erased, 
			user_system_name, 
			user_system_pass, 
			
		       user_system_email, 
			user_system_comment, 
			student_id, 
			student_erased, 
			
		       student_file_number, 
			student_institution_original_name, 
			student_institution_web_site, 
			
		       student_institution_country_code, 
			admission_period_id, 
			admission_period_erased, 
			
		       admission_period_number_admission_period, 
			admission_period_in_type, 
			
		       admission_period_year, 
			admission_period_semester, 
			admission_period_title, 
			
		       admission_period_from_date, 
			admission_period_to_date, 
			admission_period_comment, 
			
		       enrrollment_status_id, 
			enrrollment_status_erased, 
			enrrollment_status_code, 
			
		       enrrollment_status_name, 
			enrrollment_status_comment

			
			
		
	  FROM kuntur.v_unc_in_enrrollment_json_tmp;
