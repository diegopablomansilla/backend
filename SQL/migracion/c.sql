
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

------------------------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM postulation_tmp

DROP TABLE IF EXISTS postulation_a_tmp CASCADE;

CREATE TABLE postulation_a_tmp
(
	  id character varying(255) NOT NULL  UNIQUE,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  is_contract boolean,
	  is_program boolean,
	  home_study_area character varying(255),
	  study_area character varying(255),
	  disease character varying(255),
	  fees_paid real,
	  sanctions integer,
	  creation_date date,
	  insurance boolean,
	  original_documentation boolean,
	  language_certificate boolean,
	  visa character varying(255),
	  career character varying(255),
	  career_subjects integer,
	  approved_subjects integer,
	  subjects_for_study integer,
	  exchange_period character varying(255),
	  subjects_to_recognize text,
	  eri_in boolean,
	  note character varying(255),
	  academic_average real,
	  historic_average real,
	  performance real,
	  teaching real,
	  extension real,
	  proposal real,
	  observation text,
	  
	  period_admission_id character varying(255),
	  year_academic INTEGER,
	  semester INTEGER,	

	  
	  physical_person_id character varying(255),
	  physical_person_in_eri_out_id character varying(255),


	  sys_state_life_cycle_id character varying(255) NOT NULL,
	  code_status VARCHAR NOT NULL,

	  institution_id character varying(255),
	  institution_in_eri_out_id character varying(255),
	  academic_unit_id character varying(255),
	  contract_id character varying(255),
	  exchange_program_id character varying(255),
	  study_program_id character varying(255),
	  academic_perform_id character varying(255),
	  sys_file_university_credential_id character varying(255),
	  sys_file_analytical_id character varying(255),
	  sys_file_passport_id character varying(255),
	  sys_file_language_certificate_id character varying(255),
	  sys_file_cv_id character varying(255),
	  sys_file_psychophysical_certificate_id character varying(255),
	  sys_file_postulation_letter_id character varying(255),
	  sys_file_acceptance_letter_id character varying(255),
	  sys_file_acceptance_letter_mail_id character varying(255),
	  sys_file_academic_certificate_id character varying(255),
	  sys_file_regular_student_certificate_id character varying(255),
	  sys_file_cv_certificate_id character varying(255),
	  sys_file_arrival_certificate_id character varying(255),
	  sys_file_intermediate_report_id character varying(255),
	  sys_file_final_report_id character varying(255),
	  sys_file_study_contract_id character varying(255),
	  sys_file_analytical_certificate_id character varying(255),
	  sys_file_analytical_certificate_mail_id character varying(255),
	  sys_file_program_id character varying(255),
	  participation real,
	  modified_note character varying(255)
);



INSERT INTO postulation_a_tmp (

			SELECT  p.id, 
				p.state_enable, 
				p.name, 
				p.comment, 
				p.is_contract, 
				p.is_program, 
				p.home_study_area, 
			        p.study_area, 
			        p.disease, 
			        p.fees_paid, 
			        p.sanctions, 
			        p.creation_date, 
			        p.insurance, 
			        p.original_documentation, 
			        p.language_certificate, 
			        p.visa, 
			        p.career, 
			        p.career_subjects, 
			        p.approved_subjects, 
			        p.subjects_for_study, 
			        p.exchange_period, 
			        p.subjects_to_recognize, 
			        p.eri_in, 
			        p.note, 
			        p.academic_average, 
			        p.historic_average, 
			        p.performance, 
			        p.teaching, 
			        p.extension, 
			        p.proposal, 
			        p.observation, 

			        p.period_admission_id, 
			        pa.year_academic,
			        CASE WHEN pa.semester1 = true THEN 1 ELSE 2 END AS semester,	
			       
			        p.physical_person_id, 
			        p.physical_person_in_eri_out_id, 

			        p.sys_state_life_cycle_id, 
				(SELECT code FROM v_enrrollment_status_map x WHERE x.number_code = sys_state_life_cycle_id)::VARCHAR AS code_status,
			       

			        p.institution_id, 
			        p.institution_in_eri_out_id, 
			        p.academic_unit_id, 
			        p.contract_id, 
			        p.exchange_program_id, 
			        p.study_program_id, 
			        p.academic_perform_id, 
			        p.sys_file_university_credential_id, 
			        p.sys_file_analytical_id, 
			        p.sys_file_passport_id, 
			        p.sys_file_language_certificate_id, 
			        p.sys_file_cv_id, 
			        p.sys_file_psychophysical_certificate_id, 
			        p.sys_file_postulation_letter_id, 
			        p.sys_file_acceptance_letter_id, 
			        p.sys_file_acceptance_letter_mail_id, 
			        p.sys_file_academic_certificate_id, 
			        p.sys_file_regular_student_certificate_id, 
			        p.sys_file_cv_certificate_id, 
			        p.sys_file_arrival_certificate_id, 
			        p.sys_file_intermediate_report_id, 
			        p.sys_file_final_report_id, 
			        p.sys_file_study_contract_id, 
			        p.sys_file_analytical_certificate_id, 
			        p.sys_file_analytical_certificate_mail_id, 
			        p.sys_file_program_id, 
			        p.participation, 
			        p.modified_note
			FROM 	postulation_tmp p 
			LEFT JOIN period_admission pa
				ON pa.id = p.period_admission_id
			WHERE 	p.physical_person_id IS NOT NULL 
				AND p.sys_state_life_cycle_id <> '267'
				AND p.sys_state_life_cycle_id IS NOT NULL
				AND p.state_enable <> false
);

