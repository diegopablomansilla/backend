ALTER TABLE kuntur.person_identity
  ADD CONSTRAINT u_person_identity UNIQUE (person_id, identity_number);

ALTER TABLE kuntur.person_identity
  ADD CONSTRAINT u_person_identity_b UNIQUE (identity_number, country_code);

ALTER TABLE kuntur.person_nationality
  ADD CONSTRAINT u_person_nationality UNIQUE (person_id, country_code);

ALTER TABLE kuntur.person_email
  ADD CONSTRAINT u_person_email UNIQUE (person_id, email);  

ALTER TABLE kuntur.person_phone
  ADD CONSTRAINT u_person_phone UNIQUE (person_id, phone_number);  

--------------------------------------  

ALTER TABLE kuntur.enrrollment_identity
  ADD CONSTRAINT u_enrrollment_identity UNIQUE (enrrollment_id, identity_number);

--ALTER TABLE kuntur.enrrollment_identity
--  ADD CONSTRAINT u_enrrollment_identity_b UNIQUE (identity_number, country_code);

--ALTER TABLE kuntur.enrrollment_nationality
--  ADD CONSTRAINT u_enrrollment_nationality UNIQUE (enrrollment_id, country_code);

ALTER TABLE kuntur.enrrollment_email
  ADD CONSTRAINT u_enrrollment_email UNIQUE (enrrollment_id, email);

ALTER TABLE kuntur.enrrollment_phone
  ADD CONSTRAINT u_enrrollment_phone UNIQUE (enrrollment_id, phone_number);

ALTER TABLE kuntur.enrrollment_stakeholder
  ADD CONSTRAINT u_enrrollment_stakeholder UNIQUE (user_system_id, enrrollment_id);

--------------------------------------

--================================================================================================

CREATE OR REPLACE  FUNCTION kuntur.ftg_number_agreement_increment() RETURNS trigger AS $number_increment$
    BEGIN
       
         SELECT INTO NEW.number_agreement coalesce(MAX(number_agreement),0) + 1 
         FROM kuntur.agreement;
         --WHERE 	coalesce(agreement_id,'') = coalesce(NEW.agreement_id,'');
      
        RETURN NEW;
    END;
$number_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_number_agreement_increment BEFORE INSERT ON kuntur.agreement
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_number_agreement_increment();

--================================================================================================

CREATE OR REPLACE  FUNCTION kuntur.ftg_file_number_student_increment() RETURNS trigger AS $file_number_increment$
    BEGIN
       
         SELECT INTO NEW.file_number coalesce(MAX(file_number),0) + 1 
         FROM kuntur.student;
         --WHERE 	coalesce(id,'') = coalesce(NEW.id,'');
      
        RETURN NEW;
    END;
$file_number_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_file_number_student_increment BEFORE INSERT ON kuntur.student
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_file_number_student_increment();

--================================================================================================

-- DROP FUNCTION ftg_file_number_enrollment_increment() CASCADE
CREATE OR REPLACE  FUNCTION kuntur.ftg_number_enrrollment_increment() RETURNS trigger AS $number_enrrollment_increment$
    BEGIN
       
         SELECT INTO NEW.number_enrrollment coalesce(MAX(number_enrrollment),0) + 1 
         FROM 	kuntur.enrrollment;
         --JOIN	kunutur.admission_period ap
	--	ON e.
        -- WHERE 	coalesce(id,'') = coalesce(NEW.id,'');
      
        RETURN NEW;
    END;
$number_enrrollment_increment$ LANGUAGE plpgsql;

--DROP TRIGGER ftg_file_number_enrrollment_increment ON kuntur.enrrollment;
CREATE TRIGGER tg_number_enrollment_increment BEFORE INSERT ON kuntur.enrrollment
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_number_enrrollment_increment();

--================================================================================================

CREATE OR REPLACE  FUNCTION kuntur.ftg_number_admission_period_increment() RETURNS trigger AS $admission_period_increment$
    BEGIN
       
         SELECT INTO NEW.number_admission_period coalesce(MAX(number_admission_period),0) + 1 
         FROM kuntur.admission_period;
         --WHERE 	coalesce(agreement_id,'') = coalesce(NEW.agreement_id,'');
      
        RETURN NEW;
    END;
$admission_period_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_number_admission_period_increment BEFORE INSERT ON kuntur.admission_period
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_number_admission_period_increment();

--================================================================================================

DROP VIEW IF EXISTS kuntur.v_enrrollment_list CASCADE;

CREATE OR REPLACE VIEW kuntur.v_enrrollment_list AS 

SELECT 	e.id,
	e.number_enrrollment,
	ap.id AS admission_period_id,
	ap.year,
	ap.semester,
	--CASE 	WHEN ap.semester = 1 THEN '1er Semestre'::varchar
	--	WHEN ap.semester = 2 THEN '2do Semestre'::varchar
	--	ELSE ''::varchar
	--END AS semester_comment,
	es.id AS enrrollment_status_id,
	'(' || es.code || ') ' || es.name AS enrrollment_status,	
	e.student_id,
	coalesce(e.family_name, '')  || ' ' || coalesce(e.given_name, '') AS student,	
	(SELECT string_agg(x.email, ', ') FROM kuntur.enrrollment_email x WHERE e.id = x.enrrollment_id) AS email,


	COALESCE(birth_country_code, '') || ', ' || COALESCE(o.country_code, '') || ', ' || COALESCE((SELECT string_agg(x.country_code, ', ') FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id), '') AS nationality,

