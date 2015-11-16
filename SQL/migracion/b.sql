--=================================================================================================================================================
							-- CARGA DE PERSONAS	
 --=================================================================================================================================================
DELETE FROM kuntur.user_group CASCADE;
DELETE FROM kuntur.enrrollment_stakeholder CASCADE;
DELETE FROM kuntur.unc_in_academic_coordinator CASCADE;
DELETE FROM kuntur.unc_in_academic_office CASCADE;
DELETE FROM kuntur.unc_in_academic_performance CASCADE;
DELETE FROM kuntur.unc_in_studied_type CASCADE;
DELETE FROM kuntur.unc_in_grading_scale CASCADE;
DELETE FROM kuntur.unc_in_study_program CASCADE;
DELETE FROM kuntur.org WHERE org_id IS NOT NULL;
DELETE FROM kuntur.unc_in_enrrollment CASCADE;
DELETE FROM kuntur.enrrollment_address CASCADE;
DELETE FROM kuntur.enrrollment_phone CASCADE;
DELETE FROM kuntur.enrrollment_email CASCADE;
DELETE FROM kuntur.enrrollment_nationality CASCADE;
DELETE FROM kuntur.enrrollment_identity CASCADE;
DELETE FROM kuntur.enrrollment CASCADE;
DELETE FROM kuntur.admission_period CASCADE; 
DELETE FROM kuntur.student;
DELETE FROM kuntur.org WHERE erased = true;
DELETE FROM kuntur.user_system;
DELETE FROM kuntur.person_address;
DELETE FROM kuntur.person_nationality;
DELETE FROM kuntur.person_phone;
DELETE FROM kuntur.person_email;
DELETE FROM kuntur.person_identity;
DELETE FROM kuntur.person;

  --=================================================================================================================================================


-- SELECT * FROM physical_person_a_tmp;

/*
DROP VIEW IF EXISTS v_physical_person_distinct_a_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_a_tmp AS	

	SELECT 	DISTINCT last_name, name
	FROM 	physical_person_a_tmp 	
	WHERE 	(name IS NULL AND last_name IS NULL) = false	
	ORDER BY last_name, name; -- 1169
*/
-- SELECT * FROM v_physical_person_distinct_a_tmp;	-- 1169

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_b_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_b_tmp AS

	SELECT 	DISTINCT last_name, name, identification_number  
	FROM 	physical_person_a_tmp 		
	ORDER BY last_name, name, identification_number; 

-- SELECT COUNT(*) FROM v_physical_person_distinct_b_tmp;	-- 1069
-- SELECT * FROM v_physical_person_distinct_b_tmp;	

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_c_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_c_tmp AS

	SELECT 	name,
		last_name,
		identification_number
	FROM 	v_physical_person_distinct_b_tmp b
	WHERE	COALESCE(b.identification_number, '')::VARCHAR NOT IN (SELECT COALESCE(x.identification_number, '')::VARCHAR FROM v_physical_person_distinct_b_tmp x GROUP BY x.identification_number HAVING COUNT(*) > 1 AND x.identification_number IS NOT NULL)
	ORDER BY last_name, name, identification_number;

-- SELECT COUNT(*) FROM v_physical_person_distinct_c_tmp; -- 1037
-- SELECT * FROM v_physical_person_distinct_c_tmp; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_d_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_d_tmp AS

	SELECT 	name,
		last_name,
		identification_number
	FROM 	v_physical_person_distinct_b_tmp b
	WHERE	COALESCE(b.identification_number, '')::VARCHAR IN (SELECT COALESCE(x.identification_number, '')::VARCHAR FROM v_physical_person_distinct_b_tmp x GROUP BY x.identification_number HAVING COUNT(*) > 1 AND x.identification_number IS NOT NULL)
	ORDER BY last_name, name, identification_number;

-- SELECT COUNT(*) FROM v_physical_person_distinct_d_tmp; -- 32
-- SELECT * FROM v_physical_person_distinct_d_tmp; --

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_e_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_e_tmp AS

	SELECT 	(
			SELECT	x.name
			FROM	v_physical_person_distinct_d_tmp x
			WHERE	COALESCE(x.identification_number,'') ILIKE COALESCE(d.identification_number,'')
			ORDER BY x.name DESC
			LIMIT 1
		)::VARCHAR AS name,
		(
			SELECT	x.last_name
			FROM	v_physical_person_distinct_d_tmp x
			WHERE	COALESCE(x.identification_number,'') ILIKE COALESCE(d.identification_number,'')
			ORDER BY x.last_name DESC
			LIMIT 1
		)::VARCHAR AS last_name,
		identification_number
	FROM 	v_physical_person_distinct_d_tmp d;

-- SELECT COUNT(*) FROM v_physical_person_distinct_e_tmp; -- 32
-- SELECT * FROM v_physical_person_distinct_e_tmp ORDER BY identification_number, last_name, name; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_f_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_f_tmp AS

	SELECT 	DISTINCT * 
	FROM 	v_physical_person_distinct_e_tmp 
	ORDER BY identification_number, last_name, name;


-- SELECT COUNT(*) FROM v_physical_person_distinct_f_tmp -- 16
-- SELECT * FROM v_physical_person_distinct_f_tmp 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_g_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_g_tmp AS

	SELECT * FROM v_physical_person_distinct_f_tmp
	UNION ALL
	SELECT * FROM v_physical_person_distinct_c_tmp;


-- SELECT COUNT(*) FROM v_physical_person_distinct_g_tmp -- 1053
-- SELECT * FROM v_physical_person_distinct_g_tmp 
 
----------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS physical_person_distinct_tmp CASCADE;

CREATE TABLE physical_person_distinct_tmp
(
	  id character varying(255) NOT NULL,	 
	  name character varying(255),
	  last_name character varying(255),	  
	  identification_number character varying(255)	  
 );

 INSERT INTO physical_person_distinct_tmp (

	SELECT 	uuid_generate_v4()::VARCHAR AS id,
		name AS given_name,
		last_name AS last_name,
		identification_number
	FROM 	v_physical_person_distinct_g_tmp	
	
 );

