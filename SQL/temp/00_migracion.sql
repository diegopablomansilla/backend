DROP TABLE IF EXISTS physical_person_tmp CASCADE;

CREATE TABLE physical_person_tmp
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

INSERT INTO physical_person_tmp (

	SELECT 	TRIM(id)::VARCHAR, 
		state_enable, 
		INITCAP(TRIM(name))::VARCHAR, 
		INITCAP(TRIM(last_name))::VARCHAR, 
		TRIM(comment)::VARCHAR, 
		TRIM(identification_type_person_id)::VARCHAR, 
		TRIM(identification_number)::VARCHAR, 
		masculine, 
		birth_date, 
		TRIM(birth_address_id)::VARCHAR, 
		TRIM(address_id)::VARCHAR, 
		TRIM(marital_status)::VARCHAR, 
		TRIM(phone)::VARCHAR, 
		TRIM(phone_in_cordoba)::VARCHAR, 
		TRIM(cell_phone)::VARCHAR, 
		LOWER(TRIM(mail))::VARCHAR, 
		TRIM(sys_file_id)::VARCHAR, 
		postulation, 
		TRIM(physical_person_id)::VARCHAR, 
		TRIM(country_id)::VARCHAR
	FROM 	physical_person  
 );

 -- SELECT * FROM physical_person_tmp;

UPDATE physical_person_tmp SET id = null WHERE CHAR_LENGTH(id) = 0;
--UPDATE physical_person_tmp SET state_enable = null WHERE CHAR_LENGTH(state_enable) = 0;
UPDATE physical_person_tmp SET name = null WHERE CHAR_LENGTH(name) = 0; 
UPDATE physical_person_tmp SET last_name = null WHERE CHAR_LENGTH(last_name) = 0;
UPDATE physical_person_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;
UPDATE physical_person_tmp SET identification_type_person_id = null WHERE CHAR_LENGTH(identification_type_person_id) = 0;
UPDATE physical_person_tmp SET identification_number = null WHERE CHAR_LENGTH(identification_number) = 0;
--UPDATE physical_person_tmp SET masculine = null WHERE CHAR_LENGTH(masculine) = 0;
--UPDATE physical_person_tmp SET birth_date = null WHERE CHAR_LENGTH(birth_date) = 0;
UPDATE physical_person_tmp SET birth_address_id = null WHERE CHAR_LENGTH(birth_address_id) = 0;
UPDATE physical_person_tmp SET address_id = null WHERE CHAR_LENGTH(address_id) = 0;
UPDATE physical_person_tmp SET marital_status = null WHERE CHAR_LENGTH(marital_status) = 0;
UPDATE physical_person_tmp SET phone = null WHERE CHAR_LENGTH(phone) = 0;
UPDATE physical_person_tmp SET phone_in_cordoba = null WHERE CHAR_LENGTH(phone_in_cordoba) = 0;
UPDATE physical_person_tmp SET cell_phone = null WHERE CHAR_LENGTH(cell_phone) = 0;
UPDATE physical_person_tmp SET mail = null WHERE CHAR_LENGTH(mail) = 0;
UPDATE physical_person_tmp SET sys_file_id = null WHERE CHAR_LENGTH(sys_file_id) = 0;
--UPDATE physical_person_tmp SET postulation = null WHERE CHAR_LENGTH(postulation) = 0;
UPDATE physical_person_tmp SET physical_person_id = null WHERE CHAR_LENGTH(physical_person_id) = 0;
UPDATE physical_person_tmp SET country_id = null WHERE CHAR_LENGTH(country_id) = 0;

-- SELECT COUNT(*) FROM physical_person_tmp; -- 4418
-- SELECT * FROM physical_person_tmp ORDER BY last_name, name, identification_number; -- 4418

-- ========================================================================================================

-- SELECT * FROM postulation

DROP TABLE IF EXISTS postulation_tmp CASCADE;

CREATE TABLE postulation_tmp
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
	  physical_person_id character varying(255),
	  physical_person_in_eri_out_id character varying(255),
	  sys_state_life_cycle_id character varying(255),
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

