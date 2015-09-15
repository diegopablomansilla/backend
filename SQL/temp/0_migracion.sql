DELETE FROM kuntur.enrrollment_stakeholder CASCADE;
DELETE FROM kuntur.unc_in_academic_office CASCADE;
DELETE FROM kuntur.unc_in_academic_coordinator CASCADE;
DELETE FROM kuntur.contact CASCADE;
DELETE FROM kuntur.unc_in_academic_performance CASCADE;
DELETE FROM kuntur.unc_in_grading_scale;
DELETE FROM kuntur.unc_in_studied_type CASCADE;
DELETE FROM kuntur.unc_in_study_program CASCADE;
DELETE FROM kuntur.org WHERE org_id IS NOT NULL;
DELETE FROM kuntur.unc_in_enrrollment CASCADE;
DELETE FROM kuntur.enrrollment_address CASCADE;
DELETE FROM kuntur.enrrollment_identity CASCADE;
DELETE FROM kuntur.enrrollment_nationality CASCADE;	
DELETE FROM kuntur.enrrollment_phone CASCADE;	
DELETE FROM kuntur.enrrollment_email CASCADE;	
DELETE FROM kuntur.enrrollment CASCADE;	
DELETE FROM kuntur.admission_period CASCADE;	
DELETE FROM kuntur.student CASCADE;
DELETE FROM kuntur.org WHERE erased = true AND org_type_id = (SELECT id FROM kuntur.org_type x WHERE x.code = 'U');
DELETE FROM kuntur.user_system CASCADE;
DELETE FROM kuntur.person_identity CASCADE;
DELETE FROM kuntur.person_nationality CASCADE;
DELETE FROM kuntur.person_email CASCADE;
DELETE FROM kuntur.person_phone CASCADE;
DELETE FROM kuntur.person_address CASCADE;
DELETE FROM kuntur.person CASCADE;

-- =========================================================================

DROP VIEW IF EXISTS v_enrrollment_status_map CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_status_map AS

	SELECT 'A'::VARCHAR AS code, 'Postulante'::VARCHAR AS comment, '268'::VARCHAR AS number_code
	UNION ALL
	SELECT 'B'::VARCHAR AS code,'Administrativos PRI'::VARCHAR AS comment, '259'::VARCHAR AS number_code
	UNION ALL
	SELECT 'C'::VARCHAR AS code,'Postulante'  AS comment, '260'::VARCHAR AS number_code
	UNION ALL
	SELECT 'D'::VARCHAR AS code,'Coordinadores Academicos'  AS comment , '261'::VARCHAR AS number_code
	UNION ALL
	SELECT 'E'::VARCHAR AS code,'Postulante'  AS comment, '264'::VARCHAR AS number_code
	UNION ALL
	SELECT 'F'::VARCHAR AS code,'Administrativos PRI'  AS comment, '262'::VARCHAR AS number_code
	UNION ALL
	SELECT 'G'::VARCHAR AS code,'Postulante'   AS comment, '263'::VARCHAR AS number_code
	UNION ALL
	SELECT 'H'::VARCHAR AS code,'Despachos'  AS comment, '270'::VARCHAR AS number_code
	UNION ALL
	SELECT 'I'::VARCHAR AS code,'Administrativos PRI'  AS comment, '265'::VARCHAR AS number_code
	UNION ALL
	SELECT 'J'::VARCHAR AS code,'Despachos'   AS comment, '271'::VARCHAR AS number_code
	UNION ALL
	SELECT 'K'::VARCHAR AS code,'Administrativos PRI'  AS comment , '266'::VARCHAR AS number_code
	UNION ALL
	SELECT 'z'::VARCHAR AS code,'Administrativos PRI'  AS comment, '267'::VARCHAR AS number_code;

-- SELECT * FROM v_enrrollment_status_map;	


DROP VIEW IF EXISTS v_postulation_ok_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp AS 

	SELECT 	trim(pp.id)::varchar AS physical_person_id,
		p.id AS postulation_id,
		trim(pp.last_name)::varchar AS last_name,
		trim(pp.name)::varchar AS name,
		trim(pp.identification_number)::varchar AS identification_number,		
		lower(trim(pp.mail))::varchar AS mail,
		pa.year_academic,
		CASE WHEN pa.semester1 = true THEN 1 ELSE 2 END AS semester,			
		pa.start_period,
		pa.end_period,	
		esm.code AS status_code,		
		trim(slc.name)::varchar AS state,
		esm.number_code AS status_number_code,
		trim(slc.id)::varchar AS state_id,		
		esm.comment AS status_comment,		
		trim(i.name)::varchar AS institution_name,
		trim(c.iso_alfa3)::varchar AS institution_country_code,
		trim(i.id)::varchar AS institution_id
	FROM	physical_person pp
	JOIN	postulation p
		ON pp.id = p.physical_person_id
	LEFT JOIN institution i 
		ON i.id::text = p.institution_id::text
	LEFT JOIN country c 
		ON c.id::text = i.country_id::text
	LEFT JOIN sys_state_life_cycle slc
		ON slc.id = p.sys_state_life_cycle_id
	LEFT JOIN v_enrrollment_status_map esm
		ON p.sys_state_life_cycle_id = esm.number_code	
	LEFT JOIN period_admission pa
		ON pa.id = p.period_admission_id	
	WHERE 	trim(pp.mail) NOT ILIKE '%unc.edu.ar%'
		--AND trim(pp.mail) NOT ILIKE '%@pri.unc.edu.ar%'
		--AND trim(pp.mail) NOT ILIKE '%@psi.unc.edu.ar%'		
		AND slc.name <> 'Desistida'		
		AND trim(pp.mail) <> 'diegopablomansilla@gmail.com'			
		AND pp.id <> '489090263af126a7013af4969101001b'	
		AND p.id <> '489090263a2c13fc013a2c7995d50007'
		AND p.id <> '4890902645d7483c0145ff59eb47015f'
		AND p.id <> '489090264c037dd8014d28f563a0074e'
		AND p.id <> '4890902648308086014831a0a804000a'	
		AND p.id <> '4890902639fecae2013a02e8a0bc0031'	
		AND p.id <> '48909026460aedad01462f470b8a0147'	
		AND p.id <> '00000000415a0312014185c7050c0154'	
		AND p.id <> '000000004275cbe40142a0e73ace0103'	
		AND p.id <> 'edu_hernandez_postulation'	
	ORDER BY 	pa.year_academic ASC,  
			semester ASC, 
			pp.last_name ASC, 
			pp.name ASC,
			esm.code ASC;

-- SELECT * FROM v_postulation_ok_tmp
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%correa%';
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%orcellet%';
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%guessi%';
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%guesi%';
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%mansilla%';
-- SELECT * FROM v_postulation_ok_tmp WHERE mail ILIKE '%unc.%';


DROP TABLE IF EXISTS postulation_ok_tmp CASCADE ;

CREATE TABLE postulation_ok_tmp
(

		physical_person_id VARCHAR,
		postulation_id VARCHAR,
		last_name VARCHAR,
		name VARCHAR,
		identification_number VARCHAR,		
		mail VARCHAR,
		year_academic INTEGER,
		semester INTEGER,			
		start_period DATE,
		end_period DATE,	
		status_code VARCHAR,
		status_code_max VARCHAR,
		state VARCHAR,
		status_number_code VARCHAR,
		state_id VARCHAR,		
		status_comment VARCHAR,		
		institution_name VARCHAR,
		institution_country_code VARCHAR,
		institution_id VARCHAR 
);

INSERT INTO postulation_ok_tmp (

	SELECT 	v.physical_person_id, 
		v.postulation_id, 
		v.last_name, 
		v.name, 
		v.identification_number, 
		v.mail, 
		v.year_academic, 
		v.semester, 
		v.start_period, 
		v.end_period, 
		v.status_code, 

		(

			SELECT 	MAX(x.status_code)
			FROM 	v_postulation_ok_tmp x 
			WHERE 	x.last_name = v.last_name
				AND x.name = v.name
				AND x.identification_number = v.identification_number
				AND x.mail = v.mail
				AND x.year_academic = v.year_academic
				AND x.semester = v.semester					

		) AS status_code_max,
		
		v.state, 
		v.status_number_code, 
		v.state_id, 
		v.status_comment, 
		v.institution_name, 
		v.institution_country_code, 
		v.institution_id
	FROM v_postulation_ok_tmp v
);


-- SELECT * FROM postulation_ok_tmp;

DELETE FROM postulation_ok_tmp WHERE status_code <> status_code_max;

----------------------------------------------------------------

DROP VIEW IF EXISTS v_postulation_ok_tmp_x CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp_x AS 
			
	SELECT 	v.* 
	FROM 	postulation_ok_tmp v	
	WHERE	(	SELECT 	count(x.*) 
			FROM 	postulation_ok_tmp x 
			WHERE 	x.last_name = v.last_name
				AND x.name = v.name
				AND x.identification_number = v.identification_number
				AND x.mail = v.mail
				AND x.year_academic = v.year_academic
				AND x.semester = v.semester
				AND x.state <> v.state
		) > 0
	--WHERE mail = 'aalarconipn@gmail.com'
	ORDER BY last_name, name, identification_number, state;		

-- SELECT * FROM v_postulation_ok_tmp_x ORDER BY year_academic, semester, last_name, name;

------------------------------------------------------------------------

DROP VIEW IF EXISTS v_postulation_ok_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp AS 

	SELECT 	v.physical_person_id, 
		v.postulation_id, 
		v.last_name, 
		v.name, 
		v.identification_number, 
		v.mail, 
		v.year_academic, 
		v.semester, 
		v.start_period, 
		v.end_period, 
		v.status_code,
		v.state, 
		v.status_number_code, 
		v.state_id, 
		v.status_comment, 
		v.institution_name, 
		v.institution_country_code, 
		v.institution_id 
	FROM 	postulation_ok_tmp v;

-- SELECT * FROM v_postulation_ok_tmp;	

---------------------------------------------------------------------------------			
---------------------------------------------------------------------------------			
---------------------------------------------------------------------------------			

DROP VIEW IF EXISTS v_postulation_ok_tmp_b CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp_b AS 

	SELECT 	t.physical_person_id,
		t.last_name, 
		t.name, 
		t.mail,
		t.identification_number, 

		CASE WHEN t.institution_name IS NULL THEN (
								SELECT 	x.institution_name 
								FROM 	v_postulation_ok_tmp x
								WHERE	x.physical_person_id = t.physical_person_id
									AND x.institution_name IS NOT NULL
								LIMIT 1		
							)::varchar
			ELSE institution_name
		END AS institution_name,

		CASE WHEN institution_country_code IS NULL THEN (
								SELECT 	x.institution_country_code 
								FROM 	v_postulation_ok_tmp x
								WHERE	x.physical_person_id = t.physical_person_id
									AND x.institution_country_code IS NOT NULL
								LIMIT 1		
							)::varchar
			ELSE institution_country_code
		END AS institution_country_code
		 
	FROM 	v_postulation_ok_tmp t
	ORDER BY t.last_name, t.name, t.identification_number;

-- SELECT * FROM v_postulation_ok_tmp_b; -- 1290
-- SELECT DISTINCT * FROM v_postulation_ok_tmp_b; -- 1262

---------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_postulation_ok_tmp_c CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp_c AS 

	 SELECT DISTINCT * FROM v_postulation_ok_tmp_b;

-- SELECT * FROM v_postulation_ok_tmp_c ;

/*
SELECT * FROM v_postulation_ok_tmp_c 
WHERE physical_person_id IN (SELECT physical_person_id FROM v_postulation_ok_tmp_c GROUP BY physical_person_id HAVING count(*) > 1)
ORDER BY last_name, name, identification_number;

---------------------------------------------------------------------------------

select * from v_postulation_ok_tmp
WHERE physical_person_id IN
	(
	SELECT physical_person_id FROM v_postulation_ok_tmp_c 
	WHERE physical_person_id IN (SELECT physical_person_id FROM v_postulation_ok_tmp_c GROUP BY physical_person_id HAVING count(*) > 1)
	ORDER BY last_name, name, identification_number
	)

	ORDER BY last_name, name, identification_number;
	
*/


-- ==============================================================================


DROP VIEW IF EXISTS v_contact_a CASCADE;

CREATE OR REPLACE VIEW v_contact_a AS

		SELECT	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased,
			false::boolean AS reception_student,
			true::boolean AS sending_student,
			i.id::varchar AS org_id,
			pp.id::varchar AS person_id
		FROM 	institution_in_eri_out i
		JOIN	institution_in_eri_out_physical_person_in_eri_out_list ipl
			ON i.id = ipl.institution_in_eri_out_id
		JOIN	physical_person_in_eri_out pp		
			ON pp.id = ipl.physical_person_in_eri_out_id	
		ORDER BY 	i.country_id, 
				i.name, 
				ipl.order_number;	

-- SELECT DISTINCT * FROM v_contact_a;	

DROP VIEW IF EXISTS v_contact_b CASCADE;

CREATE OR REPLACE VIEW v_contact_b AS

		SELECT	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased,
			false::boolean AS reception_student,
			true::boolean AS sending_student,
			i.id::varchar AS org_id,
			pp.id::varchar AS person_id
		FROM 	institution i
		JOIN	institution_physical_person_list ipl
			ON i.id = ipl.institution_id
		JOIN	physical_person pp		
			ON pp.id = ipl.physical_person_id
			AND trim(pp.mail) <> 'diegopablomansilla@gmail.com'
			AND trim(pp.mail) <> 'dmansilla@psi.unc.edu.ar'
		ORDER BY 	i.country_id, 
				i.name, 
				ipl.order_number;	

-- SELECT DISTINCT * FROM v_contact_b;


DROP VIEW IF EXISTS v_contact CASCADE;

CREATE OR REPLACE VIEW v_contact AS

	SELECT DISTINCT * FROM v_contact_a
	UNION ALL
	SELECT DISTINCT * FROM v_contact_b;

-- ==============================================================================

-- SELECT * FROM physical_person pp

DROP VIEW IF EXISTS v_person_a CASCADE;