-- SELECT COUNT(*) FROM postulation_a_tmp; -- 1128
-- SELECT * FROM postulation_a_tmp;

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM physical_person_b_tmp
-- SELECT * FROM physical_person_b_tmp WHERE id = physical_person_id
-- SELECT * FROM physical_person_distinct_tmp

-- SELECT *  FROM kuntur.person_identity

DROP VIEW IF EXISTS v_p_pi CASCADE;

CREATE OR REPLACE VIEW v_p_pi AS

	SELECT 	p.id,
		p.given_name,
		p.family_name,		
		(SELECT pi.identity_number FROM kuntur.person_identity pi WHERE p.id = pi.person_id) AS identity_number
		--(SELECT pu.email FROM kuntur.user_system pu WHERE p.id = pu.id) AS email
	FROM 	kuntur.person p;
	
-- SELECT COUNT(*) FROM v_p_pi; -- 1172
-- SELECT * FROM v_p_pi;

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT COUNT(*) FROM postulation_a_tmp; -- 1292
-- SELECT * FROM postulation_a_tmp;

DROP VIEW IF EXISTS v_postulation_person_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_person_tmp AS

	SELECT 	pp.name AS given_name,
		pp.last_name AS family_name,
		pp.identification_number AS identity_number,
		p.*
	FROM 	postulation_a_tmp p
	JOIN	physical_person_b_tmp pp
		ON pp.id = p.physical_person_id;

-- SELECT COUNT(*) FROM v_postulation_person_tmp; -- 1289
-- SELECT * FROM v_postulation_person_tmp;		

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT COUNT(*) FROM postulation_a_tmp; -- 1292
-- SELECT * FROM postulation_a_tmp;

DROP VIEW IF EXISTS v_postulation_person_b_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_person_b_tmp AS

	SELECT 	p.*,		
		pp.id AS person_id,
		pp.given_name AS person_given_name,
		pp.family_name AS person_family_name,
		pp.identity_number AS person_identity_number
	FROM 	v_postulation_person_tmp p
	JOIN	v_p_pi pp
		ON COALESCE(pp.given_name, '') ILIKE COALESCE(p.given_name, '')
		AND COALESCE(pp.family_name, '') ILIKE COALESCE(p.family_name, '')
		AND COALESCE(pp.identity_number, '') ILIKE COALESCE(p.identity_number, '');

-- SELECT COUNT(*) FROM v_postulation_person_b_tmp; -- 1286
-- SELECT * FROM v_postulation_person_b_tmp;		
-- SELECT * FROM v_postulation_person_b_tmp WHERE person_id IS NULL;	

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM postulation_tmp

DROP TABLE IF EXISTS postulation_b_tmp CASCADE;

CREATE TABLE postulation_b_tmp
(
	  id character varying(255) NOT NULL  UNIQUE,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  is_contract boolean,
	  is_program boolean,
	  home_study_area character varying(255),
	  study_area character varying(255),
	  disease character varying(255),
	  fees_paid real,
	  sanctions integer,
	  creation_date date,
	  insurance boolean,
	  original_documentation boolean,
	  language_certificate boolean,
	  visa character varying(255),
	  career character varying(255),
	  career_subjects integer,
	  approved_subjects integer,
	  subjects_for_study integer,
	  exchange_period character varying(255),
	  subjects_to_recognize text,
	  eri_in boolean,
	  note character varying(255),
	  academic_average real,
	  historic_average real,
	  performance real,
	  teaching real,
	  extension real,
	  proposal real,
	  observation text,
	  
	  period_admission_id character varying(255),
	  year_academic INTEGER,
	  semester INTEGER,
	  
	  physical_person_id character varying(255),
	  family_name VARCHAR,
	  given_name VARCHAR,
	  identity_number VARCHAR,	  
	  
	  physical_person_in_eri_out_id character varying(255),


	  sys_state_life_cycle_id character varying(255) NOT NULL,
	  code_status VARCHAR NOT NULL,

	  institution_id character varying(255),
	  institution_in_eri_out_id character varying(255),
	  academic_unit_id character varying(255),
	  contract_id character varying(255),
	  exchange_program_id character varying(255),
	  study_program_id character varying(255),
	  academic_perform_id character varying(255),
	  sys_file_university_credential_id character varying(255),
	  sys_file_analytical_id character varying(255),
	  sys_file_passport_id character varying(255),
	  sys_file_language_certificate_id character varying(255),
	  sys_file_cv_id character varying(255),
	  sys_file_psychophysical_certificate_id character varying(255),
	  sys_file_postulation_letter_id character varying(255),
	  sys_file_acceptance_letter_id character varying(255),
	  sys_file_acceptance_letter_mail_id character varying(255),
	  sys_file_academic_certificate_id character varying(255),
	  sys_file_regular_student_certificate_id character varying(255),
	  sys_file_cv_certificate_id character varying(255),
	  sys_file_arrival_certificate_id character varying(255),
	  sys_file_intermediate_report_id character varying(255),
	  sys_file_final_report_id character varying(255),
	  sys_file_study_contract_id character varying(255),
	  sys_file_analytical_certificate_id character varying(255),
	  sys_file_analytical_certificate_mail_id character varying(255),
	  sys_file_program_id character varying(255),
	  participation real,
	  modified_note character varying(255)
);


