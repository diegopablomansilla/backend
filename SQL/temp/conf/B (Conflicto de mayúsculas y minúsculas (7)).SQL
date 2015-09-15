--=================================================================================================================================================
							-- CARGA DE PERSONA	
 --=================================================================================================================================================
DELETE FROM kuntur.person_identity;
DELETE FROM kuntur.person;

  --=================================================================================================================================================


-- SELECT * FROM physical_person_tmp;

/*
DROP VIEW IF EXISTS v_physical_person_distinct_a_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_a_tmp AS	

	SELECT 	DISTINCT last_name, name
	FROM 	physical_person_a_tmp 	
	WHERE 	(name IS NULL AND last_name IS NULL) = false	
	ORDER BY last_name, name; -- 1185
*/
-- SELECT * FROM v_physical_person_distinct_a_tmp;	-- 1185

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_b_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_b_tmp AS

	SELECT 	DISTINCT last_name, name, identification_number  
	FROM 	physical_person_a_tmp 		
	ORDER BY last_name, name, identification_number; -- 1203

-- SELECT * FROM v_physical_person_distinct_b_tmp;	-- 1203

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_c_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_c_tmp AS

	SELECT 	name,
		last_name,
		identification_number
	FROM 	v_physical_person_distinct_b_tmp b
	WHERE	COALESCE(b.identification_number, '')::VARCHAR NOT IN (SELECT COALESCE(x.identification_number, '')::VARCHAR FROM v_physical_person_distinct_b_tmp x GROUP BY x.identification_number HAVING COUNT(*) > 1 AND x.identification_number IS NOT NULL)
	ORDER BY last_name, name, identification_number;

-- SELECT * FROM v_physical_person_distinct_c_tmp; -- 1169

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_d_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_d_tmp AS

	SELECT 	name,
		last_name,
		identification_number
	FROM 	v_physical_person_distinct_b_tmp b
	WHERE	COALESCE(b.identification_number, '')::VARCHAR IN (SELECT COALESCE(x.identification_number, '')::VARCHAR FROM v_physical_person_distinct_b_tmp x GROUP BY x.identification_number HAVING COUNT(*) > 1 AND x.identification_number IS NOT NULL)
	ORDER BY last_name, name, identification_number;

-- SELECT * FROM v_physical_person_distinct_d_tmp; -- 34

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_e_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_e_tmp AS

	SELECT 	(
			SELECT	x.name
			FROM	v_physical_person_distinct_d_tmp x
			WHERE	COALESCE(x.identification_number,'') = COALESCE(d.identification_number,'')
			ORDER BY x.name DESC
			LIMIT 1
		)::VARCHAR AS name,
		(
			SELECT	x.last_name
			FROM	v_physical_person_distinct_d_tmp x
			WHERE	COALESCE(x.identification_number,'') = COALESCE(d.identification_number,'')
			ORDER BY x.last_name DESC
			LIMIT 1
		)::VARCHAR AS last_name,
		identification_number
	FROM 	v_physical_person_distinct_d_tmp d;

-- SELECT * FROM v_physical_person_distinct_e_tmp ORDER BY identification_number, last_name, name; -- 34

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_f_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_f_tmp AS

	SELECT 	DISTINCT * 
	FROM 	v_physical_person_distinct_e_tmp 
	ORDER BY identification_number, last_name, name;


-- SELECT * FROM v_physical_person_distinct_f_tmp -- 17

----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_physical_person_distinct_g_tmp CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_g_tmp AS

	SELECT * FROM v_physical_person_distinct_f_tmp
	UNION ALL
	SELECT * FROM v_physical_person_distinct_c_tmp;


-- SELECT * FROM v_physical_person_distinct_g_tmp -- 1186
 
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

-- SELECT * FROM physical_person_distinct_tmp; -- 1186

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

UPDATE physical_person_b_tmp t SET name = (SELECT x.name FROM physical_person_distinct_tmp x WHERE COALESCE(x.identification_number, '') =  COALESCE(t.identification_number, '')) WHERE t.identification_number IS NOT NULL;
UPDATE physical_person_b_tmp t SET last_name = (SELECT x.last_name FROM physical_person_distinct_tmp x WHERE COALESCE(x.identification_number, '') =  COALESCE(t.identification_number, '')) WHERE t.identification_number IS NOT NULL;


--=================================================================================================================================================

-- SELECT * FROM physical_person_distinct_tmp;