CREATE OR REPLACE VIEW v_person_a AS 

	SELECT 	trim(pp.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN pp.name IS NOT NULL THEN initcap(trim(pp.name))::varchar 
			WHEN pp.last_name IS NOT NULL THEN initcap(trim(pp.last_name))::varchar 
			ELSE 'Sin Nombre'  
		END AS given_name, 
		--trim(pp.name)::varchar AS given_name, 

		null::varchar AS middle_name, 

		CASE 	WHEN pp.last_name IS NOT NULL THEN initcap(trim(pp.last_name))::varchar 
			WHEN pp.name IS NOT NULL THEN initcap(trim(pp.name))::varchar 
			ELSE 'Sin Apellido'  
		END AS family_name, 
		
		--trim(pp.last_name)::varchar AS family_name, 
		pp.birth_date::date AS birth_date, 
		pp.masculine::boolean AS male, 
		trim(sf.back_end_path)::varchar AS url_photo, 
		trim(pp.comment)::varchar AS comment,
		 
		CASE WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar ELSE TRIM(c.iso_alfa3)::varchar END AS birth_country_code, 		

		null::varchar AS birth_admin_area_level1_code, 		
		null::varchar AS birth_admin_area_level2, 
		null::varchar AS birth_locality, 
		null::double precision AS birth_lat, 
		null::double precision AS birth_lng 	
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN sys_file sf
		ON sf.id = pp.sys_file_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	LEFT JOIN country c
		ON c.id = pp.country_id
	WHERE	trim(mail) <>	'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND (
			pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp) 
			--OR pp.id IN (SELECT DISTINCT vc.person_id FROM v_contact_b vc)
		    );


-- SELECT *   FROM v_person_a;

-----------------------------------------------


DROP VIEW IF EXISTS v_person_b CASCADE;

CREATE OR REPLACE VIEW v_person_b AS 

	SELECT 	trim(pp.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN pp.name IS NOT NULL THEN initcap(trim(pp.name))::varchar 
			WHEN pp.last_name IS NOT NULL THEN initcap(trim(pp.last_name))::varchar 
			ELSE 'Sin Nombre'  
		END AS given_name, 
		--trim(pp.name)::varchar AS given_name, 

		null::varchar AS middle_name, 

		CASE 	WHEN pp.last_name IS NOT NULL THEN initcap(trim(pp.last_name))::varchar 
			WHEN pp.name IS NOT NULL THEN initcap(trim(pp.name))::varchar 
			ELSE 'Sin Apellido'  
		END AS family_name, 
		
		--trim(pp.last_name)::varchar AS family_name, 
		pp.birth_date::date AS birth_date, 
		pp.masculine::boolean AS male, 
		trim(sf.back_end_path)::varchar AS url_photo, 
		trim(pp.comment)::varchar AS comment,
		 
		CASE WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar ELSE TRIM(c.iso_alfa3)::varchar END AS birth_country_code, 		

		null::varchar AS birth_admin_area_level1_code, 		
		null::varchar AS birth_admin_area_level2, 
		null::varchar AS birth_locality, 
		null::double precision AS birth_lat, 
		null::double precision AS birth_lng 	
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN sys_file sf
		ON sf.id = pp.sys_file_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	LEFT JOIN country c
		ON c.id = pp.country_id;	

-- SELECT *   FROM v_person_b;

DROP VIEW IF EXISTS v_person CASCADE;

CREATE OR REPLACE VIEW v_person AS 

	SELECT *   FROM v_person_a
	UNION ALL
	SELECT *   FROM v_person_b;
	
-- SELECT *   FROM v_person;

-----------------------------------------------


DROP VIEW IF EXISTS v_person_address_a CASCADE;

CREATE OR REPLACE VIEW v_person_address_a AS 

	SELECT 	trim(a.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(c.iso_alfa3)::varchar AS country_code, 
		null::varchar AS admin_area_level1_code, 
		trim(a.state)::varchar AS admin_area_level2, 
		null::varchar AS locality, 
		trim(a.district)::varchar AS neighbourhood, 
		trim(a.street)::varchar AS street, 
		trim(a.number)::varchar AS street_number, 
		trim(a.floor)::varchar AS building_floor, 
		trim(a.flat)::varchar AS building_room, 
		trim(a.building)::varchar AS building, 
		trim(a.postal_code)::varchar AS postal_code, 
		null::varchar AS comment, 
		null::double precision AS lat, 
		null::double precision AS lng, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	--LEFT JOIN address ba
	--	ON ba.id = pp.birth_address_id
	--LEFT JOIN country bc
	--	ON bc.id = ba.country_id
	JOIN 	address a
		ON a.id = pp.address_id
	LEFT JOIN country c
		ON c.id = a.country_id
	WHERE	trim(mail) <>	'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);

-- SELECT * FROM v_person_address_a;

DROP VIEW IF EXISTS v_person_address_b CASCADE;

CREATE OR REPLACE VIEW v_person_address_b AS 

	SELECT 	trim(a.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(c.iso_alfa3)::varchar AS country_code, 
		null::varchar AS admin_area_level1_code, 
		trim(a.state)::varchar AS admin_area_level2, 
		null::varchar AS locality, 
		trim(a.district)::varchar AS neighbourhood, 
		trim(a.street)::varchar AS street, 
		trim(a.number)::varchar AS street_number, 
		trim(a.floor)::varchar AS building_floor, 
		trim(a.flat)::varchar AS building_room, 
		trim(a.building)::varchar AS building, 
		trim(a.postal_code)::varchar AS postal_code, 
		null::varchar AS comment, 
		null::double precision AS lat, 
		null::double precision AS lng, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	JOIN address a
		ON a.id = pp.birth_address_id
	LEFT JOIN country c
		ON c.id = a.country_id
	WHERE	trim(mail) <>	'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);	
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country c
	--	ON c.id = a.country_id;

-- SELECT * FROM v_person_address_b;

DROP VIEW IF EXISTS v_person_address_c CASCADE;

CREATE OR REPLACE VIEW v_person_address_c AS 

	SELECT 	trim(a.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(c.iso_alfa3)::varchar AS country_code, 
		null::varchar AS admin_area_level1_code, 
		trim(a.state)::varchar AS admin_area_level2, 
		null::varchar AS locality, 
		trim(a.district)::varchar AS neighbourhood, 
		trim(a.street)::varchar AS street, 
		trim(a.number)::varchar AS street_number, 
		trim(a.floor)::varchar AS building_floor, 
		trim(a.flat)::varchar AS building_room, 
		trim(a.building)::varchar AS building, 
		trim(a.postal_code)::varchar AS postal_code, 
		null::varchar AS comment, 
		null::double precision AS lat, 
		null::double precision AS lng, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	--LEFT JOIN address ba
	--	ON ba.id = pp.birth_address_id
	--LEFT JOIN country bc
	--	ON bc.id = ba.country_id
	JOIN address a
		ON a.id = pp.address_id
	LEFT JOIN country c
		ON c.id = a.country_id;

-- SELECT * FROM v_person_address_c;

DROP VIEW IF EXISTS v_person_address_d CASCADE;

CREATE OR REPLACE VIEW v_person_address_d AS 

	SELECT 	trim(a.id)::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(c.iso_alfa3)::varchar AS country_code, 
		null::varchar AS admin_area_level1_code, 
		trim(a.state)::varchar AS admin_area_level2, 
		null::varchar AS locality, 
		trim(a.district)::varchar AS neighbourhood, 
		trim(a.street)::varchar AS street, 
		trim(a.number)::varchar AS street_number, 
		trim(a.floor)::varchar AS building_floor, 
		trim(a.flat)::varchar AS building_room, 
		trim(a.building)::varchar AS building, 
		trim(a.postal_code)::varchar AS postal_code, 
		null::varchar AS comment, 
		null::double precision AS lat, 
		null::double precision AS lng, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	JOIN address a
		ON a.id = pp.birth_address_id
	LEFT JOIN country c
		ON c.id = a.country_id;
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country c
	--	ON c.id = a.country_id;

-- SELECT * FROM v_person_address_d;


DROP VIEW IF EXISTS v_person_address CASCADE;

CREATE OR REPLACE VIEW v_person_address AS 

	SELECT * FROM v_person_address_b
	UNION ALL
	SELECT * FROM v_person_address_a
	UNION ALL
	SELECT * FROM v_person_address_c
	UNION ALL
	SELECT * FROM v_person_address_d;

-- SELECT * FROM v_person_address;	


DROP VIEW IF EXISTS v_person_email_a CASCADE;

CREATE OR REPLACE VIEW v_person_email_a AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		lower(trim(pp.mail))::varchar AS email, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	WHERE 	char_length(trim(pp.mail)) > 0
	 	AND pp.mail IS NOT NULL
	 	AND trim(mail) <> 'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'		
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);

DROP VIEW IF EXISTS v_person_email_b CASCADE;

CREATE OR REPLACE VIEW v_person_email_b AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		lower(trim(pp.mail))::varchar AS email, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	WHERE 	char_length(trim(pp.mail)) > 0
	 	AND pp.mail IS NOT NULL;
	 	

DROP VIEW IF EXISTS v_person_email CASCADE;

CREATE OR REPLACE VIEW v_person_email AS 

	SELECT * FROM v_person_email_a
	UNION ALL
	SELECT * FROM v_person_email_b;

-- SELECT * FROM v_person_email;	

DROP VIEW IF EXISTS v_person_phone_a CASCADE;

CREATE OR REPLACE VIEW v_person_phone_a AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar 
			--WHEN c.iso_alfa3 IS NOT NULL THEN TRIM(c.iso_alfa3)::varchar 
			ELSE TRIM(c.iso_alfa3)::varchar 
		END AS country_code, 		
			
		trim(pp.phone)::varchar AS phone_number, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country ac
	--	ON ac.id = a.country_id		
	LEFT JOIN country c
		ON c.id = pp.country_id
	
	WHERE 	char_length(trim(pp.phone)) > 0
	 	AND pp.phone IS NOT NULL
	 	AND trim(mail) <> 'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);

-- SELECT * FROM v_person_phone_a;	 	

DROP VIEW IF EXISTS v_person_phone_b CASCADE;

CREATE OR REPLACE VIEW v_person_phone_b AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		'ARG'::varchar AS country_code,
		trim(pp.phone_in_cordoba)::varchar AS phone_number, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	
	WHERE 	char_length(trim(pp.phone_in_cordoba)) > 0
	 	AND pp.phone_in_cordoba IS NOT NULL
	 	AND trim(mail) <> 'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND (
			SELECT 	count(a.*) 
			FROM 	v_person_phone_a a 
			WHERE 	a.person_id = trim(pp.id)::varchar 
				AND a.phone_number ILIKE trim(pp.phone_in_cordoba)::varchar
		    ) = 0		
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);    

-- SELECT * FROM v_person_phone_b;	

DROP VIEW IF EXISTS v_person_phone_c CASCADE;

CREATE OR REPLACE VIEW v_person_phone_c AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar 
			--WHEN c.iso_alfa3 IS NOT NULL THEN TRIM(c.iso_alfa3)::varchar 
			ELSE TRIM(c.iso_alfa3)::varchar 
		END AS country_code, 		
			
		trim(pp.cell_phone)::varchar AS phone_number, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country ac
	--	ON ac.id = a.country_id		
	LEFT JOIN country c
		ON c.id = pp.country_id
	
	WHERE 	char_length(trim(pp.cell_phone)) > 0
	 	AND pp.phone IS NOT NULL
	 	AND trim(mail) <> 'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND (
			SELECT 	count(a.*) 
			FROM 	v_person_phone_a a 
			WHERE 	a.person_id = trim(pp.id)::varchar 
				AND a.phone_number ILIKE trim(pp.cell_phone)::varchar
		    ) = 0
		AND (
			SELECT 	count(b.*) 
			FROM 	v_person_phone_b b 
			WHERE 	b.person_id = trim(pp.id)::varchar 
				AND b.phone_number ILIKE trim(pp.cell_phone)::varchar
		    ) = 0
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);

-- SELECT * FROM v_person_phone_c;


DROP VIEW IF EXISTS v_person_phone_d CASCADE;

CREATE OR REPLACE VIEW v_person_phone_d AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar 
			--WHEN c.iso_alfa3 IS NOT NULL THEN TRIM(c.iso_alfa3)::varchar 
			ELSE TRIM(c.iso_alfa3)::varchar 
		END AS country_code, 		
			
		trim(pp.phone)::varchar AS phone_number, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country ac
	--	ON ac.id = a.country_id		
	LEFT JOIN country c
		ON c.id = pp.country_id
	
	WHERE 	char_length(trim(pp.phone)) > 0
	 	AND pp.phone IS NOT NULL;
	 	

-- SELECT * FROM v_person_phone_d;	 


DROP VIEW IF EXISTS v_person_phone_e CASCADE;

CREATE OR REPLACE VIEW v_person_phone_e AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 

		CASE 	WHEN bc.iso_alfa3 IS NOT NULL THEN TRIM(bc.iso_alfa3)::varchar 
			--WHEN c.iso_alfa3 IS NOT NULL THEN TRIM(c.iso_alfa3)::varchar 
			ELSE TRIM(c.iso_alfa3)::varchar 
		END AS country_code, 		
			
		trim(pp.cell_phone)::varchar AS phone_number, 
		null::varchar AS comment, 
		trim(pp.id)::varchar AS person_id
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id
	--LEFT JOIN address a
	--	ON a.id = pp.address_id
	--LEFT JOIN country ac
	--	ON ac.id = a.country_id		
	LEFT JOIN country c
		ON c.id = pp.country_id
	
	WHERE 	char_length(trim(pp.cell_phone)) > 0
	 	AND pp.phone IS NOT NULL
	 	AND (
			SELECT 	count(d.*) 
			FROM 	v_person_phone_d d 
			WHERE 	d.person_id = trim(pp.id)::varchar 
				AND d.phone_number ILIKE trim(pp.cell_phone)::varchar
		    ) = 0;

-- SELECT * FROM v_person_phone_d;	


DROP VIEW IF EXISTS v_person_phone CASCADE;

CREATE OR REPLACE VIEW v_person_phone AS 

	SELECT * FROM v_person_phone_a
	UNION ALL
	SELECT * FROM v_person_phone_b
	UNION ALL
	SELECT * FROM v_person_phone_c
	UNION ALL
	SELECT * FROM v_person_phone_d
	UNION ALL
	SELECT * FROM v_person_phone_e;

-- SELECT * FROM v_person_phone; 	

DROP VIEW IF EXISTS v_person_nationality CASCADE;

CREATE OR REPLACE VIEW v_person_nationality AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		p.erased, 
		p.birth_country_code AS country_code, 		
		null::varchar AS comment, 
		trim(p.id)::varchar AS person_id
	FROM 	v_person p
	WHERE 	p.birth_country_code IS NOT NULL;

-- SELECT * FROM v_person_nationality;

-------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_identity_a CASCADE;