INSERT INTO postulation_b_tmp (

			SELECT p.id, 
			       p.state_enable, 
			       p.name, 
			       p.comment, 
			       p.is_contract, 
			       p.is_program, 
			       p.home_study_area, 
			       p.study_area, 
			       p.disease, 
			       p.fees_paid, 
			       p.sanctions, 
			       p.creation_date, 
			       p.insurance, 
			       p.original_documentation, 
			       p.language_certificate, 
			       p.visa, 
			       p.career, 
			       p.career_subjects, 
			       p.approved_subjects, 
			       p.subjects_for_study, 
			       p.exchange_period, 
			       p.subjects_to_recognize, 
			       p.eri_in, 
			       p.note, 
			       p.academic_average, 
			       p.historic_average, 
			       p.performance, 
			       p.teaching, 
			       p.extension, 
			       p.proposal, 
			       p.observation, 
			       p.period_admission_id, 
			       p.year_academic,
			       p.semester,
			       
			       p.person_id AS physical_person_id,
			       p.person_family_name AS family_name,
			       p.person_given_name AS given_name, 
			       p.person_identity_number AS identity_number,
			       
			       p.physical_person_in_eri_out_id,
			       
			       p.sys_state_life_cycle_id, 
			       p.code_status,			       

			       p.institution_id, 
			       p.institution_in_eri_out_id, 
			       p.academic_unit_id, 
			       p.contract_id, 
			       p.exchange_program_id, 
			       p.study_program_id, 
			       p.academic_perform_id, 
			       
			       p.sys_file_university_credential_id, 
			       p.sys_file_analytical_id, 
			       p.sys_file_passport_id, 
			       p.sys_file_language_certificate_id, 
			       p.sys_file_cv_id, 
			       p.sys_file_psychophysical_certificate_id, 
			       p.sys_file_postulation_letter_id, 
			       p.sys_file_acceptance_letter_id, 
			       p.sys_file_acceptance_letter_mail_id, 
			       p.sys_file_academic_certificate_id, 
			       p.sys_file_regular_student_certificate_id, 
			       p.sys_file_cv_certificate_id, 
			       p.sys_file_arrival_certificate_id, 
			       p.sys_file_intermediate_report_id, 
			       p.sys_file_final_report_id, 
			       p.sys_file_study_contract_id, 
			       p.sys_file_analytical_certificate_id, 
			       p.sys_file_analytical_certificate_mail_id, 
			       p.sys_file_program_id, 
			       
			       p.participation, 
			       p.modified_note
			FROM   v_postulation_person_b_tmp p 
			
);

-- SELECT COUNT(*) FROM postulation_b_tmp; -- 1286
-- SELECT * FROM postulation_b_tmp;
	
------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM postulation_tmp

DROP TABLE IF EXISTS postulation_c_tmp CASCADE;

CREATE TABLE postulation_c_tmp
(
	  id character varying(255) NOT NULL  UNIQUE,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  is_contract boolean,
	  is_program boolean,
	  home_study_area character varying(255),
	  study_area character varying(255),
	  disease character varying(255),
	  fees_paid real,
	  sanctions integer,
	  creation_date date,
	  insurance boolean,
	  original_documentation boolean,
	  language_certificate boolean,
	  visa character varying(255),
	  career character varying(255),
	  career_subjects integer,
	  approved_subjects integer,
	  subjects_for_study integer,
	  exchange_period character varying(255),
	  subjects_to_recognize text,
	  eri_in boolean,
	  note character varying(255),
	  academic_average real,
	  historic_average real,
	  performance real,
	  teaching real,
	  extension real,
	  proposal real,
	  observation text,
	  
	  period_admission_id character varying(255),
	  year_academic INTEGER,
	  semester INTEGER,
	  
	  physical_person_id character varying(255),	  
	  
	  physical_person_in_eri_out_id character varying(255),

	  sys_state_life_cycle_id character varying(255) NOT NULL,
	  code_status VARCHAR NOT NULL,
	  code_status_max VARCHAR NOT NULL,

	  institution_id character varying(255),
	  institution_in_eri_out_id character varying(255),
	  academic_unit_id character varying(255),
	  contract_id character varying(255),
	  exchange_program_id character varying(255),
	  study_program_id character varying(255),
	  academic_perform_id character varying(255),
	  sys_file_university_credential_id character varying(255),
	  sys_file_analytical_id character varying(255),
	  sys_file_passport_id character varying(255),
	  sys_file_language_certificate_id character varying(255),
	  sys_file_cv_id character varying(255),
	  sys_file_psychophysical_certificate_id character varying(255),
	  sys_file_postulation_letter_id character varying(255),
	  sys_file_acceptance_letter_id character varying(255),
	  sys_file_acceptance_letter_mail_id character varying(255),
	  sys_file_academic_certificate_id character varying(255),
	  sys_file_regular_student_certificate_id character varying(255),
	  sys_file_cv_certificate_id character varying(255),
	  sys_file_arrival_certificate_id character varying(255),
	  sys_file_intermediate_report_id character varying(255),
	  sys_file_final_report_id character varying(255),
	  sys_file_study_contract_id character varying(255),
	  sys_file_analytical_certificate_id character varying(255),
	  sys_file_analytical_certificate_mail_id character varying(255),
	  sys_file_program_id character varying(255),
	  participation real,
	  modified_note character varying(255)
);


