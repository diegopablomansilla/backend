
-- SELECT * FROM kuntur.enrrollment_address;

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_address_list(enrrollment_id VARCHAR, mod VARCHAR)  CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_address_list(enrrollment_id VARCHAR, mod VARCHAR) 
	RETURNS SETOF VARCHAR AS $$


	SELECT	''
	------------------------------------------	
		|| '{'
						
			|| '"id":{"val":' || COALESCE('"' || enrrollment_address.id || '"', 'null') || ', "mod":"N" }, '
			|| '"erased":{"val":' || COALESCE('' || enrrollment_address.erased || '', 'null') || ', "mod":"R" }, '						
			|| '"countryCode":{"val":' || COALESCE('"' || enrrollment_address.country_code || '"', 'null') || ', "mod":"N" }, '
			|| '"adminAreaLevel1Code":{"val":' || COALESCE('"' || enrrollment_address.admin_area_level1_code || '"', 'null') || ', "mod":"N" }, '
			|| '"adminAreaLevel2":{"val":' || COALESCE('"' || enrrollment_address.admin_area_level2 || '"', 'null') || ', "mod":"N" }, '
			|| '"locality":{"val":' || COALESCE('"' || enrrollment_address.locality || '"', 'null') || ', "mod":"N" }, '
			|| '"neighbourhood":{"val":' || COALESCE('"' || enrrollment_address.neighbourhood || '"', 'null') || ', "mod":"N" }, '
			|| '"street":{"val":' || COALESCE('"' || enrrollment_address.street || '"', 'null') || ', "mod":"N" }, '
			|| '"streetNumber":{"val":' || COALESCE('"' || enrrollment_address.street_number || '"', 'null') || ', "mod":"N" }, '
			|| '"buildingFloor":{"val":' || COALESCE('"' || enrrollment_address.building_floor || '"', 'null') || ', "mod":"N" }, '
			|| '"buildingRoom":{"val":' || COALESCE('"' || enrrollment_address.building_room || '"', 'null') || ', "mod":"N" }, '
			|| '"building":{"val":' || COALESCE('"' || enrrollment_address.building || '"', 'null') || ', "mod":"N" }, '
			|| '"postalCode":{"val":' || COALESCE('"' || enrrollment_address.postal_code || '"', 'null') || ', "mod":"N" }, '
			|| '"comment":{"val":' || COALESCE('"' || enrrollment_address.comment || '"', 'null') || ', "mod":"N" }, '
			|| '"lat":{"val":' || COALESCE('' || enrrollment_address.lat || '', 'null') || ', "mod":"N" }, '
			|| '"lat":{"val":' || COALESCE('' || enrrollment_address.lat || '', 'null') || ', "mod":"N" } '
		------------------------------------------	
		|| '}' AS json
				
		------------------------------------------
			
		
	------------------------------------------	
	--	enrrollment_stakeholder.enrrollment_id	
	------------------------------------------	
	FROM 	kuntur.enrrollment_address	

	WHERE	enrrollment_address.enrrollment_id = $1;		

$$ LANGUAGE SQL;

SELECT '[' || STRING_AGG(f_find_enrrollment_address_list, ', ')  || ']' FROM kuntur.f_find_enrrollment_address_list('489090263ec1c856013ec1d1f0450003', 'W') ;
		
		