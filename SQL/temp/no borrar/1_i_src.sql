
-- SELECT * FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = '489090263ec1c856013ec1d1f0450003';	


DROP FUNCTION IF EXISTS kuntur.f_find_unc_in_study_program_list(unc_in_enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_unc_in_study_program_list(unc_in_enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || unc_in_study_program.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || unc_in_study_program.erased || '', 'null') || ', "mod":"R" }, '		
			|| '"subjects":{"val":' || COALESCE('"' || TRIM(unc_in_study_program.subjects) || '"', 'null') || ', "mod":"R" }, '		
			|| '"approved":{"val":' || COALESCE('' || unc_in_study_program.approved || '', 'null') || ', "mod":"R" }, '		
			|| '"approved_by":{"val":' || COALESCE('"' || unc_in_study_program.approved_by || '"', 'null') || ', "mod":"R" }, '		
			|| '"file_number":{"val":' || COALESCE('"' || unc_in_study_program.file_number || '"', 'null') || ', "mod":"R" }, '		
			|| '"comment":{"val":' || COALESCE('"' || unc_in_study_program.comment || '"', 'null') || ', "mod":"R" }, '		

			------------------------------------------			

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
			|| ', "mod":"R"} '
		------------------------------------------	
		|| '}' AS json
				
		------------------------------------------
			
	
	------------------------------------------	
	FROM 	kuntur.unc_in_study_program	
	------------------------------------------
	JOIN kuntur.org org
		ON org.id = kuntur.unc_in_study_program.org_id
	WHERE	unc_in_study_program.unc_in_enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_unc_in_study_program_list, ', ')  || ']' FROM kuntur.f_find_unc_in_study_program_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		