CREATE OR REPLACE VIEW v_person_identity_a AS 

	SELECT 	null::VARCHAR AS id,
		--uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(pp.identification_number)::varchar identity_number, 
		CASE 	WHEN trim(itp.name) = 'Pasaporte' THEN 'PASS'::VARCHAR 
			WHEN trim(itp.name) = 'ID MErcosur' THEN 'IDM'::VARCHAR
			ELSE trim(itp.name)::VARCHAR
		END AS code, 
		CASE 	WHEN trim(itp.name) = 'DNI' THEN 'Documento Nacional de Identidad'::VARCHAR 			
			WHEN char_length(trim(itp.name)) = 0 OR itp.name IS NULL THEN 'Otro'::VARCHAR 			
			ELSE trim(itp.name)::VARCHAR
		END AS name, 
		trim(bc.iso_alfa3)::varchar AS country_code, 
		null::varchar AS comment, 
		trim(pp.id) AS person_id, 
		null::varchar AS person_identity_type_id		
	FROM 	physical_person pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN identification_type_person itp
		ON itp.id = pp.identification_type_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id		
	WHERE 	char_length(trim(pp.identification_number)) > 0
	 	AND pp.identification_number IS NOT NULL
	 	AND trim(mail) <> 'diegopablomansilla@gmail.com'
		AND trim(mail) <> 'dmansilla@psi.unc.edu.ar'
		AND pp.id IN (SELECT physical_person_id::varchar FROM v_postulation_ok_tmp);
		

-- SELECT * FROM v_person_identity_a;
-- SELECT * FROM v_person_identity_a WHERE name IS NULL;

DROP VIEW IF EXISTS v_person_identity_b CASCADE;

CREATE OR REPLACE VIEW v_person_identity_b AS 

	SELECT 	null::VARCHAR AS id,
		--uuid_generate_v4()::varchar AS id, 
		CASE WHEN pp.state_enable = false THEN true ELSE false END AS erased, 
		trim(pp.identification_number)::varchar identity_number, 
		CASE 	WHEN trim(itp.name) = 'Pasaporte' THEN 'PASS'::VARCHAR 
			WHEN trim(itp.name) = 'ID MErcosur' THEN 'IDM'::VARCHAR
			ELSE trim(itp.name)::VARCHAR
		END AS code, 
		CASE 	WHEN trim(itp.name) = 'DNI' THEN 'Documento Nacional de Identidad'::VARCHAR 			
			WHEN char_length(trim(itp.name)) = 0 OR itp.name IS NULL THEN 'Otro'::VARCHAR 			
			ELSE trim(itp.name)::VARCHAR
		END AS name, 
		trim(bc.iso_alfa3)::varchar AS country_code, 
		null::varchar AS comment, 
		trim(pp.id) AS person_id, 
		null::varchar AS person_identity_type_id		
	FROM 	physical_person_in_eri_out pp
	--JOIN	postulation p
	--	ON pp.id = p.physical_person_id
	LEFT JOIN identification_type_person itp
		ON itp.id = pp.identification_type_person_id
	LEFT JOIN address ba
		ON ba.id = pp.birth_address_id
	LEFT JOIN country bc
		ON bc.id = ba.country_id		
	WHERE 	char_length(trim(pp.identification_number)) > 0
	 	AND pp.identification_number IS NOT NULL;

-- SELECT * FROM v_person_identity_b;
-- SELECT * FROM v_person_identity_b WHERE name IS NULL;


DROP VIEW IF EXISTS v_person_identity_c CASCADE;

CREATE OR REPLACE VIEW v_person_identity_c AS 

	SELECT * FROM v_person_identity_a
	UNION ALL
	SELECT * FROM v_person_identity_b;

-- SELECT * FROM v_person_identity_c;

DROP VIEW IF EXISTS v_person_identity_d CASCADE;

CREATE OR REPLACE VIEW v_person_identity_d AS 

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
	FROM	v_person_identity_c pi
	ORDER BY pi.code;
	
-- SELECT * FROM v_person_identity_d;

DROP VIEW IF EXISTS v_person_identity CASCADE;

CREATE OR REPLACE VIEW v_person_identity AS 

	SELECT 	pi.id, 
		pi.erased, 
		pi.identity_number, 
		pi.code, 

		CASE 	WHEN trim(pit.id) IS NULL THEN pi.name::VARCHAR ELSE pit.name END AS name,
		
		pi.country_code, 
		pi.comment, 
		pi.person_id, 
		pit.id AS person_identity_type_id
	FROM	v_person_identity_d pi
	LEFT JOIN kuntur.person_identity_type pit
		ON pit.code = pi.code;

	--	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- SELECT DISTINCT code, name, country_code FROM v_person_identity WHERE code <> 'PASS' AND person_identity_type_id IS NULL ORDER BY country_code;	

-- SELECT DISTINCT code, name FROM v_person_identity ORDER BY name, code;

-- SELECT * FROM v_person_identity;
-- SELECT * FROM v_person_identity WHERE name IS NULL;


--========================================================


DROP TABLE IF EXISTS person_tmp CASCADE ;

CREATE TABLE person_tmp
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  given_name character varying NOT NULL,
	  middle_name character varying,
	  family_name character varying NOT NULL,
	  birth_date date,
	  male boolean,
	  url_photo character varying,
	  comment character varying,
	  birth_country_code character varying,
	  birth_admin_area_level1_code character varying,
	  birth_admin_area_level2 character varying,
	  birth_locality character varying,
	  birth_lat double precision,
	  birth_lng double precision 
);

INSERT INTO person_tmp (SELECT * FROM v_person);

UPDATE person_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE person_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
UPDATE person_tmp SET given_name = null WHERE char_length(trim(given_name)) = 0;
UPDATE person_tmp SET middle_name = null WHERE char_length(trim(middle_name)) = 0;
UPDATE person_tmp SET family_name = null WHERE char_length(trim(family_name)) = 0;
--UPDATE person_tmp SET birth_date  = null WHERE char_length(trim(birth_date)) = 0;
--UPDATE person_tmp SET male = null WHERE char_length(trim(male)) = 0;
UPDATE person_tmp SET url_photo = null WHERE char_length(trim(url_photo)) = 0;
UPDATE person_tmp SET comment = null WHERE char_length(trim(comment)) = 0;
UPDATE person_tmp SET birth_country_code = null WHERE char_length(trim(birth_country_code)) = 0;
UPDATE person_tmp SET birth_admin_area_level1_code = null WHERE char_length(trim(birth_admin_area_level1_code)) = 0;
UPDATE person_tmp SET birth_admin_area_level2 = null WHERE char_length(trim(birth_admin_area_level2)) = 0;
UPDATE person_tmp SET birth_locality = null WHERE char_length(trim(birth_locality)) = 0;
--UPDATE person_tmp SET birth_lat = null WHERE char_length(trim(birth_lat)) = 0;
--UPDATE person_tmp SET birth_lng = null WHERE char_length(trim(birth_lng)) = 0;


-- SELECT * FROM person_tmp;

-- Table: kuntur.person_address

DROP TABLE IF EXISTS person_address_tmp;

CREATE TABLE person_address_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  country_code character varying,
	  admin_area_level1_code character varying,
	  admin_area_level2 character varying,
	  locality character varying,
	  neighbourhood character varying,
	  street character varying,
	  street_number character varying,
	  building_floor character varying,
	  building_room character varying,
	  building character varying,
	  postal_code character varying,
	  comment character varying,
	  lat double precision,
	  lng double precision,
	  person_id character varying NOT NULL  
);

INSERT INTO person_address_tmp (SELECT DISTINCT * FROM v_person_address);

--SELECT DISTINCT * FROM v_person_address WHERE id = 'ff808082385897cc0138719d86680026'
--SELECT * FROM address WHERE id = 'ff808082385897cc0138719d86680026'


UPDATE person_address_tmp SET id  =  null WHERE char_length(trim(id)) = 0;
--UPDATE person_address_tmp SET erased  =  null WHERE char_length(trim(erased)) = 0;
UPDATE person_address_tmp SET country_code  =  null WHERE char_length(trim(country_code)) = 0;
UPDATE person_address_tmp SET admin_area_level1_code  =  null WHERE char_length(trim(admin_area_level1_code)) = 0;
UPDATE person_address_tmp SET admin_area_level2  =  null WHERE char_length(trim(admin_area_level2)) = 0;
UPDATE person_address_tmp SET locality  =  null WHERE char_length(trim(locality)) = 0;
UPDATE person_address_tmp SET neighbourhood  =  null WHERE char_length(trim(neighbourhood)) = 0;
UPDATE person_address_tmp SET street  =  null WHERE char_length(trim(street)) = 0;
UPDATE person_address_tmp SET street_number  =  null WHERE char_length(trim(street_number)) = 0;
UPDATE person_address_tmp SET building_floor  =  null WHERE char_length(trim(building_floor)) = 0;
UPDATE person_address_tmp SET building_room  =  null WHERE char_length(trim(building_room)) = 0;
UPDATE person_address_tmp SET building  =  null WHERE char_length(trim(building)) = 0;
UPDATE person_address_tmp SET postal_code  =  null WHERE char_length(trim(postal_code)) = 0;
UPDATE person_address_tmp SET comment  =  null WHERE char_length(trim(comment)) = 0;
--UPDATE person_address_tmp SET lat  =  null WHERE char_length(trim(lat)) = 0;
--UPDATE person_address_tmp SET lng  =  null WHERE char_length(trim(lng)) = 0;
UPDATE person_address_tmp SET person_id =  null WHERE char_length(trim(id)) = 0;

-- Table: kuntur.person_email

DROP TABLE IF EXISTS person_email_tmp;

CREATE TABLE person_email_tmp
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  email character varying NOT NULL,
	  comment character varying,
	  person_id character varying NOT NULL  
);

INSERT INTO person_email_tmp (SELECT DISTINCT * FROM v_person_email);

UPDATE person_email_tmp SET id = null WHERE char_length(trim(id)) = 0; 
--UPDATE person_email_tmp SET erased = null WHERE char_length(trim(erased)) = 0; 
UPDATE person_email_tmp SET email = null WHERE char_length(trim(email)) = 0; 
UPDATE person_email_tmp SET comment = null WHERE char_length(trim(comment)) = 0; 
UPDATE person_email_tmp SET person_id = null WHERE char_length(trim(person_id)) = 0;

-- SELECT * FROM person_email_tmp;

DROP TABLE IF EXISTS person_phone_tmp;

CREATE TABLE person_phone_tmp
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  country_code character varying ,
	  phone_number character varying NOT NULL,
	  comment character varying,
	  person_id character varying NOT NULL  
);


INSERT INTO person_phone_tmp (SELECT DISTINCT * FROM v_person_phone);

UPDATE person_phone_tmp SET id = null WHERE char_length(trim(id)) = 0; 
--UPDATE person_phone_tmp SET erased = null WHERE char_length(trim(erased)) = 0; 
UPDATE person_phone_tmp SET country_code = null WHERE char_length(trim(country_code)) = 0; 
UPDATE person_phone_tmp SET phone_number = null WHERE char_length(trim(phone_number)) = 0; 
UPDATE person_phone_tmp SET comment = null WHERE char_length(trim(comment)) = 0; 
UPDATE person_phone_tmp SET person_id = null WHERE char_length(trim(person_id)) = 0;


-- SELECT * FROM person_phone_tmp;
/*
SELECT 	* 
FROM 	person_phone_tmp pp
WHERE 	( 
		SELECT  count(x.*) 
		FROM 	person_phone_tmp x 
		WHERE 	x.person_id = pp.person_id 
			AND x.phone_number = pp.phone_number 
			AND x.country_code <> pp.country_code
	) > 0
ORDER BY pp.person_id, pp.phone_number;
*/


-- SELECT person_id, phone_number, country_code FROM person_phone_tmp GROUP BY person_id, phone_number, country_code HAVING count(*) > 1;
-- SELECT person_id, phone_number FROM person_phone_tmp GROUP BY person_id, phone_number, country_code HAVING count(*) > 1;


DROP TABLE IF EXISTS person_nationality_tmp CASCADE;

CREATE TABLE person_nationality_tmp
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  country_code character varying NOT NULL,
	  comment character varying,
	  person_id character varying NOT NULL
);

INSERT INTO person_nationality_tmp (SELECT * FROM v_person_nationality);

UPDATE person_nationality_tmp SET id = null WHERE char_length(trim(id)) = 0; 
--UPDATE person_nationality_tmp SET erased = null WHERE char_length(trim(erased)) = 0; 
UPDATE person_nationality_tmp SET country_code = null WHERE char_length(trim(country_code)) = 0; 
UPDATE person_nationality_tmp SET comment = null WHERE char_length(trim(comment)) = 0; 
UPDATE person_nationality_tmp SET person_id = null WHERE char_length(trim(person_id)) = 0;

-- SELECT * FROM person_nationality_tmp;

DROP TABLE IF EXISTS person_identity_tmp CASCADE;

CREATE TABLE person_identity_tmp
(
	  id character varying,
	  erased boolean NOT NULL,
	  identity_number character varying NOT NULL,
	  code character varying NOT NULL,
	  name character varying NOT NULL,
	  country_code character varying ,
	  comment character varying,
	  person_id character varying NOT NULL,
	  person_identity_type_id character varying 
 
);

-- SELECT * FROM v_person_identity WHERE name IS NULL

-- SELECT * FROM v_person_identity;
-- SELECT DISTINCT * FROM v_person_identity;

INSERT INTO person_identity_tmp (SELECT DISTINCT * FROM v_person_identity);

UPDATE person_identity_tmp SET id = null WHERE char_length(trim(id)) = 0; 
--UPDATE person_identity_tmp SET erased = null WHERE char_length(trim(erased)) = 0; 
UPDATE person_identity_tmp SET identity_number = null WHERE char_length(trim(identity_number)) = 0; 
UPDATE person_identity_tmp SET code = null WHERE char_length(trim(code)) = 0; 
UPDATE person_identity_tmp SET name = null WHERE char_length(trim(name)) = 0; 
UPDATE person_identity_tmp SET country_code = null WHERE char_length(trim(country_code)) = 0; 
UPDATE person_identity_tmp SET comment = null WHERE char_length(trim(comment)) = 0; 
UPDATE person_identity_tmp SET person_id = null WHERE char_length(trim(person_id)) = 0;
UPDATE person_identity_tmp SET person_identity_type_id = null WHERE char_length(trim(person_identity_type_id)) = 0;

-- SELECT * FROM person_identity_tmp ORDER BY identity_number, person_id, country_code;

DELETE FROM person_identity_tmp WHERE identity_number = '----------';
DELETE FROM person_identity_tmp WHERE identity_number = '...';
DELETE FROM person_identity_tmp WHERE identity_number = '**';
DELETE FROM person_identity_tmp WHERE identity_number = '0';

UPDATE person_identity_tmp SET id = uuid_generate_v4()::varchar;

-- SELECT * FROM person_identity_tmp ORDER BY identity_number, person_id, country_code;

/*
SELECT 	* 
FROM 	person_identity_tmp i
WHERE 	( 
		SELECT  count(x.*) 
		FROM 	person_identity_tmp x 
		WHERE 	x.person_id = i.person_id 
			AND x.identity_number = i.identity_number 
			AND x.name <> i.name
	) > 0

*/


