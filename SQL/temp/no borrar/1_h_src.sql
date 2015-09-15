
-- SELECT * FROM kuntur.enrrollment_log;

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_log_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_log_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_log.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_log.erased || '', 'null') || ', "mod":"R" }, '						
			
		------------------------------------------	
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_log	

	WHERE	enrrollment_log.enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT COALESCE('[' || STRING_AGG(f_find_enrrollment_log_list, ', ')  || ']', 'null') FROM kuntur.f_find_enrrollment_log_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		