INSERT INTO postulation_tmp (
	SELECT 	TRIM(id), 
		state_enable, 
		INITCAP(TRIM(name)), 
		TRIM(comment), 
		is_contract, 
		is_program, 
		TRIM(home_study_area), 
		TRIM(study_area), 
		TRIM(disease), 
		fees_paid, 
		sanctions, 
		creation_date, 
		insurance, 
		original_documentation, 
		language_certificate, 
		TRIM(visa), 
		TRIM(career), 
		career_subjects, 
		approved_subjects, 
		subjects_for_study, 
		TRIM(exchange_period), 
		TRIM(subjects_to_recognize), 
		eri_in, 
		TRIM(note), 
		academic_average, 
		historic_average, 
		performance, 
		teaching, 
		extension, 
		proposal, 
		TRIM(observation), 
		TRIM(period_admission_id), 
		TRIM(physical_person_id), 
		TRIM(physical_person_in_eri_out_id), 
		TRIM(sys_state_life_cycle_id), 
		TRIM(institution_id), 
		TRIM(institution_in_eri_out_id), 
		TRIM(academic_unit_id), 
		TRIM(contract_id), 
		TRIM(exchange_program_id), 
		TRIM(study_program_id), 
		TRIM(academic_perform_id), 
		TRIM(sys_file_university_credential_id), 
		TRIM(sys_file_analytical_id), 
		TRIM(sys_file_passport_id), 
		TRIM(sys_file_language_certificate_id), 
		TRIM(sys_file_cv_id), 
		TRIM(sys_file_psychophysical_certificate_id), 
		TRIM(sys_file_postulation_letter_id), 
		TRIM(sys_file_acceptance_letter_id), 
		TRIM(sys_file_acceptance_letter_mail_id), 
		TRIM(sys_file_academic_certificate_id), 
		TRIM(sys_file_regular_student_certificate_id), 
		TRIM(sys_file_cv_certificate_id), 
		TRIM(sys_file_arrival_certificate_id), 
		TRIM(sys_file_intermediate_report_id), 
		TRIM(sys_file_final_report_id), 
		TRIM(sys_file_study_contract_id), 
		TRIM(sys_file_analytical_certificate_id), 
		TRIM(sys_file_analytical_certificate_mail_id), 
		TRIM(sys_file_program_id), 
		participation, 
		TRIM(modified_note)
	  FROM 	postulation
 );

-- SELECT * FROM postulation_tmp;