-- SELECT person_id, identity_number  FROM person_identity_tmp GROUP BY person_id, identity_number HAVING count(*) > 1;
-- SELECT country_code, identity_number, count(*)  FROM person_identity_tmp GROUP BY country_code, identity_number HAVING count(*) > 1;
/*
SELECT 	* 
FROM 	person_identity_tmp t 
WHERE 	t.identity_number::varchar IN (SELECT identity_number FROM person_identity_tmp GROUP BY country_code, identity_number HAVING count(*) > 1)
ORDER BY t.identity_number, person_id, country_code
*/


-- ==============================================================================



INSERT INTO kuntur.person (SELECT * FROM person_tmp);

-- SELECT * FROM kuntur.person;

INSERT INTO kuntur.person_address (SELECT * FROM person_address_tmp);

-- SELECT * FROM kuntur.person_address;

INSERT INTO kuntur.person_email (SELECT * FROM person_email_tmp);

-- SELECT * FROM kuntur.person_email;

INSERT INTO kuntur.person_phone (SELECT * FROM person_phone_tmp ORDER BY person_id, country_code);

-- SELECT * FROM kuntur.person_phone;

INSERT INTO kuntur.person_nationality (SELECT * FROM person_nationality_tmp);

-- SELECT * FROM kuntur.person_nationality;

INSERT INTO kuntur.person_identity (SELECT * FROM person_identity_tmp);

-- SELECT * FROM kuntur.person_identity;




-- ========================================================================

DROP VIEW IF EXISTS v_user_system CASCADE;

CREATE OR REPLACE VIEW v_user_system AS 

	SELECT	p.id AS id,
		p.erased, 
		lower(trim(pp.mail))::varchar AS name,
		'1234'::varchar AS pass,
		lower(trim(pp.mail))::varchar AS email,
		p.family_name || ' ' || p.given_name::varchar AS comment	
	FROM	physical_person pp
	JOIN	kuntur.person p	
		ON pp.id = p.id
	WHERE 	pp.mail IS NOT NULL 
		AND char_length(trim(pp.mail)) > 0;

-- SELECT * FROM v_user_system ORDER BY comment, email;
-- SELECT DISTINCT * FROM v_user_system ORDER BY comment, email;
-- SELECT * FROM v_user_system WHERE name IS NULL;

/*
SELECT 	* 
FROM 	v_postulation_ok_tmp o
WHERE	o.mail IN (SELECT name FROM v_user_system u GROUP BY name HAVING count(*) > 1);
*/

DROP TABLE IF EXISTS user_system_tmp CASCADE;

CREATE TABLE user_system_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  name character varying NOT NULL UNIQUE,
	  pass character varying NOT NULL,
	  email character varying NOT NULL UNIQUE,
	  comment character varying
);

INSERT INTO user_system_tmp (SELECT * FROM v_user_system ORDER BY comment, email);

UPDATE user_system_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE user_system_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
UPDATE user_system_tmp SET name = null WHERE char_length(trim(name)) = 0;
UPDATE user_system_tmp SET pass = null WHERE char_length(trim(pass)) = 0;
UPDATE user_system_tmp SET email = null WHERE char_length(trim(email)) = 0;
UPDATE user_system_tmp SET comment = null WHERE char_length(trim(comment)) = 0;

-- SELECT * FROM user_system_tmp WHERE name = 'international@uni.leuphana.de'

/*
SELECT * 
FROM physical_person pp 
join postulation p 
	on pp.id = p.physical_person_id
--WHERE pp.mail = 'international@uni.leuphana.de'
--WHERE pp.mail = 'silvia.spaggiari@ucaldas.edu.co'
--WHERE pp.mail = 'info-service@fu-berlin.de'
WHERE pp.mail = 'luisfort24@gmail.com'
*/


INSERT INTO kuntur.user_system (SELECT DISTINCT * FROM user_system_tmp);


DROP VIEW IF EXISTS v_act_id_user_a CASCADE;

CREATE OR REPLACE VIEW v_act_id_user_a AS

	SELECT 	lower(trim(u.id_))::varchar AS id,
		trim(u.email_)::varchar AS email,
		initcap(lower(trim(u.last_)))::varchar AS last,
		initcap(lower(trim(u.first_)))::varchar AS first,
		trim(u.pwd_)::varchar AS pwd
	FROM 	act_id_user u;

-- SELECT DISTINCT * FROM v_act_id_user_a ORDER BY last, first, id, email

-- SELECT id, count(*) FROM v_act_id_user_a GROUP BY id HAVING count(*) > 1;

/*
SELECT 	*,
	(SELECT count(*) FROM v_act_id_user_a a WHERE a.id = trim(lower(k.email))::varchar)
FROM 	kuntur.user_system k 
WHERE 	(SELECT count(*) FROM v_act_id_user_a a WHERE a.id = trim(lower(k.email))::varchar) > 1
*/	

UPDATE kuntur.user_system k 
	SET pass = (SELECT a.pwd FROM v_act_id_user_a a WHERE a.id = trim(lower(k.email))::varchar LIMIT 1)
	WHERE (SELECT a.pwd FROM v_act_id_user_a a WHERE a.id = trim(lower(k.email))::varchar LIMIT 1)::varchar IS NOT NULL;

UPDATE kuntur.user_system k 
	SET pass = (SELECT a.pwd FROM v_act_id_user_a a WHERE a.email = trim(lower(k.email))::varchar LIMIT 1)
	WHERE (SELECT a.pwd FROM v_act_id_user_a a WHERE a.email = trim(lower(k.email))::varchar LIMIT 1)::varchar IS NOT NULL
		AND k.pass = '1234';	

-- SELECT  * FROM kuntur.user_system WHERE pass = '1234'

-- SELECT * FROM kuntur.user_system;

-- =================================================================================


DROP VIEW IF EXISTS v_org_u CASCADE;

CREATE OR REPLACE VIEW v_org_u AS

		SELECT	i.id::varchar AS id,
			--replace(trim(i.name), '-', '')::varchar AS id, 
			true::boolean AS erased,
			null::varchar AS short_name, 
			trim(i.name)::varchar AS name, 
			trim(i.name)::varchar AS original_name, 
			null::varchar AS photo_url, 
			trim(i.id)::varchar AS web_site, 
			null::varchar AS comment, 
			(SELECT iso_alfa3 FROM country x WHERE x.id = i.country_id)::varchar AS country_code, 
			false::boolean AS primary_org, 
			null::integer AS code_ona,
			null::varchar AS code_guarani,
			(SELECT id FROM kuntur.org_type x WHERE x.code = 'U')::varchar AS org_type_id, 
			null::varchar AS org_id
			--'xxxxxx',
			--i.* 
		FROM 	institution_in_eri_out i
		--LEFT JOIN	institution_in_eri_out_physical_person_in_eri_out_list ipl
		--	ON i.id = ipl.institution_in_eri_out_id
		--LEFT JOIN	physical_person_in_eri_out pp		
		--	ON pp.id = ipl.physical_person_in_eri_out_id	
		ORDER BY 	i.country_id, 
				i.name;
				--ipl.order_number;	

-- SELECT DISTINCT * FROM v_org_u ORDER BY name;

DROP VIEW IF EXISTS v_org_u_b CASCADE;

CREATE OR REPLACE VIEW v_org_u_b AS

		SELECT	i.id::varchar AS id,
			--replace(trim(i.name), '-', '')::varchar AS id, 
			true::boolean AS erased,
			null::varchar AS short_name, 
			trim(i.name)::varchar AS name, 
			trim(i.name)::varchar AS original_name, 
			null::varchar AS photo_url, 
			trim(i.id)::varchar AS web_site, 
			null::varchar AS comment, 
			(SELECT iso_alfa3 FROM country x WHERE x.id = i.country_id)::varchar AS country_code, 
			false::boolean AS primary_org, 
			null::integer AS code_ona,
			null::varchar AS code_guarani,
			(SELECT id FROM kuntur.org_type x WHERE x.code = 'U')::varchar AS org_type_id, 
			null::varchar AS org_id
			--'xxxxxx',
			--i.* 
		FROM 	institution i
		--LEFT JOIN	institution_physical_person_list ipl
		--	ON i.id = ipl.institution_id
		--LEFT JOIN	physical_person pp		
		--	ON pp.id = ipl.physical_person_id	
		ORDER BY 	i.country_id, 
				i.name;
				--ipl.order_number;

-- SELECT DISTINCT * FROM v_org_u_b ORDER BY name;

DROP VIEW IF EXISTS v_org_u_c CASCADE;

CREATE OR REPLACE VIEW v_org_u_c AS

	SELECT DISTINCT * FROM v_org_u
	UNION ALL
	SELECT DISTINCT * FROM v_org_u_b;

-- SELECT DISTINCT * FROM v_org_u_c ORDER BY country_code, name;	



INSERT INTO kuntur.org (SELECT DISTINCT * FROM v_org_u_c ORDER BY name);			

-- SELECT * FROM kuntur.org WHERE erased = true AND org_type_id = (SELECT id FROM kuntur.org_type x WHERE x.code = 'U');


----------------------------------------------------------------------------------------------


-- =================================================================================

DROP VIEW IF EXISTS v_student CASCADE;

CREATE OR REPLACE VIEW v_student AS 

	SELECT 	physical_person_id AS id,
		false::boolean AS erased, 
		null::bigint AS file_number, 

		CASE WHEN institution_name IS NULL THEN 'Sin especificar'::varchar ELSE institution_name END AS institution_original_name,		
		 
		'Sin especificar'::varchar AS institution_web_site, 
		CASE WHEN institution_country_code IS NULL THEN 'Sin especificar'::varchar ELSE institution_country_code END  AS institution_country_code, 
		
		(SELECT x.id FROM kuntur.org x WHERE x.original_name = institution_name LIMIT 1)::varchar AS org_id
	FROM	v_postulation_ok_tmp_c;	

/*

SELECT 	* 
FROM 	v_postulation_ok_tmp_c o
WHERE	o.physical_person_id IN (SELECT id FROM v_student GROUP BY id having count(*) > 1)
ORDER BY last_name, name, mail;

SELECT 	* 
FROM 	v_postulation_ok_tmp o
WHERE	o.physical_person_id IN (SELECT id FROM v_student GROUP BY id having count(*) > 1)
ORDER BY last_name, name, mail;


SELECT count(*), id FROM v_student GROUP BY id having count(*) > 1;

*/

DROP TABLE IF EXISTS student_tmp CASCADE;

CREATE TABLE student_tmp
(
	  id character varying NOT NULL unique,
	  erased boolean NOT NULL,
	  file_number bigint,
	  institution_original_name character varying NOT NULL,
	  institution_web_site character varying NOT NULL,
	  institution_country_code character varying,
	  org_id character varying 
);

INSERT INTO student_tmp (SELECT DISTINCT * FROM v_student);


UPDATE student_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE student_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
--UPDATE student_tmp SET file_number = null WHERE char_length(trim(file_number)) = 0;
UPDATE student_tmp SET institution_original_name = null WHERE char_length(trim(institution_original_name)) = 0;
UPDATE student_tmp SET institution_web_site = null WHERE char_length(trim(institution_web_site)) = 0;
UPDATE student_tmp SET institution_country_code = null WHERE char_length(trim(institution_country_code)) = 0;
UPDATE student_tmp SET org_id = null WHERE char_length(trim(org_id)) = 0;


-- SELECT * FROM student_tmp;

INSERT INTO kuntur.student (SELECT * FROM student_tmp);

-- SELECT * FROM kuntur.student;

--==================================================================================================================

--SELECT * FROM 	period_admission pa ORDER BY pa.year_academic ;

DROP VIEW IF EXISTS v_admission_period_a CASCADE;

CREATE OR REPLACE VIEW v_admission_period_a AS 

	SELECT 	pa.id, 
		false::boolean AS erased,
		null::bigint AS number_admission_period,
		true::boolean AS in_type,		
		pa.year_academic AS year, 
		CASE WHEN pa.semester1 = true THEN 1 ELSE 2 END AS semester,	
		null::varchar AS title,
		pa.start_period AS from_date,
		pa.end_period AS to_date,
		null::varchar AS comment,

		CASE WHEN pa.end_period IS NOT NULL AND pa.end_period <= now()::date THEN 'C' ELSE 'A' END AS admission_period_status_id
		
		--null::varchar AS admission_period_status_id
	FROM 	period_admission pa 
	JOIN 	postulation p 
		ON pa.id = p.period_admission_id 
	ORDER BY pa.year_academic;

-- SELECT DISTINCT * FROM v_admission_period ORDER BY year, semester;

DROP VIEW IF EXISTS v_admission_period_b CASCADE;

CREATE OR REPLACE VIEW v_admission_period_b AS 

	SELECT DISTINCT * FROM v_admission_period_a ORDER BY year, semester;

-- SELECT * FROM v_admission_period_b;

DROP VIEW IF EXISTS v_admission_period CASCADE;

CREATE OR REPLACE VIEW v_admission_period AS 

	SELECT 	ap.id,
		ap.erased,
		ap.number_admission_period,
		ap.in_type,
		ap.year,
		ap.semester,
		
		CASE WHEN ap.in_type = true THEN year || '-IN-' || ap.semester ELSE year || '-OUT-' || ap.semester END AS title,

		ap.from_date,
		ap.to_date,
		ap.comment,
		s.id AS admission_period_status_id
	FROM 	v_admission_period_b ap
	JOIN	kuntur.admission_period_status s
		ON s.code = ap.admission_period_status_id;

SELECT * FROM v_admission_period;

DROP TABLE IF EXISTS admission_period_tmp;

CREATE TABLE admission_period_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  number_admission_period bigint,
	  in_type boolean NOT NULL,
	  year integer NOT NULL,
	  semester integer NOT NULL,
	  title character varying NOT NULL,
	  from_date date NOT NULL,
	  to_date date NOT NULL,
	  comment character varying,
	  admission_period_status_id character varying
);

INSERT INTO admission_period_tmp (SELECT DISTINCT * FROM v_admission_period);

UPDATE admission_period_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE admission_period_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
UPDATE admission_period_tmp SET title = null WHERE char_length(trim(title)) = 0;
UPDATE admission_period_tmp SET comment = null WHERE char_length(trim(comment)) = 0;
UPDATE admission_period_tmp SET admission_period_status_id = null WHERE char_length(trim(admission_period_status_id)) = 0;

INSERT INTO kuntur.admission_period (SELECT * FROM admission_period_tmp);

-- SELECT * FROM kuntur.admission_period;	
	
--==================================================================================================================


DROP VIEW IF EXISTS v_enrrollment CASCADE;