INSERT INTO postulation_c_tmp (

			SELECT p.id, 
			       p.state_enable, 
			       p.name, 
			       p.comment, 
			       p.is_contract, 
			       p.is_program, 
			       p.home_study_area, 
			       p.study_area, 
			       p.disease, 
			       p.fees_paid, 
			       p.sanctions, 
			       p.creation_date, 
			       p.insurance, 
			       p.original_documentation, 
			       p.language_certificate, 
			       p.visa, 
			       p.career, 
			       p.career_subjects, 
			       p.approved_subjects, 
			       p.subjects_for_study, 
			       p.exchange_period, 
			       p.subjects_to_recognize, 
			       p.eri_in, 
			       p.note, 
			       p.academic_average, 
			       p.historic_average, 
			       p.performance, 
			       p.teaching, 
			       p.extension, 
			       p.proposal, 
			       p.observation, 
			       
			       p.period_admission_id, 
			       p.year_academic,
			       p.semester,
			       
			       p.physical_person_id, 			     
			       
			       p.physical_person_in_eri_out_id,
			       
			       p.sys_state_life_cycle_id, 
			       p.code_status,		

				(

					SELECT 	MAX(x.code_status)
					FROM 	postulation_b_tmp x 					
					WHERE 	COALESCE(x.family_name, '') = COALESCE(p.family_name, '')
						AND COALESCE(x.given_name, '') = COALESCE(p.given_name, '')
						AND COALESCE(x.identity_number, '') = COALESCE(p.identity_number, '')
						--AND x.email = v.email
						AND x.year_academic = p.year_academic
						AND x.semester = p.semester					

				) AS code_status_max,
			       	       

			       p.institution_id, 
			       p.institution_in_eri_out_id, 
			       p.academic_unit_id, 
			       p.contract_id, 
			       p.exchange_program_id, 
			       p.study_program_id, 
			       p.academic_perform_id, 
			       p.sys_file_university_credential_id, 
			       p.sys_file_analytical_id, 
			       p.sys_file_passport_id, 
			       p.sys_file_language_certificate_id, 
			       p.sys_file_cv_id, 
			       p.sys_file_psychophysical_certificate_id, 
			       p.sys_file_postulation_letter_id, 
			       p.sys_file_acceptance_letter_id, 
			       p.sys_file_acceptance_letter_mail_id, 
			       p.sys_file_academic_certificate_id, 
			       p.sys_file_regular_student_certificate_id, 
			       p.sys_file_cv_certificate_id, 
			       p.sys_file_arrival_certificate_id, 
			       p.sys_file_intermediate_report_id, 
			       p.sys_file_final_report_id, 
			       p.sys_file_study_contract_id, 
			       p.sys_file_analytical_certificate_id, 
			       p.sys_file_analytical_certificate_mail_id, 
			       p.sys_file_program_id, 
			       p.participation, 
			       p.modified_note
			       
			FROM   postulation_b_tmp p
			 
			
			
);

-- SELECT COUNT(*) FROM postulation_c_tmp; -- 1117
-- SELECT * FROM postulation_c_tmp;

DELETE FROM postulation_c_tmp WHERE code_status <> code_status_max;

-- SELECT COUNT(*) FROM postulation_c_tmp; -- 1117
-- SELECT * FROM postulation_c_tmp;
-- SELECT * FROM postulation_c_tmp WHERE state_enable = false;

------------------------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------------------------

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

-- SELECT DISTINCT * FROM v_admission_period_a ORDER BY year, semester;

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

-- SELECT * FROM v_admission_period;

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

INSERT INTO kuntur.admission_period (SELECT * FROM admission_period_tmp ORDER BY year, semester);

-- SELECT * FROM kuntur.admission_period;	
	
------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_enrrollment CASCADE;

CREATE OR REPLACE VIEW v_enrrollment AS

	SELECT 	p.id::VARCHAR AS id, 
		false::BOOLEAN AS erased, 
		pp.given_name::VARCHAR AS given_name, 
		pp.middle_name::VARCHAR AS middle_name, 
		pp.family_name::VARCHAR AS family_name, 
		pp.birth_date::DATE AS birth_date, 
		pp.male::BOOLEAN AS male, 
		pp.url_photo::VARCHAR AS url_photo, 
		pp.comment::VARCHAR AS comment, 
		pp.birth_country_code::VARCHAR AS birth_country_code, 
		pp.birth_admin_area_level1_code::VARCHAR AS birth_admin_area_level1_code, 
		pp.birth_admin_area_level2::VARCHAR AS birth_admin_area_level2, 
		pp.birth_locality::VARCHAR AS birth_locality, 
		pp.birth_lat::double precision AS birth_lat, 
		pp.birth_lng::double precision AS birth_lng, 
		s.institution_original_name::VARCHAR AS institution_original_name, 
		s.institution_web_site::VARCHAR AS institution_web_site, 
		s.institution_country_code::VARCHAR AS institution_country_code, 
		null::BIGINT AS number_enrrollment, 
		null::TIMESTAMP AS check_out_date, 
		s.org_id::VARCHAR AS org_id, 
		null::VARCHAR AS user_system_id, 
		s.id::VARCHAR AS student_id, 
		period_admission_id::VARCHAR AS admission_period_id, 
		es.id::VARCHAR AS enrrollment_status_id
	FROM 	postulation_c_tmp p	
	JOIN	kuntur.person pp
		ON pp.id = p.physical_person_id
	JOIN	kuntur.student s
		ON s.id = pp.id
	JOIN	kuntur.enrrollment_status es 
		ON es.code = p.code_status
	JOIN	kuntur.admission_period ap
		ON ap.id = p.period_admission_id		
	WHERE	p.state_enable <> false;

