-- SELECT back_end_path FROM sys_file ORDER BY back_end_path;


-- SELECT * FROM physical_person;

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

	SELECT 	TRIM(pp.id)::VARCHAR, 
		pp.state_enable, 
		INITCAP(TRIM(pp.name))::VARCHAR, 
		INITCAP(TRIM(pp.last_name))::VARCHAR, 
		TRIM(pp.comment)::VARCHAR, 
		TRIM(pp.identification_type_person_id)::VARCHAR, 
		UPPER(TRIM(pp.identification_number))::VARCHAR, 
		pp.masculine, 
		pp.birth_date, 
		TRIM(pp.birth_address_id)::VARCHAR, 
		TRIM(pp.address_id)::VARCHAR, 
		TRIM(pp.marital_status)::VARCHAR, 
		TRIM(pp.phone)::VARCHAR, 
		TRIM(pp.phone_in_cordoba)::VARCHAR, 
		TRIM(pp.cell_phone)::VARCHAR, 
		LOWER(TRIM(pp.mail))::VARCHAR, 
		TRIM(sf.back_end_path)::VARCHAR AS sys_file_id, 
		--TRIM(pp.sys_file_id)::VARCHAR, 
		pp.postulation, 
		TRIM(pp.physical_person_id)::VARCHAR, 
		TRIM(pp.country_id)::VARCHAR
	FROM 	physical_person pp
	LEFT JOIN sys_file sf
		ON TRIM(sf.id)::VARCHAR = TRIM(pp.sys_file_id)::VARCHAR 
	
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


-- SELECT DISTINCT identification_number FROM physical_person_tmp ORDER BY identification_number;
UPDATE physical_person_tmp SET identification_number = null WHERE identification_number = '----------';

UPDATE physical_person_tmp SET name = REPLACE(name, 'Prof.', 'Prof. '); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Prof', 'Prof. '); 
UPDATE physical_person_tmp SET name = REPLACE(name, '. ', ''); 
UPDATE physical_person_tmp SET name = REPLACE(name, '.', ''); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dra', ' Dra.'); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dr', ' Dr.'); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dr.a.', ' Dra.'); 
UPDATE physical_person_tmp SET name = REPLACE(name, ',', ' '); 
UPDATE physical_person_tmp SET name = REPLACE(name, ';', ' '); 
UPDATE physical_person_tmp SET name = REPLACE(name, '-', ''); 
UPDATE physical_person_tmp SET name = REPLACE(name, '_', ''); 
UPDATE physical_person_tmp SET name = REPLACE(name, '  ', ' '); 
UPDATE physical_person_tmp SET name = REPLACE(name, '   ', ' '); 
UPDATE physical_person_tmp SET name = REPLACE(name, '    ', ' '); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dra. ', 'Dra.'); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dra. ', 'Dra. '); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dr. ', 'Dr.'); 
UPDATE physical_person_tmp SET name = REPLACE(name, 'Dr.', 'Dr. '); 

UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Prof.', 'Prof. '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Prof', 'Prof. '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '. ', ''); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '.', ''); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dra', ' Dra.'); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dr', ' Dr.'); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dr.a.', ' Dra.'); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, ',', ' '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, ';', ' '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '-', ''); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '_', '');
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '  ', ' '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '   ', ' ');  
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, '    ', ' ');  
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dra. ', 'Dra.'); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dra.', 'Dra. '); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dr. ', 'Dr.'); 
UPDATE physical_person_tmp SET last_name = REPLACE(last_name, 'Dr.', 'Dr. '); 

UPDATE physical_person_tmp SET name = INITCAP(name); 
UPDATE physical_person_tmp SET last_name = INITCAP(last_name); 

-- select sys_file_id from physical_person_tmp order by sys_file_id

-- SELECT COUNT(*) FROM physical_person_tmp; -- 4418
-- SELECT * FROM physical_person_tmp ORDER BY last_name, name, identification_number; -- 4418

-- SELECT back_end_path FROM sys_file ORDER BY back_end_path;
-- SELECT sys_file_id FROM physical_person_tmp ORDER BY sys_file_id;

--=================================================================================================================================================
--=================================================================================================================================================


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


UPDATE postulation_tmp t SET sys_file_university_credential_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_university_credential_id = x.id);

UPDATE postulation_tmp t SET sys_file_analytical_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_analytical_id = x.id);

UPDATE postulation_tmp t SET sys_file_passport_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_passport_id = x.id);