INSERT INTO  kuntur.person (

	SELECT 	p.id,
		false::BOOLEAN AS erased,
		p.name AS given_name,
		null::VARCHAR AS middle_name,
		p.last_name AS family_name,
		(
			SELECT 	x.birth_date
			FROM 	physical_person_tmp x 
			WHERE 	x.birth_date IS NOT NULL
				AND COALESCE(x.name, '') = COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(p.identification_number, '')
			LIMIT 1	
		)::DATE AS birth_date, 
	        (
			SELECT 	x.masculine
			FROM 	physical_person_tmp x 
			WHERE 	x.masculine IS NOT NULL 
				AND COALESCE(x.name, '') = COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(p.identification_number, '')
			LIMIT 1	
		)::BOOLEAN AS male, 
	        (
			SELECT 	x.sys_file_id
			FROM 	physical_person_tmp x 
			WHERE 	x.sys_file_id IS NOT NULL
				AND COALESCE(x.name, '') = COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS url_photo, 
	        (
			SELECT 	x.comment
			FROM 	physical_person_tmp x 
			WHERE 	x.comment IS NOT NULL
				AND COALESCE(x.name, '') = COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS comment, 

		 (
			SELECT 	CASE 	WHEN bc.iso_alfa3 IS NOT NULL AND TRIM(bc.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(bc.iso_alfa3)::VARCHAR 
					--WHEN c.iso_alfa3 IS NOT NULL AND TRIM(c.iso_alfa3)::VARCHAR <> 'ARG' THEN TRIM(c.iso_alfa3)::VARCHAR 
					ELSE NULL::VARCHAR END AS birth_country_code
			FROM 	physical_person_tmp x 
			LEFT JOIN address ba
				ON ba.id = x.birth_address_id
			LEFT JOIN country bc
				ON bc.id = x.country_id
			--LEFT JOIN country c
			--	ON c.id = x.country_id
			WHERE 	COALESCE(x.name, '') = COALESCE(p.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(p.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(p.identification_number, '')
			LIMIT 1	
		)::VARCHAR AS birth_country_code, 
	        null::VARCHAR AS birth_admin_area_level1_code, 
	        null::VARCHAR AS birth_admin_area_level2, 
	        null::VARCHAR AS birth_locality, 
	        null::DOUBLE PRECISION AS birth_lat, 
	        null::DOUBLE PRECISION AS birth_lng  
		
	FROM 	physical_person_distinct_tmp p
);

-- SELECT * FROM kuntur.person; --1186
-- SELECT * FROM kuntur.person ORDER BY birth_country_code; --1186
-- SELECT * FROM kuntur.person WHERE birth_country_code IS NULL ORDER BY birth_country_code; --136

--=================================================================================================================================================

-- SELECT * FROM identification_type_person;

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
			ELSE NULL::VARCHAR END AS country_code,


		-- TRIM(bc.iso_alfa3)::VARCHAR AS country_code, 


		null::VARCHAR AS comment, 
		(	SELECT 	x.id 
			FROM 	physical_person_distinct_tmp x
			WHERE	COALESCE(x.name, '') = COALESCE(pp.name, '')
				AND COALESCE(x.last_name, '') = COALESCE(pp.last_name, '')
				AND COALESCE(x.identification_number, '') = COALESCE(pp.identification_number, '')
		)::VARCHAR AS person_id, 		
		null::VARCHAR AS person_identity_type_id		
	FROM 	physical_person_b_tmp pp	
	LEFT JOIN identification_type_person itp
		ON itp.id = pp.identification_type_person_id

	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id				

	WHERE 	pp.identification_number IS NOT NULL	 	
		AND CHAR_LENGTH(pp.identification_number) > 3; -- 1255
	 	
-- SELECT * FROM v_person_identity_a; -- 1255

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
	
-- SELECT * FROM v_person_identity_b; -- 1255

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

-- SELECT DISTINCT * FROM v_person_identity_c; -- 1205
-- SELECT * FROM v_person_identity_c; -- 1255	

 -- SELECT DISTINCT code, name, country_code FROM v_person_identity_c WHERE code <> 'PASS' AND person_identity_type_id IS NULL ORDER BY country_code;
 -- SELECT DISTINCT code, name FROM v_person_identity_c ORDER BY name, code;

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_d CASCADE;

CREATE OR REPLACE VIEW v_person_identity_d AS 

	SELECT DISTINCT * FROM v_person_identity_c;	


-- SELECT * FROM v_person_identity_d; -- 1205
-- SELECT identity_number, COUNT(*) FROM v_person_identity_d GROUP BY identity_number HAVING COUNT(*) > 1;

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

-- SELECT * FROM v_person_identity_e;

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_f CASCADE;

CREATE OR REPLACE VIEW v_person_identity_f AS 

	SELECT * FROM v_person_identity_d t WHERE COALESCE(t.identity_number,'')::VARCHAR IN (SELECT COALESCE(x.identity_number,'')::VARCHAR FROM v_person_identity_d x GROUP BY x.identity_number HAVING COUNT(*) > 1);	

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
				AND x.identity_number = pi.identity_number
			LIMIT 1	
		)::VARCHAR AS code,
		
		--pi.code,


		(
			SELECT 	x.name
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number = pi.identity_number
			LIMIT 1	
		)::VARCHAR AS name,

		--pi.name,


		
		
		(
			SELECT 	x.country_code
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number = pi.identity_number
			LIMIT 1	
		)::VARCHAR AS country_code, 
		pi.comment, 
		pi.person_id, 

		(
			SELECT 	x.person_identity_type_id
			FROM 	v_person_identity_f x
			WHERE	x.country_code IS NOT NULL
				AND x.identity_number = pi.identity_number
			LIMIT 1	
		)::VARCHAR AS person_identity_type_id
		--pi.person_identity_type_id
	FROM	v_person_identity_f pi
	ORDER BY pi.identity_number;

-- SELECT * FROM v_person_identity_g;
-- SELECT DISTINCT * FROM v_person_identity_g;

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_h CASCADE;

CREATE OR REPLACE VIEW v_person_identity_h AS 	

		SELECT DISTINCT * FROM v_person_identity_g;

-- SELECT * FROM v_person_identity_h;

 ----------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity CASCADE;

CREATE OR REPLACE VIEW v_person_identity AS 	

	SELECT * FROM v_person_identity_h
	UNION ALL
	SELECT * FROM v_person_identity_e;

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
 
 INSERT INTO kuntur.person_identity (
	SELECT 	uuid_generate_v4()::varchar AS id, 
		pi.erased, 
		pi.identity_number, 
		pi.code, 
		pi.name,		
		pi.country_code, 
		pi.comment, 
		pi.person_id, 
		pi.person_identity_type_id 
	FROM 	v_person_identity pi
);

 SELECT * FROM kuntur.person_identity;
 -- SELECT * FROM kuntur.person_identity WHERE country_code IS NULL ;

--=================================================================================================================================================