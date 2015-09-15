
-- SELECT * FROM kuntur.unc_in_academic_performance WHERE unc_in_enrrollment_id = '489090263ec1c856013ec1d1f0450003';	


DROP FUNCTION IF EXISTS kuntur.f_find_unc_in_academic_performance_list(unc_in_enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_unc_in_academic_performance_list(unc_in_enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || unc_in_academic_performance.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || unc_in_academic_performance.erased || '', 'null') || ', "mod":"R" }, '		
			|| '"subject":{"val":' || COALESCE('"' || TRIM(unc_in_academic_performance.subject) || '"', 'null') || ', "mod":"R" }, '		
			|| '"hs":{"val":' || COALESCE('' || unc_in_academic_performance.hs || '', 'null') || ', "mod":"R" }, '				

			------------------------------------------
			|| '"uncInGradingScale":{"val":' 
				|| COALESCE(''	|| '{'
					
					--|| '"id":{"val":' || COALESCE('"' || unc_in_grading_scale.id || '"', 'null') || ', "mod":"R"}, '
					|| '"id":{"val":' || '"' || null || '"' || ', "mod":"R"}, '
					|| '"erased":{"val":' || COALESCE('' || unc_in_grading_scale.erased || '', 'null') || ', "mod":"R"}, '
					|| '"rateNumber":{"val":' || COALESCE('' || unc_in_grading_scale.rate_number || '', 'null') || ', "mod":"R"}, '
					|| '"rateLetter":{"val":' || COALESCE('"' || unc_in_grading_scale.rate_letter || '"', 'null') || ', "mod":"R"}, '
					|| '"comment":{"val":' || COALESCE('"' || unc_in_grading_scale.comment || '"', 'null') || ', "mod":"R"} '
					
				|| '}', 'null')
			|| ', "mod":"R"}, '			
		------------------------------------------
			|| '"uncInStudiedType":{"val":' 
				|| '{'
					|| '"id":{"val":' || COALESCE('"' || unc_in_studied_type.id || '"', 'null') || ', "mod":"R"}, '
					|| '"erased":{"val":' || COALESCE('' || unc_in_studied_type.erased || '', 'null') || ', "mod":"R"}, '
					|| '"code":{"val":' || COALESCE('"' || unc_in_studied_type.code || '"', 'null') || ', "mod":"R"}, '
					|| '"name":{"val":' || COALESCE('"' || unc_in_studied_type.name || '"', 'null') || ', "mod":"R"}, '
					|| '"comment":{"val":' || COALESCE('"' || unc_in_studied_type.comment || '"', 'null') || ', "mod":"R"} '
				|| '}'
			|| ', "mod":"R"}, '		
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
	FROM 	kuntur.unc_in_academic_performance		
	------------------------------------------	
	LEFT JOIN kuntur.unc_in_grading_scale unc_in_grading_scale
		ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.id
	------------------------------------------
	LEFT JOIN kuntur.unc_in_studied_type unc_in_studied_type
		ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.id
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.unc_in_academic_performance.org_id = org.id
		
	WHERE	unc_in_academic_performance.unc_in_enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_unc_in_academic_performance_list, ', ')  || ']' FROM kuntur.f_find_unc_in_academic_performance_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		