UPDATE postulation_tmp t SET sys_file_language_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_language_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_cv_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_cv_id = x.id);

UPDATE postulation_tmp t SET sys_file_psychophysical_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_psychophysical_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_postulation_letter_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_postulation_letter_id = x.id);

UPDATE postulation_tmp t SET sys_file_acceptance_letter_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_acceptance_letter_id = x.id);

UPDATE postulation_tmp t SET sys_file_acceptance_letter_mail_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_acceptance_letter_mail_id = x.id);

UPDATE postulation_tmp t SET sys_file_academic_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_academic_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_regular_student_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_regular_student_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_cv_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_cv_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_arrival_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_arrival_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_intermediate_report_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_intermediate_report_id = x.id);

UPDATE postulation_tmp t SET sys_file_final_report_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_final_report_id = x.id);

UPDATE postulation_tmp t SET sys_file_study_contract_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_study_contract_id = x.id);

UPDATE postulation_tmp t SET sys_file_analytical_certificate_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_analytical_certificate_id = x.id);

UPDATE postulation_tmp t SET sys_file_analytical_certificate_mail_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_analytical_certificate_mail_id = x.id);

UPDATE postulation_tmp t SET sys_file_program_id = (SELECT x.back_end_path FROM sys_file x WHERE t.sys_file_program_id = x.id);



-- select * from postulation_tmp
-- select * from sys_file
-- select * from kuntur.person
-- select * from kuntur.enrrollment
-- select * from kuntur.unc_in_enrrollment



-- SELECT COUNT(*) FROM postulation_tmp; -- 1515
-- SELECT * FROM postulation_tmp; -- 1515

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
	  country_id character varying(255)
 );

 INSERT INTO physical_person_a_tmp (

	SELECT 	pp.*
	FROM 	physical_person_tmp pp
	WHERE	pp.state_enable <> false
		AND pp.mail NOT ILIKE '%unc.edu.ar%'
		AND pp.mail NOT ILIKE '%pri.unc.edu.ar%'
		AND pp.mail NOT ILIKE '%psi.unc.edu.ar%'
		AND pp.mail NOT ILIKE '%diegopablomansilla@gmail.com%'
		AND COALESCE(pp.id, '')::VARCHAR IN (
							SELECT 	p.physical_person_id::VARCHAR 
							FROM 	postulation_tmp p 
							WHERE 	p.physical_person_id IS NOT NULL 
								AND p.sys_state_life_cycle_id <> '267'
								AND p.sys_state_life_cycle_id IS NOT NULL
								AND p.state_enable <> false
						)
 );

UPDATE physical_person_a_tmp SET last_name = 'Sin especificar' WHERE last_name IS NULL;

UPDATE physical_person_a_tmp SET name = last_name WHERE name IS NULL;

UPDATE physical_person_a_tmp SET phone = null WHERE CHAR_LENGTH(phone) < 4;

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090264c037dd8014d28e6aaa5074a';
UPDATE physical_person_a_tmp SET identification_number = 'L7C56CN9R' WHERE id = '489090264c037dd8014d28e6aaa5074a';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090264c037dd8014d28e6aaa5074a';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090264808929001481817a3d90018';
UPDATE physical_person_a_tmp SET identification_number = 'AQ159552' WHERE id = '489090264808929001481817a3d90018';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090264808929001481817a3d90018';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090263e315e60013e35d60d640029';
UPDATE physical_person_a_tmp SET identification_number = 'C904TRF87' WHERE id = '489090263e315e60013e35d60d640029';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090263e315e60013e35d60d640029';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '4890902639da67890139e55d085800a5';
UPDATE physical_person_a_tmp SET identification_number = '18690653' WHERE id = '4890902639da67890139e55d085800a5';
UPDATE physical_person_a_tmp SET identification_type_person_id = '258' WHERE id = '4890902639da67890139e55d085800a5';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090263e315e60013e35d60d640029';
UPDATE physical_person_a_tmp SET identification_number = 'C904TRF87' WHERE id = '489090263e315e60013e35d60d640029';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090263e315e60013e35d60d640029';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '48909026460aedad01460cf70c6b0009';
UPDATE physical_person_a_tmp SET identification_number = '34990124N' WHERE id = '48909026460aedad01460cf70c6b0009';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '48909026460aedad01460cf70c6b0009';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '00000000415a03120141a471993f0278';
UPDATE physical_person_a_tmp SET identification_number = 'AO962129' WHERE id = '00000000415a03120141a471993f0278';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '00000000415a03120141a471993f0278';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090263d3f79f8013d509b58ba0074';
UPDATE physical_person_a_tmp SET identification_number = '13AK05435' WHERE id = '489090263d3f79f8013d509b58ba0074';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090263d3f79f8013d509b58ba0074';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090264541c61d0145963b6edb0138';
UPDATE physical_person_a_tmp SET identification_number = 'G13331152' WHERE id = '489090264541c61d0145963b6edb0138';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090264541c61d0145963b6edb0138';