UPDATE postulation_tmp SET id = null WHERE CHAR_LENGTH(id) = 0;
--UPDATE postulation_tmp SET state_enable = null WHERE CHAR_LENGTH(state_enable) = 0;
UPDATE postulation_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
UPDATE postulation_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;
--UPDATE postulation_tmp SET is_contract = null WHERE CHAR_LENGTH(is_contract) = 0;
--UPDATE postulation_tmp SET is_program = null WHERE CHAR_LENGTH(is_program) = 0;
UPDATE postulation_tmp SET home_study_area = null WHERE CHAR_LENGTH(home_study_area) = 0;
UPDATE postulation_tmp SET study_area = null WHERE CHAR_LENGTH(study_area) = 0;
UPDATE postulation_tmp SET disease = null WHERE CHAR_LENGTH(disease) = 0;
--UPDATE postulation_tmp SET fees_paid = null WHERE CHAR_LENGTH(fees_paid) = 0;
--UPDATE postulation_tmp SET sanctions = null WHERE CHAR_LENGTH(sanctions) = 0;
--UPDATE postulation_tmp SET creation_date = null WHERE CHAR_LENGTH(creation_date) = 0;
--UPDATE postulation_tmp SET insurance = null WHERE CHAR_LENGTH(insurance) = 0;
--UPDATE postulation_tmp SET original_documentation = null WHERE CHAR_LENGTH(original_documentation) = 0;
--UPDATE postulation_tmp SET language_certificate = null WHERE CHAR_LENGTH(language_certificate) = 0;
UPDATE postulation_tmp SET visa = null WHERE CHAR_LENGTH(visa) = 0;
UPDATE postulation_tmp SET career = null WHERE CHAR_LENGTH(career) = 0;
--UPDATE postulation_tmp SET career_subjects = null WHERE CHAR_LENGTH(career_subjects) = 0;
--UPDATE postulation_tmp SET approved_subjects = null WHERE CHAR_LENGTH(approved_subjects) = 0;
--UPDATE postulation_tmp SET subjects_for_study = null WHERE CHAR_LENGTH(subjects_for_study) = 0;
UPDATE postulation_tmp SET exchange_period = null WHERE CHAR_LENGTH(exchange_period) = 0;
UPDATE postulation_tmp SET subjects_to_recognize = null WHERE CHAR_LENGTH(subjects_to_recognize) = 0;
--UPDATE postulation_tmp SET eri_in = null WHERE CHAR_LENGTH(eri_in) = 0;
UPDATE postulation_tmp SET note = null WHERE CHAR_LENGTH(note) = 0;
--UPDATE postulation_tmp SET academic_average = null WHERE CHAR_LENGTH(academic_average) = 0;
--UPDATE postulation_tmp SET historic_average = null WHERE CHAR_LENGTH(historic_average) = 0;
--UPDATE postulation_tmp SET performance = null WHERE CHAR_LENGTH(performance) = 0;
--UPDATE postulation_tmp SET teaching = null WHERE CHAR_LENGTH(teaching) = 0;
--UPDATE postulation_tmp SET extension = null WHERE CHAR_LENGTH(extension) = 0;
--UPDATE postulation_tmp SET proposal = null WHERE CHAR_LENGTH(proposal) = 0;
UPDATE postulation_tmp SET observation = null WHERE CHAR_LENGTH(observation) = 0;
UPDATE postulation_tmp SET period_admission_id = null WHERE CHAR_LENGTH(period_admission_id) = 0;
UPDATE postulation_tmp SET physical_person_id = null WHERE CHAR_LENGTH(physical_person_id) = 0;
UPDATE postulation_tmp SET physical_person_in_eri_out_id = null WHERE CHAR_LENGTH(physical_person_in_eri_out_id) = 0;
UPDATE postulation_tmp SET sys_state_life_cycle_id = null WHERE CHAR_LENGTH(sys_state_life_cycle_id) = 0;
UPDATE postulation_tmp SET institution_id = null WHERE CHAR_LENGTH(institution_id) = 0;
UPDATE postulation_tmp SET institution_in_eri_out_id = null WHERE CHAR_LENGTH(institution_in_eri_out_id) = 0;
UPDATE postulation_tmp SET academic_unit_id = null WHERE CHAR_LENGTH(academic_unit_id) = 0;
UPDATE postulation_tmp SET contract_id = null WHERE CHAR_LENGTH(contract_id) = 0;
UPDATE postulation_tmp SET exchange_program_id = null WHERE CHAR_LENGTH(exchange_program_id) = 0;
UPDATE postulation_tmp SET study_program_id = null WHERE CHAR_LENGTH(study_program_id) = 0;
UPDATE postulation_tmp SET academic_perform_id = null WHERE CHAR_LENGTH(academic_perform_id) = 0;
UPDATE postulation_tmp SET sys_file_university_credential_id = null WHERE CHAR_LENGTH(sys_file_university_credential_id) = 0;
UPDATE postulation_tmp SET sys_file_analytical_id = null WHERE CHAR_LENGTH(sys_file_analytical_id) = 0;
UPDATE postulation_tmp SET sys_file_passport_id = null WHERE CHAR_LENGTH(sys_file_passport_id) = 0;
UPDATE postulation_tmp SET sys_file_language_certificate_id = null WHERE CHAR_LENGTH(sys_file_language_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_cv_id = null WHERE CHAR_LENGTH(sys_file_cv_id) = 0;
UPDATE postulation_tmp SET sys_file_psychophysical_certificate_id = null WHERE CHAR_LENGTH(sys_file_psychophysical_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_postulation_letter_id = null WHERE CHAR_LENGTH(sys_file_postulation_letter_id) = 0;
UPDATE postulation_tmp SET sys_file_acceptance_letter_id = null WHERE CHAR_LENGTH(sys_file_acceptance_letter_id) = 0;
UPDATE postulation_tmp SET sys_file_acceptance_letter_mail_id = null WHERE CHAR_LENGTH(sys_file_acceptance_letter_mail_id) = 0;
UPDATE postulation_tmp SET sys_file_academic_certificate_id = null WHERE CHAR_LENGTH(sys_file_academic_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_regular_student_certificate_id = null WHERE CHAR_LENGTH(sys_file_regular_student_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_cv_certificate_id = null WHERE CHAR_LENGTH(sys_file_cv_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_arrival_certificate_id = null WHERE CHAR_LENGTH(sys_file_arrival_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_intermediate_report_id = null WHERE CHAR_LENGTH(sys_file_intermediate_report_id) = 0;
UPDATE postulation_tmp SET sys_file_final_report_id = null WHERE CHAR_LENGTH(sys_file_final_report_id) = 0;
UPDATE postulation_tmp SET sys_file_study_contract_id = null WHERE CHAR_LENGTH(sys_file_study_contract_id) = 0;
UPDATE postulation_tmp SET sys_file_analytical_certificate_id = null WHERE CHAR_LENGTH(sys_file_analytical_certificate_id) = 0;
UPDATE postulation_tmp SET sys_file_analytical_certificate_mail_id = null WHERE CHAR_LENGTH(sys_file_analytical_certificate_mail_id) = 0;
UPDATE postulation_tmp SET sys_file_program_id = null WHERE CHAR_LENGTH(sys_file_program_id) = 0;
--UPDATE postulation_tmp SET participation = null WHERE CHAR_LENGTH(participation) = 0;
UPDATE postulation_tmp SET modified_note = null WHERE CHAR_LENGTH(modified_note) = 0;


-- SELECT COUNT(*) FROM postulation_tmp; -- 1515
-- SELECT * FROM postulation_tmp; -- 1515

--=================================================================================================================================================
--=================================================================================================================================================
--=================================================================================================================================================

DROP TABLE IF EXISTS physical_person_a_tmp CASCADE;
CREATE TABLE physical_person_a_tmp
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
	  country_id character varying(255),
	  cant_postulation INTEGER
 );

INSERT INTO physical_person_a_tmp (

	SELECT 	pp.id, 
		pp.state_enable, 
		pp.name, 
		pp.last_name, 
		pp.comment, 
		pp.identification_type_person_id, 
		pp.identification_number, 
		pp.masculine, 
		pp.birth_date, 
		pp.birth_address_id, 
		pp.address_id, 
		pp.marital_status, 
		pp.phone, 
		pp.phone_in_cordoba, 
		pp.cell_phone, 
		pp.mail, 
		pp.sys_file_id, 
		pp.postulation, 
		pp.physical_person_id, 
		pp.country_id,
		(SELECT COUNT(p.*) FROM postulation_tmp p WHERE p.physical_person_id::VARCHAR = pp.id::VARCHAR)::INTEGER
	FROM 	physical_person_tmp pp
);

-- SELECT COUNT(*) FROM physical_person_tmp pp JOIN postulation_tmp p ON pp.id = p.physical_person_id

-- SELECT COUNT(*) FROM physical_person_a_tmp; -- 4418
-- SELECT * FROM physical_person_a_tmp ORDER BY last_name, name, identification_number; -- 4418
-- SELECT * FROM physical_person_a_tmp WHERE cant_postulation > 0 ORDER BY last_name, name, identification_number; -- 1283
-- SELECT * FROM physical_person_a_tmp WHERE cant_postulation = 1 ORDER BY last_name, name, identification_number; -- 1149
-- SELECT * FROM physical_person_a_tmp WHERE cant_postulation > 1 ORDER BY last_name, name, identification_number; -- 134

-- SELECT DISTINCT last_name, name, identification_number, mail  FROM physical_person_a_tmp ORDER BY last_name, name, identification_number; -- 2968

-- SELECT DISTINCT last_name, name, identification_number  FROM physical_person_a_tmp ORDER BY last_name, name, identification_number; -- 2968
-- SELECT DISTINCT last_name, name, identification_number  FROM physical_person_a_tmp WHERE cant_postulation > 0  ORDER BY last_name, name, identification_number; -- 1223
-- SELECT DISTINCT last_name, name, identification_number  FROM physical_person_a_tmp WHERE cant_postulation = 1  ORDER BY last_name, name, identification_number; -- 1100
-- SELECT DISTINCT last_name, name, identification_number  FROM physical_person_a_tmp WHERE cant_postulation > 1  ORDER BY last_name, name, identification_number; -- 134		

 --=================================================================================================================================================

DROP VIEW IF EXISTS v_physical_person_distinct_tm CASCADE;

CREATE OR REPLACE VIEW v_physical_person_distinct_tmp AS

	SELECT 	DISTINCT last_name, name, identification_number  
	FROM 	physical_person_a_tmp 		
	ORDER BY last_name, name, identification_number; -- 2968

-- SELECT * FROM v_physical_person_distinct_tmp;	
 

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
		name,
		last_name,
		identification_number
	FROM 	v_physical_person_distinct_tmp	
	
 );

 -- SELECT * FROM physical_person_distinct_tmp;

--=================================================================================================================================================

DROP TABLE IF EXISTS physical_person_b_tmp CASCADE;

CREATE TABLE physical_person_b_tmp
(
	  id character varying(255) NOT NULL,
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
	  country_id character varying(255),
	  cant_postulation INTEGER,
	  old_id VARCHAR UNIQUE
 ); 

 INSERT INTO physical_person_b_tmp (

	SELECT 	(
			SELECT 	d.id 
			FROM 	physical_person_distinct_tmp d 
			WHERE 	COALESCE(d.last_name, '')::VARCHAR = COALESCE(pp.last_name, '')::VARCHAR
				AND COALESCE(d.name, '')::VARCHAR = COALESCE(pp.name, '')::VARCHAR
				AND COALESCE(d.identification_number, '')::VARCHAR = COALESCE(pp.identification_number, '')::VARCHAR
		)::VARCHAR AS id,
		pp.state_enable, 
		pp.name, 
		pp.last_name, 
		pp.comment, 
		pp.identification_type_person_id, 
		pp.identification_number, 
		pp.masculine, 
		pp.birth_date, 
		pp.birth_address_id, 
		pp.address_id, 
		pp.marital_status, 
		pp.phone, 
		pp.phone_in_cordoba, 
		pp.cell_phone, 
		pp.mail, 
		pp.sys_file_id, 
		pp.postulation, 
		pp.physical_person_id, 
		pp.country_id,
		pp.cant_postulation,
		pp.id AS old_id
	FROM 	physical_person_a_tmp pp
	ORDER BY pp.last_name, pp.name, pp.identification_number
);


-- UPDATE physical_person_b_tmp SET id = old_id WHERE id IS NULL;

-- SELECT * FROM physical_person_b_tmp;

--=================================================================================================================================================

DROP TABLE IF EXISTS physical_person_c_tmp CASCADE;

CREATE TABLE physical_person_c_tmp
(
	  id character varying(255) NOT NULL,
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
	  country_id character varying(255),
	  cant_postulation INTEGER,
	  old_id VARCHAR UNIQUE,
	  cant_rep INTEGER
 ); 

INSERT INTO physical_person_c_tmp (

	SELECT 	pp.id, 
		pp.state_enable, 
		pp.name, 
		pp.last_name, 
		pp.comment, 
		pp.identification_type_person_id, 
		pp.identification_number, 
		pp.masculine, 
		pp.birth_date, 
		pp.birth_address_id, 
		pp.address_id, 
		pp.marital_status, 
		pp.phone, 
		pp.phone_in_cordoba, 
		pp.cell_phone, 
		pp.mail, 
		pp.sys_file_id, 
		pp.postulation, 
		pp.physical_person_id, 
		pp.country_id,
		cant_postulation,
		pp.old_id,
		(SELECT COUNT(x.*) FROM physical_person_b_tmp x WHERE x.id::VARCHAR = pp.id::VARCHAR)::INTEGER
	FROM 	physical_person_b_tmp pp
);

-- SELECT * FROM physical_person_c_tmp ORDER BY last_name, name, identification_number;

-- SELECT * FROM physical_person_c_tmp WHERE cant_postulation > 0 AND cant_rep > 1


--=================================================================================================================================================

DROP VIEW IF EXISTS v_postulation_ok_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_tmp AS

	SELECT 	p.* 
	FROM	physical_person_c_tmp pp
	JOIN	postulation_tmp p
		ON pp.old_id = p.physical_person_id
	WHERE 	pp.mail NOT ILIKE '%unc.edu.ar%'
		AND pp.mail NOT ILIKE '%pri.unc.edu.ar%'
		AND pp.mail NOT ILIKE '%psi.unc.edu.ar%'
		AND pp.mail NOT ILIKE '%diegopablomansilla@gmail.com%'
		AND p.sys_state_life_cycle_id <> '267'
		AND p.sys_state_life_cycle_id IS NOT NULL;

-- SELECT DISTINCT * FROM v_postulation_ok_tmp;

DROP VIEW IF EXISTS v_postulation_ok_a_tmp CASCADE;

CREATE OR REPLACE VIEW v_postulation_ok_a_tmp AS
		
	SELECT 	DISTINCT * 
	FROM 	v_postulation_ok_tmp;

-- SELECT * FROM v_postulation_ok_a_tmp; -- 1289

-- SELECT * FROM postulation_tmp; -- 1515

-- SELECT * FROM postulation; -- 1515

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
	  physical_person_id character varying(255),
	  physical_person_in_eri_out_id character varying(255),
	  sys_state_life_cycle_id character varying(255),
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
	  modified_note character varying(255),
	  new_physical_person_id VARCHAR NOT NULL
);

INSERT INTO postulation_a_tmp (
	SELECT 	p.id, 
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
		p.physical_person_id, 
		p.physical_person_in_eri_out_id, 
		p.sys_state_life_cycle_id, 
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
		p.modified_note,
		(SELECT pp.id FROM physical_person_c_tmp pp WHERE pp.old_id::VARCHAR = p.physical_person_id::VARCHAR)::VARCHAR AS new_physical_person_id
	  FROM 	v_postulation_ok_a_tmp p
	 
 );

-- SELECT * FROM postulation_a_tmp; -- 1289

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

-- =========================================================================

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
	  physical_person_id character varying(255),
	  physical_person_in_eri_out_id character varying(255),
	  sys_state_life_cycle_id character varying(1) NOT NULL,
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
	  modified_note character varying(255),
	  new_physical_person_id VARCHAR NOT NULL,
	  year_academic INTEGER NOT NULL,
	  semester INTEGER NOT NULL,
	  last_name VARCHAR,
	  given_name VARCHAR,
	  identification_number VARCHAR,
	  mail VARCHAR
);

-- SELECT * FROM postulation_a_tmp; -- 1289

INSERT INTO postulation_b_tmp (

	SELECT 	p.id, 
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
		p.physical_person_id, 
		p.physical_person_in_eri_out_id, 
		
		esm.code AS sys_state_life_cycle_id, 
		
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
		p.modified_note,
		p.new_physical_person_id,
		pa.year_academic::INTEGER,
		CASE WHEN pa.semester1 = true THEN 1::INTEGER ELSE 2::INTEGER END AS semester,
		pp.last_name,
		pp.name,
		pp.identification_number,
		pp.mail
	 FROM 	postulation_a_tmp p
	 LEFT JOIN v_enrrollment_status_map esm
		ON p.sys_state_life_cycle_id = esm.number_code
	 LEFT JOIN period_admission pa
		ON pa.id = p.period_admission_id
	 LEFT JOIN physical_person_c_tmp pp
		ON pp.old_id = p.physical_person_id	

);

-- SELECT * FROM postulation_b_tmp;	

-- =========================================================================

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
	  physical_person_id character varying(255),
	  physical_person_in_eri_out_id character varying(255),
	  
	  sys_state_life_cycle_id character varying(1) NOT NULL,
	  sys_state_life_cycle_id_max character varying(1) NOT NULL,

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
	  modified_note character varying(255),
	  new_physical_person_id VARCHAR NOT NULL,
	  year_academic INTEGER NOT NULL,
	  semester INTEGER NOT NULL,
	  last_name VARCHAR,
	  given_name VARCHAR,
	  identification_number VARCHAR,
	  mail VARCHAR
	  
);

INSERT INTO postulation_c_tmp (

		SELECT 	p.id, 
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
		p.physical_person_id, 
		p.physical_person_in_eri_out_id, 
		
		p.sys_state_life_cycle_id, 

		(

			SELECT 	MAX(x.sys_state_life_cycle_id)
			FROM 	postulation_b_tmp x 
			WHERE 	COALESCE(x.last_name, '')::VARCHAR = COALESCE(p.last_name, '')::VARCHAR
				AND COALESCE(x.name, '')::VARCHAR = COALESCE(p.name, '')::VARCHAR
				AND COALESCE(x.identification_number, '')::VARCHAR = COALESCE(p.identification_number, '')::VARCHAR
				AND COALESCE(x.mail, '')::VARCHAR = COALESCE(p.mail, '')::VARCHAR
				--AND x.new_physical_person_id = p.new_physical_person_id
				AND x.year_academic = p.year_academic
				AND x.semester = p.semester					

		) AS sys_state_life_cycle_id_max,
		
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
		p.modified_note,
		p.new_physical_person_id,
		p.year_academic,
		p.semester
	 FROM 	postulation_b_tmp p
	
);

-- SELECT * FROM postulation_c_tmp; -- 1289

DELETE FROM postulation_c_tmp WHERE sys_state_life_cycle_id <> sys_state_life_cycle_id_max;

-- SELECT * FROM postulation_c_tmp; -- 1282

--=================================================================================================================================================

DROP TABLE IF EXISTS physical_person_d_tmp CASCADE;

CREATE TABLE physical_person_d_tmp
(
	  id character varying(255) NOT NULL,
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
	  country_id character varying(255),
	  cant_postulation INTEGER,
	  old_id VARCHAR UNIQUE,
	  cant_rep INTEGER
 ); 

INSERT INTO physical_person_d_tmp (

	SELECT 	pp.id, 
		pp.state_enable, 
		pp.name, 
		pp.last_name, 
		pp.comment, 
		pp.identification_type_person_id, 
		pp.identification_number, 
		pp.masculine, 
		pp.birth_date, 
		pp.birth_address_id, 
		pp.address_id, 
		pp.marital_status, 
		pp.phone, 
		pp.phone_in_cordoba, cell_phone, 
		pp.mail, 
		pp.sys_file_id, 
		pp.postulation, 
		pp.physical_person_id, 
		pp.country_id, 
		--pp.cant_postulation, 
		--(SELECT COUNT(p.*) FROM postulation_c_tmp p WHERE p.physical_person_id::VARCHAR = pp.old_id::VARCHAR)::INTEGER AS cant_postulation,
		(SELECT COUNT(p.*) FROM postulation_c_tmp p WHERE p.new_physical_person_id::VARCHAR = pp.id::VARCHAR)::INTEGER AS cant_postulation,
		pp.old_id, 
		pp.cant_rep
	  FROM 	physical_person_c_tmp pp
);

SELECT * FROM physical_person_d_tmp ORDER BY last_name, name, identification_number;

-- SELECT * FROM physical_person_d_tmp WHERE cant_postulation > 0 AND cant_rep > 1

-- SELECT * FROM physical_person_d_tmp WHERE cant_rep > 1 AND cant_postulation > 0 ORDER BY last_name, name, identification_number;

--=================================================================================================================================================