-- SELECT COUNT(*) FROM physical_person_distinct_tmp; -- 1053
-- SELECT * FROM physical_person_distinct_tmp; 

--=================================================================================================================================================

DROP TABLE IF EXISTS physical_person_b_tmp CASCADE;

CREATE TABLE physical_person_b_tmp
(
	  id character varying(255) NOT NULL  UNIQUE,
	  state_enable boolean,
	  name character varying(255),
	  last_name character varying(255),
	  comment character varying(255),
	  identification_type_person_id character varying(255),
	  identification_number character varying(255),
	  masculine boolean,
	  birth_date date,
	  birth_address_id character varying(255),
	  address_id character varying(255),
	  marital_status character varying(255),
	  phone character varying(255),
	  phone_in_cordoba character varying(255),
	  cell_phone character varying(255),
	  mail character varying(255),
	  sys_file_id character varying(255),
	  postulation boolean,
	  physical_person_id character varying(255),
	  country_id character varying(255)
 );

INSERT INTO physical_person_b_tmp (
	SELECT * FROM physical_person_a_tmp
);

UPDATE physical_person_b_tmp t SET name = (SELECT x.name FROM physical_person_distinct_tmp x WHERE COALESCE(x.identification_number, '') ILIKE  COALESCE(t.identification_number, '')) WHERE t.identification_number IS NOT NULL;
UPDATE physical_person_b_tmp t SET last_name = (SELECT x.last_name FROM physical_person_distinct_tmp x WHERE COALESCE(x.identification_number, '') ILIKE  COALESCE(t.identification_number, '')) WHERE t.identification_number IS NOT NULL;


-- SELECT sys_file_id FROM physical_person_b_tmp  WHERE sys_file_id IS NOT NULL ORDER BY sys_file_id;

--=================================================================================================================================================

DROP VIEW IF EXISTS v_person_tmp CASCADE;