-- SELECT * FROM kuntur.enrrollment_status
-- SELECT * FROM kuntur.admission_period
-- SELECT * FROM postulation where id = '000000003f3499ea013f43e7de47006f'
-- SELECT * FROM postulation_c_tmp where id = '000000003f3499ea013f43e7de47006f'

-- SELECT COUNT(*) FROM v_enrrollment; -- 927
-- SELECT * FROM v_enrrollment;

----------------------------------------------------------------------------------------------------------------------------------------------------					

INSERT INTO kuntur.enrrollment (SELECT * FROM v_enrrollment);

-- SELECT COUNT(*) FROM kuntur.enrrollment; -- 940
-- SELECT * FROM kuntur.enrrollment;

----------------------------------------------------------------------------------------------------------------------------------------------------					


DROP VIEW IF EXISTS v_enrrollment_identity CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_identity AS

	SELECT 	pi.id AS id,
		pi.erased AS erased, 
		pi.identity_number AS identity_number, 
		pi.code AS code, 
		pi.name AS name, 
		CASE WHEN pi.country_code IS NULL THEN 'Sin Especificar' ELSE pi.country_code END AS country_code, 
		pi.comment AS comment, 
		e.id AS enrrollment_id, 
		pi.person_identity_type_id AS person_identity_type_id
	FROM 	kuntur.person_identity pi
	JOIN	kuntur.enrrollment e
		ON pi.person_id = e.student_id;

-- SELECT COUNT(*) FROM v_enrrollment_identity; -- 940
-- SELECT * FROM v_enrrollment_identity;
	
----------------------------------------------------------------------------------------------------------------------------------------------------					
/*

SELECT * FROM v_enrrollment_identity v WHERE v.identity_number IN (

	SELECT x.identity_number FROM v_enrrollment_identity x GROUP BY x.identity_number, x.country_code HAVING COUNT(x.*) > 1
) ORDER BY enrrollment_id, identity_number, country_code; 

*/

INSERT INTO kuntur.enrrollment_identity (

		SELECT 	uuid_generate_v4()::VARCHAR AS id, 
			erased, 
			identity_number, 
			code, 
			name, 
			country_code, 
			comment, 
			enrrollment_id, 
			person_identity_type_id 
		FROM 	v_enrrollment_identity);

-- SELECT COUNT(*) FROM kuntur.enrrollment_identity; -- 927
-- SELECT * FROM kuntur.enrrollment_identity;

----------------------------------------------------------------------------------------------------------------------------------------------------					


DROP VIEW IF EXISTS v_enrrollment_nationality CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_nationality AS

	SELECT 	pn.id AS id, 
		pn.erased AS erased, 
		pn.country_code AS country_code, 
		pn.comment AS comment, 
		e.id AS enrrollment_id
	FROM 	kuntur.person_nationality pn
	JOIN	kuntur.enrrollment e
		ON pn.person_id = e.student_id;

-- SELECT COUNT(*) FROM v_enrrollment_nationality; -- 842
-- SELECT * FROM v_enrrollment_nationality;
	
----------------------------------------------------------------------------------------------------------------------------------------------------					

INSERT INTO kuntur.enrrollment_nationality (

		SELECT 	uuid_generate_v4()::VARCHAR AS id, 
			erased, 
			country_code, 
			comment, 
			enrrollment_id
		FROM 	v_enrrollment_nationality
);

-- SELECT COUNT(*) FROM kuntur.enrrollment_nationality; -- 842
-- SELECT * FROM kuntur.enrrollment_nationality;

----------------------------------------------------------------------------------------------------------------------------------------------------					


DROP VIEW IF EXISTS v_enrrollment_email CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_email AS

	SELECT 	pe.id AS id, 
		pe.erased AS erased, 
		pe.email AS email, 
		pe.comment AS comment, 
		e.id AS enrrollment_id
	FROM 	kuntur.person_email pe
	JOIN	kuntur.enrrollment e
		ON pe.person_id = e.student_id;

-- SELECT COUNT(*) FROM v_enrrollment_email; -- 1059
-- SELECT * FROM v_enrrollment_email;
	
----------------------------------------------------------------------------------------------------------------------------------------------------					

INSERT INTO kuntur.enrrollment_email (

		SELECT 	uuid_generate_v4()::VARCHAR AS id, 
			erased, 
			email, 
			comment, 
			enrrollment_id
		FROM 	v_enrrollment_email
);

-- SELECT COUNT(*) FROM kuntur.enrrollment_email; -- 1059
-- SELECT * FROM kuntur.enrrollment_email;

----------------------------------------------------------------------------------------------------------------------------------------------------					


DROP VIEW IF EXISTS v_enrrollment_phone CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_phone AS

	SELECT 	ph.id AS id, 
		ph.erased AS erased, 
		CASE WHEN ph.country_code IS NULL THEN 'Sin Especificar' ELSE ph.country_code END AS country_code, 
		ph.phone_number AS phone_number, 
		ph.comment AS comment, 
		e.id AS enrrollment_id
	FROM 	kuntur.person_phone ph
	JOIN	kuntur.enrrollment e
		ON ph.person_id = e.student_id;

-- SELECT COUNT(*) FROM v_enrrollment_phone; -- 2149
-- SELECT * FROM v_enrrollment_phone;
	
----------------------------------------------------------------------------------------------------------------------------------------------------					