UPDATE physical_person_a_tmp SET comment = 'Número Documento Alternativo: ' || identification_number WHERE id = '489090263ed11bbf013ed1bb17240131';
UPDATE physical_person_a_tmp SET identification_number = 'C1Y8W4YXK' WHERE id = '489090263ed11bbf013ed1bb17240131';
UPDATE physical_person_a_tmp SET identification_type_person_id = '257' WHERE id = '489090263ed11bbf013ed1bb17240131';

UPDATE physical_person_a_tmp SET comment = 'Número Telfono Alternativo: ' || phone WHERE id = '0000000041dc14cd0142242b5dea03f4';
UPDATE physical_person_a_tmp SET phone = '(55) 41-33732350' WHERE id = '0000000041dc14cd0142242b5dea03f4';

UPDATE physical_person_a_tmp SET comment = 'Número Telfono Alternativo: ' || phone WHERE id = '0000000041dc14cd0141f1c4a1330209';
UPDATE physical_person_a_tmp SET phone = '00420724227221' WHERE id = '0000000041dc14cd0141f1c4a1330209';

UPDATE physical_person_a_tmp SET comment = 'Número Telfono Alternativo: ' || phone WHERE id = '00000000415a031201418e6b76170167';
UPDATE physical_person_a_tmp SET phone = '0039 3495355862' WHERE id = '00000000415a031201418e6b76170167';


UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE id = '489090263a50d14d013a61346e010160';

UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE phone = phone_in_cordoba;
UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE cell_phone = phone_in_cordoba;
UPDATE physical_person_a_tmp SET cell_phone = null WHERE phone = cell_phone;

UPDATE physical_person_a_tmp SET phone_in_cordoba = phone WHERE phone ILIKE '351%' AND phone_in_cordoba IS NULL;
UPDATE physical_person_a_tmp SET phone_in_cordoba = phone WHERE phone ILIKE '0351%' AND phone_in_cordoba IS NULL;

UPDATE physical_person_a_tmp SET phone = null WHERE phone ILIKE '351%' AND phone_in_cordoba IS NOT NULL;
UPDATE physical_person_a_tmp SET phone = null WHERE phone ILIKE '0351%' AND phone_in_cordoba IS NOT NULL;

UPDATE physical_person_a_tmp SET phone_in_cordoba = cell_phone WHERE cell_phone ILIKE '351%' AND phone_in_cordoba IS NULL;
UPDATE physical_person_a_tmp SET phone_in_cordoba = cell_phone WHERE cell_phone ILIKE '0351%' AND phone_in_cordoba IS NULL;

UPDATE physical_person_a_tmp SET cell_phone = null WHERE cell_phone ILIKE '351%' AND phone_in_cordoba IS NOT NULL;
UPDATE physical_person_a_tmp SET cell_phone = null WHERE cell_phone ILIKE '0351%' AND phone_in_cordoba IS NOT NULL;

UPDATE physical_person_a_tmp SET phone = null WHERE char_length(phone) < 5;
UPDATE physical_person_a_tmp SET cell_phone = null WHERE char_length(cell_phone) < 5;
UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE char_length(phone_in_cordoba) < 5;

UPDATE physical_person_a_tmp SET phone = null WHERE phone = '00000';
UPDATE physical_person_a_tmp SET cell_phone = null WHERE cell_phone = '00000';
UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE phone_in_cordoba = '00000';

UPDATE physical_person_a_tmp SET phone = null WHERE phone ILIKE 'No Tengo';
UPDATE physical_person_a_tmp SET cell_phone = null WHERE cell_phone ILIKE 'No Tengo';
UPDATE physical_person_a_tmp SET phone_in_cordoba = null WHERE phone_in_cordoba ILIKE 'No Tengo';


