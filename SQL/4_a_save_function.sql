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

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_orgs(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR, institution_web_site VARCHAR, institution_country_code VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_orgs(inenrrollment_id VARCHAR, user_system_id VARCHAR, institution_original_name VARCHAR, institution_web_site VARCHAR,institution_country_code VARCHAR) RETURNS BOOLEAN AS
$$
DECLARE    	

	update_ok BOOLEAN = false;	

	ic VARCHAR = 'null';
	iw VARCHAR = 'null';
	io VARCHAR = 'null';
	
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

	sql = 'UPDATE kuntur.enrrollment SET institution_original_name = ' || io || ', institution_web_site = ' || iw || ', institution_country_code = ' || ic || ' WHERE id = ''' || $1 || ''' ';
	
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
ALTER FUNCTION kuntur.f_u_enrrollment_male(character varying, character varying, boolean)
  OWNER TO us_kuntur2;


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

	sql = 'UPDATE kuntur.enrrollment SET birth_date = ''' || coalesce(birth_date, 'null') || ''', birth_country_code = ''' || coalesce(birth_country, 'null') || ''' WHERE id = ''' || $1 || ''' ';
	
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

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_Insertaddress(inenrrollment_id character varying, user_system_id character varying, nac character varying);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_Insertaddress(inenrrollment_id character varying, user_system_id character varying, country_code character varying, admin_area_lvl1_code character varying, locality character varying
, neighbourhood character varying, street character varying, street_number character varying, building_floor character varying, building_room character varying, building character varying, postal_code character varying, comment character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;
	sql VARCHAR = 'null';
	
    
BEGIN


	sql = 'INSERT INTO kuntur.enrrollment_address(id, erased, country_code, admin_area_level1_code, admin_area_level2, locality, neighbourhood, street, street_number, building_floor, building_room,
	building, postal_code, comment, lat, lng, enrrollment_id) 
	VALUES (uuid_generate_v4()::varchar, false, '''||coalesce(country_code, 'null')||''', '''||coalesce(admin_area_lvl1_code, 'null')||''' , null, '''||coalesce(locality, 'null')||''', '''||coalesce(neighbourhood, 'null')||'''
	, '''||coalesce(street, 'null')||''', '''||coalesce(street_number, 'null')||''', '''||coalesce(building_floor, 'null')||''', '''||coalesce(building_room, 'null')||''', '''||coalesce(building, 'null')||'''
	, '''||coalesce(postal_code, 'null')||''', '''||coalesce(comment, 'null')||''', null, null, '''||$1||''') ';

	
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

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_InsertInStudyProgram(inenrrollment_id character varying, user_system_id character varying, subject character varying, orgId character varying)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	type_user VARCHAR = 'null';
	
    
BEGIN

	select * into type_user from kuntur.f_role_stakeholder( $1, $2, 'unc_in_study_program' );

	IF type_user = 'ALL' OR type_user = 'STUDENT' THEN

		sql = 'INSERT INTO kuntur.unc_in_study_program(id, erased, subject, approved, approved_by, file_number, comment, unc_in_enrrollment_id, org_id) 
		VALUES (uuid_generate_v4()::varchar, false, ''' || $3 || ''', null , null , null , null, '''||$1||''', '''||$4||''') ';

		
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

DROP FUNCTION IF EXISTS kuntur.f_u_enrrollment_inStudyProgram(inenrrollment_id character varying, user_system_id character varying, subject character varying, orgId character varying, approved BOOLEAN, legajoGuarani CHARACTER VARYING, studyProgramId CHARACTER VARYING);

CREATE OR REPLACE FUNCTION kuntur.f_u_enrrollment_inStudyProgram(inenrrollment_id character varying, user_system_id character varying, subject character varying, orgId character varying, approved BOOLEAN, legajoGuarani CHARACTER VARYING, studyProgramId CHARACTER VARYING)
  RETURNS BOOLEAN AS
$BODY$
DECLARE    	

	update_ok BOOLEAN = false;	
	n VARCHAR = 'null';
	sql VARCHAR = 'null';
	type_user VARCHAR = 'null';
	
    
BEGIN

	select * into type_user from kuntur.f_role_stakeholder( $1, $2, 'unc_in_study_program' );

	IF type_user = 'STUDENT' THEN

		sql = 'UPDATE kuntur.unc_in_study_program SET subject = ''' || $3 || ''' , org_id = '''|| $4 ||''' WHERE id = ''' || $7 || ''''; 		
		
		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSIF type_user = 'COORDINATOR' THEN

		sql = 'UPDATE kuntur.unc_in_study_program SET approved = ''' || $5 || ''' , approved_by = '''|| $2 ||''' WHERE id = ''' || $7 || ''' '; 	

		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSIF type_user = 'OFFICE' THEN

		sql = 'UPDATE kuntur.unc_in_study_program SET file_number = ''' || $6 || ''' WHERE id = ''' || $7 || ''''; 	

		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

		RETURN update_ok;

	ELSIF type_user = 'ALL' THEN
		sql = 'UPDATE kuntur.unc_in_study_program SET file_number = ''' || coalesce($6, 'null') || ''', approved = ' || $5 || ' , approved_by = '''|| $2 ||''', subject = ''' || $3 || ''' , org_id = '''|| $4 ||''' WHERE id = ''' || $7 || ''' '; 	

		SELECT  kuntur.is_update($1, $2, sql, 'unc_in_study_program') INTO update_ok; 

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
    
BEGIN

	IF org_id IS NOT NULL AND CHAR_LENGTH(TRIM(org_id)) > 0 THEN

		oid = '' || TRIM(org_id) || '';
	
	END IF;

	sql = 'UPDATE kuntur.enrrollment SET org_id = ''' || oid || ''' WHERE id = ''' || $1 || ''' ';
	
	SELECT  kuntur.is_update($1, $2, sql, 'enrrollment.org_id') INTO update_ok; 

	IF update_ok THEN

		select name, web_site, country_code into Orgname, web, country from kuntur.org where id = oid;
	
		update kuntur.enrrollment set institution_web_site = web, institution_country_code = country, institution_original_name = Orgname where id = $1;

	END IF;

	RETURN update_ok;
    
END;
$$ LANGUAGE plpgsql;