INSERT INTO kuntur.enrrollment_phone (

		SELECT 	uuid_generate_v4()::VARCHAR AS id, 
			erased, 
			country_code, 
			phone_number,
			comment, 
			enrrollment_id
		FROM 	v_enrrollment_phone
);

-- SELECT COUNT(*) FROM kuntur.enrrollment_phone; -- 2149
-- SELECT * FROM kuntur.enrrollment_phone;

----------------------------------------------------------------------------------------------------------------------------------------------------					

DROP VIEW IF EXISTS v_enrrollment_address CASCADE;

CREATE OR REPLACE VIEW v_enrrollment_address AS

	SELECT 	pa.id, 
		pa.erased, 		
		CASE WHEN pa.country_code IS NULL THEN 'Sin Especificar' ELSE pa.country_code END AS country_code, 
		pa.admin_area_level1_code, 
		pa.admin_area_level2, 
		CASE WHEN pa.locality IS NULL THEN 'Sin Especificar' ELSE pa.locality END AS locality,		 
		pa.neighbourhood, 
		pa.street, 
		pa.street_number, 
		pa.building_floor, 
		pa.building_room, 
		pa.building, 
		CASE WHEN pa.postal_code IS NULL THEN 'Sin Especificar' ELSE pa.postal_code END AS postal_code, 		
		pa.comment, 
		pa.lat, 
		pa.lng, 
		e.id AS enrrollment_id
	FROM 	kuntur.person_address pa
	JOIN	kuntur.enrrollment e
		ON pa.person_id = e.student_id;

-- SELECT COUNT(*) FROM v_enrrollment_address; -- 1058
-- SELECT * FROM v_enrrollment_address;

----------------------------------------------------------------------------------------------------------------------------------------------------					

INSERT INTO kuntur.enrrollment_address (

		SELECT 	uuid_generate_v4()::VARCHAR AS id, 
			erased, 
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
			enrrollment_id
		FROM 	v_enrrollment_address
);

-- SELECT COUNT(*) FROM kuntur.enrrollment_address; -- 1058
-- SELECT * FROM kuntur.enrrollment_address;

----------------------------------------------------------------------------------------------------------------------------------------------------	


DROP VIEW IF EXISTS v_unc_in_enrrollment CASCADE;

CREATE OR REPLACE VIEW v_unc_in_enrrollment AS

	SELECT	p.id::VARCHAR AS id, 
		false::BOOLEAN AS erased, 
		CASE WHEN p.is_contract IS NULL THEN false::boolean ELSE p.is_contract::boolean END AS is_contract, 
		CASE WHEN p.is_program IS NULL THEN false::boolean ELSE p.is_program::boolean END AS is_program, 
		CASE WHEN p.fees_paid IS NULL THEN 0::double precision ELSE p.fees_paid::double precision END AS amount_paid, 			
		CASE WHEN p.original_documentation IS NULL THEN false::boolean ELSE p.original_documentation::boolean END AS original_doc, 
		CASE WHEN p.insurance IS NULL THEN false::boolean ELSE p.insurance::boolean END AS insurance, 
		CASE WHEN p.language_certificate IS NULL THEN false::boolean ELSE p.language_certificate::boolean END AS language_certificate, 	
		p.visa AS visa, 
		null::VARCHAR AS emergency_contact, 
		null::VARCHAR AS credential_code, 
		p.sys_file_analytical_id AS url_origininal_transcript, 
	        p.sys_file_passport_id AS url_passport, 
	        p.sys_file_language_certificate_id AS url_language_certificate, 
	        p.sys_file_cv_id AS url_cv, 	        
	        p.sys_file_postulation_letter_id AS url_application_letter, 
	        p.sys_file_psychophysical_certificate_id AS url_certificate_psychophysical, 
	        p.sys_file_acceptance_letter_id AS url_admission_act, --Generación Dinamica
	        p.sys_file_acceptance_letter_mail_id AS url_admission_act_template, --Generación Dinamica
	        p.sys_file_analytical_certificate_id AS url_transcript, --Generación Dinamica
	        p.sys_file_analytical_certificate_mail_id AS url_transcript_template, --Generación Dinamica
		null::VARCHAR AS url_university_credential, -- Se pide una vez al ws y se almacena
		p.sys_file_intermediate_report_id AS url_student_report, -- Generación Dinamica
	        p.sys_file_program_id AS url_exchange_form, -- falta averiguar cual es Formulario de Intercambio		
		p.comment AS comment, 
		p.observation AS observation, 
		p.creation_date AS creation_date_postulation, 
		
		c.name AS agreement_name, 
		c.comment AS agreement_comment, 
		c.number_students::INTEGER AS agreement_number_students, 
		i.name AS agreement_org, 
		i.comment AS agreement_org_comment, 
		u.name AS agreement_academic_unit, 

		ep.name AS exchange_program_name,
		ep.comment AS exchange_program_comment,
		ep.number_students AS exchange_program_number_students,
		ep.initial_number_students AS exchange_program_initial_number_students
		
	FROM 	postulation_c_tmp p
	JOIN	kuntur.enrrollment e
		ON e.id = p.id
	LEFT JOIN  contract_tmp c 
		ON c.id = p.contract_id
	LEFT JOIN institution_tmp i 
		ON i.id = c.institution_id	
	LEFT JOIN academic_unit_tmp u 
		ON u.id = c.academic_unit_id
	LEFT JOIN exchange_program_tmp ep
		ON ep.id = p.exchange_program_id;	