-- SELECT * FROM country WHERE id = '18'
UPDATE address SET country_id = null WHERE country_id = '18';




 -- SELECT COUNT(*) FROM physical_person_a_tmp; -- 1119
 -- SELECT * FROM physical_person_a_tmp; 

-- SELECT back_end_path FROM sys_file ORDER BY back_end_path;
-- SELECT sys_file_id FROM physical_person_a_tmp ORDER BY sys_file_id;

--=================================================================================================================================================
--=================================================================================================================================================


DROP TABLE IF EXISTS act_id_user_tmp CASCADE;

CREATE TABLE act_id_user_tmp
(
	  id character varying(64) NOT NULL UNIQUE,
	  rev integer,
	  first character varying(255),
	  last character varying(255),
	  email character varying(255),
	  pwd character varying(255),
	  picture_id character varying(64)
);

INSERT INTO act_id_user_tmp (

	SELECT 	 TRIM(id_),
		 rev_,
		 TRIM(first_),
		 TRIM(last_),
		 TRIM(email_),
		 TRIM(pwd_),
		 TRIM(picture_id_)
	FROM 	act_id_user u	
	ORDER BY TRIM(last_), TRIM(first_), TRIM(email_), TRIM(id_)
);	


UPDATE act_id_user_tmp SET id = null WHERE CHAR_LENGTH(id) = 0;
UPDATE act_id_user_tmp SET first = null WHERE CHAR_LENGTH(first) = 0;
UPDATE act_id_user_tmp SET last = null WHERE CHAR_LENGTH(last) = 0;
UPDATE act_id_user_tmp SET email = null WHERE CHAR_LENGTH(email) = 0;
UPDATE act_id_user_tmp SET pwd = null WHERE CHAR_LENGTH(pwd) = 0;
UPDATE act_id_user_tmp SET picture_id = null WHERE CHAR_LENGTH(picture_id) = 0;

-- SELECT COUNT(*) FROM act_id_user_tmp; -- 1920
-- SELECT * FROM act_id_user_tmp;
-- SELECT picture_id FROM act_id_user_tmp ORDER BY picture_id;

--=================================================================================================================================================

DROP TABLE IF EXISTS contract_tmp CASCADE;

CREATE TABLE contract_tmp
(
	  id character varying(255) NOT NULL UNIQUE,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  number_students integer,
	  institution_id character varying(255),
	  academic_unit_id character varying(255),
	  initial_number_students integer
);

INSERT INTO contract_tmp (

	SELECT 	TRIM(id)::VARCHAR, 
		state_enable, 
		TRIM(name)::VARCHAR, 
		TRIM(comment)::VARCHAR, 
		number_students, 
		TRIM(institution_id)::VARCHAR, 
		TRIM(academic_unit_id)::VARCHAR, 
		initial_number_students
	FROM contract
);

UPDATE contract_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
UPDATE contract_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;


-- SELECT COUNT(*) FROM contract_tmp; -- 111
-- SELECT * FROM contract_tmp;

DROP TABLE IF EXISTS institution_tmp CASCADE;

CREATE TABLE institution_tmp
(
	  id character varying(255) NOT NULL,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  country_id character varying(255),
	  is_entered boolean
);

INSERT INTO institution_tmp (

	SELECT 	TRIM(id)::VARCHAR, 
		state_enable, 
		TRIM(name)::VARCHAR, 
		TRIM(comment)::VARCHAR, 
		TRIM(country_id)::VARCHAR, 
		is_entered
	FROM 	institution
);

UPDATE institution_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
UPDATE institution_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;

-- SELECT COUNT(*) FROM institution_tmp; -- 315
-- SELECT * FROM institution_tmp;

DROP TABLE IF EXISTS academic_unit_tmp CASCADE;

CREATE TABLE academic_unit_tmp
(
	  id character varying(255) NOT NULL,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255)
);

INSERT INTO academic_unit_tmp (

	SELECT 	TRIM(id)::VARCHAR, 
		state_enable, 
		TRIM(name)::VARCHAR, 
		TRIM(comment)::VARCHAR
	FROM 	academic_unit
 );

 UPDATE academic_unit_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
 UPDATE academic_unit_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;

-- SELECT COUNT(*) FROM academic_unit_tmp; -- 21
-- SELECT * FROM academic_unit_tmp;

DROP TABLE IF EXISTS exchange_program_tmp CASCADE;