CREATE OR REPLACE VIEW v_enrrollment AS 

	SELECT 	p.postulation_id AS id,		
		--pp.id, 
		pp.erased, 
		pp.given_name, 
		pp.middle_name, 
		pp.family_name, 
		pp.birth_date, 
		pp.male, 
		pp.url_photo, 
		pp.comment, 
		pp.birth_country_code, 
		pp.birth_admin_area_level1_code, 
		pp.birth_admin_area_level2, 
		pp.birth_locality, 
		pp.birth_lat, 
		pp.birth_lng,		
		--s.erased, 
		--s.file_number, 
		s.institution_original_name, 
		s.institution_web_site, 
		s.institution_country_code, 
		null::bigint AS number_enrrollment,
		null::timestamp AS check_out_date,
		s.org_id,
		--u.id AS user_system_id,
		null::varchar AS user_system_id,
		s.id AS student_id,
		pa.id AS admission_period_id,
		trim(p.state_id)::varchar AS enrollment_status_id		
	FROM 	kuntur.person pp
	JOIN	kuntur.student s
		ON pp.id = s.id
	--JOIN	kuntur.user_system u
	--	ON pp.id = u.id
	JOIN	v_postulation_ok_tmp p
		ON p.physical_person_id = pp.id	
	JOIN	kuntur.admission_period pa
		ON pa.year = p.year_academic
		AND pa.semester = p.semester
		AND p.start_period = pa.from_date
		AND p.end_period = pa.to_date;

-- SELECT * FROM v_enrrollment;

DROP TABLE IF EXISTS enrrollment_tmp CASCADE;

CREATE TABLE enrrollment_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  given_name character varying NOT NULL,
	  middle_name character varying,
	  family_name character varying NOT NULL,
	  birth_date date NOT NULL,
	  male boolean,
	  url_photo character varying,
	  comment character varying,
	  birth_country_code character varying,
	  birth_admin_area_level1_code character varying,
	  birth_admin_area_level2 character varying,
	  birth_locality character varying,
	  birth_lat double precision,
	  birth_lng double precision,
	  institution_original_name character varying NOT NULL,
	  institution_web_site character varying NOT NULL,
	  institution_country_code character varying NOT NULL,
	  number_enrrollment bigint ,
	  check_out_date timestamp without time zone,
	  org_id character varying,
	  user_system_id character varying,
	  student_id character varying NOT NULL,
	  admission_period_id character varying NOT NULL,
	  enrrollment_status_id character varying NOT NULL
);

-- SELECT * FROM v_enrrollment;
-- SELECT DISTINCT * FROM v_enrrollment;


INSERT INTO enrrollment_tmp (SELECT DISTINCT * FROM v_enrrollment);



UPDATE enrrollment_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE enrrollment_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
UPDATE enrrollment_tmp SET given_name = null WHERE char_length(trim(given_name)) = 0;
UPDATE enrrollment_tmp SET middle_name = null WHERE char_length(trim(middle_name)) = 0;
UPDATE enrrollment_tmp SET family_name = null WHERE char_length(trim(family_name)) = 0;
UPDATE enrrollment_tmp SET url_photo = null WHERE char_length(trim(url_photo)) = 0;
UPDATE enrrollment_tmp SET comment = null WHERE char_length(trim(comment)) = 0;
UPDATE enrrollment_tmp SET birth_country_code = null WHERE char_length(trim(birth_country_code)) = 0;
UPDATE enrrollment_tmp SET birth_admin_area_level1_code = null WHERE char_length(trim(id)) = 0;
UPDATE enrrollment_tmp SET id = null WHERE char_length(trim(birth_admin_area_level1_code)) = 0;
UPDATE enrrollment_tmp SET birth_admin_area_level2 = null WHERE char_length(trim(birth_admin_area_level2)) = 0;
UPDATE enrrollment_tmp SET birth_locality = null WHERE char_length(trim(birth_locality)) = 0;
UPDATE enrrollment_tmp SET institution_original_name = null WHERE char_length(trim(institution_original_name)) = 0;
UPDATE enrrollment_tmp SET institution_web_site = null WHERE char_length(trim(institution_web_site)) = 0;
UPDATE enrrollment_tmp SET institution_country_code = null WHERE char_length(trim(institution_country_code)) = 0;
UPDATE enrrollment_tmp SET org_id = null WHERE char_length(trim(org_id)) = 0;
UPDATE enrrollment_tmp SET user_system_id = null WHERE char_length(trim(user_system_id)) = 0;
UPDATE enrrollment_tmp SET student_id = null WHERE char_length(trim(student_id)) = 0;
UPDATE enrrollment_tmp SET admission_period_id = null WHERE char_length(trim(admission_period_id)) = 0;
UPDATE enrrollment_tmp SET enrrollment_status_id = null WHERE char_length(trim(enrrollment_status_id)) = 0;

UPDATE enrrollment_tmp t SET enrrollment_status_id = (SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = t.enrrollment_status_id);

-- SELECT * FROM enrrollment_tmp;

INSERT INTO kuntur.enrrollment (SELECT * FROM enrrollment_tmp);

--SELECT * FROM kuntur.enrrollment;

DROP VIEW IF EXISTS v_enrrollment_email CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_email AS

	SELECT  uuid_generate_v4()::varchar AS id, 
		pe.erased,
		pe.email,
		pe.comment,
		e.id AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id
	JOIN	kuntur.person p
		ON p.id = s.id
	JOIN	kuntur.person_email pe
		ON p.id = pe.person_id;

-- SELECT * FROM v_enrrollment_email;

INSERT INTO kuntur.enrrollment_email (SELECT * FROM v_enrrollment_email);

-- SELECT * FROM kuntur.enrrollment_email;	


 DROP VIEW IF EXISTS v_enrrollment_phone CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_phone AS

	SELECT  uuid_generate_v4()::varchar AS id, 
		ph.erased,
		
		CASE WHEN ph.country_code IS NULL THEN 'Sin Especificar' ELSE ph.country_code END AS country_code,
	
		--ph.country_code,
		ph.phone_number,
		ph.comment,
		e.id AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id
	JOIN	kuntur.person p
		ON p.id = s.id
	JOIN	kuntur.person_phone ph
		ON p.id = ph.person_id;

-- SELECT * FROM v_enrrollment_phone WHERE country_code IS NULL ORDER BY enrrollment_id, country_code;


-- SELECT * FROM v_enrrollment_phone ORDER BY enrrollment_id, country_code;

INSERT INTO kuntur.enrrollment_phone (SELECT * FROM v_enrrollment_phone ORDER BY enrrollment_id, country_code);

-- SELECT * FROM kuntur.enrrollment_phone;	

DROP VIEW IF EXISTS v_enrrollment_nationality CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_nationality AS

	SELECT  uuid_generate_v4()::varchar AS id, 
		pn.erased,
		
		--CASE WHEN ph.country_code IS NULL THEN 'Sin Especificar' ELSE ph.country_code END AS country_code,
	
		pn.country_code,		
		pn.comment,
		e.id AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id
	JOIN	kuntur.person p
		ON p.id = s.id
	JOIN	kuntur.person_nationality pn
		ON p.id = pn.person_id;

-- SELECT * FROM v_enrrollment_nationality WHERE country_code IS NULL ORDER BY enrrollment_id, country_code;

-- SELECT * FROM v_enrrollment_nationality ORDER BY enrrollment_id, country_code;

INSERT INTO kuntur.enrrollment_nationality (SELECT * FROM v_enrrollment_nationality ORDER BY enrrollment_id, country_code);

-- SELECT * FROM kuntur.enrrollment_nationality;	

DROP VIEW IF EXISTS v_enrrollment_identity CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_identity AS

	SELECT  uuid_generate_v4()::varchar AS id, 
		pi.erased,
		pi.identity_number,
		pi.code,
		pi.name,			
		--pi.country_code, -- 
		CASE WHEN pi.country_code IS NULL THEN 'Sin Especificar' ELSE pi.country_code END AS country_code,		
		pi.comment,
		e.id AS enrrollment_id,
		pi.person_identity_type_id		
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id
	JOIN	kuntur.person p
		ON p.id = s.id
	JOIN	kuntur.person_identity pi
		ON p.id = pi.person_id;

-- SELECT * FROM v_enrrollment_identity WHERE country_code IS NULL ORDER BY enrrollment_id, country_code;


-- SELECT * FROM v_enrrollment_identity ORDER BY enrrollment_id, country_code;

INSERT INTO kuntur.enrrollment_identity (SELECT * FROM v_enrrollment_identity ORDER BY enrrollment_id, country_code);

-- SELECT * FROM kuntur.enrrollment_identity;

DROP VIEW IF EXISTS v_enrrollment_address CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_address AS

	SELECT 	uuid_generate_v4()::varchar AS id, 
		pa.erased, 

		CASE WHEN pa.country_code IS NULL THEN 'Sin Especificar' ELSE pa.country_code END country_code, 
		
		--pa.country_code, 

		CASE WHEN pa.admin_area_level1_code IS NULL THEN 'Sin Especificar' ELSE pa.admin_area_level1_code END admin_area_level1_code, 
		
		--pa.admin_area_level1_code, 
		pa.admin_area_level2, 

		CASE WHEN pa.locality IS NULL THEN 'Sin Especificar' ELSE pa.locality END locality, 
		--pa.locality, 

		
		pa.neighbourhood, 

		CASE WHEN pa.street IS NULL THEN 'Sin Especificar' ELSE pa.street END street, 
		
		--pa.street, 
		pa.street_number, 
		pa.building_floor, 
		pa.building_room, 
		pa.building, 

		CASE WHEN pa.postal_code IS NULL THEN 'Sin Especificar' ELSE pa.postal_code END postal_code, 
		
		--pa.postal_code, 
		pa.comment, 
		pa.lat, 
		pa.lng, 
		e.id AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id
	JOIN	kuntur.person p
		ON p.id = s.id
	JOIN	kuntur.person_address pa
		ON p.id = pa.person_id;	


-- SELECT * FROM v_enrrollment_address WHERE country_code IS NULL ORDER BY enrrollment_id, country_code;


-- SELECT * FROM v_enrrollment_address ORDER BY enrrollment_id, country_code;

INSERT INTO kuntur.enrrollment_address (SELECT * FROM v_enrrollment_address ORDER BY enrrollment_id, country_code);

-- SELECT * FROM kuntur.enrrollment_address;

-- ======================================================================================

DROP VIEW IF EXISTS v_unc_in_enrrollment CASCADE;

CREATE OR REPLACE VIEW v_unc_in_enrrollment AS 

	SELECT 	--vp.physical_person_id, 
		--vp.postulation_id, 
		--vp.last_name, 
		--vp.name, 
		--vp.identification_number, 
		--vp.mail, 
		--vp.year_academic, 
		--vp.semester, 
		--vp.start_period, 
		--vp.end_period, 
		--vp.state_id, 
		--vp.state, 
		--vp.institution_name, 
		--vp.institution_country_code

		--------------------------------

		vp.postulation_id AS id,
		false AS erased,

		CASE WHEN is_contract IS NULL THEN false::boolean ELSE is_contract::boolean END AS is_contract, 
		CASE WHEN is_program IS NULL THEN false::boolean ELSE is_program::boolean END AS is_program, 
			
		--null::varchar AS program_name, -- quitar no va mas el campo
		
		CASE WHEN fees_paid IS NULL THEN 0::double precision ELSE fees_paid::double precision END AS amount_paid, 			
		CASE WHEN original_documentation IS NULL THEN false::boolean ELSE original_documentation::boolean END AS original_doc, 
		CASE WHEN insurance IS NULL THEN false::boolean ELSE insurance::boolean END AS insurance, 
		CASE WHEN language_certificate IS NULL THEN false::boolean ELSE language_certificate::boolean END AS language_certificate, 
		

		trim(visa)::varchar AS visa, 
		
		null::varchar AS emergency_contact, 
		
		null::varchar AS credential_code, 
		
	        trim(sys_file_analytical_id)::varchar AS url_origininal_transcript, 
	        trim(sys_file_passport_id)::varchar AS url_passport, 
	        trim(sys_file_language_certificate_id)::varchar AS url_language_certificate, 
	        trim(sys_file_cv_id)::varchar AS url_cv, 	        
	        trim(sys_file_postulation_letter_id)::varchar AS url_application_letter, 
	        trim(sys_file_psychophysical_certificate_id)::varchar AS url_certificate_psychophysical, 

	        trim(sys_file_acceptance_letter_id)::varchar AS url_admission_act, --Generación Dinamica
	        trim(sys_file_acceptance_letter_mail_id)::varchar AS url_admission_act_template, --Generación Dinamica
	        trim(sys_file_analytical_certificate_id)::varchar AS url_transcript, --Generación Dinamica
	        trim(sys_file_analytical_certificate_mail_id)::varchar AS url_transcript_template, --Generación Dinamica
	       
	        null::varchar AS url_university_credential, -- Se pide una vez al ws y se almacena
	        
	        trim(sys_file_intermediate_report_id)::varchar AS url_student_report, -- Generación Dinamica
	        trim(sys_file_program_id)::varchar AS url_exchange_form, -- falta averiguar cual es Formulario de Intercambio

		trim(p.comment) AS comment,
		trim(p.observation) AS observation,
		p.creation_date AS creation_date,
	        
	        trim(c.name)::varchar AS agreement_name,
		trim(c.comment)::varchar AS agreement_comment,
		c.number_students::integer AS agreement_number_students,
		trim(i.name)::varchar AS agreement_org,
		trim(i.comment)::varchar AS agreement_org_comment,
		trim(u.name)::varchar AS agreement_academic_unit,

		trim(ep.name)::varchar AS exchange_program_name,
		trim(ep.comment)::varchar AS exchange_program_comment,
		ep.number_students::integer AS exchange_program_number_students,
		ep.initial_number_students::integer AS exchange_program_initial_number_students
		
		--------------------------------
		
	FROM 	v_postulation_ok_tmp vp
	JOIN	postulation p
		ON trim(p.id)::varchar = vp.postulation_id::varchar
	LEFT JOIN  contract c 
		ON c.id = p.contract_id
	LEFT JOIN institution i 
		ON i.id = c.institution_id	
	LEFT JOIN academic_unit u 
		ON u.id = c.academic_unit_id
	LEFT JOIN exchange_program ep
		ON ep.id = p.exchange_program_id;	

-- SELECT * FROM v_unc_in_enrrollment;


DROP TABLE IF EXISTS unc_in_enrrollment_tmp CASCADE;