-- SELECT COUNT(*) FROM v_unc_in_enrrollment; -- 927
-- SELECT * FROM v_unc_in_enrrollment;

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.unc_in_enrrollment ( SELECT * FROM v_unc_in_enrrollment );

-- SELECT COUNT(*) FROM kuntur.unc_in_enrrollment; -- 927
-- SELECT * FROM kuntur.unc_in_enrrollment;


----------------------------------------------------------------------------------------------------------------------------------------------------	

-- ======================================================================================


-- SELECT * FROM model.academic_unit au
-- SELECT * FROM nahuel_academic_unit_tmp
-- SELECT * FROM kuntur.org

---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS v_org_f CASCADE;

CREATE OR REPLACE VIEW v_org_f AS

		SELECT	au.code_b::VARCHAR AS id, 
			false::BOOLEAN AS erased, 
			au.short_name AS short_name, 			
			au.name AS name, 
			au.name AS original_name, 
			null::VARCHAR AS photo_url, 
			au.code_b::VARCHAR AS web_site, 
			null::VARCHAR AS comment, 
			'ARG'::VARCHAR AS country_code, 
			false::BOOLEAN AS primary_org, 
			au.code::INTEGER AS code_ona,
			au.code_b::VARCHAR AS code_guarani,
			au.au_type_id::VARCHAR AS org_type_id,
			(SELECT x.code_b FROM model.academic_unit x WHERE x.id = au.academic_unit_parent_id)::VARCHAR AS org_id
			--CASE 	WHEN au.academic_unit_parent_id IS NOT NULL THEN (SELECT x.code_b FROM model.academic_unit x WHERE x.id = au.academic_unit_parent_id)::varchar 
			--	ELSE (SELECT id FROM kuntur.org x WHERE x.web_site = 'www.unc.edu.ar')::varchar 
			--END AS org_id			
		FROM	nahuel_academic_unit_tmp au		
		ORDER BY au.name;

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
		FROM	academic_unit_tmp au
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

-- SELECT COUNT(*) FROM kuntur.org WHERE org_id IS NOT NULL; -- 39
-- SELECT * FROM kuntur.org WHERE org_id IS NOT NULL;

----------------------------------------------------------------------------------------------------------------------------------------------------	

DROP VIEW IF EXISTS v_unc_in_study_program CASCADE;

