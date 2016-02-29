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


---------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_orgs(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR, institution_web_site VARCHAR, institution_country_code VARCHAR
,institution_short_name VARCHAR, institution_name VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_orgs(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR, institution_web_site VARCHAR,institution_country_code VARCHAR
,institution_short_name VARCHAR, institution_name VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	

	ic VARCHAR = 'null';
	iw VARCHAR = 'null';
	io VARCHAR = 'null';
	inn VARCHAR = 'null';
	iss VARCHAR = 'null';
	
	sql VARCHAR = null;
    
BEGIN

	IF institution_country_code IS NOT NULL AND CHAR_LENGTH(TRIM(institution_country_code)) > 0 THEN

		ic = '''' || UPPER(TRIM(institution_country_code)) || '''';
	
	END IF;	

	IF institution_web_site IS NOT NULL AND CHAR_LENGTH(TRIM(institution_web_site)) > 0 THEN

		iw = '''' || LOWER(TRIM(institution_web_site)) || '''';
	
	END IF;	

	IF institution_original_name IS NOT NULL AND CHAR_LENGTH(TRIM(institution_original_name)) > 0 THEN

		io = '''' || INITCAP(TRIM(institution_original_name)) || '''';
	
	END IF;	

	IF institution_short_name IS NOT NULL AND CHAR_LENGTH(TRIM(institution_original_name)) > 0 THEN

		iss = '''' || INITCAP(TRIM(institution_short_name)) || '''';
	
	END IF;	

	IF institution_name IS NOT NULL AND CHAR_LENGTH(TRIM(institution_name)) > 0 THEN

		inn = '''' || INITCAP(TRIM(institution_name)) || '''';
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET institution_name = ' || inn || ',institution_short_name = ' || iss || ', institution_original_name = ' || io || ', institution_web_site = ' || iw || ', institution_country_code = ' || ic || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.family_name') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_email(inenrrollment_id VARCHAR, user_system_id VARCHAR, mail VARCHAR, mailId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_email(inenrrollment_id VARCHAR, user_system_id VARCHAR, mail VARCHAR, mailId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF mail IS NOT NULL THEN

		m = mail;
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment_email SET email = ''' || m || ''' WHERE id = ''' || mailId || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_email.email') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


----------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Insertemail(inenrrollment_id VARCHAR, user_system_id VARCHAR, mail VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Insertemail(inenrrollment_id VARCHAR, user_system_id VARCHAR, mail VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF mail IS NOT NULL THEN

		m = mail;
	
	END IF;

	sql = 'INSERT INTO kuntur.enrrollment_email(id, erased, email, comment, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, ''' || m || ''', '''', ''' || $1 || ''') ';

	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_email.email') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Deleteemail(inenrrollment_id VARCHAR, user_system_id VARCHAR, mailId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Deleteemail(inenrrollment_id VARCHAR, user_system_id VARCHAR, mailId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF mailId IS NOT NULL THEN

		m = mailId;
	
	END IF;	

	sql = 'DELETE FROM kuntur.enrrollment_email WHERE id = ''' || m || ''' ';

	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_email.email') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


----------------------------------------------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_phone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phone VARCHAR, country_code VARCHAR, phoneId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_phone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phone VARCHAR, country_code VARCHAR, phoneId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	p VARCHAR = 'null';
	c VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF phone IS NOT NULL AND country_code IS NOT NULL THEN

		p = phone;
		C = country_code;
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment_phone SET phone_number = ''' || p || ''',country_code = ''' || c || ''' WHERE id = ''' || phoneId || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_phone.phone_number') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Insertphone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phone VARCHAR, country_code VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Insertphone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phone VARCHAR, country_code VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	p VARCHAR = 'null';
	c VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF phone IS NOT NULL AND country_code IS NOT NULL THEN

		p = phone;
		c = country_code;
	
	END IF;

	sql = 'INSERT INTO kuntur.enrrollment_phone(id, erased, country_code, phone_number, comment, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, ''' || c || ''', ''' || p || ''', '''', ''' || $1 || ''') ';

	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_email.email') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Deletephone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phoneId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Deletephone(inenrrollment_id VARCHAR, user_system_id VARCHAR, phoneId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	p VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF phoneId IS NOT NULL THEN

		p = phoneId;
	
	END IF;	

	sql = 'DELETE FROM kuntur.enrrollment_phone WHERE id = ''' || p || ''' ';

	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_phone.phone') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_u_enrrollment_male(character varying, character varying, boolean)

DROP FUNCTION IF EXISTS  kuntur.f_u_enrrollment_male(character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_male(inenrrollment_id character varying, user_system_id character varying, male boolean)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN
	IF male IS NOT NULL THEN

		m = male;
	
	END IF;	

	sql = 'UPDATE kuntur.enrrollment SET male = ''' || m || ''' WHERE id = ''' || $1 || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.male') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_u_enrrollment_male(character varying, character varying, boolean)
  --OWNER TO postgres;


---------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS  kuntur.f_u_enrrollment_citizenship(inenrrollment_id character varying, user_system_id character varying, nac character varying, identity_number character varying, code character varying, name character varying, indentityId character varying);



CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_citizenship(inenrrollment_id character varying, user_system_id character varying, nac character varying, identity_number character varying, code character varying, 
name character varying, indentityId character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	inu VARCHAR = 'null';
	cod VARCHAR = 'null';
	na VARCHAR = 'null';
	pit VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN


	sql = 'UPDATE kuntur.enrrollment_identity SET country_code = ''' || coalesce(nac, 'null') || ''', 
	identity_number = ''' || coalesce(identity_number, 'null') || ''', code = ''' || coalesce(code, 'null') ||''', 
	name = ''' || coalesce(name, 'null') || ''', person_identity_type_id = (SELECT id FROM kuntur.person_identity_type WHERE code = '''|| coalesce(code, 'null') || ''') WHERE id = ''' || indentityId || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_identity') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS  kuntur.f_u_enrrollment_Insertcitizenship(inenrrollment_id character varying, user_system_id character varying, nac character varying, identity_number character varying, code character varying, 
name character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Insertcitizenship(inenrrollment_id character varying, user_system_id character varying, nac character varying, identity_number character varying, code character varying, 
name character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	inu VARCHAR = 'null';
	cod VARCHAR = 'null';
	na VARCHAR = 'null';
	pit VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN


	sql = 'INSERT INTO kuntur.enrrollment_identity(id, erased, identity_number, code, name, country_code, comment, enrrollment_id, person_identity_type_id) 
	VALUES (uuid_generate_v4()::varchar, false, '''||coalesce(identity_number, 'null')||''', '''|| coalesce(code, 'null')||''', '''||coalesce(name, 'null')||''', '''||coalesce(nac, 'null')||''', '''',
	  '''||$1||''',(SELECT id FROM kuntur.person_identity_type WHERE code = '''|| coalesce(code, 'null') || '''  ) ) ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_identity') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Deletecitizenship(inenrrollment_id character varying, user_system_id character varying, indentityId character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Deletecitizenship(inenrrollment_id character varying, user_system_id character varying, indentityId character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	inu VARCHAR = 'null';
	cod VARCHAR = 'null';
	na VARCHAR = 'null';
	pit VARCHAR = 'null';
	sql VARCHAR = null;
    
BEGIN


	sql = 'DELETE FROM kuntur.enrrollment_identity WHERE id = ''' || indentityId || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_identity') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Insertnationality(inenrrollment_id character varying, user_system_id character varying, nac character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Insertnationality(inenrrollment_id character varying, user_system_id character varying, nac character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'INSERT INTO kuntur.enrrollment_nationality(id, erased, country_code, comment, enrrollment_id) 
	VALUES (uuid_generate_v4()::varchar, false, '''||coalesce(nac, 'null')||''', null, '''||$1||''') ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_nationality') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_nationality(inenrrollment_id character varying, user_system_id character varying, nac character varying, enrrollment_nationality_id character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_nationality(inenrrollment_id character varying, user_system_id character varying, nac character varying, enrrollment_nationality_id character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'UPDATE kuntur.enrrollment_nationality SET country_code = '''||coalesce(nac, 'null')||''' WHERE id = ''' || enrrollment_nationality_id || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_nationality') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Deletenationality(inenrrollment_id character varying, user_system_id character varying, enrrollment_nationality_id character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_Deleteenrrollment_nationality(inenrrollment_id character varying, user_system_id character varying, enrrollment_nationality_id character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'DELETE FROM kuntur.enrrollment_nationality WHERE id = ''' || enrrollment_nationality_id || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_nationality') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_birth_date(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_date DATE) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_birth(inenrrollment_id VARCHAR, user_system_id VARCHAR, birth_date DATE, birth_country VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	bd VARCHAR = 'null';	
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.enrrollment SET birth_date = ''' || coalesce(birth_date, NULL) || ''', birth_country_code = ''' || coalesce(birth_country, 'null') || ''' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.birth_date') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_emergency_contact(inenrrollment_id VARCHAR, user_system_id VARCHAR, emergency VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_emergency_contact(inenrrollment_id VARCHAR, user_system_id VARCHAR, emergency VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET emergency_contact = ''' || coalesce(emergency, 'null') || ''' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'unc_in_enrrollment.emergency_contact') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_u_enrrollment_insertaddress(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_u_enrrollment_insertaddress(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_insertaddress(inenrrollment_id character varying, user_system_id character varying, country_code character varying, admin_area_lvl1_code character varying, locality character varying, neighbourhood character varying, street character varying, street_number character varying, building_floor character varying, building_room character varying, building character varying, postal_code character varying, comment character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';
	v_country_code varchar = 'null';
	v_admin_area_lvl1_code varchar = 'null';
	v_locality varchar = 'null';
	v_neighbourhood varchar = 'null';
	v_street varchar = 'null';
	v_street_number varchar = 'null';
	v_building_floor varchar = 'null';
	v_building_room varchar = 'null';
	v_building varchar = 'null';
	v_postal_code varchar = 'null';
	v_comment varchar = 'null';
    
BEGIN

	if country_code is not null then
		v_country_code = '''' || country_code || '''';
	end if;

	if admin_area_lvl1_code is not null then
		v_admin_area_lvl1_code = '''' || admin_area_lvl1_code || '''';
	end if;

	if locality is not null then
		v_locality = '''' || locality || '''';
	end if;

	if neighbourhood is not null then
		v_neighbourhood = '''' || neighbourhood || '''';
	end if;

	if street is not null then
		v_street = '''' || street || '''';
	end if;

	if street_number is not null then
		v_street_number = '''' || street_number || '''';
	end if;

	if building_floor is not null then
		v_building_floor = '''' || building_floor || '''';
	end if;

	if building_room is not null then
		v_building_room = '''' || building_room || '''';
	end if;

	if building is not null then
		v_building = '''' || building || '''';
	end if;

	if postal_code is not null then
		v_postal_code = '''' || postal_code || '''';
	end if;

	if comment is not null then
		v_comment = '''' || comment || '''';
	end if;

	sql = 'INSERT INTO kuntur.enrrollment_address(id, erased, country_code, admin_area_level1_code, admin_area_level2, locality, neighbourhood, street, street_number, building_floor, building_room,
	building, postal_code, comment, lat, lng, enrrollment_id) 
	VALUES (uuid_generate_v4()::varchar, false, ' || v_country_code || ', ' || v_admin_area_lvl1_code || ', null, ' || v_locality || ', ' || v_neighbourhood || ', ' || v_street || ', ' || v_street_number || ', '
	|| v_building_floor || ', ' || v_building_room || ', ' || v_building || ', ' || v_postal_code || ', ' || v_comment || ', null, null, '''||$1||''') ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_address') INTO update_ok; 


	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_address(inenrrollment_id character varying, user_system_id character varying, country_code character varying, admin_area_lvl1_code character varying, locality character varying
, neighbourhood character varying, street character varying, street_number character varying, building_floor character varying, building_room character varying, building character varying, postal_code character varying, 
comment character varying, address_id character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_address(inenrrollment_id character varying, user_system_id character varying, country_code character varying, admin_area_lvl1_code character varying, locality character varying
, neighbourhood character varying, street character varying, street_number character varying, building_floor character varying, building_room character varying, building character varying, postal_code character varying, 
comment character varying, address_id character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'UPDATE kuntur.enrrollment_address SET country_code = '''||coalesce(country_code, 'country_code')||''', admin_area_level1_code = '''||coalesce(admin_area_lvl1_code, 'null')||''', locality = '''||coalesce(locality, 'null')||'''
	, neighbourhood = '''||coalesce(neighbourhood, 'null')||''', street = '''||coalesce(street, 'null')||''', street_number = '''||coalesce(street_number, 'null')||''', building_floor = '''||coalesce(building_floor, 'null')||'''
	, building_room = '''||coalesce(building_room, 'null')||''', building = '''||coalesce(building, 'null')||''', postal_code = '''||coalesce(postal_code, 'null')||''', comment = '''||coalesce(comment, 'null')||''' WHERE id = ''' || address_id || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_address') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Deleteaddress(inenrrollment_id character varying, user_system_id character varying, address_id character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Deleteaddress(inenrrollment_id character varying, user_system_id character varying, address_id character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'DELETE FROM kuntur.enrrollment_address WHERE id = ''' || address_id || ''' ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment_address') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_agreement(inenrrollment_id VARCHAR, user_system_id VARCHAR, agreement BOOLEAN, name VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_agreement(inenrrollment_id VARCHAR, user_system_id VARCHAR, agreement BOOLEAN, name VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET agreement = ' || coalesce(agreement, 'null') || ', agreement_name = ''' || coalesce(name, null) || ''' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_program(inenrrollment_id VARCHAR, user_system_id VARCHAR, program BOOLEAN) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_program(inenrrollment_id VARCHAR, user_system_id VARCHAR, program BOOLEAN) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET program = ' || coalesce(program, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_amountPaid(inenrrollment_id VARCHAR, user_system_id VARCHAR, amount double precision);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_amountPaid(inenrrollment_id VARCHAR, user_system_id VARCHAR, amount double precision) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET amount_paid = ' || coalesce(amount, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_originalDoc(inenrrollment_id VARCHAR, user_system_id VARCHAR, doc BOOLEAN) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_originalDoc(inenrrollment_id VARCHAR, user_system_id VARCHAR, doc BOOLEAN) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET original_doc = ' || coalesce(doc, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_insurance(inenrrollment_id VARCHAR, user_system_id VARCHAR, ins BOOLEAN) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_insurance(inenrrollment_id VARCHAR, user_system_id VARCHAR, ins BOOLEAN) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET insurance = ' || coalesce(ins, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_visa(inenrrollment_id VARCHAR, user_system_id VARCHAR, visa VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_visa(inenrrollment_id VARCHAR, user_system_id VARCHAR, visa VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET visa= ' || coalesce(visa, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_comment(inenrrollment_id VARCHAR, user_system_id VARCHAR, comment VARCHAR, observation VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_comment(inenrrollment_id VARCHAR, user_system_id VARCHAR, comment VARCHAR, observation VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = null;
    
BEGIN

	sql = 'UPDATE kuntur.unc_in_enrrollment SET comment = ' || coalesce($3, 'null') || ', observation = ' || coalesce($4, 'null') || ' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'null') INTO update_ok; 


	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_u_enrrollment_insertinstudyprogram(character varying, character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_u_enrrollment_insertinstudyprogram(character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_insertinstudyprogram(inenrrollment_id character varying, user_system_id character varying, subject character varying, orgid character varying, comentario VARCHAR)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	type_user VARCHAR = 'null';
	v_comment VARCHAR = 'NULL';
	
    
BEGIN

	select * into type_user from kuntur.f_role_stakeholder( $1, $2, 'unc_in_study_program' );

	IF $5 IS NOT NULL THEN

		v_comment = '''' || $5 || '''';

	END IF;


	IF type_user = 'ALL' OR type_user = 'STUDENT' THEN

		sql = 'INSERT INTO kuntur.unc_in_study_program(id, erased, subject, approved, approved_by, file_number, comment, unc_in_enrrollment_id, org_id) 
		VALUES (uuid_generate_v4()::varchar, false, ''' || $3 || ''', null , null , null ,  ' || v_comment || ', '''||$1||''', '''||$4||''') ';

		
		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSE 

		RETURN false;

	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_instudyprogram(inenrrollment_id character varying, user_system_id character varying, subject character varying, orgid character varying, appr boolean, legajoguarani character varying, studyprogramid character varying, comentarios character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	type_user VARCHAR = 'null';

	fn VARCHAR = 'null';
	mn VARCHAR = 'null';
	gn VARCHAR = 'null';

	var_approved BOOLEAN = false;

	v_file_number VARCHAR = 'NULL';
	v_subject VARCHAR = 'NULL';
	v_org_id VARCHAR = 'NULL';
	v_approved VARCHAR = 'NULL';
	v_comment VARCHAR = 'NULL';

	
    
BEGIN

	select * into type_user from kuntur.f_role_stakeholder( $1, $2, 'unc_in_study_program' );

	IF type_user = 'STUDENT' THEN

		sql = 'UPDATE kuntur.unc_in_study_program SET subject = ''' || $3 || ''' , org_id = '''|| $4 ||''' WHERE id = ''' || $7 || ''''; 		
		
		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSIF type_user = 'COORDINATOR' THEN
		
		SELECT approved INTO var_approved FROM kuntur.unc_in_study_program where id = $7;

		IF $8 IS NOT NULL THEN

			v_comment = '''' || $8 || '''';

		END IF;


		IF (var_approved is null and $5 is not null) or (var_approved is not null and $5 is null) or (var_approved <> $5) THEN --CONTROLO QUE SE CAMBIO EL CAMPO APPROVED, EN CASO Q NO NO SE CAMBIA PARA NO MODIFICAR EL APPROVED_BY

			SELECT family_name, middle_name, given_name INTO fn, mn, gn FROM kuntur.person WHERE id = $2;

			sql = 'UPDATE kuntur.unc_in_study_program SET approved = ' || COALESCE($5, 'false') || ' , approved_by = '''|| fn || ', ' ||  gn || ' ' || mn || ''' , comment = ' || v_comment || ' WHERE id = ''' || $7 || ''' '; 	

			SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		ELSE

			update_ok=true;

		END IF;

		RETURN update_ok;

	ELSIF type_user = 'OFFICE' THEN

		sql = 'UPDATE kuntur.unc_in_study_program SET file_number = ''' || $6 || ''' WHERE id = ''' || $7 || ''''; 	

		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSIF type_user = 'ALL' THEN

		SELECT approved INTO var_approved FROM kuntur.unc_in_study_program where id = $7;

		IF $6 IS NOT NULL THEN

			v_file_number = '''' || $6 || '''';

		END IF;

		IF $3 IS NOT NULL THEN

			v_subject = '''' || $3 || '''';

		END IF;

		IF $4 IS NOT NULL THEN

			v_org_id = '''' || $4 || '''';

		END IF;

		IF $5 IS NOT NULL THEN

			v_approved = $5::VARCHAR;

		END IF;

		IF $8 IS NOT NULL THEN

			v_comment = '''' || $8 || '''';

		END IF;


		IF (var_approved is null and $5 is not null) or (var_approved is not null and $5 is null) or (var_approved <> $5) THEN --CONTROLO QUE SE CAMBIO EL CAMPO APPROVED, EN CASO Q NO NO SE CAMBIA PARA NO MODIFICAR EL APPROVED_BY

			SELECT family_name, middle_name, given_name INTO fn, mn, gn FROM kuntur.person WHERE id = $2;
			
			sql = 'UPDATE kuntur.unc_in_study_program SET file_number = '|| v_file_number || ', approved = ' || v_approved || ' , approved_by = '''|| fn || ', ' ||  gn || ' ' || mn || ''', subject = ''' || $3 || ''' , org_id = '''|| $4 ||''' , comment = ' || v_comment || ' WHERE id = ''' || $7 || ''' '; 	
		
			SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		ELSE

			sql = 'UPDATE kuntur.unc_in_study_program SET file_number = ' || v_file_number || ',  subject = ''' || $3 || ''' , org_id = '''|| $4 ||''' , comment = ' || v_approved || ' WHERE id = ''' || $7 || ''' '; 	

			SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		END IF;

		RETURN update_ok;

	ELSE

		RETURN false;

	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_DeleteInStudyProgram(inenrrollment_id character varying, user_system_id character varying, studyProgramId CHARACTER VARYING);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_DeleteInStudyProgram(inenrrollment_id character varying, user_system_id character varying, studyProgramId CHARACTER VARYING)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';
	type_user VARCHAR = 'null';
	
    
BEGIN

	select * into type_user from kuntur.f_role_stakeholder( $1, $2, 'unc_in_study_program' );

	IF type_user = 'STUDENT' OR type_user = 'ALL' THEN

		sql = 'DELETE FROM kuntur.unc_in_study_program WHERE id = ''' || $3 || ''''; 		
		
		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSE

		RETURN false;

	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_InsertAcademicPerformance(inenrrollment_id character varying, user_system_id character varying, org character varying, subject character varying, grade character varying, hs double precision, type_course character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_InsertAcademicPerformance(inenrrollment_id character varying, user_system_id character varying, org character varying, subject character varying, grade character varying, hs double precision, type_course character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';
	grade_number INTEGER = -3;
	approved boolean = false;
	
    
BEGIN

	select rate_number into grade_number from kuntur.unc_in_grading_scale;

	IF grade_number > 4 THEN

	approved = true;

	END IF;


	sql = 'INSERT INTO kuntur.unc_in_academic_performance(id, erased, subject, approved, approved_by, file_number, hs, unc_in_enrrollment_id, unc_in_grading_scale_id, unc_in_studied_type_id, org_id) 
	VALUES (uuid_generate_v4()::varchar, false, '''|| coalesce($4, 'null') ||''', '|| approved ||', '''|| coalesce($2, 'null') ||''', null, '|| coalesce($6, null) ||', ''' || coalesce($1, null) || ''', ''' || coalesce($5, null) || ''', ''' || coalesce($7, null) || ''', ''' || coalesce($3, null) || ''') ';

	
	SELECT  kuntur.is_update($1, $2, sql, 'unc_in_academic_performance') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_academicPerformance(inenrrollment_id character varying, user_system_id character varying, org character varying, subject character varying, grade character varying, hs double precision, type_course character varying, academicPerformanceId character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_academicPerformance(inenrrollment_id character varying, user_system_id character varying, org character varying, subject character varying, grade character varying, hs double precision, type_course character varying, academicPerformanceId character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';
	grade_number INTEGER = -3;
	approved boolean = false;
	
    
BEGIN

	select rate_number into grade_number from kuntur.unc_in_grading_scale;

	IF grade_number > 4 THEN

	approved = true;

	END IF;


	sql = 'UPDATE kuntur.unc_in_academic_performance SET subject = '''|| coalesce($4, 'null') ||''', approved = '|| approved ||', approved_by = '''|| coalesce($2, 'null') ||''', 
	hs = '|| coalesce($6, null) ||', unc_in_enrrollment_id = ''' || coalesce($1, null) || ''', unc_in_grading_scale_id = ''' || coalesce($5, null) || ''', 
	unc_in_studied_type_id = ''' || coalesce($7, null) || ''', org_id = ''' || coalesce($3, null) || ''' WHERE id = '''|| $8 ||''' ';


	
	SELECT  kuntur.is_update($1, $2, sql, 'unc_in_academic_performance') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_DeleteacademicPerformance(inenrrollment_id character varying, user_system_id character varying, academicPerformanceId character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_DeleteacademicPerformance(inenrrollment_id character varying, user_system_id character varying, academicPerformanceId character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';	
    
BEGIN

	sql = 'DELETE FROM kuntur.unc_in_academic_performance WHERE id = '''|| $3 ||''' ';

	SELECT  kuntur.is_update($1, $2, sql, 'unc_in_academic_performance') INTO update_ok; 

	RETURN update_ok;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_org_id(inenrrollment_id VARCHAR, user_system_id VARCHAR, org_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_org_id(inenrrollment_id VARCHAR, user_system_id VARCHAR, org_id VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	oid VARCHAR = 'null';
	sql VARCHAR = null;
	Orgname VARCHAR = '';
	country VARCHAR = '';
	web VARCHAR = '';
	iname VARCHAR = '';
	ishortName VARCHAR = '';
    
BEGIN

	IF org_id IS NOT NULL AND CHAR_LENGTH(TRIM(org_id)) > 0 THEN

		oid = '' || TRIM(org_id) || '';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET org_id = ''' || oid || ''' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.org_id') INTO update_ok; 

	IF update_ok THEN

		select original_name, web_site, country_code, name, short_name into Orgname, web, country, iname, ishortName from kuntur.org where id = oid;
	
		update kuntur.enrrollment set institution_web_site = web, institution_country_code = country, institution_original_name = Orgname, institution_name = iname, institution_short_name = ishortName where id = $1;

	END IF;

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION kuntur.f_login(us character varying, pass character varying)
  RETURNS character varying AS
$BODY$
DECLARE    	

	num INTEGER = 0;	
	rol VARCHAR = '';
    
BEGIN

	SELECT count(us.id) into num from kuntur.user_system us where us.name = '' || $1 ||'' and us.pass = '' || $2 || ''; 

	IF num > 0 THEN

		select us.name into rol from kuntur.user_system us
			inner join kuntur.user_group ug
				on ug.user_system_id = us. id
			inner join kuntur.group_system gs
				on gs.id = group_system_id
			where us.name = '' || $1 || '';

		RETURN rol;

	ELSE

		RETURN NULL;

	END IF; 

	
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_login(character varying, character varying)
  --OWNER TO postgres;



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_login_oid(us VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_login_oid(us VARCHAR) RETURNS VARCHAR AS
$$
DECLARE    	

	rol VARCHAR = '';
    
BEGIN


	select gs.code into rol from kuntur.user_system us
		inner join kuntur.user_group ug
			on ug.user_system_id = us. id
		inner join kuntur.group_system gs
			on gs.id = group_system_id
		where us.name = '' || $1 || '';

	RETURN rol;

	
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS  kuntur.f_new_student(name VARCHAR, lastName VARCHAR, mail VARCHAR, us VARCHAR, pass VARCHAR, country VARCHAR);

CREATE OR REPLACE FUNCTION kuntur.f_new_student(name VARCHAR, lastName VARCHAR, mail VARCHAR, us VARCHAR, pass VARCHAR, country VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	person_id varchar = 'null';
    
BEGIN


	insert into kuntur.person(id, erased, given_name, family_name, birth_country_code) 
	values (uuid_generate_v4()::varchar, false, ''|| coalesce($1, null) ||'', ''|| coalesce($2, null) ||'', ''|| coalesce($6, null) ||'') RETURNING id into person_id;

	insert into kuntur.person_email(id, erased, email, person_id) values (uuid_generate_v4()::varchar, false, ''|| coalesce($3, null) ||'', person_id);

	insert into kuntur.user_system(id, erased, name, pass, email, checked_mail) values (person_id, false, ''|| coalesce($4, null) ||'', ''|| coalesce($5, null) ||'', ''|| coalesce($3, null) ||'', false);

	insert into kuntur.user_group(id, erased, user_system_id, group_system_id) values (uuid_generate_v4()::varchar, false, person_id, (select id from kuntur.group_system where code = 'student'));

	insert into kuntur.student(id, erased) values (person_id, false);
	
	return true;
	
    
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS  kuntur.perfilArray(us VARCHAR);

CREATE OR REPLACE FUNCTION kuntur.perfilArray(us VARCHAR) RETURNS VARCHAR AS
$$
DECLARE
	personId VARCHAR = '';
	json json = null;
	emails json = null;
	phones json = null;
	addresses json = null;
	identities json = null;
	nationalities json = null;

BEGIN

	select id into personId from kuntur.user_system where name = ''|| $1 ||'';

	with m as(
		select * from kuntur.person_email where person_id = ''|| personId ||''
	)
	select array_to_json(array_agg(row_to_json(m.*))) into emails from m;

	with p as(
		select * from kuntur.person_phone where person_id = ''|| personId ||''
	)
	select array_to_json(array_agg(row_to_json(p.*))) into phones from p;

	with a as(
		select * from kuntur.person_address where person_id = ''|| personId ||''
	)
	select array_to_json(array_agg(row_to_json(a.*))) into addresses from a;

	with pi as(
		select pi.id as id,
		pi.erased as erased,
		pi.identity_number as identity_number,
		pit.code as code,
		pit.name as name, 
		pi.country_code as country_code,
		pi.person_id as person_id,
		pi.person_identity_type_id as person_identity_type_id
		from kuntur.person_identity pi inner join kuntur.person_identity_type pit on pit.id = pi.person_identity_type_id where pi.person_id = ''|| personId ||''
	)
	select array_to_json(array_agg(row_to_json(pi.*))) into identities from pi;

	with n as(
		select * from kuntur.person_nationality where person_id = ''|| personId ||''
	)
	select array_to_json(array_agg(row_to_json(n))) into nationalities from n;


	with r as(
		select  p.id as person_id,
		p.given_name as person_given_name,
		p.middle_name as person_middle_name,
		p.family_name as person_family_name,
		p.birth_date as person_birth_date,
		p.male as person_male,
		p.url_photo as person_url_photo,
		p.birth_country_code as person_birth_country_code,
		s.id as student_id,
		s.file_number as student_file_number,
		s.institution_short_name as student_short_name,
		s.institution_name as student_institution_name,
		s.institution_original_name as student_institution_original_name,
		s.institution_web_site as student_institution_web_site,
		s.institution_country_code as student_institution_country_code,
		s.org_id as student_org_id,
		o.id as org_id,
		o.short_name as org_short_name,
		o.name as org_name,
		o.original_name as org_original_name,
		o.url_photo as org_url_photo,
		o.web_site as org_web_site,
		o.country_code as org_country_code,
		o.code_ona as org_code_ona,
		o.code_guarani as org_code_guarani,
		emails, phones, addresses
		, identities as identities, nationalities::json from kuntur.person p left join kuntur.student s on s.id = p.id left join kuntur.org o on o.id = s.org_id where p.id = ''|| personId ||''
	)
	select row_to_json(r.*) into json from r;--array_to_json()array_agg()

	RETURN json;

END;
$$ LANGUAGE plpgsql;






--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



  CREATE OR REPLACE FUNCTION kuntur.updatePerson(us VARCHAR,tab VARCHAR, field VARCHAR, val VARCHAR, idField VARCHAR, id VARCHAR)
	RETURNS VARCHAR AS
$BODY$
DECLARE

	sql VARCHAR = '';

BEGIN
	sql = 'UPDATE '|| TAB ||' SET '|| field ||' = '|| val ||' WHERE '|| idField || ' = ''' || id || '''';

	RETURN sql; 
END;
$BODY$
	LANGUAGE plpgsql;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_validateStudent(id VARCHAR, us VARCHAR);

CREATE OR REPLACE FUNCTION  kuntur.f_validateStudent(userId VARCHAR, us VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE

	r INTEGER = 0;

BEGIN
	SELECT COUNT(*) INTO r FROM kuntur.user_system where name = '' || us ||'' AND id = '' || userId || '';

	IF r > 0 THEN
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$
	LANGUAGE plpgsql;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION kuntur.f_u_studentProfile(fName VARCHAR, mName VARCHAR, lName VARCHAR, gender BOOLEAN, bDate VARCHAR, bPlace VARCHAR, idOrg VARCHAR, iShortName VARCHAR, iName VARCHAR, iOriginalName VARCHAR, iWeb VARCHAR, 
iCountry VARCHAR, us VARCHAR, idPerson VARCHAR) RETURNS BOOLEAN AS 
$$
DECLARE

	per BOOLEAN = false;
	oSName VARCHAR = '';
	oName VARCHAR = '';
	oOriginalName VARCHAR = '';
	oWeb VARCHAR = '';
	oCountry VARCHAR = '';

BEGIN

	select kuntur.f_validateStudent(idPerson, us) into per;

	--RAISE EXCEPTION '% % % % % % % % % % % % % %', $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14; 
		

	IF per THEN
		UPDATE kuntur.person SET given_name = '' || $1 || '', middle_name = '' || $2 || '', family_name = '' || $3 || '', birth_date = $5::DATE , male =  $4 , 
		birth_country_code = '' || $6 || '' WHERE id = '' || $14 || '';

		IF idOrg is null THEN

			UPDATE kuntur.student SET institution_short_name = '' || iShortName || '', institution_name = '' || iName || '', institution_original_name = '' || iOriginalName || '', 
			institution_web_site = '' || iWeb || '', institution_country_code = '' || iCountry || '', org_id = null WHERE id = '' || idPerson || '';

		ELSE

			SELECT short_name, name, original_name, web_site, country_code INTO oSName, oName, oOriginalName, oWeb, oCountry FROM kuntur.org WHERE id = '' || idOrg || '';
		
			UPDATE kuntur.student SET institution_short_name = '' || oSName || '', institution_name = '' || oName || '', institution_original_name = '' || oOriginalName || '', 
			institution_web_site = '' || oWeb || '', institution_country_code = '' || oCountry || '', org_id = '' || idOrg || '' WHERE id = '' || idPerson || '';
	
		END IF;

	END IF;

	RETURN true;

END;
$$
 LANGUAGE plpgsql;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_i_student_email(person_id VARCHAR, us VARCHAR, mail VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_i_student_email(person_id VARCHAR, us VARCHAR, mail VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
	per BOOLEAN = false;
    
BEGIN
	IF mail IS NOT NULL THEN

		m = mail;
	
	END IF;

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		INSERT INTO kuntur.person_email(id, erased, email, person_id) VALUES (uuid_generate_v4()::varchar, false, '' || m || '', '' || $1 || '') ;

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_u_student_email(person_id VARCHAR, us VARCHAR, mail VARCHAR, mailId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_student_email(person_id VARCHAR, us VARCHAR, mail VARCHAR, mailId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
	per BOOLEAN = false;
    
BEGIN
	IF mail IS NOT NULL THEN

		m = mail;
	
	END IF;

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		UPDATE kuntur.person_email SET email = '' || m || '' WHERE  id = '' || mailId || '';

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_d_student_email(person_id VARCHAR, us VARCHAR, mailId VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_d_student_email(person_id VARCHAR, us VARCHAR, mailId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	
	m VARCHAR = 'null';
	sql VARCHAR = null;
	per BOOLEAN = false;
    
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		DELETE FROM  kuntur.person_email WHERE  id = '' || mailId || '';

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_i_student_phone(person_id VARCHAR, us VARCHAR, country VARCHAR, phone VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_i_student_phone(person_id VARCHAR, us VARCHAR, country VARCHAR, phone VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		INSERT INTO kuntur.person_phone(id, erased, country_code, phone_number, person_id) VALUES (uuid_generate_v4()::varchar, false, '' || country || '', '' || phone || '', '' || $1 || '') ;

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_u_student_phone(person_id VARCHAR, us VARCHAR, country VARCHAR, phone VARCHAR, phone_id VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		UPDATE kuntur.person_phone SET country_code = '' || country || '', phone_number = '' || phone || '' WHERE id = '' || phone_id || '' ;

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_d_student_phone(person_id VARCHAR, us VARCHAR, phone_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_d_student_phone(person_id VARCHAR, us VARCHAR, phone_id VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;	

	IF per THEN

		DELETE FROM kuntur.person_phone WHERE id = '' || phone_id || '' ;

		RETURN TRUE;

	END IF;

	RETURN FALSE;
    
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_d_student_nationality(character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_d_student_nationality(character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_d_student_nationality(person_id character varying, us character varying, nac_id character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		DELETE FROM kuntur.person_nationality WHERE id = ''|| nac_id ||'';

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_d_student_nationality(character varying, character varying, character varying)
  --OWNER TO postgres;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_i_student_nationality(character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_i_student_nationality(character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_i_student_nationality(person_id character varying, us character varying, nac character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		INSERT INTO kuntur.person_nationality(id, erased, country_code, person_id) 
		VALUES (uuid_generate_v4()::varchar, false, ''||coalesce(nac, 'null')||'', ''||$1||'');

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_i_student_nationality(character varying, character varying, character varying)
  --OWNER TO postgres;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_u_student_nationality(character varying, character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_u_student_nationality(character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_student_nationality(person_id character varying, us character varying, nac character varying, nac_id character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		UPDATE kuntur.person_nationality SET country_code = '' ||coalesce(nac, 'null') || '' WHERE id = ''|| nac_id ||'';

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_u_student_nationality(character varying, character varying, character varying, character varying)
  --OWNER TO postgres;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS kuntur.f_i_student_document(person_id character varying, us character varying, code character varying, idenNum character varying, name character varying, country character varying);
CREATE OR REPLACE FUNCTION kuntur.f_i_student_document(person_id character varying, us character varying, icode character varying, idenNum character varying, name character varying, country character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		INSERT INTO kuntur.person_identity(id, erased, identity_number, code, name, country_code, person_id, person_identity_type_id) 
		VALUES (uuid_generate_v4()::varchar, false, ''||coalesce(idenNum, 'null')||'', ''||coalesce(icode, 'null')||'', ''||coalesce(name, 'null')||'', ''||coalesce(country, 'null')||''
		, ''||coalesce(person_id, 'null')||'', (SELECT t.id FROM kuntur.person_identity_type t WHERE t.code = ''|| coalesce(icode, 'null') || ''));

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_i_student_nationality(character varying, character varying, character varying)
  --OWNER TO postgres;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_u_student_document(person_id character varying, us character varying, code character varying, idenNum character varying, name character varying, country character varying, idIdentity character varying);
CREATE OR REPLACE FUNCTION kuntur.f_u_student_document(person_id character varying, us character varying, icode character varying, idenNum character varying, iname character varying, country character varying, idIdentity character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		UPDATE kuntur.person_identity SET identity_number = ''||coalesce(idenNum, 'null')||'', code = ''||coalesce(icode, 'null')||'', name = ''||coalesce(iname, 'null')||'', country_code = ''||coalesce(country, 'null')||'', 
		person_identity_type_id = (SELECT t.id FROM kuntur.person_identity_type t WHERE t.code = ''|| coalesce(icode, 'null') || '') WHERE id = ''||idIdentity||'';

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_d_student_document(person_id character varying, us character varying, idIdentity character varying);
CREATE OR REPLACE FUNCTION kuntur.f_d_student_document(person_id character varying, us character varying, idIdentity character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

per BOOLEAN = false;
	
BEGIN

	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		DELETE FROM kuntur.person_identity WHERE id = ''||idIdentity||'';

		RETURN TRUE;
	END IF;

	RETURN FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION kuntur.f_i_student_address(person_id character varying, us character varying, country_code character varying, admin_area_lvl1_code character varying, locality character varying
, neighbourhood character varying, street character varying, street_number character varying, building_floor character varying, building_room character varying, building character varying, postal_code character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN


	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		INSERT INTO kuntur.person_address(id, erased, country_code, admin_area_level1_code, locality, neighbourhood, street, street_number, building_floor, building_room,
		building, postal_code, person_id) 
		VALUES (uuid_generate_v4()::varchar, false, ''||coalesce(country_code, null)||'', ''||coalesce(admin_area_lvl1_code, null)||'' , ''||coalesce(locality, null)||'', ''||coalesce(neighbourhood, null)||''
		, ''||coalesce(street, null)||'', ''||coalesce(street_number, null)||'', ''||coalesce(building_floor, null)||'', ''||coalesce(building_room, null)||'', ''||coalesce(building, null)||''
		, ''||coalesce(postal_code, null)||'', ''||$1||'');

		RETURN TRUE;

	END IF;

	RETURN FALSE;

	
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: kuntur.f_u_student_address(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION kuntur.f_u_student_address(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_student_address(person_id character varying, us character varying, acountry_code character varying, admin_area_lvl1_code character varying, alocality character varying, aneighbourhood character varying, astreet character varying, astreet_number character varying, abuilding_floor character varying, abuilding_room character varying, abuilding character varying, apostal_code character varying, address_id character varying)
  RETURNS boolean AS
$BODY$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN


	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		UPDATE kuntur.person_address SET country_code = ''||coalesce(acountry_code, null)||'', admin_area_level1_code = ''||coalesce(admin_area_lvl1_code, null)||'', locality = ''||coalesce(alocality, null)||'', 
		neighbourhood = ''||coalesce(aneighbourhood, null)||'', street = ''||coalesce(astreet, null)||'', street_number = ''||coalesce(astreet_number, null)||'', building_floor = ''||coalesce(abuilding_floor, null)||'', 
		building_room = ''||coalesce(abuilding_room, null)||'', building = ''||coalesce(abuilding, null)||'', postal_code = ''||coalesce(apostal_code, null)||'' WHERE id = address_id;

		RETURN TRUE;

	END IF;

	RETURN FALSE;

	
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION kuntur.f_u_student_address(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)
  --OWNER TO postgres;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_d_student_address(person_id character varying, us character varying, address_id character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	per BOOLEAN = false;
    
BEGIN


	select kuntur.f_validateStudent(person_id, us) into per;

	IF per THEN

		DELETE FROM kuntur.person_address WHERE id = address_id;

		RETURN TRUE;

	END IF;

	RETURN FALSE;

	
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION kuntur.f_change_state(enrrollment_id VARCHAR, userSystem VARCHAR, finalStatusCode VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE
	statusId VARCHAR = null;
	statusName VARCHAR = null;
	
	oldStatusId VARCHAR = null;
	oldStatusCode VARCHAR = null;
	oldStatusName VARCHAR = null;

	permission BOOLEAN = null;
	stakeholdersStatus BOOLEAN = null;

	userSystemId VARCHAR = null;
	
BEGIN

	SELECT kuntur.f_validate_enrrollment_permission(userSystem, enrrollment_id) INTO permission;

	IF permission THEN

		SELECT id, name INTO statusId, statusName FROM kuntur.enrrollment_status WHERE code = finalStatusCode;

		SELECT enrrollment_status_id INTO oldStatusId FROM kuntur.enrrollment WHERE id = enrrollment_id;

		SELECT name, code INTO oldStatusName, oldStatusCode FROM kuntur.enrrollment_status WHERE id = oldStatusId;

		SELECT id INTO userSystemId FROM kuntur.user_system WHERE name = userSystem;
		
		UPDATE kuntur.enrrollment SET enrrollment_status_id = statusId WHERE id = enrrollment_id;

		INSERT INTO kuntur.enrrollment_log(id, erased, code_start, name_start, code_end, name_end, promotion_date, enrrollment_status_a_id, enrrollment_status_b_id, enrrollment_id, user_system_id) 
		VALUES (uuid_generate_v4()::varchar, false, oldStatusCode, oldStatusName, finalStatusCode, statusName, transaction_timestamp(), oldStatusId, statusId, enrrollment_id, userSystemId);

		SELECT kuntur.f_update_stakeholders(enrrollment_id) INTO stakeholdersStatus;

		IF stakeholdersStatus THEN

			RETURN true;

		ELSE

			RETURN false;

		END IF;

	END IF;

	RETURN false;

END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




DROP FUNCTION IF EXISTS kuntur.f_validate_enrrollment_permission(userSystem VARCHAR, enrrollmentId VARCHAR);
CREATE OR REPLACE FUNCTION kuntur.f_validate_enrrollment_permission(userSystem VARCHAR, enrrollmentId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE
	userSystemId VARCHAR = null;
	permissionCode VARCHAR = null;
BEGIN
	SELECT id INTO userSystemId FROM kuntur.user_system WHERE name = userSystem;

	SELECT code INTO permissionCode FROM kuntur.enrrollment_stakeholder WHERE user_system_id = userSystemId AND enrrollment_id = enrrollmentId;

	IF permissionCode::Integer > 1 AND permissionCode::Integer < 4 THEN
		RETURN true;
	END IF;

	RETURN false;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Function: kuntur.f_update_stakeholders(character varying)

-- DROP FUNCTION kuntur.f_update_stakeholders(character varying);

CREATE OR REPLACE FUNCTION kuntur.f_update_stakeholders(enrrollmentid character varying)
  RETURNS boolean AS
$BODY$
DECLARE
	statusId VARCHAR = null;
	statusCode VARCHAR = null;
	studentId VARCHAR = null;
	auxCount INTEGER = 0;

	org VARCHAR = null;
	person VARCHAR = null;
BEGIN

	SELECT enrrollment_status_id INTO statusId FROM kuntur.enrrollment WHERE id = enrrollmentId;

	SELECT code INTO statusCode FROM kuntur.enrrollment_status WHERE id = statusId;

	IF statusCode = 'A' OR statusCode = 'C' OR statusCode = 'E' OR statusCode = 'G' THEN--lo tiene el estudiante

		SELECT student_id INTO studentId FROM kuntur.enrrollment WHERE id = enrrollmentId;

		SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = studentid AND enrrollment_id = enrrollmentId;

		IF auxCount > 0 THEN	

			UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = enrrollmentId;

			UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = studentId AND enrrollment_id = enrrollmentId;

		ELSE

			INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, studentId, enrrollmentId);

		END IF;

		RETURN true;

	ELSIF statusCode = 'B' OR statusCode = 'F' OR statusCode = 'I' THEN--lo tiene la pri

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = enrrollmentId;

		RETURN true;

--------------------CORRECCION------------------------------
	ELSIF statusCode = 'D' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_coordinator WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;
	ELSIF statusCode = 'H' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_office WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;

	ELSIF statusCode = 'J' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM --tengo q unir las dos tablas para obtener todas las organizaciones que intervienen en la postulacion y asi encontrar las personas de despacho correspondientes
			(SELECT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid
				UNION
				SELECT org_id FROM kuntur.unc_in_academic_performance WHERE unc_in_enrrollment_id = enrrollmentid) AS a

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_office WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;

--------------------FIN CORRECCION----------------------------
	
	
	ELSIF statusCode = 'K' OR statusCode = 'Z' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  enrrollment_id = enrrollmentId;

		RETURN true;

	ELSE

		RETURN false;

	END IF;

		

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS kuntur.f_enrrollment_status(enrrollment_id VARCHAR, userSystem VARCHAR);

CREATE OR REPLACE FUNCTION kuntur.f_enrrollment_status(enrrollment_id VARCHAR, userSystem VARCHAR) RETURNS VARCHAR AS
$$
DECLARE

	result VARCHAR = null;
	
BEGIN

	WITH t AS (
	SELECT * FROM kuntur.enrrollment_status ORDER BY code
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO result FROM t;

	RETURN result;
	
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Function: kuntur.nextstep(character varying, character varying)

-- DROP FUNCTION kuntur.nextstep(character varying, character varying);

CREATE OR REPLACE FUNCTION kuntur.nextstep(usersystem character varying, enrrollmentid character varying)
  RETURNS boolean AS
$BODY$
DECLARE

	appr BOOLEAN = false;
	orgIdIterator VARCHAR = null;
	personIterator VARCHAR = null;
	
	flagApproved BOOLEAN = true;
	flagComplete BOOLEAN = true;
	flagOrg BOOLEAN = true;
	result BOOLEAN = false;

	orgId VARCHAR = null;
	userSystemId VARCHAR = null;

	statusId VARCHAR = null;
	statusCode VARCHAR = null;

	fN VARCHAR = null;
	validFN BOOLEAN = true;

	carCode VARCHAR = null;
	subj VARCHAR = null;
	filNumb VARCHAR = null;
	hrs DOUBLE PRECISION = 0;

	auxCountAA INTEGER = 0;
	auxCountAP INTEGER = 0;


BEGIN


	SELECT enrrollment_status_id INTO statusId FROM kuntur.enrrollment where id = enrrollmentid;

	SELECT code INTO statusCode FROM kuntur.enrrollment_status WHERE  id = statusId;

	SELECT id INTO userSystemId FROM kuntur.user_system WHERE name = usersystem;

	SELECT org_id INTO orgId FROM kuntur.unc_in_academic_coordinator WHERE person_id = userSystemId;
	
	IF statusCode LIKE 'D' THEN -- EN EVALUACION

		FOR appr, orgIdIterator IN SELECT approved, org_id from kuntur.unc_in_study_program where unc_in_enrrollment_id = enrrollmentId

		LOOP

			IF appr IS NOT null THEN
		

				IF appr IS FALSE THEN

					flagApproved = false;

				END IF;

			ELSE

				flagComplete = false;

				IF orgIdIterator LIKE orgId THEN

					flagOrg = false;

				END IF;

			END IF;

		END LOOP;



		IF flagComplete THEN -- TODOS LOS CAMOS APROBADOS ESTAN LLENOS

			IF flagApproved THEN -- ESTAN APROBADOS

				SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'F') INTO result;
				RETURN result;

			ELSE	-- NO ESTAN APROBADOS

				SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'E') INTO result;
				RETURN result;

			END IF;

		ELSE -- NO TODOS LOS CAMPOS APROBADOS ESTAN LLENOS

			IF flagOrg THEN -- FALTAN REGISTROS DE COMPLETAR PERO LA ORGANIZACION A LA QUE PERTENECE LA PERSONA TERMINO
			
				FOR personIterator IN SELECT person_id FROM kuntur.unc_in_academic_coordinator WHERE org_id = orgId -- BUCLE QUE RECORRE LAS PERSONAS PERTENECIENTES A UNA ORGANIZACION PARA CAMBIARLE LOS PERMISOS EN STAKEHOLDERS

				LOOP

					UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE user_system_id = personIterator AND enrrollment_id = enrrollmentid;

				END LOOP;

				RETURN true;

			END IF;

			RETURN false;

		END IF;

	ELSIF statusCode LIKE 'A' THEN --NO INICIADA

		SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'B') INTO result;
		RETURN result;

	ELSIF statusCode LIKE 'C' THEN -- INCOMPLETA

		SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'B') INTO result;
		RETURN result;	

	ELSIF statusCode LIKE 'E' THEN --MODIFICACION PLAN 1
	
		UPDATE kuntur.unc_in_study_program SET approved = null where unc_in_enrrollment_id = enrrollmentId AND approved = false;--LAS MATERIAS POR LAS QUE SE DESAPROBO SE VUELVEN A NULO PARA Q SEAN REEVALUADAS
		SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'D') INTO result;
		RETURN result;			

	ELSIF statusCode LIKE 'G' THEN -- MODIFICACION PLAN 2

		SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'H') INTO result;
		RETURN result;

	ELSIF statusCode LIKE 'H' THEN -- EN MATRICULACION
	
		SELECT org_id INTO orgId FROM kuntur.unc_in_academic_office WHERE person_id = userSystemId;
		

		FOR fN, orgIdIterator IN SELECT file_number, org_id from kuntur.unc_in_study_program where unc_in_enrrollment_id = enrrollmentId

		LOOP

			--SELECT kuntur.f_validateFileNumber(fN) INTO validFN; NO EXISTE LA FUNCION QUE VALIDA EL FILE NUMBER CREAR

			

			IF fN IS NOT NULL THEN

	
			ELSE

				flagComplete = false;

				IF orgIdIterator LIKE orgId THEN

					flagOrg = false;

				END IF;

			END IF;

		END LOOP;



		IF flagComplete THEN -- TODOS LOS CAMOS ESTAN LLENOS

			SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'I') INTO result;
			RETURN result;

		ELSE -- NO TODOS LOS CAMPOS ESTAN LLENOS

			IF flagOrg THEN -- FALTAN REGISTROS DE COMPLETAR PERO LA ORGANIZACION A LA QUE PERTENECE LA PERSONA TERMINO

				FOR personIterator IN SELECT person_id FROM kuntur.unc_in_academic_office WHERE org_id = orgId -- BUCLE QUE RECORRE LAS PERSONAS PERTENECIENTES A UNA ORGANIZACION PARA CAMBIARLE LOS PERMISOS EN STAKEHOLDERS

				LOOP

					UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE user_system_id = personIterator AND enrrollment_id = enrrollmentid;

				END LOOP;

				RETURN true;

			END IF;

			RETURN false;

		END IF;

	--END IF;

	------------------------------

	ELSIF statusCode LIKE 'J' THEN -- EN MATRICULACION

		SELECT org_id INTO orgId FROM kuntur.unc_in_academic_office WHERE person_id = userSystemId;
		
		FOR carCode, subj, filNumb, hrs, orgIdIterator IN SELECT career_code, subject, file_number, hs, org_id from kuntur.unc_in_academic_performance where unc_in_enrrollment_id = enrrollmentId
--SELECT career_code, subject, file_number, hs, org_id FROM KUNTUR.unc_in_academic_performance where unc_in_enrrollment_id = '489090264e78c0ce014e931e3425002b'
		LOOP


			IF  subj IS NOT NULL  AND hrs IS NOT NULL THEN --carCode IS NOT NULL AND AND filNumb IS NOT NULL

	
			ELSE

				flagComplete = false;

				IF orgIdIterator LIKE orgId THEN

					flagOrg = false;

				END IF;

			END IF;

		END LOOP;


		--SELECT COUNT(*) INTO auxCountAP FROM kuntur.unc_in_academic_performance WHERE person_id = userSystemId;
		--SELECT COUNT(*) INTO auxCountAA FROM kuntur.unc_in_study_program WHERE person_id = userSystemId;

		SELECT COUNT(*) INTO auxCountAP FROM kuntur.unc_in_academic_performance WHERE unc_in_enrrollment_id = $2;
		SELECT COUNT(*) INTO auxCountAA FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = $2;

		IF auxCountAP <> auxCountAA THEN
			flagComplete = false;
		END IF;

		--RAISE EXCEPTION 'algo';
		IF flagComplete THEN -- TODOS LOS CAMOS ESTAN LLENOS

			SELECT kuntur.f_change_state(enrrollmentId, userSystem, 'K') INTO result;
			RETURN result;

		ELSE -- NO TODOS LOS CAMPOS ESTAN LLENOS

			IF flagOrg THEN -- FALTAN REGISTROS DE COMPLETAR PERO LA ORGANIZACION A LA QUE PERTENECE LA PERSONA TERMINO
			
				FOR personIterator IN SELECT person_id FROM kuntur.unc_in_academic_office WHERE org_id = orgId -- BUCLE QUE RECORRE LAS PERSONAS PERTENECIENTES A UNA ORGANIZACION PARA CAMBIARLE LOS PERMISOS EN STAKEHOLDERS

				LOOP

					UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE user_system_id = personIterator AND enrrollment_id = enrrollmentid;


				END LOOP;

				RETURN true;

			END IF;

			RETURN false;

		END IF;

	END IF;

	------------------------------

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS  kuntur.f_get_directivos(orgId VARCHAR);

CREATE OR REPLACE FUNCTION kuntur.f_get_directivos(orgId VARCHAR) RETURNS VARCHAR AS
$$
DECLARE

	result json = null;
	coordinadores json = null;
	despacho json = null;

BEGIN


------------------------------------------------------------------COORDINADORES------------------------------------------------------------------------------------------------------------------------------------
	WITH t AS (
		SELECT p.id, family_name, given_name, middle_name,
		replace(
			replace(
				(
					SELECT	string_agg( person_identity::text , ', '::text) 
					FROM (

						SELECT 	TRIM( coalesce(t.code, '') || ' ' || coalesce(i.identity_number, ''))
						FROM kuntur.person_identity i
						JOIN kuntur.person_identity_type t
							ON t.id = i.person_identity_type_id
							AND i.person_id = p.id

					     ) AS person_identity 
				), '("', ''), '")', ''
			)  AS person_identity ,


				(
				select string_agg( email::text, ', '::text) FROM (
						SELECT e.email FROM kuntur.person_email e WHERE e.person_id = p.id
					) AS email 
				) AS email

		FROM kuntur.person p JOIN kuntur.unc_in_academic_coordinator ac ON ac.person_id = p.id WHERE ac.org_id = $1 group by family_name, given_name, middle_name, p.id
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO coordinadores FROM t;

------------------------------------------------------------------------------DESPACHO-----------------------------------------------------------------------------------------------------------

	WITH s AS (
		SELECT p.id, family_name, given_name, middle_name,
		replace(
			replace(
				(
					SELECT	string_agg( person_identity::text , ', '::text) 
					FROM (

						SELECT 	TRIM( coalesce(t.code, '') || ' ' || coalesce(i.identity_number, ''))
						FROM kuntur.person_identity i
						JOIN kuntur.person_identity_type t
							ON t.id = i.person_identity_type_id
							AND i.person_id = p.id

					     ) AS person_identity 
				), '("', ''), '")', ''
			)  AS person_identity ,


				(
				select string_agg( email::text, ', '::text) FROM (
						SELECT e.email FROM kuntur.person_email e WHERE e.person_id = p.id
					) AS email 
				) AS email

		FROM kuntur.person p JOIN kuntur.unc_in_academic_office ac ON ac.person_id = p.id WHERE ac.org_id = $1 group by family_name, given_name, middle_name, p.id
	)
	SELECT array_to_json(array_agg(row_to_json(s.*))) INTO despacho FROM s;

	with r as(
		select coordinadores, despacho
	)
	select row_to_json(r.*) into result from r;--array_to_json()array_agg()

	RETURN result;

END;
$$ language plpgsql;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION kuntur.f_get_org_academic_performance(us VARCHAR) RETURNS VARCHAR AS
$$
DECLARE

  result VARCHAR = NULL;
  rol VARCHAR = NULL;

BEGIN

	SELECT gs.code INTO rol FROM kuntur.user_system us JOIN kuntur.user_group ug ON ug.user_system_id = us.id JOIN kuntur.group_system gs ON gs.id = ug.group_system_id WHERE us.name = $1;

	IF rol LIKE 'admin' THEN	--SI LA PERSONA ES ADMINISTRADOR DEVUELVO TODAS LAS UNIDADES ACADEMICAS

		SELECT array_to_json(array_agg(row_to_json(org.*))) INTO result FROM kuntur.org org INNER JOIN kuntur.org_type types ON org.org_type_id=types.id WHERE code='F' OR code='F';

	ELSE	--SI LA PERSONA NO ES ADMNISTRADOR SOLO DEVUELVO LAS UNIDADES ACADEMICAS DE LAS Q ES DESPACHO

		select array_to_json(array_agg(row_to_json(o.*))) into result from kuntur.unc_in_academic_office ao join kuntur.org o on o.id = ao.org_id join kuntur.user_system us on us.id = ao.person_id where us.name = $1;

	END IF;

	RETURN result;

END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION kuntur.f_info_mails(enrrollmentId VARCHAR)RETURNS VARCHAR AS
$$
DECLARE

	v_status VARCHAR = NULL;

	mailConfig json = NULL;
	stakeholders json = NULL;
	result json = NULL;

BEGIN

	SELECT enrrollment_status_id INTO v_status FROM kuntur.enrrollment WHERE id = $1;

	SELECT array_to_json(array_agg(row_to_json(mc.*))) INTO mailConfig FROM kuntur.mail_config mc WHERE mc.status_id = v_status AND mc.active = TRUE;



	WITH aux AS (
		SELECT us.email, gs.id as group_system_id, gs.code FROM kuntur.enrrollment_stakeholder es JOIN
		kuntur.user_system us ON us.id = es.user_system_id JOIN
			kuntur.user_group ug ON ug.user_system_id = us.id JOIN
				kuntur.group_system gs ON gs.id = ug.group_system_id
					WHERE es.enrrollment_id = $1
	)
	SELECT array_to_json(array_agg(row_to_json(aux.*))) INTO stakeholders FROM aux;

	WITH t AS (
		SELECT mailConfig, stakeholders
	)

	SELECT row_to_json(t.*) INTO result FROM t;

	RETURN result;

END;
$$ LANGUAGE plpgsql;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_get_all_directivos() RETURNS VARCHAR AS
$$
DECLARE

	result json = null;
	coordinadores json = null;
	despacho json = null;

BEGIN


------------------------------------------------------------------COORDINADORES------------------------------------------------------------------------------------------------------------------------------------
	WITH t AS (
		SELECT p.id, family_name, given_name, middle_name,
		replace(
			replace(
				(
					SELECT	string_agg( person_identity::text , ', '::text) 
					FROM (

						SELECT 	TRIM( coalesce(t.code, '') || ' ' || coalesce(i.identity_number, ''))
						FROM kuntur.person_identity i
						JOIN kuntur.person_identity_type t
							ON t.id = i.person_identity_type_id
							AND i.person_id = p.id

					     ) AS person_identity 
				), '("', ''), '")', ''
			)  AS person_identity ,


				(
				select string_agg( email::text, ', '::text) FROM (
						SELECT e.email FROM kuntur.person_email e WHERE e.person_id = p.id
					) AS email 
				) AS email

		FROM kuntur.person p JOIN kuntur.unc_in_academic_coordinator ac ON ac.person_id = p.id group by family_name, given_name, middle_name, p.id
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO coordinadores FROM t;

------------------------------------------------------------------------------DESPACHO-----------------------------------------------------------------------------------------------------------

	WITH s AS (
		SELECT p.id, family_name, given_name, middle_name,
		replace(
			replace(
				(
					SELECT	string_agg( person_identity::text , ', '::text) 
					FROM (

						SELECT 	TRIM( coalesce(t.code, '') || ' ' || coalesce(i.identity_number, ''))
						FROM kuntur.person_identity i
						JOIN kuntur.person_identity_type t
							ON t.id = i.person_identity_type_id
							AND i.person_id = p.id

					     ) AS person_identity 
				), '("', ''), '")', ''
			)  AS person_identity ,


				(
				select string_agg( email::text, ', '::text) FROM (
						SELECT e.email FROM kuntur.person_email e WHERE e.person_id = p.id
					) AS email 
				) AS email

		FROM kuntur.person p JOIN kuntur.unc_in_academic_office ac ON ac.person_id = p.id group by family_name, given_name, middle_name, p.id
	)
	SELECT array_to_json(array_agg(row_to_json(s.*))) INTO despacho FROM s;

	with r as(
		select coordinadores, despacho
	)
	select row_to_json(r.*) into result from r;--array_to_json()array_agg()

	RETURN result;

END;
$$ language plpgsql;


------------------------------------para ver las postulaciones disponibles-------------------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE FUNCTION kuntur.f_get_admission_period_by_org(orgId VARCHAR, userSystemId VARCHAR) RETURNS VARCHAR AS
$$
DECLARE

	result JSON = null;

	v_coun_agreement INTEGER = null;

BEGIN

	SELECT count(*) INTO v_coun_agreement FROM kuntur.admission_period ap 
	WHERE ap.id NOT IN (SELECT admission_period_id FROM kuntur.enrrollment WHERE student_id = $2) AND ap.is_agreement = true;

	IF v_coun_agreement > 0 THEN --CONTROLO SI EL ESTUDIANTE TIENE ACCESO A AGREEMENTS


		WITH t AS(
			--SELECT * FROM kuntur.admission_period ap JOIN kuntur.admission_period_item api ON api.admission_period_id = ap.id WHERE api.org_id = $1
			SELECT * FROM kuntur.admission_period ap 
			--JOIN kuntur.admission_period_item api ON api.admission_period_id = ap.id 
			WHERE ap.id NOT IN (SELECT admission_period_id FROM kuntur.enrrollment WHERE student_id = $2) AND ap.is_agreement = true
		)
		SELECT array_to_json(array_agg(row_to_json(t.*))) INTO result FROM t;



	ELSE--muestro tambien los q no son agreement

		WITH t AS(
			SELECT * FROM kuntur.admission_period ap 
			--JOIN kuntur.admission_period_item api ON api.admission_period_id = ap.id 
			WHERE ap.id NOT IN (SELECT admission_period_id FROM kuntur.enrrollment WHERE student_id = $2)
		)
		SELECT array_to_json(array_agg(row_to_json(t.*))) INTO result FROM t;

	END IF;

	RETURN result;
	

END;
$$
LANGUAGE plpgsql;



--------------------------------------funcion q inserta un nuevo enrrollment---------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_insert_enrrollment(admissionPeriodId VARCHAR, personId VARCHAR) RETURNS BOOLEAN AS
$$

DECLARE

	v_enrrollmentId VARCHAR = null;

BEGIN

INSERT INTO kuntur.enrrollment
SELECT	uuid_generate_v4()::varchar, 
	FALSE, 
	p.given_name, 
	p.middle_name, 
	p.family_name, 
	p.birth_date, 
	p.male, 
	p.url_photo,
	p.comment,--comment
	p.birth_country_code, 
	p.birth_admin_area_level1_code, 
	p.birth_admin_area_level2, 
	p.birth_locality,
	p.birth_lat,
	p.birth_lng::double precision,
	s.institution_short_name,
	s.institution_name, 
	s.institution_original_name,
	s.institution_web_site,
	s.institution_country_code,
	(select number_enrrollment+1 from kuntur.enrrollment order by number_enrrollment desc limit 1) as number_enrrollment,
	(select now()),
	s.org_id,
	p.id,
	s.id,
	$1,
	(select id from kuntur.enrrollment_status where code = 'A')

FROM kuntur.person p 
	join kuntur.student s on s.id = p.id

WHERE p.id = $2

RETURNING id INTO v_enrrollmentId;

INSERT INTO kuntur.enrrollment_identity
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	identity_number,
	code,
	name,
	country_code,
	comment,
	v_enrrollmentId,
	person_identity_type_id
FROM kuntur.person_identity

WHERE person_id = $2;


INSERT INTO kuntur.enrrollment_nationality
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	country_code,
	comment,
	v_enrrollmentId
FROM kuntur.person_nationality

WHERE person_id = $2;

INSERT INTO kuntur.enrrollment_address
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	country_code,
	admin_area_level1_code,
	admin_area_level2,
	locality,
	neighbourhood,
	street,
	street_number,
	building_floor,
	building_room,
	building,
	postal_code,
	comment,
	lat,
	lng,
	v_enrrollmentId
FROM kuntur.person_address

WHERE person_id = $2;


INSERT INTO kuntur.enrrollment_email
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	email,
	comment,
	v_enrrollmentId
FROM kuntur.person_email

WHERE person_id = $2;

INSERT INTO kuntur.enrrollment_phone
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	country_code,
	phone_number,
	comment,
	v_enrrollmentId
FROM kuntur.person_phone

WHERE person_id = $2;


INSERT INTO kuntur.enrrollment_stakeholder--cargo gente de la pri
SELECT	uuid_generate_v4()::varchar, 
	FALSE,
	3,--codigo de administradores
	us.id,
	v_enrrollmentId
FROM kuntur.user_system us 
	join kuntur.user_group ug 
		on ug.user_system_id = us.id 
		join kuntur.group_system gs 
			on gs.id = ug.group_system_id 

where gs.code = 'admin';
--RAISE EXCEPTION 'Nonexistent ID --> %', v_enrrollmentId;
INSERT INTO kuntur.enrrollment_stakeholder-- cargo al alumno
values(uuid_generate_v4()::varchar,FALSE,2, $2, v_enrrollmentId);


INSERT INTO kuntur.unc_in_enrrollment (id, erased) VALUES (v_enrrollmentId, FALSE); 




RETURN true;


END;
$$
LANGUAGE plpgsql;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_get_all_users() RETURNS VARCHAR AS
$$
DECLARE

	result json = null;
	users json = null;

BEGIN
	WITH t AS (
		SELECT p.id, family_name, given_name, middle_name, url_photo, us.name, us.email
		FROM kuntur.person p 
		JOIN kuntur.user_system us ON us.id = p.id 
			GROUP BY family_name, given_name, middle_name, p.id, us.name, us.email			
		
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO users FROM t;


	WITH r AS(
		SELECT users
	)
	SELECT row_to_json(r.*) INTO result FROM r;--array_to_json()array_agg()

	RETURN result;
END;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------frunciones de ggrupos---------------------------------------------------------------------------------


-----------------------------------users por id de grupo ------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION kuntur.f_get_usersby_group(groupId VARCHAR) RETURNS VARCHAR AS
$$
DECLARE

	result json = null;
	users json = null;

BEGIN
	WITH t AS (
		SELECT p.* 
		FROM kuntur.user_system us 
		JOIN kuntur.user_group ug 
			ON ug.user_system_id = us.id 
			JOIN kuntur.group_system gs 
				ON gs.id = ug.group_system_id 
				JOIN kuntur.person p
					ON us.id = p.id

		WHERE gs.id = $1			
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO result FROM t;

	RETURN result;
END;
$$ language plpgsql;


--------------------------------grupos disponibles--------------------------------------------------------------------------------------- 

CREATE OR REPLACE FUNCTION kuntur.f_get_groups() RETURNS VARCHAR AS
$$
DECLARE

	result json = null;

BEGIN
	WITH t AS (
		SELECT * 
		FROM kuntur.group_system	
	)
	SELECT array_to_json(array_agg(row_to_json(t.*))) INTO result FROM t;

	RETURN result;
END;
$$ language plpgsql;	


--------------------------------AGREGAR PERSONA A GRUPO--------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION kuntur.f_add_to_group(usID VARCHAR, groupId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE

	result json = null;

BEGIN

	INSERT INTO kuntur.user_group VALUES (uuid_generate_v4()::varchar, FALSE, $1, $2);

	RETURN TRUE;
END;
$$ language plpgsql;


-------------------------------QUITA UNA PERSNA DE UN GRUPO---------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION kuntur.f_remove_from_group(usID VARCHAR, groupId VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE

	result json = null;

BEGIN

	DELETE FROM kuntur.user_group WHERE user_system_id = $1 AND group_system_id = $2;

	RETURN TRUE;
END;
$$ language plpgsql;

----------------------------------------------------------------------------------------------------------------------------------------