CREATE TABLE unc_in_enrrollment_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  agreement boolean NOT NULL,
	  program boolean NOT NULL,
	--  program_name character varying,
	  amount_paid double precision NOT NULL,
	  original_doc boolean NOT NULL,
	  insurance boolean NOT NULL,
	  language_certificate boolean NOT NULL,
	  visa character varying,
	  emergency_contact character varying,
	  credential_code character varying,
	  url_origininal_transcript character varying,
	  url_passport character varying,
	  url_language_certificate character varying,
	  url_cv character varying,
	  url_application_letter character varying,
	  url_certificate_psychophysical character varying,
	  url_admission_act character varying,
	  url_admission_act_template character varying,
	  url_transcript character varying,
	  url_transcript_template character varying,
	  url_university_credential character varying,
	  url_student_report character varying,
	  url_exchange_form character varying,
	  comment character varying,
	  observation character varying,
	  creation_date_postulation date,
	  agreement_name character varying,
	  agreement_comment character varying,
	  agreement_number_students integer,
	  agreement_org character varying,
	  agreement_org_comment character varying,
	  agreement_academic_unit character varying,
	  exchange_program_name character varying,
	  exchange_program_comment character varying,
	  exchange_program_number_students integer,
	  exchange_program_initial_number_students integer
 );

INSERT INTO unc_in_enrrollment_tmp (SELECT * FROM v_unc_in_enrrollment);

UPDATE unc_in_enrrollment_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE unc_in_enrrollment_tmp SET erased = null WHERE char_length(trim(erased)) = 0;
--UPDATE unc_in_enrrollment_tmp SET agreement = null WHERE char_length(trim(agreement)) = 0;
--UPDATE unc_in_enrrollment_tmp SET program = null WHERE char_length(trim(program)) = 0;
--UPDATE unc_in_enrrollment_tmp SET program_name = null WHERE char_length(trim(program_name)) = 0;
--UPDATE unc_in_enrrollment_tmp SET amount_paid = null WHERE char_length(trim(amount_paid)) = 0;
--UPDATE unc_in_enrrollment_tmp SET original_doc = null WHERE char_length(trim(original_doc)) = 0;
--UPDATE unc_in_enrrollment_tmp SET insurance = null WHERE char_length(trim(insurance)) = 0;
--UPDATE unc_in_enrrollment_tmp SET language_certificate = null WHERE char_length(trim(language_certificate)) = 0;
UPDATE unc_in_enrrollment_tmp SET visa = null WHERE char_length(trim(visa)) = 0;
UPDATE unc_in_enrrollment_tmp SET emergency_contact = null WHERE char_length(trim(emergency_contact)) = 0;
UPDATE unc_in_enrrollment_tmp SET credential_code = null WHERE char_length(trim(credential_code)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_origininal_transcript = null WHERE char_length(trim(url_origininal_transcript)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_passport = null WHERE char_length(trim(url_passport)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_language_certificate = null WHERE char_length(trim(url_language_certificate)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_cv = null WHERE char_length(trim(url_cv)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_application_letter = null WHERE char_length(trim(url_application_letter)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_certificate_psychophysical = null WHERE char_length(trim(url_certificate_psychophysical)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_admission_act = null WHERE char_length(trim(url_admission_act)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_admission_act_template = null WHERE char_length(trim(url_admission_act_template)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_transcript = null WHERE char_length(trim(url_transcript)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_transcript_template = null WHERE char_length(trim(url_transcript_template)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_university_credential = null WHERE char_length(trim(url_university_credential)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_student_report = null WHERE char_length(trim(url_student_report)) = 0;
UPDATE unc_in_enrrollment_tmp SET url_exchange_form = null WHERE char_length(trim(url_exchange_form)) = 0;
UPDATE unc_in_enrrollment_tmp SET comment = null WHERE char_length(trim(comment)) = 0;
UPDATE unc_in_enrrollment_tmp SET observation = null WHERE char_length(trim(observation)) = 0;
--UPDATE unc_in_enrrollment_tmp SET creation_date_postulation = null WHERE char_length(trim(creation_date_postulation)) = 0;
UPDATE unc_in_enrrollment_tmp SET agreement_name = null WHERE char_length(trim(agreement_name)) = 0;
UPDATE unc_in_enrrollment_tmp SET agreement_comment = null WHERE char_length(trim(agreement_comment)) = 0;
--UPDATE unc_in_enrrollment_tmp SET agreement_number_students = null WHERE char_length(trim(agreement_number_students)) = 0;
UPDATE unc_in_enrrollment_tmp SET agreement_org = null WHERE char_length(trim(agreement_org)) = 0;
UPDATE unc_in_enrrollment_tmp SET agreement_org_comment = null WHERE char_length(trim(agreement_org_comment)) = 0;
UPDATE unc_in_enrrollment_tmp SET agreement_academic_unit = null WHERE char_length(trim(agreement_academic_unit)) = 0;
UPDATE unc_in_enrrollment_tmp SET exchange_program_name = null WHERE char_length(trim(exchange_program_name)) = 0;
UPDATE unc_in_enrrollment_tmp SET exchange_program_comment = null WHERE char_length(trim(exchange_program_comment)) = 0;
--UPDATE unc_in_enrrollment_tmp SET exchange_program_number_students = null WHERE char_length(trim(exchange_program_number_students)) = 0;
--UPDATE unc_in_enrrollment_tmp SET exchange_program_initial_number_students = null WHERE char_length(trim(exchange_program_initial_number_students)) = 0;

UPDATE unc_in_enrrollment_tmp t SET url_origininal_transcript = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_origininal_transcript); 
UPDATE unc_in_enrrollment_tmp t SET url_passport = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_passport); 
UPDATE unc_in_enrrollment_tmp t SET url_language_certificate = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_language_certificate); 
UPDATE unc_in_enrrollment_tmp t SET url_cv = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_cv); 
UPDATE unc_in_enrrollment_tmp t SET url_application_letter = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_application_letter); 
UPDATE unc_in_enrrollment_tmp t SET url_certificate_psychophysical = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_certificate_psychophysical); 
UPDATE unc_in_enrrollment_tmp t SET url_admission_act = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_admission_act); 
UPDATE unc_in_enrrollment_tmp t SET url_admission_act_template = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_admission_act_template); 
UPDATE unc_in_enrrollment_tmp t SET url_transcript = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_transcript); 
UPDATE unc_in_enrrollment_tmp t SET url_transcript_template = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_transcript_template); 
UPDATE unc_in_enrrollment_tmp t SET url_university_credential = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_university_credential); 
UPDATE unc_in_enrrollment_tmp t SET url_student_report = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_student_report); 
UPDATE unc_in_enrrollment_tmp t SET url_exchange_form = (SELECT x.back_end_path FROM sys_file x WHERE x.id = t.url_exchange_form); 

UPDATE unc_in_enrrollment_tmp t SET credential_code = (SELECT x.codigo FROM credential x WHERE x.postulation_id = t.id AND x.state_enable = true LIMIT 1); 

-- SELECT * FROM unc_in_enrrollment_tmp;

-- SELECT * FROM unc_in_enrrollment_tmp WHERE id = 'edu_hernandez_postulation';

INSERT INTO kuntur.unc_in_enrrollment (SELECT DISTINCT * FROM unc_in_enrrollment_tmp);

-- SELECT * FROM kuntur.unc_in_enrrollment;

-- ======================================================================================


-- SELECT * FROM model.academic_unit au
-- SELECT * FROM kuntur.org

DROP VIEW IF EXISTS v_org_f CASCADE;

CREATE OR REPLACE VIEW v_org_f AS
		SELECT	au.code_b::varchar AS id, 
			false::boolean AS erased, 
			trim(au.short_name)::varchar AS short_name, 			
			trim(au.name)::varchar AS name, 
			trim(au.name)::varchar AS original_name, 
			null::varchar AS photo_url, 
			au.code_b::varchar AS web_site, 
			null::varchar AS comment, 
			'ARG'::varchar AS country_code, 
			false::boolean AS primary_org, 
			au.code::integer AS code_ona,
			au.code_b::varchar AS code_guarani,
			au.au_type_id::varchar AS org_type_id,
			(SELECT x.code_b FROM model.academic_unit x WHERE x.id = au.academic_unit_parent_id)::varchar  AS org_id
			--CASE 	WHEN au.academic_unit_parent_id IS NOT NULL THEN (SELECT x.code_b FROM model.academic_unit x WHERE x.id = au.academic_unit_parent_id)::varchar 
			--	ELSE (SELECT id FROM kuntur.org x WHERE x.web_site = 'www.unc.edu.ar')::varchar 
			--END AS org_id			
		FROM	model.academic_unit au		
		ORDER BY trim(au.name);

-- SELECT * FROM v_org_f ORDER BY id, org_id;

DROP TABLE IF EXISTS org_f_tmp_a CASCADE;

CREATE TABLE org_f_tmp_a
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  short_name character varying,
	  name character varying,
	  original_name character varying NOT NULL,
	  url_photo character varying,
	  web_site character varying NOT NULL,
	  comment character varying,
	  country_code character varying NOT NULL,
	  primary_org boolean NOT NULL,
	  code_ona integer UNIQUE,
	  code_guarani character varying UNIQUE NOT NULL ,
	  org_type_id character varying NOT NULL,
	  org_id character varying 
);

INSERT INTO org_f_tmp_a (SELECT * FROM v_org_f );

INSERT INTO org_f_tmp_a (
            id, erased, short_name, name, original_name, url_photo, web_site, 
            comment, country_code, primary_org, code_ona, code_guarani, org_type_id, 
            org_id)
    VALUES ('www.efn.unc.edu.ar/escuelas/biolog/', false, 'EB', 'Escuela de Biología', 'Escuela de Biología', null, 'www.efn.unc.edu.ar/escuelas/biolog/', 
            null, 'ARG', false, null, 'www.efn.unc.edu.ar/escuelas/biolog/', 
            (SELECT x.id FROM kuntur.org_type x WHERE x.code = 'E')::varchar , '10');

-- SELECT * FROM org_f_tmp_a;

--------------------------------------------------------------------

DROP VIEW IF EXISTS v_org_f_b CASCADE;

CREATE OR REPLACE VIEW v_org_f_b AS
		SELECT	au.id, 
			true::boolean erased, 
			--substring(trim(au.name) from 0 for 4)::varchar short_name, 
			trim(split_part(trim(au.name), '-', 1))::varchar AS short_name2, 
			trim(split_part(trim(au.name), '-', 2))::varchar AS name, 
			trim(split_part(trim(au.name), '-', 2))::varchar AS original_name, 
			null::varchar AS photo_url, 
			trim(au.name)::varchar AS web_site, 
			trim(au.name)::varchar AS comment, 
			'ARG'::varchar AS country_code, 
			false::boolean AS primary_org, 
			null::integer AS code_ona,
			null::varchar AS code_guarani,
			(SELECT x.id FROM kuntur.org_type x WHERE x.code = 'F')::varchar AS org_type_id, 
			(SELECT id FROM kuntur.org x WHERE x.web_site = 'www.unc.edu.ar')::varchar AS org_id
		FROM	academic_unit au
		WHERE   au.id IN (SELECT y.academic_unit_id FROM chosen_academic_unit_in_eri_in y)
		ORDER BY trim(au.name);

-- SELECT * FROM v_org_f_b;

DROP TABLE IF EXISTS org_f_tmp_b CASCADE;

CREATE TABLE org_f_tmp_b
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  short_name character varying,
	  name character varying,
	  original_name character varying NOT NULL,
	  url_photo character varying,
	  web_site character varying NOT NULL,
	  comment character varying,
	  country_code character varying NOT NULL,
	  primary_org boolean NOT NULL,
	  code_ona integer UNIQUE,
	  code_guarani character varying UNIQUE,
	  org_type_id character varying NOT NULL,
	  org_id character varying 
);

INSERT INTO org_f_tmp_b (SELECT * FROM v_org_f_b );




-- SELECT * FROM org_f_tmp_b ORDER BY name;
-- SELECT * FROM org_f_tmp_a ORDER BY short_name;