/*
	CASE 	WHEN (SELECT COUNT(x.*) FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id) > 0 AND birth_country_code IS NOT NULL
			THEN birth_country_code || ', ' || (SELECT string_agg(x.country_code, ', ') FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id) 

		WHEN (SELECT COUNT(x.*) FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id) = 0 AND birth_country_code IS NOT NULL
			THEN birth_country_code

		WHEN (SELECT COUNT(x.*) FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id) > 0 AND birth_country_code IS NULL
			THEN (SELECT string_agg(x.country_code, ', ') FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id) 

		ELSE null		
	END AS nationality,
*/
		
	CASE 	WHEN o.original_name IS NULL THEN e.institution_original_name 
		ELSE o.original_name
	END AS institution,
	o.id AS org_institution_id
	
	--,e.* 
FROM 	kuntur.enrrollment e
LEFT JOIN	kuntur.admission_period ap
	ON ap.id = e.admission_period_id
LEFT JOIN	kuntur.enrrollment_status es
	ON es.id = e.enrrollment_status_id	
LEFT JOIN	kuntur.org o
	ON o.id = e.org_id
ORDER BY e.number_enrrollment DESC;


-- SELECT * FROM kuntur.v_enrrollment_list;

-- SELECT * FROM kuntur.user_system;

DROP FUNCTION IF EXISTS kuntur.f_find_enrrollment_list(year INTEGER, semester INTEGER, enrrollment_status_id VARCHAR, 
					nationality_id VARCHAR, student VARCHAR, institution VARCHAR,  number_enrrollment BIGINT, user_system_id VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION kuntur.f_find_enrrollment_list(year INTEGER, semester INTEGER, enrrollment_status_id VARCHAR, 
					nationality_id VARCHAR, student VARCHAR, institution VARCHAR,  number_enrrollment BIGINT, user_system_id VARCHAR) 
	RETURNS SETOF kuntur.v_enrrollment_list AS $$
	
		SELECT 	id, 
			number_enrrollment, 
			admission_period_id, 
			year, 
			semester, 
			enrrollment_status_id, 
			enrrollment_status, 
			student_id, student, 
			email, 
			$4, 
			institution, 
			org_institution_id
					
		FROM 	kuntur.v_enrrollment_list e
		WHERE 	(($1 IS NOT NULL AND $1 = e.year) OR $1 IS NULL)  
			AND (($2 IS NOT NULL AND $2 = e.semester) OR $2 IS NULL)  
			AND (($3 IS NOT NULL AND $3 = e.enrrollment_status_id) OR $3 IS NULL)  

			AND (($4 IS NOT NULL 
				AND trim(lower($4))::varchar ILIKE '%' || e.nationality || '%') OR $4 IS NULL)  
			
			/*
			AND (($4 IS NOT NULL 
				AND trim(lower($4))::varchar IN (SELECT trim(lower(coalesce(x.country_code,'')))::varchar FROM kuntur.enrrollment_nationality x WHERE e.id = x.enrrollment_id)
				) OR $4 IS NULL)  
			*/
				
			AND (
				(
					$5 IS NOT NULL 
					AND  translate(trim(coalesce(e.student::varchar, '')), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')::varchar ILIKE translate( '%' || trim(coalesce($5::varchar, '')) || '%', 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')::varchar 
				)
				OR $5 IS NULL
			)	

			AND (($6 IS NOT NULL 
				AND  translate(trim(coalesce(e.institution::varchar, '')), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')::varchar ILIKE translate( '%' || trim(coalesce($6::varchar, '')) || '%', 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')::varchar ) 
				OR $6 IS NULL)		

			AND (($7 IS NOT NULL AND $7 = e.number_enrrollment) OR $7 IS NULL) 

			AND trim($8)::varchar IN (

				SELECT 	x.user_system_id::varchar
				FROM 	kuntur.enrrollment_stakeholder x 
				WHERE 	x.user_system_id = $8::varchar --(SELECT id FROM kuntur.user_system WHERE name = '46385')--
					AND x.enrrollment_id = e.id --(SELECT id FROM kuntur.enrrollment WHERE number_enrrollment = 272)--
					AND (x.code = 1 OR x.code = 2 OR x.code = 3)	

			)
			
		;
$$ LANGUAGE SQL;


-- SELECT * FROM kuntur.v_enrrollment_list x 
-- SELECT * FROM kuntur.enrrollment_stakeholder 
-- SELECT * FROM kuntur.user_system WHERE name = '46385'
-- SELECT * FROM kuntur.user_system WHERE id = '337fd425-7a91-4df5-b60c-21931bd9bfff'
-- SELECT * FROM kuntur.student WHERE id = '337fd425-7a91-4df5-b60c-21931bd9bfff'
-- SELECT * FROM kuntur.enrrollment_stakeholder WHERE enrrollment_id = '489090264c037dd8014c350fd9070152'


-- SELECT * FROM kuntur.enrrollment_status

SELECT  * FROM  kuntur.f_find_enrrollment_list(null, null, null, null, null, null, null, null);


SELECT  * 
FROM  	kuntur.f_find_enrrollment_list
	(2014, 2, 
	(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = 'k'), 'MEX', 'ria', 
	'autonoma', null, (SELECT id FROM kuntur.user_system WHERE name = '46385')
	);


SELECT  * 
FROM  	kuntur.f_find_enrrollment_list
	(2014, 2, 
	(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = 'k'), 'MEX', 'ria', 
	'autonoma', 298, (SELECT id FROM kuntur.user_system WHERE id = '337fd425-7a91-4df5-b60c-21931bd9bfff')
	);


SELECT  * 
FROM  	kuntur.f_find_enrrollment_list
	(2015, 2, 
	(SELECT x.id FROM kuntur.enrrollment_status x WHERE x.code = 'H'), 'MEX', 'ria', 
	null, null, (SELECT id FROM kuntur.user_system WHERE name = '46385')
	);	

--================================================================================================
