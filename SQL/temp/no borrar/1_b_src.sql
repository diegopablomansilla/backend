
DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_stakeholder_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_stakeholder_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_stakeholder.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_stakeholder.erased || '', 'null') || ', "mod":"R" }, '
			|| '"code":{"val":' || COALESCE('"' || enrrollment_stakeholder.code || '"', 'null') || ', "mod":"R" }, '			
		------------------------------------------
			|| '"userSystem":{"val":' 
					|| '{'
						|| '"id":{"val":' || COALESCE('"' || user_system.id || '"', 'null') || ', "mod":"R" }, '
						|| '"erased":{"val":' || COALESCE('' || user_system.erased || '', 'null') || ', "mod":"R" }, '
						|| '"name":{"val":' || COALESCE('"' || user_system.name || '"', 'null') || ', "mod":"R" }, '
						--|| '"pass":{"val":' || COALESCE('"' || user_system.pass || '"', 'null') || ', "mod":"R" }, '
						|| '"email":{"val":' || COALESCE('"' || user_system.email || '"', 'null') || ', "mod":"R" }, '
						--|| '"comment":{"val":' || COALESCE('"' || user_system.comment || '"', 'null') || ', "mod":"R" }, '	
		------------------------------------------
						--person.id AS person_id /*id*/,
						--person.erased AS person_erased /*erased*/,
						|| '"given_name":{"val":' || COALESCE('"' || person.given_name || '"', 'null') || ', "mod":"R" }, '	
						|| '"middle_name":{"val":' || COALESCE('"' || person.middle_name || '"', 'null') || ', "mod":"R" }, '	
						|| '"family_name":{"val":' || COALESCE('"' || person.family_name || '"', 'null') || ', "mod":"R" }, '	
						--|| '"birth_date":{"val":' || COALESCE('"' || person.birth_date || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"male":{"val":' || COALESCE('"' || person.male || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						|| '"url_photo":{"val":' || COALESCE('"' || person.url_photo || '"', 'null') || ', "mod":"R" } '	
						--|| '"birth_country_code":{"val":' || COALESCE('"' || person.birth_country_code || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"birth_admin_area_level1_code":{"val":' || COALESCE('"' || person.birth_admin_area_level1_code || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"birth_admin_area_level2":{"val":' || COALESCE('"' || person.birth_admin_area_level2 || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"birth_locality":{"val":' || COALESCE('"' || person.birth_locality || '"', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"birth_lat":{"val":' || COALESCE('' || person.birth_lat || '', 'null') || ', "mod":"' || $2 || '" }, '	
						--|| '"birth_lng":{"val":' || COALESCE('' || person.birth_lng || '', 'null') || ', "mod":"' || $2 || '" } '
					|| '}'
				|| ', "mod":"R" }'		
		------------------------------------------			
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_stakeholder
	------------------------------------------
	JOIN 	kuntur.user_system user_system
		ON kuntur.enrrollment_stakeholder.user_system_id = user_system.id
	------------------------------------------	
	JOIN kuntur.person
		ON user_system.id = kuntur.person.id

	WHERE	enrrollment_stakeholder.enrrollment_id	= $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_enrrollment_stakeholder_list, ', ')  || ']' FROM kuntur.f_find_enrrollment_stakeholder_list('489090263ec1c856013ec1d1f0450003', 'W') ;

--SELECT * FROM kuntur.v_enrrollment_stakeholder;		
		