-- SELECT 'UPDATE org_f_tmp_b SET code_guarani = '''' WHERE web_site = ''' || web_site || ''';'  FROM org_f_tmp_b ORDER BY name;

UPDATE org_f_tmp_b SET code_guarani = '13' WHERE web_site = 'FAUD - Arquitectura y Diseño';
UPDATE org_f_tmp_b SET code_guarani = 'www.efn.unc.edu.ar/escuelas/biolog/' WHERE web_site = 'EFN - Biología & Otras';
UPDATE org_f_tmp_b SET code_guarani = '19' WHERE web_site = 'FCA - Ciencias Agropecuarias';
UPDATE org_f_tmp_b SET code_guarani = '42' WHERE web_site = 'ECI - Ciencias de la Información';
UPDATE org_f_tmp_b SET code_guarani = '11' WHERE web_site = 'FCE - Ciencias Económicas';
UPDATE org_f_tmp_b SET code_guarani = '15' WHERE web_site = 'FCQ - Ciencias Químicas';
UPDATE org_f_tmp_b SET code_guarani = '05' WHERE web_site = 'FDyCS - Derecho y Ciencias Sociales';
UPDATE org_f_tmp_b SET code_guarani = '06027' WHERE web_site = 'FCM - Enfermería';
UPDATE org_f_tmp_b SET code_guarani = '69' WHERE web_site = 'CEA - Estudios Avanzados POSGRADO';
UPDATE org_f_tmp_b SET code_guarani = '95' WHERE web_site = 'FA - Facultad de Artes';
UPDATE org_f_tmp_b SET code_guarani = '12' WHERE web_site = 'FFyH - Filosofía y Humanidades';
UPDATE org_f_tmp_b SET code_guarani = '06-1' WHERE web_site = 'FCM - Fonoaudio';
UPDATE org_f_tmp_b SET code_guarani = '10' WHERE web_site = 'EFN - Ingeniería';
UPDATE org_f_tmp_b SET code_guarani = '16' WHERE web_site = 'FL - Lenguas';
UPDATE org_f_tmp_b SET code_guarani = '03' WHERE web_site = 'FAMAF - Matemática, Astronomía y Física';
UPDATE org_f_tmp_b SET code_guarani = '06' WHERE web_site = 'FCM - Medicina';
UPDATE org_f_tmp_b SET code_guarani = '06031' WHERE web_site = 'FCM - Nutrición';
UPDATE org_f_tmp_b SET code_guarani = '14' WHERE web_site = 'FO - Odontología';
UPDATE org_f_tmp_b SET code_guarani = '75' WHERE web_site = 'FP - Psicología';
UPDATE org_f_tmp_b SET code_guarani = '20' WHERE web_site = 'ETS - Trabajo Social';





DROP VIEW IF EXISTS v_org_f_c CASCADE;

CREATE OR REPLACE VIEW v_org_f_c AS

		SELECT	CASE 	WHEN b.code_guarani IS NOT NULL THEN b.id 
				ELSE a.id
			END AS id,
			CASE 	WHEN b.code_guarani IS NOT NULL THEN b.erased 
				ELSE a.erased
			END AS erased,	
			--a.erased, 			
			a.short_name, 
			a.name, 			
			a.original_name, 
			a.url_photo, 
			a.web_site, 			
			b.web_site::varchar AS comment,			
			a.country_code, 
			a.primary_org, 
			a.code_ona,
			a.code_guarani,
			a.org_type_id, 
			(SELECT x.id FROM org_f_tmp_b x WHERE x.code_guarani = a.org_id)::varchar AS org_id
			--a.org_id
		FROM	org_f_tmp_a a
		LEFT JOIN org_f_tmp_b b
			ON a.code_guarani = b.code_guarani		
		ORDER BY a.short_name;

-- SELECT * FROM v_org_f_c;

DROP TABLE IF EXISTS org_f_tmp_c CASCADE;

CREATE TABLE org_f_tmp_c
(
	  id character varying NOT NULL,
	  erased boolean NOT NULL,
	  short_name character varying,
	  name character varying,
	  original_name character varying NOT NULL,
	  url_photo character varying,
	  web_site character varying NOT NULL,
	  comment character varying,
	  country_code character varying NOT NULL,
	  primary_org boolean NOT NULL,
	  code_ona integer UNIQUE,
	  code_guarani character varying UNIQUE,
	  org_type_id character varying NOT NULL,
	  org_id character varying 
);

INSERT INTO org_f_tmp_c (SELECT * FROM v_org_f_c );

-- SELECT * FROM org_f_tmp_c;

-- SELECT * FROM  org_f_tmp_c c WHERE c.id::varchar NOT IN (SELECT DISTINCT x.org_id::varchar FROM org_f_tmp_c x WHERE x.org_id IS NOT NULL) AND erased = false;

UPDATE org_f_tmp_c c SET id = uuid_generate_v4()::varchar  WHERE c.id::varchar NOT IN (SELECT DISTINCT x.org_id::varchar FROM org_f_tmp_c x WHERE x.org_id IS NOT NULL) AND erased = false;

-- SELECT * FROM org_f_tmp_c;

UPDATE org_f_tmp_c c SET erased = false;

-- SELECT * FROM org_f_tmp_c;

UPDATE org_f_tmp_c c SET org_id = (SELECT x.id FROM kuntur.org x WHERE x.web_site = 'www.unc.edu.ar')::varchar WHERE c.org_id IS NULL;

-- SELECT * FROM org_f_tmp_c;

-- DELETE FROM kuntur.org WHERE org_id = (SELECT x.id FROM kuntur.org x WHERE x.web_site = 'www.unc.edu.ar')::varchar;

INSERT INTO kuntur.org (SELECT * FROM org_f_tmp_c);



-- SELECT * FROM kuntur.org WHERE org_id IS NOT NULL;

-- ======================================================================================

DROP VIEW IF EXISTS v_unc_in_study_program CASCADE;

CREATE OR REPLACE VIEW v_unc_in_study_program AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased,
			trim(c.subjects)::varchar AS subjects,
			sp.approved::boolean AS approved, 			
			null::varchar AS approved_by,	
			trim(c.guarani)::varchar AS file_number,
			null::varchar AS comment,
			vp.postulation_id AS unc_in_enrrollment_id,
			trim(c.academic_unit_id)::varchar AS org_id
		FROM 	postulation p
		JOIN	v_postulation_ok_tmp vp
			ON trim(p.id)::varchar = vp.postulation_id::varchar	
		JOIN 	study_program sp 
			ON trim(sp.id)::varchar = trim(p.study_program_id)::varchar	
		JOIN	study_program_chosen_academic_unit_in_eri_in_list spt
			ON sp.id::varchar = spt.study_program_id::varchar
		JOIN	chosen_academic_unit_in_eri_in c
			ON c.id::varchar = spt.chosen_academic_unit_in_eri_in_id::varchar
		JOIN	academic_unit au
			ON au.id::varchar = c.academic_unit_id::varchar	
		WHERE 	sp.state_enable = true	
		ORDER BY vp.postulation_id, spt.order_number;	

-- SELECT * FROM v_unc_in_study_program;
-- SELECT * FROM v_unc_in_study_program WHERE org_id IS NULL;

DROP TABLE IF EXISTS unc_in_study_program_tmp CASCADE;

CREATE TABLE unc_in_study_program_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  subjects character varying NOT NULL,
	  approved boolean,
	  approved_by character varying,
	  file_number character varying,
	  comment character varying,
	  unc_in_enrrollment_id character varying NOT NULL,
	  org_id character varying NOT NULL  
);


INSERT INTO unc_in_study_program_tmp (SELECT * FROM v_unc_in_study_program WHERE subjects IS NOT NULL);

UPDATE unc_in_study_program_tmp SET id = null WHERE char_length(trim(id)) = 0;
UPDATE unc_in_study_program_tmp SET subjects = null WHERE char_length(trim(subjects)) = 0;
UPDATE unc_in_study_program_tmp SET file_number = null WHERE char_length(trim(file_number)) = 0;
UPDATE unc_in_study_program_tmp SET unc_in_enrrollment_id = null WHERE char_length(trim(unc_in_enrrollment_id)) = 0;
UPDATE unc_in_study_program_tmp SET org_id = null WHERE char_length(trim(org_id)) = 0;

--SELECT * FROM unc_in_study_program_tmp;

INSERT INTO kuntur.unc_in_study_program (SELECT * FROM unc_in_study_program_tmp);

-- SELECT * FROM kuntur.unc_in_study_program;

-- ======================================================================================

DROP VIEW IF EXISTS v_unc_in_studied_type_a CASCADE;

CREATE OR REPLACE VIEW v_unc_in_studied_type_a AS

		SELECT 	DISTINCT semester 
		FROM 	subject;

-- SELECT * FROM v_unc_in_studied_type_a;

DROP VIEW IF EXISTS v_unc_in_studied_type CASCADE;

CREATE OR REPLACE VIEW v_unc_in_studied_type AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased, 
			trim(s.semester)::varchar AS code, 

			CASE 	WHEN trim(s.semester)::varchar = 'A' THEN 'Anual'
				WHEN trim(s.semester)::varchar = 'S' THEN 'Semestral'
				WHEN trim(s.semester)::varchar = 'CP' THEN 'Cursado parcial de materia anual'
			END AS name,				
			--trim(s.semester)::varchar AS name, 
			null::varchar AS comment
		FROM 	v_unc_in_studied_type_a s
		ORDER BY s.semester;

-- SELECT * FROM v_unc_in_studied_type;		

INSERT INTO kuntur.unc_in_studied_type (SELECT * FROM v_unc_in_studied_type);

 -- SELECT * FROM kuntur.unc_in_studied_type;

 -- ======================================================================================

 DROP VIEW IF EXISTS v_unc_in_grading_scale_a CASCADE;

CREATE OR REPLACE VIEW v_unc_in_grading_scale_a AS

		SELECT 	DISTINCT s.note_in_numbers::integer AS note_in_numbers, 
			trim(s.note_in_letters)::varchar AS note_in_letters
		FROM 	subject s
		WHERE	s.state_enable = true
			AND s.id IN (SELECT x.subject_id FROM academic_perform_subject_list x);

			

-- SELECT * FROM v_unc_in_grading_scale_a;

DROP VIEW IF EXISTS v_unc_in_grading_scale CASCADE;

CREATE OR REPLACE VIEW v_unc_in_grading_scale AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased, 
			note_in_numbers AS rate_number,
			note_in_letters AS rate_letter,
			null::varchar AS comment
		FROM 	v_unc_in_grading_scale_a g 
		WHERE	(note_in_numbers = 7 AND note_in_letters = 'Distinguido') = false
			AND (note_in_numbers = 8 AND note_in_letters = 'Distinguido') = false
		ORDER BY g.note_in_numbers;

-- SELECT * FROM v_unc_in_grading_scale;		



INSERT INTO kuntur.unc_in_grading_scale (SELECT * FROM v_unc_in_grading_scale);

 -- SELECT * FROM kuntur.unc_in_grading_scale;

 -- ==========================================================================

 DROP VIEW IF EXISTS v_unc_in_academic_performance CASCADE;

CREATE OR REPLACE VIEW v_unc_in_academic_performance AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased,
			trim(s.name)::varchar AS subject,
			s.hours AS hs, 
			vp.postulation_id AS unc_in_enrrollment_id,
			(SELECT gs.id FROM kuntur.unc_in_grading_scale gs WHERE s.note_in_numbers = gs.rate_number)::varchar AS unc_in_grading_scale_id, 
			(SELECT st.id FROM kuntur.unc_in_studied_type st WHERE s.semester = st.code)::varchar AS unc_in_studied_type_id, 			
			trim(s.academic_unit_id)::varchar AS org_id
		FROM 	postulation p
		JOIN	v_postulation_ok_tmp vp
			ON trim(p.id)::varchar = vp.postulation_id::varchar	
		JOIN 	academic_perform ap 
			ON trim(ap.id)::varchar = trim(p.academic_perform_id)::varchar	
		JOIN	academic_perform_subject_list apsl
			ON ap.id::varchar = apsl.academic_perform_id::varchar
		JOIN	subject s
			ON s.id::varchar = apsl.subject_id::varchar
		JOIN	academic_unit au
			ON au.id::varchar = s.academic_unit_id::varchar	
		WHERE 	ap.state_enable = true	
		ORDER BY vp.postulation_id, apsl.order_number;	
-- SELECT * FROM subject
-- SELECT * FROM v_unc_in_academic_performance;
-- SELECT * FROM v_unc_in_academic_performance WHERE org_id IS NULL;

DROP TABLE IF EXISTS unc_in_academic_performance_tmp CASCADE;

CREATE TABLE unc_in_academic_performance_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  subject character varying NOT NULL,
	  hs double precision NOT NULL,
	  unc_in_enrrollment_id character varying NOT NULL,
	  unc_in_grading_scale_id character varying NOT NULL,
	  unc_in_studied_type_id character varying NOT NULL,
	  org_id character varying NOT NULL
);

INSERT INTO unc_in_academic_performance_tmp (SELECT * FROM v_unc_in_academic_performance);

UPDATE unc_in_academic_performance_tmp SET subject = null WHERE char_length(trim(subject)) = 0;

-- SELECT * FROM unc_in_academic_performance_tmp;

INSERT INTO kuntur.unc_in_academic_performance (SELECT * FROM unc_in_academic_performance_tmp);

-- SELECT * FROM kuntur.unc_in_academic_performance;

---------------------------------------------------------------------------

SELECT DISTINCT * FROM v_contact

INSERT INTO kuntur.contact (SELECT DISTINCT * FROM v_contact);			


-- SELECT * FROM kuntur.contact;	

--------------------------------------------------------------------------------------------------

-- SELECT  * FROM kuntur.user_system

/*

	SELECT 	*
	FROM 	act_id_user u	
	JOIN	act_id_membership m
		ON trim(u.id_)::varchar = trim(m.user_id_)::varchar
		AND trim(email_) ILIKE '%@pri.unc.edu.ar%'
	ORDER BY id_	

*/

DROP VIEW IF EXISTS v_act_id_user CASCADE;

CREATE OR REPLACE VIEW 	v_act_id_user AS 

	SELECT 	trim(u.id_)::varchar AS id_user,
		lower(trim(u.email_))::varchar AS email,
		initcap(lower(trim(u.last_)))::varchar AS last,
		initcap(lower(trim(u.first_)))::varchar AS first,
		trim(u.pwd_)::varchar AS pwd,
		trim(m.group_id_)::varchar AS group_id
	FROM 	act_id_user u	
	JOIN	act_id_membership m
		ON trim(u.id_)::varchar = trim(m.user_id_)::varchar
		AND trim(m.group_id_)::varchar <> 'admin'
		AND trim(m.group_id_)::varchar <> 'eri-in'
	WHERE 	trim(u.id_)::varchar NOT IN (SELECT x.email::varchar FROM kuntur.user_system x)
		AND trim(u.email_)::varchar NOT ILIKE '%@pri.unc.edu.ar'
		-- AND trim(u.last_)::varchar IS NOT NULL
	ORDER BY trim(last_), trim(first_), trim(email_), trim(id_);	


-- SELECT * FROM v_act_id_user;	

DROP VIEW IF EXISTS v_person_act_id_user CASCADE;

CREATE OR REPLACE VIEW 	v_person_act_id_user AS 

	SELECT DISTINCT id_user, email, last, first, pwd		
	FROM 	v_act_id_user 
	ORDER BY last, first, email, id_user;	

-- SELECT * FROM v_person_act_id_user;	


DROP VIEW IF EXISTS v_person_z CASCADE;

CREATE OR REPLACE VIEW 	v_person_z AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		--t.id::varchar AS id, 
		false::boolean AS erased, 
		first::varchar AS given_name, 
		t.id_user::varchar AS middle_name, 
		last::varchar AS family_name, 
		null::date AS birth_date, 
		null::boolean AS male, 
		pwd::varchar AS url_photo, 
		t.email::varchar AS comment, 
		null::varchar AS birth_country_code, 
		null::varchar AS birth_admin_area_level1_code, 
		null::varchar AS birth_admin_area_level2, 
		null::varchar AS birth_locality, 
		null::double precision AS birth_lat, 
		null::double precision AS birth_lng
	FROM 	v_person_act_id_user t;

-- SELECT * FROM v_person_z	

INSERT INTO kuntur.person (SELECT * FROM v_person_z);

DROP VIEW IF EXISTS v_person_email_z CASCADE;

CREATE OR REPLACE VIEW 	v_person_email_z AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased, 
		t.comment::varchar AS email, 
		t.middle_name::varchar AS comment, 
		p.id::varchar AS person_id
	FROM 	kuntur.person p
	JOIN	v_person_z t
		ON p.middle_name::varchar = t.middle_name::varchar;

-- SELECT * FROM v_person_email_z	

DROP VIEW IF EXISTS v_user_system_z CASCADE;

CREATE OR REPLACE VIEW 	v_user_system_z AS 

	SELECT 	p.id::varchar AS id, 
		false::boolean AS erased, 
		t.middle_name::varchar AS name, 
		t.url_photo::varchar AS pass, 
		t.comment::varchar AS email, 
		(coalesce(t.family_name, '') || ' ' || coalesce(t.given_name, ''))::varchar AS  comment
	FROM 	kuntur.person p
	JOIN	v_person_z t
		ON p.middle_name::varchar = t.middle_name::varchar;

-- SELECT * FROM v_user_system_z ORDER BY email;

-- ALTER TABLE kuntur.user_system DROP CONSTRAINT user_system_email_key;

INSERT INTO kuntur.user_system (SELECT * FROM v_user_system_z ORDER BY id);

INSERT INTO kuntur.person_email (SELECT * FROM v_person_email_z ORDER BY id);

-- SELECT * FROM kuntur.person_email;

-- SELECT * FROM v_act_id_user;	

DROP VIEW IF EXISTS v_unc_in_academic_coordinator CASCADE;

CREATE OR REPLACE VIEW 	v_unc_in_academic_coordinator AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased,
		p.id::varchar AS person_id,	
		o.id::varchar AS org_id
		--, u.group_id,
		--o.comment,
		--u.id_user
	FROM 	v_act_id_user u
	JOIN	kuntur.person p
		ON p.middle_name = u.id_user
	JOIN	kuntur.org o
		ON o.comment ilike u.group_id 
			OR (o.comment = 'Escuela de Kinesiología y Fisioterapia' AND u.group_id = 'FCM - Kinesio');	

-- SELECT * FROM v_unc_in_academic_coordinator;

DROP VIEW IF EXISTS v_unc_in_academic_office CASCADE;

CREATE OR REPLACE VIEW 	v_unc_in_academic_office AS 

	SELECT  uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased,
		p.id::varchar AS person_id,	
		o.id::varchar AS org_id
		--, u.group_id,
		--o.comment,
		--u.id_user
	FROM 	v_act_id_user u
	JOIN	kuntur.person p
		ON p.middle_name = u.id_user
	JOIN	kuntur.org o
		ON o.comment || ' (Despacho)' ilike u.group_id
			OR (o.name = 'Escuela de Kinesiología y Fisioterapia' AND u.group_id = 'FCM - Kinesio (Despacho)');	

-- SELECT * FROM v_unc_in_academic_office;

INSERT INTO kuntur.unc_in_academic_coordinator (SELECT * FROM v_unc_in_academic_coordinator);

-- SELECT * FROM kuntur.unc_in_academic_coordinator;

INSERT INTO kuntur.unc_in_academic_office (SELECT * FROM v_unc_in_academic_office);

-- SELECT * FROM kuntur.unc_in_academic_office;

-- =====================================================================================================================================

-- SELECT * FROM kuntur.enrrollment_status ORDER BY code;	

UPDATE kuntur.enrrollment_status SET code = 'A', comment = 'Postulante' WHERE code = '268';
UPDATE kuntur.enrrollment_status SET code = 'B', comment = 'Administrativos PRI' WHERE code = '259';
UPDATE kuntur.enrrollment_status SET code = 'C', comment = 'Postulante' WHERE code = '260';
UPDATE kuntur.enrrollment_status SET code = 'D', comment = 'Coordinadores Academicos'  WHERE code = '261';
UPDATE kuntur.enrrollment_status SET code = 'E', comment = 'Postulante' WHERE code = '264';
UPDATE kuntur.enrrollment_status SET code = 'F', comment = 'Administrativos PRI' WHERE code = '262';
UPDATE kuntur.enrrollment_status SET code = 'G', comment = 'Postulante'  WHERE code = '263';
UPDATE kuntur.enrrollment_status SET code = 'H', comment = 'Despachos' WHERE code = '270';
UPDATE kuntur.enrrollment_status SET code = 'I', comment = 'Administrativos PRI' WHERE code = '265';
UPDATE kuntur.enrrollment_status SET code = 'J', comment = 'Despachos'  WHERE code = '271';
UPDATE kuntur.enrrollment_status SET code = 'K', comment = 'Administrativos PRI'  WHERE code = '266';
UPDATE kuntur.enrrollment_status SET code = 'z', comment = 'Administrativos PRI'  WHERE code = '267';

-- SELECT * FROM kuntur.enrrollment_status ORDER BY code;	
-- SELECT * FROM kuntur.enrrollment_status ORDER BY comment, code;	

--------------------------------------------------------------------------------------------------------

-- SELECT * FROM kuntur.enrrollment	
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

DROP VIEW IF EXISTS v_enrrollment_stakeholder_a CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_a AS 

	SELECT 	null::varchar AS id, 
		--uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased, 
		CASE 	WHEN es.code = 'A' THEN 2 
			WHEN es.code = 'C' THEN 2 
			WHEN es.code = 'E' THEN 2 
			WHEN es.code = 'G' THEN 2 
			ELSE 1 
		END AS code,
		u.id::varchar AS user_system_id, 
		e.id::varchar AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	kuntur.student s
		ON s.id = e.student_id			
	JOIN	kuntur.user_system u
		ON u.id = s.id
	JOIN	kuntur.enrrollment_status es
		ON es.id = e.enrrollment_status_id;	

-- SELECT * FROM v_enrrollment_stakeholder_a;

-- SELECT * FROM kuntur.enrrollment_status ORDER BY code;	
-- SELECT * FROM kuntur.enrrollment_status ORDER BY comment, code;	

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_b CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_b AS 

	SELECT 	null::varchar AS id,
		--uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased,

		CASE WHEN es.code = 'D' THEN 2 ELSE 1 END AS code,
		 
		--1::integer AS code, 
		u.id::varchar AS user_system_id, 
		e.id::varchar AS enrrollment_id
	FROM 	kuntur.enrrollment e	
	JOIN	kuntur.unc_in_enrrollment eunc
		ON e.id = eunc.id		
	JOIN	kuntur.unc_in_study_program sp 
		ON eunc.id = sp.unc_in_enrrollment_id		
	JOIN	kuntur.unc_in_academic_coordinator ac --<<<<-----------------
		ON sp.org_id = ac.org_id		
	JOIN	kuntur.user_system u
		ON u.id = ac.person_id		
	JOIN	kuntur.enrrollment_status es
		ON es.id = e.enrrollment_status_id
		AND (	es.code = 'D'
			OR es.code = 'E'
			OR es.code = 'F'
			OR es.code = 'G'
			OR es.code = 'H'
			OR es.code = 'I'
			OR es.code = 'J'
			OR es.code = 'K'
		    );

-- SELECT * FROM v_enrrollment_stakeholder_b;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_c CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_c AS 
	
	SELECT DISTINCT * FROM v_enrrollment_stakeholder_b;

-- SELECT * FROM v_enrrollment_stakeholder_c;	

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_d CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_d AS 
	
	SELECT  null::varchar AS id, 
		--uuid_generate_v4()::varchar AS id, 
		erased,
		code, 
		user_system_id, 
		enrrollment_id
	FROM 	v_enrrollment_stakeholder_c;
	

-- SELECT * FROM v_enrrollment_stakeholder_d;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_e CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_e AS 

	SELECT 	null::varchar AS id,
		--uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased,

		CASE 	WHEN es.code = 'H' OR es.code = 'J' THEN 2 ELSE 1 END AS code,
		 
		--1::integer AS code, 
		u.id::varchar AS user_system_id, 
		e.id::varchar AS enrrollment_id
	FROM 	kuntur.enrrollment e	
	JOIN	kuntur.unc_in_enrrollment eunc
		ON e.id = eunc.id		
	JOIN	kuntur.unc_in_study_program sp
		ON eunc.id = sp.unc_in_enrrollment_id		
	JOIN	kuntur.unc_in_academic_office ac --<<<<-----------------
		ON sp.org_id = ac.org_id		
	JOIN	kuntur.user_system u
		ON u.id = ac.person_id		
	JOIN	kuntur.enrrollment_status es
		ON es.id = e.enrrollment_status_id
		AND (	es.code = 'H'
			OR es.code = 'I'
			OR es.code = 'J'
			OR es.code = 'K'
		    );

-- SELECT * FROM v_enrrollment_stakeholder_e;

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_f CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_f AS 
	
	SELECT DISTINCT * FROM v_enrrollment_stakeholder_e;

-- SELECT * FROM v_enrrollment_stakeholder_f;	

--------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_g CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_g AS 
	
	SELECT  null::varchar AS id, 
		--uuid_generate_v4()::varchar AS id, 
		erased,
		code, 
		user_system_id, 
		enrrollment_id
	FROM 	v_enrrollment_stakeholder_f;
	

-- SELECT * FROM v_enrrollment_stakeholder_g;

-------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment_stakeholder_h CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder_h AS 

	SELECT * FROM v_enrrollment_stakeholder_a
	UNION ALL
	SELECT * FROM v_enrrollment_stakeholder_d
	UNION ALL
	SELECT * FROM v_enrrollment_stakeholder_g;

-- SELECT * FROM v_enrrollment_stakeholder_h;	

DROP TABLE IF EXISTS enrrollment_stakeholder_h CASCADE ;

CREATE TABLE enrrollment_stakeholder_h
(
	id VARCHAR,
	erased BOOLEAN,
	code INTEGER,
	user_system_id VARCHAR,
	enrrollment_id VARCHAR,
	code_max INTEGER

);

INSERT INTO enrrollment_stakeholder_h ( 

	SELECT 	v.id,
		v.erased,
		v.code,
		v.user_system_id,
		v.enrrollment_id,
		(
			SELECT 	max(x.code)
			FROM	v_enrrollment_stakeholder_h x
			WHERE	x.enrrollment_id = v.enrrollment_id
				AND x.user_system_id = v.user_system_id
		) AS code_max
	FROM v_enrrollment_stakeholder_h v
);

-- SELECT * FROM enrrollment_stakeholder_h WHERE code <> code_max;

DELETE FROM enrrollment_stakeholder_h WHERE code <> code_max;
/*

SELECT 	* 
FROM 	enrrollment_stakeholder_h v
WHERE (

	SELECT 	count(x.*)
	FROM	enrrollment_stakeholder_h x
	WHERE	x.enrrollment_id = v.enrrollment_id
		AND x.user_system_id = v.user_system_id
		AND x.code <> v.code

	) > 0

*/

--------------------------------------------------------------------------------------------------------

-- SELECT * FROM enrrollment_stakeholder_h;

DROP VIEW IF EXISTS v_enrrollment_stakeholder CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_stakeholder AS 

	SELECT DISTINCT * FROM enrrollment_stakeholder_h;


-- SELECT * FROM v_enrrollment_stakeholder;

--------------------------------------------------------------------------------------------------------

INSERT INTO kuntur.enrrollment_stakeholder (

	SELECT 	uuid_generate_v4()::varchar AS id, 
		erased,
		code,
		user_system_id,
		enrrollment_id
	--	, code_max
	FROM 	v_enrrollment_stakeholder
	--WHERE  	user_system_id = '6c02adff-c331-4cf8-b9f0-75d1abd629a7'
	--	AND enrrollment_id = '4890902639c10bce0139c17bdfa90005'
);

SELECT * FROM kuntur.enrrollment_stakeholder ORDER BY code DESC ;

--------------------------------------------------------------------------------------------------------

-- =====================================================================================================

DROP VIEW IF EXISTS v_act_id_user_admin CASCADE;

CREATE OR REPLACE VIEW 	v_act_id_user_admin AS 

	SELECT 	trim(u.id_)::varchar AS id_user,
		lower(trim(u.email_))::varchar AS email,
		initcap(lower(trim(u.last_)))::varchar AS last,
		initcap(lower(trim(u.first_)))::varchar AS first,
		trim(u.pwd_)::varchar AS pwd
	FROM 	act_id_user u		
	WHERE 	trim(u.id_)::varchar NOT IN (SELECT x.email::varchar FROM kuntur.user_system x)
		AND trim(u.email_)::varchar ILIKE '%@pri.unc.edu.ar'
		AND trim(u.last_)::varchar IS NOT NULL
	ORDER BY trim(last_), trim(first_), trim(email_), trim(id_);


-- SELECT * FROM v_act_id_user_admin;	

---------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_act_id_user_admin CASCADE;

CREATE OR REPLACE VIEW 	v_person_act_id_user_admin AS 

	SELECT DISTINCT id_user, email, last, first, pwd		
	FROM 	v_act_id_user_admin 
	ORDER BY last, first, email, id_user;	


-- SELECT * FROM v_person_act_id_user_admin;			

---------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_admin CASCADE;

CREATE OR REPLACE VIEW 	v_person_admin AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		--t.id::varchar AS id, 
		false::boolean AS erased, 
		first::varchar AS given_name, 
		t.id_user::varchar AS middle_name, 
		last::varchar AS family_name, 
		null::date AS birth_date, 
		null::boolean AS male, 
		pwd::varchar AS url_photo, 
		t.email::varchar AS comment, 
		null::varchar AS birth_country_code, 
		null::varchar AS birth_admin_area_level1_code, 
		null::varchar AS birth_admin_area_level2, 
		null::varchar AS birth_locality, 
		null::double precision AS birth_lat, 
		null::double precision AS birth_lng
	FROM 	v_person_act_id_user_admin t;

 -- SELECT * FROM v_person_admin	

---------------------------------------------------------------------------------------

INSERT INTO kuntur.person (SELECT * FROM v_person_admin);

---------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_person_email_admin CASCADE;

CREATE OR REPLACE VIEW 	v_person_email_admin AS 

	SELECT 	uuid_generate_v4()::varchar AS id, 
		false::boolean AS erased, 
		t.comment::varchar AS email, 
		t.middle_name::varchar AS comment, 
		p.id::varchar AS person_id
	FROM 	kuntur.person p
	JOIN	v_person_admin t
		ON p.middle_name::varchar = t.middle_name::varchar;

-- SELECT * FROM v_person_email_admin	

---------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_user_system_admin CASCADE;

CREATE OR REPLACE VIEW 	v_user_system_admin AS 

	SELECT 	p.id::varchar AS id, 
		false::boolean AS erased, 
		t.middle_name::varchar AS name, 
		t.url_photo::varchar AS pass, 
		t.comment::varchar AS email, 
		(coalesce(t.family_name, '') || ' ' || coalesce(t.given_name, ''))::varchar AS  comment
	FROM 	kuntur.person p
	JOIN	v_person_admin t
		ON p.middle_name::varchar = t.middle_name::varchar;

-- SELECT * FROM v_user_system_admin ORDER BY email;

INSERT INTO kuntur.user_system (SELECT * FROM v_user_system_admin ORDER BY id);

INSERT INTO kuntur.person_email (SELECT * FROM v_person_email_admin ORDER BY id);

-- =======================================================================================================

INSERT INTO kuntur.enrrollment_stakeholder (

	SELECT 	uuid_generate_v4()::varchar AS id, 
		false::BOOLEAN erased,
		3::INTEGER AS code,
		u.id::VARCHAR AS user_system_id,
		e.id::VARCHAR AS enrrollment_id
	FROM 	kuntur.enrrollment e
	JOIN	v_user_system_admin u
		ON 1 = 1
);

-- =======================================================================================================

UPDATE kuntur.enrrollment e SET comment = (SELECT x.comment FROM kuntur.unc_in_enrrollment x WHERE x.id = e.id);

-- =======================================================================================================

SELECT 'FIN DE LA MIGRACION' FROM kuntur.enrrollment LIMIT 100;