CREATE TABLE exchange_program_tmp
(
	  id character varying(255) NOT NULL,
	  state_enable boolean,
	  name character varying(255),
	  comment character varying(255),
	  eri_in boolean,
	  number_students integer,
	  initial_number_students integer
);

INSERT INTO exchange_program_tmp (

	SELECT 	id, 
		state_enable, 
		TRIM(name)::VARCHAR, 
		TRIM(comment)::VARCHAR, 
		eri_in, 
		number_students, 
		initial_number_students
	FROM 	exchange_program

);

UPDATE exchange_program_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
UPDATE exchange_program_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;

-- SELECT COUNT(*) FROM exchange_program_tmp; -- 20
-- SELECT * FROM academic_unit_tmp;

DROP TABLE IF EXISTS nahuel_academic_unit_tmp CASCADE;

CREATE TABLE nahuel_academic_unit_tmp
(
	  id character varying NOT NULL, -- ID [Map Class: org.nahuel.model.edu.au.AcademicUnit.id]
	  state_enable boolean, -- Vigente [Map Class: org.nahuel.model.edu.au.AcademicUnit.stateEnable]
	  code character varying, -- Código [Map Class: org.nahuel.model.edu.au.AcademicUnit.code]
	  code_b character varying, -- Código [Map Class: org.nahuel.model.edu.au.AcademicUnit.codeB]
	  short_name character varying, -- Nombre Corto [Map Class: org.nahuel.model.edu.au.AcademicUnit.shortName]
	  name character varying, -- Nombre [Map Class: org.nahuel.model.edu.au.AcademicUnit.name]
	  comment character varying, -- Comentario [Map Class: org.nahuel.model.edu.au.AcademicUnit.comment]
	  url_logo character varying, -- Logo [Map Class: org.nahuel.model.edu.au.AcademicUnit.urlLogo]
	  au_type_id character varying, -- [Map Class: org.nahuel.model.edu.au.AcademicUnit.auType]
	  edu_institution_id character varying, -- [Map Class: org.nahuel.model.edu.au.AcademicUnit.eduInstitution]
	  academic_unit_parent_id character varying -- [Map Class: org.nahuel.model.edu.au.AcademicUnit.academicUnitParent]
);

INSERT INTO nahuel_academic_unit_tmp (

	SELECT 	TRIM(id)::VARCHAR, 
		state_enable, 
		TRIM(code)::VARCHAR, 
		TRIM(code_b)::VARCHAR, 
		TRIM(short_name)::VARCHAR, 
		TRIM(name)::VARCHAR, 
		TRIM(comment)::VARCHAR, 
		TRIM(url_logo)::VARCHAR, 
		TRIM(au_type_id)::VARCHAR, 
		TRIM(edu_institution_id)::VARCHAR, 
		TRIM(academic_unit_parent_id)::VARCHAR
		
	FROM 	model.academic_unit
);


UPDATE nahuel_academic_unit_tmp SET code = null WHERE CHAR_LENGTH(code) = 0;
UPDATE nahuel_academic_unit_tmp SET code_b = null WHERE CHAR_LENGTH(code_b) = 0;
UPDATE nahuel_academic_unit_tmp SET short_name = null WHERE CHAR_LENGTH(short_name) = 0;
UPDATE nahuel_academic_unit_tmp SET name = null WHERE CHAR_LENGTH(name) = 0;
UPDATE nahuel_academic_unit_tmp SET comment = null WHERE CHAR_LENGTH(comment) = 0;
UPDATE nahuel_academic_unit_tmp SET url_logo = null WHERE CHAR_LENGTH(url_logo) = 0;
UPDATE nahuel_academic_unit_tmp SET au_type_id = null WHERE CHAR_LENGTH(au_type_id) = 0;
UPDATE nahuel_academic_unit_tmp SET edu_institution_id = null WHERE CHAR_LENGTH(edu_institution_id) = 0;
UPDATE nahuel_academic_unit_tmp SET academic_unit_parent_id = null WHERE CHAR_LENGTH(academic_unit_parent_id) = 0;

-- SELECT COUNT(*) FROM nahuel_academic_unit_tmp; -- 38
-- SELECT * FROM nahuel_academic_unit_tmp;


--=================================================================================================================================================

SELECT 'FIN DEL PROCESO A'::VARCHAR FROM postulation LIMIT 100;

--=================================================================================================================================================