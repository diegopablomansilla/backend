DROP FUNCTION IF EXISTS kuntur.f_find_study_program_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) CASCADE;

-- ESta función no es óptima desde el punto de vista del código, sin embargo demora ms y con eso por ahora acanza

CREATE OR REPLACE FUNCTION kuntur.f_find_study_program_by_id(inenrrollment_id VARCHAR, user_system_id VARCHAR) 
	RETURNS SETOF VARCHAR AS $$
	
		
		SELECT 	('{ ' || '"guiView":' || kuntur.gui_type($1, $2) || ', ' || '"data":' ||  COALESCE(e.json, 'null') || '} ') AS json		
		FROM 	(

	SELECT 
		--================================================================================================================================
		'{'
			
			-------------------------------------------------------------------------------------------------------------			
			|| '"uncInStudyProgramList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_study_program.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_study_program.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_study_program.subject::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('approved', unc_in_study_program.approved::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('approvedBy', unc_in_study_program.approved_by::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('fileNumber', unc_in_study_program.file_number::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('comment', unc_in_study_program.comment::VARCHAR, '"', ', ' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '
						-------------------------------------------------------------------------------------------------------------		

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_study_program
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_study_program.org_id = org.id				
				------------------------------------------
				WHERE 	unc_in_enrrollment.id = unc_in_study_program.unc_in_enrrollment_id 
					
					AND (
						(SELECT kuntur.gui_type($1, $2)) = '0' 
						OR (
							SELECT 	COUNT(*)
							FROM	kuntur.unc_in_academic_coordinator x
							WHERE	x.person_id = $2
								AND x.org_id = org.id						

						) > 0
					)
						
			), '')  || '], '
			-------------------------------------------------------------------------------------------------------------			
			|| '"uncInAcademicPerformanceList":[' || COALESCE((
				SELECT STRING_AGG('{'
						|| kuntur.json_att_util('id', unc_in_academic_performance.id::VARCHAR, '"', ', ', false)
						|| kuntur.json_att_util('erased', unc_in_academic_performance.erased::VARCHAR, '', ', ' , true)
						|| kuntur.json_att_util('subject', unc_in_academic_performance.subject::VARCHAR, '"', ', ' , true)
						|| kuntur.json_att_util('hs', unc_in_academic_performance.hs::VARCHAR, '', ',' , true)
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInGradingScale":' ||  COALESCE(
							'{'
								|| kuntur.json_att_util('id', unc_in_grading_scale.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_grading_scale.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateNumber', unc_in_grading_scale.rate_number::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('rateLetter', unc_in_grading_scale.rate_letter::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_grading_scale.comment::VARCHAR, '"', ' ' , true)
							|| '}'
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------
						|| '"uncInStudiedType":' ||  COALESCE(

							'{'
								|| kuntur.json_att_util('id', unc_in_studied_type.id::VARCHAR, '"', ', ', false)
								|| kuntur.json_att_util('erased', unc_in_studied_type.erased::VARCHAR, '', ', ' , true)
								|| kuntur.json_att_util('code', unc_in_studied_type.code::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('name', unc_in_studied_type.name::VARCHAR, '"', ', ' , true)
								|| kuntur.json_att_util('comment', unc_in_studied_type.comment::VARCHAR, '"', ' ' , true)
							|| '}' 
							
						, 'null') || ', '
						-------------------------------------------------------------------------------------------------------------			
						|| '"org":' ||  COALESCE('{'
							|| kuntur.json_att_util('id', org.id::VARCHAR, '"', ', ', false)			
							|| kuntur.json_att_util('shortName', org.short_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('name', org.name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('originalName', org.original_name::VARCHAR, '"', ', ' , true)
							|| kuntur.json_att_util('urlPhoto', org.url_photo::VARCHAR, '"', ', ' , true)			
							|| kuntur.json_att_util('webSite', kuntur.json_att_util(org.id, org.web_site)::VARCHAR, '"', ', ' , true)						
							|| kuntur.json_att_util('countryCode', kuntur.json_att_util(org.country_code)::VARCHAR, '"', ' ' , true)				
						|| '}', 'null') || ' '

					|| '}', ', ') AS json	
				FROM kuntur.unc_in_academic_performance
				------------------------------------------
				LEFT JOIN kuntur.unc_in_grading_scale
					ON kuntur.unc_in_academic_performance.unc_in_grading_scale_id = unc_in_grading_scale.id
				------------------------------------------
				LEFT JOIN kuntur.unc_in_studied_type
					ON kuntur.unc_in_academic_performance.unc_in_studied_type_id = unc_in_studied_type.id
				------------------------------------------
				LEFT JOIN kuntur.org
					ON kuntur.unc_in_academic_performance.org_id = org.id
				------------------------------------------
				WHERE unc_in_enrrollment.id = unc_in_academic_performance.unc_in_enrrollment_id 
				AND (
						(SELECT kuntur.gui_type($1, $2)) = '0' 
						OR (
							SELECT 	COUNT(*)
							FROM	kuntur.unc_in_academic_coordinator x
							WHERE	x.person_id = $2
								AND x.org_id = org.id						

						) > 0
					)
				
			), '')  || '] '
		--================================================================================================================================	
		|| '}' AS json,
		unc_in_enrrollment.id AS unc_in_enrrollment_id /*id*/
	--=================================================================================================================================
	FROM kuntur.unc_in_enrrollment	
	------------------------------------------
	JOIN kuntur.enrrollment
		ON kuntur.unc_in_enrrollment.id = enrrollment.id		
	------------------------------------------
	LEFT JOIN kuntur.org
		ON kuntur.enrrollment.org_id = org.id		
	------------------------------------------
	LEFT JOIN kuntur.admission_period
		ON kuntur.enrrollment.admission_period_id = admission_period.id	
	------------------------------------------
	LEFT JOIN kuntur.enrrollment_status
		ON kuntur.enrrollment.enrrollment_status_id = enrrollment_status.id	
	--================================================================================================
	WHERE unc_in_enrrollment.id  = $1
			
		) e
	--------------------------------------------------------------------------------------		
		
		INNER JOIN
			(	
				SELECT	count(*) as canti, x.enrrollment_id 
				FROM 	kuntur.enrrollment_stakeholder x 
				WHERE 	x.user_system_id = $2::VARCHAR  
					AND x.enrrollment_id = $1
					AND (x.code = 1 OR x.code = 2 OR x.code = 3)	
				GROUP BY x.enrrollment_id 
				HAVING count(*) > 0

			) x
		ON	x.enrrollment_id = $1
		WHERE 	$1 IS NOT NULL 
			AND CHAR_LENGTH(TRIM($1)) > 0 
			AND TRIM($1) = e.unc_in_enrrollment_id
			
		;
$$ LANGUAGE SQL;

/*
SELECT * 
FROM kuntur.enrrollment_stakeholder 
JOIN kuntur.person
	ON person.id = enrrollment_stakeholder.user_system_id
WHERE enrrollment_id = '489090264c037dd8014d1e72dc3f0666'

SELECT * FROM kuntur.enrrollment WHERE number_enrrollment = 898

COPY (SELECT  * FROM kuntur.f_find_study_program_by_id ('489090264c037dd8014d1e72dc3f0666', (SELECT id FROM kuntur.user_system WHERE name = '46385')))
TO '/home/java/Descargas/json.sql';

COPY (SELECT  * FROM kuntur.f_find_study_program_by_id ('489090264c037dd8014d1e72dc3f0666', 'f1cc9355-2288-45d1-9537-9f38cab18aaf'))
TO '/home/java/Descargas/json.sql';
*/