CREATE OR REPLACE VIEW v_unc_in_study_program AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::BOOLEAN AS erased,
--			REPLACE(TRIM(c.subjects), '
--', '|')::varchar AS subjects,
			sp.approved::BOOLEAN AS approved, 			
			null::VARCHAR AS approved_by,	
			TRIM(c.guarani)::VARCHAR AS file_number,
			REPLACE(TRIM(c.subjects), '
', '|')::varchar AS comment,
			p.id AS unc_in_enrrollment_id,
			TRIM(c.academic_unit_id)::VARCHAR AS org_id
		FROM 	postulation_c_tmp p
		JOIN	kuntur.enrrollment e
			ON e.id = p.id
		JOIN 	study_program sp 
			ON TRIM(sp.id)::VARCHAR = TRIM(p.study_program_id)::VARCHAR	
		JOIN	study_program_chosen_academic_unit_in_eri_in_list spt
			ON sp.id::VARCHAR = spt.study_program_id::VARCHAR
		JOIN	chosen_academic_unit_in_eri_in c
			ON c.id::VARCHAR = spt.chosen_academic_unit_in_eri_in_id::VARCHAR
		JOIN	academic_unit_tmp au
			ON au.id::VARCHAR = c.academic_unit_id::VARCHAR	
		WHERE 	sp.state_enable = true	
		ORDER BY p.id, spt.order_number;	

-- SELECT * FROM v_unc_in_study_program;
-- SELECT * FROM v_unc_in_study_program WHERE org_id IS NULL;

DROP TABLE IF EXISTS unc_in_study_program_tmp CASCADE;

CREATE TABLE unc_in_study_program_tmp
(
	  id character varying NOT NULL UNIQUE,
	  erased boolean NOT NULL,
	  --subjects character varying NOT NULL,
	  approved boolean,
	  approved_by character varying,
	  file_number character varying,
	  comment character varying,
	  unc_in_enrrollment_id character varying NOT NULL,
	  org_id character varying NOT NULL  
);


INSERT INTO unc_in_study_program_tmp (SELECT * FROM v_unc_in_study_program WHERE comment IS NOT NULL);

UPDATE unc_in_study_program_tmp SET id = null WHERE char_length(trim(id)) = 0;
--UPDATE unc_in_study_program_tmp SET subjects = null WHERE char_length(trim(subjects)) = 0;
UPDATE unc_in_study_program_tmp SET file_number = null WHERE char_length(trim(file_number)) = 0;
UPDATE unc_in_study_program_tmp SET unc_in_enrrollment_id = null WHERE char_length(trim(unc_in_enrrollment_id)) = 0;
UPDATE unc_in_study_program_tmp SET org_id = null WHERE char_length(trim(org_id)) = 0;

-- SELECT COUNT(*) FROM unc_in_study_program_tmp; -- 1037
-- SELECT * FROM unc_in_study_program_tmp;

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.unc_in_study_program (SELECT * FROM unc_in_study_program_tmp);

-- SELECT COUNT(*) FROM kuntur.unc_in_study_program; -- 1018
-- SELECT * FROM kuntur.unc_in_study_program;

----------------------------------------------------------------------------------------------------------------------------------------------------	


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

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

----------------------------------------------------------------------------------------------------------------------------------------------------	

 

DROP VIEW IF EXISTS v_unc_in_academic_performance CASCADE;

CREATE OR REPLACE VIEW v_unc_in_academic_performance AS

		SELECT 	uuid_generate_v4()::varchar AS id,
			false::boolean AS erased,
			trim(s.name)::varchar AS subject,
			s.hours AS hs, 
			p.id AS unc_in_enrrollment_id,
			(SELECT gs.id FROM kuntur.unc_in_grading_scale gs WHERE s.note_in_numbers = gs.rate_number)::varchar AS unc_in_grading_scale_id, 
			(SELECT st.id FROM kuntur.unc_in_studied_type st WHERE s.semester = st.code)::varchar AS unc_in_studied_type_id, 			
			trim(s.academic_unit_id)::varchar AS org_id
		FROM 	postulation_c_tmp p
		JOIN	kuntur.enrrollment e
			ON e.id = p.id	
		JOIN 	academic_perform ap 
			ON trim(ap.id)::varchar = trim(p.academic_perform_id)::varchar	
		JOIN	academic_perform_subject_list apsl
			ON ap.id::varchar = apsl.academic_perform_id::varchar
		JOIN	subject s
			ON s.id::varchar = apsl.subject_id::varchar
		JOIN	academic_unit au
			ON au.id::varchar = s.academic_unit_id::varchar	
		WHERE 	ap.state_enable = true	
		ORDER BY p.id, apsl.order_number;	

		
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

-- DROP VIEW IF EXISTS v_act_id_user CASCADE;
-- SELECT * FROM act_id_user_tmp;	

CREATE OR REPLACE VIEW 	v_act_id_user AS 

	SELECT 	trim(u.id)::varchar AS id_user,
		lower(trim(u.email))::varchar AS email,
		initcap(lower(trim(u.last)))::varchar AS last,
		initcap(lower(trim(u.first)))::varchar AS first,
		trim(u.pwd)::varchar AS pwd,
		trim(m.group_id_)::varchar AS group_id
	FROM 	act_id_user_tmp u	
	JOIN	act_id_membership m
		ON trim(u.id)::varchar = trim(m.user_id_)::varchar
		AND trim(m.group_id_)::varchar <> 'admin'
		AND trim(m.group_id_)::varchar <> 'eri-in'
	WHERE 	trim(u.id)::varchar NOT IN (SELECT x.email::varchar FROM kuntur.user_system x)
		AND trim(u.email)::varchar NOT ILIKE '%@pri.unc.edu.ar'
		-- AND trim(u.last_)::varchar IS NOT NULL
	ORDER BY trim(u.last), trim(u.first), trim(u.email), trim(u.id);	

-- SELECT COUNT(*) FROM v_act_id_user; -- 68
-- SELECT * FROM v_act_id_user;

----------------------------------------------------------------------------------------------------------------------------------------------------	

DROP VIEW IF EXISTS v_person_act_id_user CASCADE;

CREATE OR REPLACE VIEW 	v_person_act_id_user AS 

	SELECT DISTINCT id_user, email, last, first, pwd		
	FROM 	v_act_id_user 
	ORDER BY last, first, email, id_user;	

-- SELECT COUNT(*) FROM v_person_act_id_user; -- 55
-- SELECT * FROM v_person_act_id_user;
----------------------------------------------------------------------------------------------------------------------------------------------------	

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

-- SELECT COUNT(*) FROM v_person_z; -- 55
-- SELECT * FROM v_person_z;

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.person (SELECT * FROM v_person_z);

-- SELECT COUNT(*) FROM kuntur.person; -- 1108
-- SELECT * FROM kuntur.person;

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

-- SELECT COUNT(*) FROM v_person_email_z; -- 55
-- SELECT * FROM v_person_email_z;	

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.person_email (SELECT * FROM v_person_email_z ORDER BY id);

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

-- SELECT COUNT(*) FROM v_user_system_z; -- 55
-- SELECT * FROM v_user_system_z ORDER BY email;	

----------------------------------------------------------------------------------------------------------------------------------------------------	

INSERT INTO kuntur.user_system (SELECT * FROM v_user_system_z ORDER BY id);

-- SELECT COUNT(*) FROM  kuntur.user_system; -- 1047

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

----------------------------------------------------------------------------------------------------------------------------------------------------				

INSERT INTO kuntur.unc_in_academic_coordinator (SELECT * FROM v_unc_in_academic_coordinator);

-- SELECT * FROM kuntur.unc_in_academic_coordinator;

INSERT INTO kuntur.unc_in_academic_office (SELECT * FROM v_unc_in_academic_office);

-- SELECT * FROM kuntur.unc_in_academic_office;

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

-- SELECT COUNT(*) FROM kuntur.enrrollment_stakeholder;
-- SELECT * FROM kuntur.enrrollment_stakeholder ORDER BY code DESC ;




----------------------------------------------------------------------------------------------------------------------------------------------------	


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

----------------------------------------------------------------------------------------------------------------------------------------------------	

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

----------------------------------------------------------------------------------------------------------------------------------------------------	

UPDATE kuntur.enrrollment e SET comment = (SELECT x.comment FROM kuntur.unc_in_enrrollment x WHERE x.id = e.id);

----------------------------------------------------------------------------------------------------------------------------------------------------	

SELECT 'FIN DEL PROCESO C'::VARCHAR FROM postulation LIMIT 100;
