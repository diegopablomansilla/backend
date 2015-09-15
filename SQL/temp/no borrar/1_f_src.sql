
-- SELECT * FROM kuntur.enrrollment_nationality;

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_nationality_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_nationality_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_nationality.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_nationality.erased || '', 'null') || ', "mod":"R" }, '
			|| '"countryCode":{"val":' || COALESCE('"' || enrrollment_nationality.country_code || '"', 'null') || ', "mod":"R" }, '						
			|| '"comment":{"val":' || COALESCE('"' || enrrollment_nationality.comment || '"', 'null') || ', "mod":"R" } '								
		------------------------------------------	
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_nationality	

	WHERE	enrrollment_nationality.enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_enrrollment_nationality_list, ', ')  || ']' FROM kuntur.f_find_enrrollment_nationality_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		