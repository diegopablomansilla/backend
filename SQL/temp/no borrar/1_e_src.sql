
DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_identity_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_identity_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_identity.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_identity.erased || '', 'null') || ', "mod":"R" }, '
			|| '"identityNumber":{"val":' || COALESCE('"' || enrrollment_identity.identity_number || '"', 'null') || ', "mod":"R" }, '			
			|| '"code":{"val":' || COALESCE('"' || enrrollment_identity.code || '"', 'null') || ', "mod":"R" }, '			
			|| '"name":{"val":' || COALESCE('"' || enrrollment_identity.name || '"', 'null') || ', "mod":"R" }, '			
			|| '"countryCode":{"val":' || COALESCE('"' || enrrollment_identity.country_code || '"', 'null') || ', "mod":"R" }, '			
			|| '"comment":{"val":' || COALESCE('"' || enrrollment_identity.comment || '"', 'null') || ', "mod":"R" }, '			
			
		------------------------------------------
			|| '"personIdentityType":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || person_identity_type.id || '"', 'null') || ', "mod":"R" }, '
						|| '"erased":{"val":' || COALESCE('' || person_identity_type.erased || '', 'null') || ', "mod":"R" }, '
						|| '"code":{"val":' || COALESCE('"' || person_identity_type.code || '"', 'null') || ', "mod":"R" }, '						
						|| '"name":{"val":' || COALESCE('"' || person_identity_type.name || '"', 'null') || ', "mod":"R" }, '						
						|| '"countryCode":{"val":' || COALESCE('"' || person_identity_type.country_code || '"', 'null') || ', "mod":"R" } '						
		
					|| '}'
				|| ', "mod":"R" }'		
		------------------------------------------	
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_identity
	------------------------------------------
	LEFT JOIN 	kuntur.person_identity_type
		ON person_identity_type.id = kuntur.enrrollment_identity.person_identity_type_id

	WHERE	enrrollment_identity.enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_enrrollment_identity_list, ', ')  || ']' FROM kuntur.f_find_enrrollment_identity_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		