DROP FUNCTION IF EXISTS kuntur.is_update_by_gui_type( gui_type VARCHAR, ukey VARCHAR ) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.is_update_by_gui_type( gui_type VARCHAR, ukey VARCHAR ) RETURNS BOOLEAN AS
$$
DECLARE
    
BEGIN
	IF $1 IS NULL OR CHAR_LENGTH(TRIM($1)) = 0 THEN

		RETURN false;

	ELSEIF $1 = '0' THEN

		RETURN true;	
	
	ELSEIF $2 = 'enrrollment.given_name' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;		

	ELSEIF $2 = 'enrrollment.middle_name' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;		

	ELSEIF $2 = 'enrrollment.family_name' AND ($1 = '1A' OR $1 = '3C')  THEN

		RETURN true;	

	ELSEIF $2 = 'enrrollment.birth_date' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'enrrollment.male' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;		

	ELSEIF $2 = 'enrrollment.url_photo' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;				


	ELSEIF $2 = 'enrrollment.birth_country_code' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;


	ELSEIF $2 = 'enrrollment.institution_original_name' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'enrrollment.institution_web_site' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'enrrollment.institution_country_code' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'enrrollment.org_id' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.emergency_contact' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.url_origininal_transcript' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.url_passport' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.url_language_certificate' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.url_cv' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;

	ELSEIF $2 = 'unc_in_enrrollment.url_application_letter' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'unc_in_enrrollment.url_certificate_psychophysical' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'enrrollment_nationality' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'enrrollment_address' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'enrrollment_phone' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;																		

	ELSEIF $2 = 'enrrollment_email' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;																			

	ELSEIF $2 = 'enrrollment_identity' AND ($1 = '1A' OR $1 = '3C') THEN

		RETURN true;	

	ELSEIF $2 = 'unc_in_study_program' AND ($1 = '1A' OR $1 = '3C' OR $1 = '4D' OR $1 = '5E' OR $1 = '7G' OR $1 = '8H') THEN

		RETURN true;	

	ELSEIF $2 = 'unc_in_academic_performance' AND $1 = '10J' THEN

		RETURN true;					

	ELSE

		RETURN false;																				

	END IF;


    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.is_update(inenrrollment_id VARCHAR, user_system_id VARCHAR, sql VARCHAR, ukey VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.is_update(inenrrollment_id VARCHAR, user_system_id VARCHAR, sql VARCHAR, ukey VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE
	
    	gui_type VARCHAR = -1;	
    	update_ok BOOLEAN = false;	
    	i int;
    
BEGIN

	IF $1 IS NULL OR CHAR_LENGTH(TRIM($1)) = 0 THEN

		RAISE EXCEPTION 'El argumento (1) inenrrollment_id es requerido';

	ELSEIF $2 IS NULL OR CHAR_LENGTH(TRIM($2)) = 0 THEN

		RAISE EXCEPTION 'El argumento (2) user_system_id es requerido';

	ELSEIF $3 IS NULL OR CHAR_LENGTH(TRIM($3)) = 0 THEN

		RAISE EXCEPTION 'El argumento (3) sql es requerido';	

	ELSEIF $4 IS NULL OR CHAR_LENGTH(TRIM($4)) = 0 THEN

		RAISE EXCEPTION 'El argumento (4) ukey es requerido';	

	ELSE

		SELECT  kuntur.gui_type($1, $2) INTO gui_type; 
		SELECT  kuntur.is_update_by_gui_type(gui_type, $4) INTO update_ok; 

		IF update_ok = true THEN	

			-- RAISE EXCEPTION 'TIENE PERMISOS PARA EJECUTAR';	
		
			EXECUTE $3;			

			GET DIAGNOSTICS i = ROW_COUNT;

			IF i > 0 THEN 

				RETURN true;

			ELSE

				RETURN false;	

			END IF;	

		

		ELSE

			RETURN false;	
			
		END IF;
		

	END IF;

	RETURN false;
    
END;
$$ LANGUAGE plpgsql;

/*

select kuntur.is_update(

	(SELECT x.id FROM kuntur.enrrollment x OFFSET 66 LIMIT 1), 
	(SELECT id FROM kuntur.user_system WHERE name = '46385'), 
	'UPDATE kuntur.enrrollment SET given_name = ''ROGELIO'' WHERE id = ''' || (SELECT x.id FROM kuntur.enrrollment x OFFSET 66 LIMIT 1) || ''' ',
	'enrrollment.given_name'
	
	);
	
*/



-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_names(inenrrollment_id VARCHAR, user_system_id VARCHAR, given_name VARCHAR, middle_name VARCHAR, family_name VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_names(inenrrollment_id VARCHAR, user_system_id VARCHAR, given_name VARCHAR, middle_name VARCHAR,family_name VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	

	fn VARCHAR = 'null';
	mn VARCHAR = 'null';
	gn VARCHAR = 'null';
	
	sql VARCHAR = null;
    
BEGIN

	IF family_name IS NOT NULL AND CHAR_LENGTH(TRIM(family_name)) > 0 THEN

		fn = '''' || INITCAP(TRIM(family_name)) || '''';
	
	END IF;	

	IF middle_name IS NOT NULL AND CHAR_LENGTH(TRIM(middle_name)) > 0 THEN

		mn = '''' || INITCAP(TRIM(middle_name)) || '''';
	
	END IF;	

	IF given_name IS NOT NULL AND CHAR_LENGTH(TRIM(given_name)) > 0 THEN

		gn = '''' || INITCAP(TRIM(given_name)) || '''';
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET family_name = ' || fn || ', middle_name = ' || mn || ', given_name = ' || gn || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.family_name') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM kuntur.enrrollment WHERE family_name ilike '%mansilla%';

select kuntur.f_u_enrrollment_names(

	(SELECT x.id FROM kuntur.enrrollment x ORDER BY id OFFSET 66 LIMIT 1), 
	(SELECT id FROM kuntur.user_system WHERE name = '46385'), 
	'diego',
	null,
	'mansilla'
	
	);

SELECT * FROM kuntur.enrrollment WHERE family_name ilike '%mansilla%';
	
*/


-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_birth_date(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_date DATE) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_birth_date(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_date DATE) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	bd VARCHAR = 'null';	
	sql VARCHAR = null;
    
BEGIN

	IF birth_date IS NOT NULL THEN

		bd = birth_date;
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET birth_date = ' || bd || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.birth_date') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_male(inenrrollment_id VARCHAR, user_system_id VARCHAR, male BOOLEAN) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_male(inenrrollment_id VARCHAR, user_system_id VARCHAR, male BOOLEAN) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF male IS NOT NULL THEN

		m = male;
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET male = ' || m || ' WHERE id = ''' || $1 || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.male') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_url_photo(inenrrollment_id VARCHAR, user_system_id VARCHAR, url_photo VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_url_photo(inenrrollment_id VARCHAR, user_system_id VARCHAR, url_photo VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	up VARCHAR = 'null';	
	sql VARCHAR = null;
    
BEGIN

	IF url_photo IS NOT NULL AND CHAR_LENGTH(TRIM(url_photo)) > 0 THEN

		up = '''' || TRIM(url_photo) || '''';
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET url_photo = ' || up || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.url_photo') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_birth_country_code(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_country_code VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_birth_country_code(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_country_code VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	bcc VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN

	IF birth_country_code IS NOT NULL AND CHAR_LENGTH(TRIM(birth_country_code)) > 0 THEN

		bcc = '''' || TRIM(birth_country_code) || '''';
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET birth_country_code = ' || bcc || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.birth_country_code') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_org_id(inenrrollment_id VARCHAR, user_system_id VARCHAR, org_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_org_id(inenrrollment_id VARCHAR, user_system_id VARCHAR, org_id VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	oid VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN

	IF org_id IS NOT NULL AND CHAR_LENGTH(TRIM(org_id)) > 0 THEN

		oid = '''' || TRIM(org_id) || '''';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET org_id = ' || oid || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.org_id') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_institution_original_name(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_institution_original_name(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	ion VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN

	IF institution_original_name IS NOT NULL AND CHAR_LENGTH(TRIM(institution_original_name)) > 0 THEN

		ion = '''' || TRIM(institution_original_name) || '''';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET institution_original_name = ' || ion || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.institution_original_name') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_institution_web_site(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_web_site VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_institution_web_site(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_web_site VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	iws VARCHAR = 'null';	
	sql VARCHAR = null;
    
BEGIN

	IF institution_web_site IS NOT NULL AND CHAR_LENGTH(TRIM(institution_web_site)) > 0 THEN

		iws = '''' || TRIM(institution_web_site) || '''';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET institution_web_site = ' || iws || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.institution_web_site') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_institution_country_code(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_country_code VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_institution_country_code(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_country_code VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	icc VARCHAR = 'null';		
	sql VARCHAR = null;
    
BEGIN

	IF institution_country_code IS NOT NULL AND CHAR_LENGTH(TRIM(institution_country_code)) > 0 THEN

		icc = '''' || TRIM(institution_country_code) || '''';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET institution_country_code = ' || icc || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.institution_country_code') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------	