CREATE OR REPLACE VIEW v_person_tmp AS

	SELECT 	p.id,
		false::BOOLEAN AS erased,
		--'Person'::varchar AS class_discriminator,
		p.name AS given_name,
		null::VARCHAR AS middle_name,
		p.last_name AS family_name,
		(
			SELECT 	x.birth_date
			FROM 	physical_person_b_tmp x 
			WHERE 	x.birth_date IS NOT NULL
				AND COALESCE(x.name, '') ILIKE COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(p.identification_number, '')
			LIMIT 1	
		)::DATE AS birth_date, 
	        (
			SELECT 	x.masculine
			FROM 	physical_person_b_tmp x 
			WHERE 	x.masculine IS NOT NULL 
				AND COALESCE(x.name, '') ILIKE COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(p.identification_number, '')
			LIMIT 1	
		)::BOOLEAN AS male, 
	        (
			SELECT 	x.sys_file_id
			FROM 	physical_person_b_tmp x 
			WHERE 	x.sys_file_id IS NOT NULL
				AND COALESCE(x.name, '') ILIKE COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS url_photo, 
	        (
			SELECT 	x.comment
			FROM 	physical_person_b_tmp x 
			WHERE 	x.comment IS NOT NULL
				AND COALESCE(x.name, '') ILIKE COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS comment, 

		 (
			SELECT 	CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
					WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
					ELSE 'XXX'::VARCHAR END AS birth_country_code
			FROM 	physical_person_b_tmp x 
			LEFT JOIN address ba
				ON ba.id = x.birth_address_id
			LEFT JOIN country bc
				ON bc.id = ba.country_id
			LEFT JOIN country c
				ON c.id = x.country_id
			WHERE 	COALESCE(x.name, '') ILIKE COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS birth_country_code, 
	        null::VARCHAR AS birth_admin_area_level1_code, 
	        null::VARCHAR AS birth_admin_area_level2, 
	        null::VARCHAR AS birth_locality, 
	        null::DOUBLE PRECISION AS birth_lat, 
	        null::DOUBLE PRECISION AS birth_lng  
		
	FROM 	physical_person_distinct_tmp p;


-- SELECT * FROM v_person_tmp;
-- SELECT COUNT(*) FROM v_person_tmp;

-- SELECT sys_file_id FROM physical_person_b_tmp  WHERE sys_file_id IS NOT NULL ORDER BY sys_file_id;
-- SELECT url_photo FROM v_person_tmp ORDER BY url_photo;

--=================================================================================================================================================

-- SELECT * FROM physical_person_distinct_tmp;

-- SELECT * FROM v_person_tmp WHERE birth_country_code IS NULL;

INSERT INTO  kuntur.person ( SELECT * FROM v_person_tmp );

-- SELECT COUNT(*) FROM kuntur.person; --1053
-- SELECT * FROM kuntur.person; 
-- SELECT * FROM kuntur.person ORDER BY birth_country_code; 
-- SELECT * FROM kuntur.person WHERE birth_country_code IS NULL ORDER BY birth_country_code; --130

-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;

--=================================================================================================================================================

-- SELECT * FROM identification_type_person;
-- SELECT * FROM physical_person_b_tmp;

DROP VIEW IF EXISTS v_person_identity_a CASCADE;

CREATE OR REPLACE VIEW v_person_identity_a AS 

	SELECT 	null::VARCHAR AS id, -- uuid_generate_v4()::varchar AS id, 
		false::BOOLEAN AS erased, 
		pp.identification_number AS identity_number, 
		CASE 	WHEN trim(itp.name) ILIKE 'Pasaporte' THEN 'PASS'::VARCHAR 
			WHEN trim(itp.name) ILIKE 'ID MErcosur' THEN 'IDM'::VARCHAR
			ELSE trim(itp.name)::VARCHAR
		END AS code, 
		CASE 	WHEN trim(itp.name) ILIKE 'DNI' THEN 'Documento Nacional de Identidad'::VARCHAR 			
			WHEN char_length(trim(itp.name)) = 0 OR itp.name IS NULL THEN 'Otro'::VARCHAR 			
			ELSE trim(itp.name)::VARCHAR
		END AS name, 

		CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
			WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
			ELSE NULL::VARCHAR END AS country_code,


		-- TRIM(bc.iso_alfa3)::VARCHAR AS country_code, 


		null::VARCHAR AS comment, 
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id, 		
		null::VARCHAR AS person_identity_type_id		
	FROM 	physical_person_b_tmp pp	
	LEFT JOIN identification_type_person itp
		ON itp.id = pp.identification_type_person_id

	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	LEFT JOIN country c
		ON c.id = pp.country_id					

	WHERE 	pp.identification_number IS NOT NULL	 	
		AND CHAR_LENGTH(pp.identification_number) > 3; 
	 	
-- SELECT COUNT(*) FROM v_person_identity_a; -- 1114
-- SELECT * FROM v_person_identity_a; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_b CASCADE;

CREATE OR REPLACE VIEW v_person_identity_b AS 

	SELECT 	pi.id, 
		pi.erased, 
		pi.identity_number, 

		CASE 	WHEN pi.code <> 'PASS' AND pi.country_code = 'ARG' THEN (pi.country_code || '_' || 'DNI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'PER' THEN (pi.country_code || '_' || 'DNI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'ESP' THEN (pi.country_code || '_' || 'DNI')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'SLV' THEN (pi.country_code || '_' || 'DUI')::varchar
			
			WHEN pi.code <> 'PASS' AND trim(pi.country_code) = 'COL' THEN (pi.country_code || '_' || 'CC')::varchar
			
			WHEN pi.code <> 'PASS' AND pi.country_code = 'VEN' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'NIC' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'ECU' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'CRI' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'CHL' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'BOL' THEN (pi.country_code || '_' || 'CI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'URY' THEN (pi.country_code || '_' || 'CI')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'PRY' THEN (pi.country_code || '_' || 'CIC')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'BRA' THEN (pi.country_code || '_' || 'RG')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'MEX' THEN (pi.country_code || '_' || 'CURP')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'FRA' THEN (pi.country_code || '_' || 'DIN')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'REU' THEN (pi.country_code || '_' || 'DIN')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'ITA' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'BEL' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'CHE' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'DEU' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'PRT' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'GBR' THEN (pi.country_code || '_' || 'DI')::varchar
			WHEN pi.code <> 'PASS' AND pi.country_code = 'HTI' THEN (pi.country_code || '_' || 'DI')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'PRI' THEN (pi.country_code || '_' || 'TI')::varchar

			WHEN pi.code <> 'PASS' AND pi.country_code = 'USA' THEN (pi.country_code || '_' || 'DR')::varchar
			

			ELSE trim(pi.code)::VARCHAR
		END AS code, 
		pi.name, 
		pi.country_code, 
		pi.comment, 
		pi.person_id, 
		pi.person_identity_type_id
	FROM	v_person_identity_a pi
	ORDER BY pi.code;
	
-- SELECT COUNT(*) FROM v_person_identity_b; -- 1114
-- SELECT * FROM v_person_identity_b; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_c CASCADE;

CREATE OR REPLACE VIEW v_person_identity_c AS 

	SELECT 	pi.id, 
		pi.erased, 
		pi.identity_number, 
		pi.code, 

		CASE 	WHEN trim(pit.id) IS NULL THEN pi.name::VARCHAR ELSE pit.name END AS name,
		
		pi.country_code, 
		pi.comment, 
		pi.person_id, 
		pit.id AS person_identity_type_id
	FROM	v_person_identity_b pi
	LEFT JOIN kuntur.person_identity_type pit
		ON pit.code = pi.code;

-- SELECT COUNT(*) FROM v_person_identity_c; -- 1114
-- SELECT * FROM v_person_identity_c; 	

 -- SELECT DISTINCT code, name, country_code FROM v_person_identity_c WHERE code <> 'PASS' AND person_identity_type_id IS NULL ORDER BY country_code;
 -- SELECT DISTINCT code, name FROM v_person_identity_c ORDER BY name, code;

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_d CASCADE;

CREATE OR REPLACE VIEW v_person_identity_d AS 

	SELECT DISTINCT * FROM v_person_identity_c;	


-- SELECT COUNT(*) FROM v_person_identity_d; -- 1056
-- SELECT * FROM v_person_identity_d; 
-- SELECT identity_number, COUNT(*) FROM v_person_identity_d GROUP BY identity_number HAVING COUNT(*) > 1; -- 10

/*
SELECT 	p.*,
	vpi.*
FROM 	v_person_identity_d  vpi
JOIN	kuntur.person p
	ON p.id = vpi.person_id
--WHERE 	identity_number = '13CH12905';
-- WHERE 	identity_number = '13AP30874';
WHERE 	identity_number = 'PC8201745';
*/

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_e CASCADE;

CREATE OR REPLACE VIEW v_person_identity_e AS 

	SELECT * FROM v_person_identity_d t WHERE COALESCE(t.identity_number,'')::VARCHAR NOT IN (SELECT COALESCE(x.identity_number,'')::VARCHAR FROM v_person_identity_d x GROUP BY x.identity_number HAVING COUNT(*) > 1);	

-- SELECT COUNT(*) FROM v_person_identity_e; -- 1040
-- SELECT * FROM v_person_identity_e; 

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_f CASCADE;

CREATE OR REPLACE VIEW v_person_identity_f AS 

	SELECT * FROM v_person_identity_d t WHERE COALESCE(t.identity_number,'')::VARCHAR IN (SELECT COALESCE(x.identity_number,'')::VARCHAR FROM v_person_identity_d x GROUP BY x.identity_number HAVING COUNT(*) > 1);	

-- SELECT COUNT(*) FROM v_person_identity_f; -- 16
-- SELECT * FROM v_person_identity_f ORDER BY identity_number; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_g CASCADE;

CREATE OR REPLACE VIEW v_person_identity_g AS 

	SELECT 	pi.id, 
		pi.erased, 
		pi.identity_number, 

		(
			SELECT 	x.code
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number ILIKE pi.identity_number
			LIMIT 1	
		)::VARCHAR AS code,
		
		--pi.code,


		(
			SELECT 	x.name
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number ILIKE pi.identity_number
			LIMIT 1	
		)::VARCHAR AS name,

		--pi.name,


		
		
		(
			SELECT 	x.country_code
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number ILIKE pi.identity_number
			LIMIT 1	
		)::VARCHAR AS country_code, 
		pi.comment, 
		pi.person_id, 

		(
			SELECT 	x.person_identity_type_id
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number ILIKE pi.identity_number
			LIMIT 1	
		)::VARCHAR AS person_identity_type_id
		--pi.person_identity_type_id
	FROM	v_person_identity_f pi
	ORDER BY pi.identity_number;

-- SELECT COUNT(*) FROM v_person_identity_g; -- 16
-- SELECT * FROM v_person_identity_g; 

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_h CASCADE;

CREATE OR REPLACE VIEW v_person_identity_h AS 	

		SELECT DISTINCT * FROM v_person_identity_g;

-- SELECT COUNT(*) FROM v_person_identity_h; -- 8
-- SELECT * FROM v_person_identity_h; 

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity CASCADE;

CREATE OR REPLACE VIEW v_person_identity AS 	

	SELECT * FROM v_person_identity_h
	UNION ALL
	SELECT * FROM v_person_identity_e;

-- SELECT COUNT(*) FROM v_person_identity; -- 1048
-- SELECT * FROM v_person_identity ORDER BY identity_number; 

/*
SELECT 	p.*,
	vpi.*
FROM 	v_person_identity  vpi
JOIN	kuntur.person p
	ON p.id = vpi.person_id
--WHERE 	identity_number = '13CH12905';
-- WHERE 	identity_number = '13AP30874';
WHERE 	identity_number = 'PC8201745';
*/

 ----------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM v_person_identity WHERE country_code IS NULL;
 
 INSERT INTO kuntur.person_identity (
	SELECT 	uuid_generate_v4()::varchar AS id, 
		pi.erased, 
		pi.identity_number, 
		pi.code, 
		pi.name,	
		CASE WHEN pi.country_code IS NULL THEN 'XXX' ELSE pi.country_code END,
		--pi.country_code, 
		pi.comment, 
		pi.person_id, 
		pi.person_identity_type_id 
	FROM 	v_person_identity pi
);

UPDATE kuntur.person_identity SET country_code = 'IRL' WHERE identity_number = 'PC8201745';
--SELECT * FROM kuntur.person_identity WHERE identity_number = 'PC8201745';

 -- SELECT COUNT(*) FROM kuntur.person_identity; -- 1048
 -- SELECT * FROM kuntur.person_identity; 
 -- SELECT * FROM kuntur.person_identity WHERE country_code IS NULL ;



 --=================================================================================================================================================

--SELECT * FROM physical_person_b_tmp ORDER BY last_name, name; -- 1260

DROP VIEW IF EXISTS v_person_mail_a CASCADE;

CREATE OR REPLACE VIEW v_person_mail_a AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		mail,
		null::VARCHAR AS comment,
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
	FROM 	physical_person_b_tmp pp
	WHERE	mail IS NOT NULL
	ORDER BY mail;

-- SELECT COUNT(*) FROM v_person_mail_a; -- 1119	
-- SELECT * FROM v_person_mail_a; 	

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_mail_b CASCADE;

CREATE OR REPLACE VIEW v_person_mail_b AS

	SELECT DISTINCT * FROM v_person_mail_a ORDER BY person_id; 

-- SELECT COUNT(*) FROM v_person_mail_b; -- 1118
-- SELECT * FROM v_person_mail_b; 

----------------------------------------------------------------------------------------------------------------------------------------------------

	
INSERT INTO kuntur.person_email (

	SELECT 	uuid_generate_v4()::varchar AS id, 
		erased,
		mail,
		comment,		
		person_id
	FROM 	v_person_mail_b
);

-- SELECT COUNT(*) FROM kuntur.person_email; -- 1118
-- SELECT * FROM kuntur.person_email; 
-- SELECT email, person_id, COUNT(*) FROM kuntur.person_email GROUP BY email, person_id HAVING COUNT(*) > 1;

--=================================================================================================================================================

-- ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡ CONTROL >>> TIENE QUE DAR 0 ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡

 SELECT email, COUNT(*) FROM kuntur.person_email GROUP BY email HAVING COUNT(*) > 1;

-- SELECT * FROM physical_person_b_tmp WHERE mail ILIKE 'paulasaray95@hotmail.com';
-- SELECT * FROM physical_person_b_tmp WHERE mail ILIKE 'a-minnemann@gmx.de'

-- SELECT * FROM kuntur.person WHERE comment IS NOT NULL;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--=================================================================================================================================================


-- SELECT * FROM physical_person_b_tmp;
-- SELECT * FROM kuntur.person;

DROP VIEW IF EXISTS v_person_phone_a CASCADE;

CREATE OR REPLACE VIEW v_person_phone_a AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		
		 (
			SELECT 	CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
					WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
					ELSE NULL::VARCHAR END AS country_code
			FROM 	physical_person_b_tmp x 
			LEFT JOIN address ba
				ON ba.id = x.birth_address_id
			LEFT JOIN country bc
				ON bc.id = ba.country_id
			LEFT JOIN country c
				ON c.id = x.country_id
			WHERE 	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS country_code, 
		
		phone::VARCHAR AS phone_number,
		
		null::VARCHAR AS comment,
		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp
	WHERE	phone IS NOT NULL
	ORDER BY phone;

	
 -- SELECT COUNT(*) FROM v_person_phone_a; -- 1051
 -- SELECT * FROM v_person_phone_a;
 

 
----------------------------------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS v_person_phone_b CASCADE;

CREATE OR REPLACE VIEW v_person_phone_b AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		
		 (
			SELECT 	CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
					WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
					ELSE NULL::VARCHAR END AS country_code
			FROM 	physical_person_b_tmp x 
			LEFT JOIN address ba
				ON ba.id = x.birth_address_id
			LEFT JOIN country bc
				ON bc.id = ba.country_id
			LEFT JOIN country c
				ON c.id = x.country_id
			WHERE 	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS country_code, 
		
		cell_phone::VARCHAR AS phone_number,
		
		null::VARCHAR AS comment,
		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp
	WHERE	cell_phone IS NOT NULL
	ORDER BY phone;


-- SELECT COUNT(*) FROM v_person_phone_b; -- 580
-- SELECT * FROM v_person_phone_b; 

 

 
----------------------------------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS v_person_phone_c CASCADE;

CREATE OR REPLACE VIEW v_person_phone_c AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		
		'ARG'::VARCHAR AS country_code, 
		
		phone_in_cordoba::VARCHAR AS phone_number,
		
		null::VARCHAR AS comment,
		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp
	WHERE	phone_in_cordoba IS NOT NULL
	ORDER BY phone;

	
 -- SELECT COUNT(*) FROM v_person_phone_c; -- 664

 
----------------------------------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS v_person_phone_d CASCADE;

CREATE OR REPLACE VIEW v_person_phone_d AS

	SELECT DISTINCT * FROM v_person_phone_a
	UNION ALL
	SELECT DISTINCT * FROM v_person_phone_b
	UNION ALL
	SELECT DISTINCT * FROM v_person_phone_c; 

-- SELECT COUNT(*) FROM v_person_phone_d; -- 2445
-- SELECT * FROM v_person_phone_d; 



----------------------------------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS v_person_phone_e CASCADE;

CREATE OR REPLACE VIEW v_person_phone_e AS

	SELECT DISTINCT * FROM v_person_phone_d ORDER BY person_id; 

-- SELECT COUNT(*) FROM v_person_phone_e; -- 2240
-- SELECT * FROM v_person_phone_e; 


----------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM v_person_phone_e WHERE country_code IS NULL
	
INSERT INTO kuntur.person_phone (

	SELECT 	uuid_generate_v4()::varchar AS id, 
		erased,
		CASE WHEN country_code IS NULL THEN 'XXX' ELSE country_code END,
		phone_number,
		comment,		
		person_id
	FROM 	v_person_phone_e
);

-- SELECT  COUNT(*) FROM kuntur.person_phone; -- 2240

-- SELECT  * FROM kuntur.person_phone; 

-- SELECT * FROM physical_person_b_tmp WHERE phone = '3516631891' OR phone_in_cordoba = '3516631891' OR cell_phone = '3516631891'



-- ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡ CONTROL >>> VERIFIACR QUE NO SE REPTITAN APELLIDO, NOMBRE, TIENE QUE DAR 0 ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡


SELECT t.last_name, t.name, COUNT(t.*)  
FROM (
	SELECT last_name, name FROM physical_person_b_tmp 
	WHERE LOWER(phone) IN (SELECT LOWER(phone_number) FROM kuntur.person_phone GROUP BY LOWER(phone_number) HAVING COUNT(*) > 1) ORDER BY last_name, name
) t
GROUP BY t.last_name, t.name
HAVING COUNT(t.*) > 1;



-- SELECT phone_number, COUNT(*) FROM kuntur.person_phone GROUP BY phone_number HAVING COUNT(*) > 1;


-- SELECT last_name, name, identification_type_person_id, identification_number, phone, mail, id FROM physical_person_b_tmp WHERE LOWER(phone) IN (SELECT LOWER(phone_number) FROM kuntur.person_phone GROUP BY LOWER(phone_number) HAVING COUNT(*) > 1) ORDER BY last_name, name;

-- SELECT last_name, name, identification_type_person_id, identification_number, phone, mail, id FROM physical_person_b_tmp WHERE LOWER(phone) IN (SELECT LOWER(phone_number) FROM kuntur.person_phone GROUP BY LOWER(phone_number) HAVING COUNT(*) > 1) ORDER BY phone, last_name, name;

-- SELECT * FROM kuntur.person WHERE comment IS NOT NULL;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--=================================================================================================================================================


-- SELECT * FROM physical_person_b_tmp;
-- SELECT * FROM kuntur.person;

DROP VIEW IF EXISTS v_person_nationality_a CASCADE;

CREATE OR REPLACE VIEW v_person_nationality_a AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		
		 (
			SELECT 	CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
					WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
					ELSE NULL::VARCHAR END AS country_code
			FROM 	physical_person_b_tmp x 
			LEFT JOIN address ba
				ON ba.id = x.birth_address_id
			LEFT JOIN country bc
				ON bc.id = ba.country_id
			LEFT JOIN country c
				ON c.id = x.country_id
			WHERE 	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS country_code, 		
		
		null::VARCHAR AS comment,
		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp	
	ORDER BY phone;

	
 -- SELECT COUNT(*) FROM v_person_nationality_a; -- 1119
 -- SELECT * FROM v_person_nationality_a; 
 
----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_nationality_b CASCADE;

CREATE OR REPLACE VIEW v_person_nationality_b AS

	SELECT DISTINCT * FROM v_person_nationality_a WHERE country_code IS NOT NULL ORDER BY person_id, country_code;

-- SELECT COUNT(*) FROM v_person_nationality_b; -- 969	

----------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO kuntur.person_nationality (
		SELECT 	uuid_generate_v4()::varchar AS id, 
			erased,
			country_code,			
			comment,		
			person_id
		FROM 	v_person_nationality_b
);

-- SELECT COUNT(*) FROM kuntur.person_nationality; -- 969
-- SELECT * FROM kuntur.person_nationality; 

--=================================================================================================================================================


-- SELECT * FROM physical_person_b_tmp;
-- SELECT * FROM kuntur.person;

DROP VIEW IF EXISTS v_person_address_a CASCADE;

CREATE OR REPLACE VIEW v_person_address_a AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		TRIM(bc.iso_alfa3)::VARCHAR AS country_code, 
		null::VARCHAR AS admin_area_level1_code, 
		null::VARCHAR AS admin_area_level2, 
		null::VARCHAR AS locality, 
		TRIM(ba.district)::VARCHAR AS neighbourhood, 
		TRIM(ba.street)::VARCHAR AS street, 
		TRIM(ba.number)::VARCHAR AS street_number, 
		TRIM(ba.floor)::VARCHAR AS building_floor, 
		TRIM(ba.flat)::VARCHAR AS building_room, 
		TRIM(ba.building)::VARCHAR AS building, 
		TRIM(ba.postal_code)::VARCHAR AS postal_code, 
		null::VARCHAR AS comment,
		null::DOUBLE PRECISION AS lat, 
		null::DOUBLE PRECISION AS lng, 		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp
	JOIN 	address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id;

-- SELECT COUNT(*) FROM v_person_address_a; -- 1119
-- SELECT * FROM v_person_address_a; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_address_b CASCADE;

CREATE OR REPLACE VIEW v_person_address_b AS

	SELECT 	null::VARCHAR AS id,
		false::BOOLEAN AS erased,
		TRIM(bc.iso_alfa3)::VARCHAR AS country_code, 
		null::VARCHAR AS admin_area_level1_code, 
		null::VARCHAR AS admin_area_level2, 
		null::VARCHAR AS locality, 
		TRIM(ba.district)::VARCHAR AS neighbourhood, 
		TRIM(ba.street)::VARCHAR AS street, 
		TRIM(ba.number)::VARCHAR AS street_number, 
		TRIM(ba.floor)::VARCHAR AS building_floor, 
		TRIM(ba.flat)::VARCHAR AS building_room, 
		TRIM(ba.building)::VARCHAR AS building, 
		TRIM(ba.postal_code)::VARCHAR AS postal_code, 
		null::VARCHAR AS comment,
		null::DOUBLE PRECISION AS lat, 
		null::DOUBLE PRECISION AS lng, 		
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') ILIKE COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') ILIKE COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') ILIKE COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id
		
	FROM 	physical_person_b_tmp pp
	JOIN 	address ba
		ON ba.id = pp.address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id;

-- SELECT COUNT(*) FROM v_person_address_b; -- 1119
-- SELECT * FROM v_person_address_b; 

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_address_c CASCADE;

CREATE OR REPLACE VIEW v_person_address_c AS

	SELECT DISTINCT * FROM v_person_address_a
	UNION ALL
	SELECT DISTINCT * FROM v_person_address_b;

-- SELECT COUNT(*) FROM v_person_address_c; -- 2232
-- SELECT * FROM v_person_address_c; 	

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_address_d CASCADE;

CREATE OR REPLACE VIEW v_person_address_d AS

	SELECT DISTINCT * FROM v_person_address_c;

-- SELECT COUNT(*) FROM v_person_address_d; -- 1116
-- SELECT * FROM v_person_address_d; 	

----------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO kuntur.person_address (

	SELECT 	uuid_generate_v4()::varchar AS id, 
		erased, 
		CASE WHEN country_code IS NULL THEN 'XXX' ELSE country_code END, 
		admin_area_level1_code, 
		admin_area_level2, 
		CASE 	WHEN locality IS NULL AND country_code IS NOT NULL THEN  country_code 
			WHEN locality IS NULL AND country_code IS NULL THEN  'Sin especificar' 
		ELSE locality END, 
		neighbourhood, 
		street, 
		street_number, 
		building_floor, 
		building_room, 
		building, 
		CASE WHEN postal_code IS NULL THEN 'Sin especificar' ELSE postal_code END, 		 
		comment, 
		lat, 
		lng, 
		person_id 
	FROM 	v_person_address_d

);

-- SELECT COUNT(*) FROM kuntur.person_address; -- 1116
-- SELECT * FROM kuntur.person_address; 	

--=================================================================================================================================================

-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;

DROP VIEW IF EXISTS v_user_system_a CASCADE;

CREATE OR REPLACE VIEW v_user_system_a AS 

	SELECT	p.id AS id,
		p.erased, 
		(SELECT email FROM kuntur.person_email pe WHERE pe.person_id = p.id LIMIT 1)::VARCHAR AS name,
		--pp.mail::VARCHAR AS name,
		'1234'::VARCHAR AS pass,
		(SELECT email FROM kuntur.person_email pe WHERE pe.person_id = p.id LIMIT 1)::VARCHAR AS email,
		--pp.mail::VARCHAR AS email,
		p.family_name || ' ' || p.given_name::varchar AS comment	
	FROM	kuntur.person p
	WHERE (SELECT COUNT(pe.*) FROM kuntur.person_email pe WHERE pe.person_id = p.id) = 1;

-- SELECT COUNT(*) FROM v_user_system_a; -- 992
-- SELECT * FROM v_user_system_a; 	

----------------------------------------------------------------------------------------------------------------------------------------------------	

DROP VIEW IF EXISTS v_user_system_b CASCADE;

CREATE OR REPLACE VIEW v_user_system_b AS 

	SELECT	DISTINCT *
	FROM	v_user_system_a
	WHERE  	email IS NOT NULL;

-- SELECT COUNT(*) FROM v_user_system_b; -- 992
-- SELECT * FROM v_user_system_b; 

SELECT * FROM v_user_system_b WHERE email <> name; 	

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.user_system (
		SELECT 	id,
			erased,
			name,
			pass,
			email,
			comment,
			false::boolean AS checked_email
		FROM 	v_user_system_b
	);

-- SELECT COUNT(*) FROM kuntur.user_system; -- 992
-- SELECT * FROM kuntur.user_system; 

UPDATE kuntur.user_system t 
	SET pass = (SELECT x.pwd  FROM act_id_user_tmp x WHERE x.email = t.email) 
WHERE (SELECT COUNT(x.*) FROM act_id_user_tmp x WHERE x.email = t.email) > 0;


-- SELECT COUNT(*) FROM kuntur.user_system WHERE pass = '1234'; -- 22


--=================================================================================================================================================
-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;

-- SELECT * FROM physical_person_b_tmp;
-- SELECT * FROM kuntur.person;

DROP VIEW IF EXISTS v_org_u_a CASCADE;

CREATE OR REPLACE VIEW v_org_u_a AS

		SELECT	i.id::VARCHAR AS id,			
			true::BOOLEAN AS erased,
			null::VARCHAR AS short_name, 
			TRIM(i.name)::VARCHAR AS name, 
			TRIM(i.name)::VARCHAR AS original_name, 
			null::VARCHAR AS photo_url, 
			trim(i.id)::VARCHAR AS web_site, 
			null::VARCHAR AS comment, 
			(SELECT iso_alfa3 FROM country x WHERE x.id = i.country_id)::VARCHAR AS country_code, 
			false::BOOLEAN AS primary_org, 
			null::INTEGER AS code_ona,
			null::VARCHAR AS code_guarani,
			(SELECT id FROM kuntur.org_type x WHERE x.code = 'U')::VARCHAR AS org_type_id, 
			null::VARCHAR AS org_id
			--'xxxxxx',
			--i.* 
		FROM 	institution_in_eri_out i
		WHERE 	COALESCE(i.id, '')::VARCHAR IN (
							SELECT 	p.institution_in_eri_out_id::VARCHAR 
							FROM 	postulation_tmp p 
							WHERE 	p.physical_person_id IS NOT NULL 
								AND p.sys_state_life_cycle_id <> '267'
								AND p.sys_state_life_cycle_id IS NOT NULL
								AND p.state_enable <> false
						)	
		ORDER BY 	i.country_id, 
				i.name;				

-- SELECT COUNT(*) FROM v_org_u_a; -- 0
-- SELECT * FROM v_org_u_a;

----------------------------------------------------------------------------------------------------------------------------------------------------	

DROP VIEW IF EXISTS v_org_u_b CASCADE;

CREATE OR REPLACE VIEW v_org_u_b AS

		SELECT	i.id::VARCHAR AS id,			
			true::BOOLEAN AS erased,
			'Sin especificar'::VARCHAR AS short_name, 
			TRIM(i.name)::VARCHAR AS name, 
			TRIM(i.name)::VARCHAR AS original_name, 
			null::VARCHAR AS photo_url, 
			TRIM(i.id)::VARCHAR AS web_site, 
			null::VARCHAR AS comment, 
			(SELECT TRIM(iso_alfa3) FROM country x WHERE x.id = i.country_id)::VARCHAR AS country_code, 
			false::BOOLEAN AS primary_org, 
			null::INTEGER AS code_ona,
			null::VARCHAR AS code_guarani,
			(SELECT id FROM kuntur.org_type x WHERE x.code = 'U')::VARCHAR AS org_type_id, 
			null::VARCHAR AS org_id
		FROM 	institution i	
		WHERE 	COALESCE(i.id, '')::VARCHAR IN (
							SELECT 	p.institution_id::VARCHAR 
							FROM 	postulation_tmp p 
							WHERE 	p.physical_person_id IS NOT NULL 
								AND p.sys_state_life_cycle_id <> '267'
								AND p.sys_state_life_cycle_id IS NOT NULL
								AND p.state_enable <> false
						)		
		ORDER BY 	i.country_id, 
				i.name;

-- SELECT COUNT(*) FROM v_org_u_b; -- 284
-- SELECT * FROM v_org_u_b;

----------------------------------------------------------------------------------------------------------------------------------------------------					

DROP VIEW IF EXISTS v_org_u_c CASCADE;

CREATE OR REPLACE VIEW v_org_u_c AS

	SELECT DISTINCT * FROM v_org_u_a
	UNION ALL
	SELECT DISTINCT * FROM v_org_u_b;

-- SELECT COUNT(*) FROM v_org_u_c; -- 284
-- SELECT * FROM v_org_u_c;

----------------------------------------------------------------------------------------------------------------------------------------------------					




INSERT INTO kuntur.org (SELECT DISTINCT * FROM v_org_u_c ORDER BY name);			

-- SELECT COUNT(*) FROM kuntur.org WHERE erased = true AND org_type_id = (SELECT id FROM kuntur.org_type x WHERE x.code = 'U'); -- 284
-- SELECT * FROM kuntur.org WHERE erased = true AND org_type_id = (SELECT id FROM kuntur.org_type x WHERE x.code = 'U');


--=================================================================================================================================================
-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;

-- SELECT * FROM physical_person_b_tmp

DROP VIEW IF EXISTS v_p_pp_i_c CASCADE;

CREATE OR REPLACE VIEW v_p_pp_i_c AS 

		SELECT 	pp.id AS physical_person_id,
			p.id AS postulation_id,
			i.id AS institution_id,
			pp.last_name,
			pp.name,
			pp.identification_number,
			i.name AS institution_name,
			i.comment AS institution_comment,
			c.iso_alfa3 AS institution_iso_country
		--SELECT *	
		FROM 	postulation_tmp p 
		JOIN	physical_person_b_tmp pp
			ON pp.id = p.physical_person_id
		JOIN	institution i
			ON i.id = p.institution_id
		JOIN	country c
			ON c.id = i.country_id	
		WHERE 	p.sys_state_life_cycle_id <> '267'
			AND p.sys_state_life_cycle_id IS NOT NULL
			AND p.state_enable <> false;
			
-- SELECT COUNT(*) FROM v_p_pp_i_c; -- 928
-- SELECT * FROM v_p_pp_i_c ORDER BY last_name, name, identification_number;

----------------------------------------------------------------------------------------------------------------------------------------------------					

DROP VIEW IF EXISTS v_p_d CASCADE;

CREATE OR REPLACE VIEW v_p_d AS 

	SELECT 	p.id,
		p.given_name,
		p.family_name,
		(SELECT x.identity_number FROM kuntur.person_identity x WHERE x.person_id = p.id)::VARCHAR AS identity_number
	FROM	kuntur.person p;	

-- SELECT COUNT(*) FROM v_p_d; -- 1053
-- SELECT * FROM v_p_d;

----------------------------------------------------------------------------------------------------------------------------------------------------					
-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;


DROP VIEW IF EXISTS v_student_a CASCADE;

CREATE OR REPLACE VIEW v_student_a AS 

	SELECT	p.id,
		false::BOOLEAN AS erased,
		null::BIGINT AS file_number, 
		(	SELECT 	DISTINCT x.institution_name 
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
		)::VARCHAR AS institution_original_name,	
		null::VARCHAR AS institution_web_site,	
		(	SELECT 	DISTINCT x.institution_iso_country
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
		)::VARCHAR AS institution_country_code,	
		(	SELECT 	DISTINCT x.institution_id
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
		)::VARCHAR AS org_id			
	FROM	v_p_d p	
	WHERE	(	SELECT 	COUNT(x.*) 
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
		) = 1;

-- SELECT COUNT(*) FROM v_student_a; -- 876
-- SELECT * FROM v_student_a;		

----------------------------------------------------------------------------------------------------------------------------------------------------					

DROP VIEW IF EXISTS v_student_b CASCADE;

CREATE OR REPLACE VIEW v_student_b AS 

	SELECT	p.id,
		false::BOOLEAN AS erased,
		null::BIGINT AS file_number, 
		(	SELECT 	DISTINCT x.institution_name 
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
			LIMIT 1	
		)::VARCHAR AS institution_original_name,	
		null::VARCHAR AS institution_web_site,	
		(	SELECT 	DISTINCT x.institution_iso_country
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
			LIMIT 1	
		)::VARCHAR AS institution_country_code,	
		(	SELECT 	DISTINCT x.institution_id
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
			LIMIT 1	
		)::VARCHAR AS org_id			
	FROM	v_p_d p	
	WHERE	(	SELECT 	COUNT(x.*) 
			FROM 	v_p_pp_i_c x 
			WHERE	COALESCE(x.name, '')::VARCHAR ILIKE COALESCE(p.given_name, '')::VARCHAR
				AND COALESCE(x.last_name, '')::VARCHAR ILIKE COALESCE(p.family_name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR ILIKE COALESCE(p.identity_number, '')::VARCHAR
		) > 1;

-- SELECT COUNT(*) FROM v_student_b; -- 70
-- SELECT * FROM v_student_b;

----------------------------------------------------------------------------------------------------------------------------------------------------					

DROP VIEW IF EXISTS v_student_c CASCADE;

CREATE OR REPLACE VIEW v_student_c AS 

	SELECT * FROM v_student_a
	UNION ALL
	SELECT * FROM v_student_b;

-- SELECT COUNT(*) FROM v_student_c; -- 955
-- SELECT * FROM v_student_c;	

----------------------------------------------------------------------------------------------------------------------------------------------------					
-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;


INSERT INTO kuntur.student (

	SELECT	e.id,
		e.erased, 
		e.file_number, 

		CASE 	WHEN e.institution_original_name IS NULL THEN 'Sin especificar'::varchar 
			ELSE e.institution_original_name
		END AS institution_short_name,		

		CASE 	WHEN e.institution_original_name IS NULL THEN 'Sin especificar'::varchar 
			ELSE e.institution_original_name 
		END AS institution_name,		

		CASE 	WHEN e.institution_original_name IS NULL THEN 'Sin especificar'::varchar 
			ELSE e.institution_original_name 
		END AS institution_original_name,		
		 
		'Sin especificar'::varchar AS institution_web_site, 
		
		CASE 	WHEN institution_country_code IS NULL 
			THEN 'Sin especificar'::varchar 
			ELSE institution_country_code 
		END  AS institution_country_code, 
		
		e.org_id
		
	FROM	v_student_c e
	 
);
	

-- SELECT COUNT(*) FROM kuntur.student; -- 874
-- SELECT * FROM kuntur.student;	

-- SELECT url_photo FROM  kuntur.person ORDER BY url_photo;

----------------------------------------------------------------------------------------------------------------------------------------------------					
/*
SELECT 	i.*, h.*
FROM 	kuntur.person p
LEFT JOIN kuntur.person_identity i
	ON p.id = i.person_id
LEFT JOIN kuntur.person_phone h
	ON p.id = h.person_id	
	AND h.country_code <> 'ARG'
WHERE 	p.birth_country_code ilike 'xxx'
*/

UPDATE kuntur.person SET birth_country_code = 'Sin especificar' WHERE birth_country_code ilike 'xxx';
UPDATE kuntur.person_identity SET country_code = 'Sin especificar' WHERE country_code ilike 'xxx';
UPDATE kuntur.person_phone SET country_code = 'Sin especificar' WHERE country_code ilike 'xxx';

----------------------------------------------------------------------------------------------------------------------------------------------------					

SELECT 'FIN DEL PROCESO B'::VARCHAR FROM postulation LIMIT 100;
