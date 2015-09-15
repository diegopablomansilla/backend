
DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_phone_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_phone_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_phone.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_phone.erased || '', 'null') || ', "mod":"R" }, '
			|| '"countryCode":{"val":' || COALESCE('"' || enrrollment_phone.country_code || '"', 'null') || ', "mod":"R" }, '			
			|| '"phoneNumber":{"val":' || COALESCE('"' || enrrollment_phone.phone_number || '"', 'null') || ', "mod":"R" }, '			
			|| '"comment":{"val":' || COALESCE('"' || enrrollment_phone.comment || '"', 'null') || ', "mod":"R" } '			
			
		
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_phone

	WHERE	enrrollment_phone.enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_enrrollment_phone_list, ', ')  || ']' FROM kuntur.f_find_enrrollment_phone_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		