-- SELECT * FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio'

-- SELECT * FROM kuntur.admission_period_item WHERE admission_period_id = (SELECT id FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio')

-- SELECT * FROM kuntur.admission_period_agreement WHERE admission_period_id = (SELECT id FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio')



DELETE FROM kuntur.admission_period_item WHERE admission_period_id = (SELECT id FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio');

DELETE FROM kuntur.admission_period_agreement WHERE admission_period_id = (SELECT id FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio');

DELETE FROM kuntur.admission_period WHERE title = 'Convocatoria con convenio';


INSERT INTO kuntur.admission_period(
            id, erased, number_admission_period, in_type, year, semester, 
            title, from_date, to_date, comment, is_agreement, admission_period_status_id 
            )
(            
	SELECT 	agreement.id, 
		false::boolean, 
		null::bigint AS number_admission_period, 
		true AS in_type, 
		2016 AS year,
		2 AS semester, 
		agreement.title, 
		'2016-04-21', 
		'2016-06-01', 
		agreement.title || ' Semestre 2 2016', 				
		true,
		(SELECT id FROM kuntur.admission_period_status WHERE code = 'A') 
		
	FROM 	kuntur.agreement
);

-- SELECT * FROM kuntur.admission_period

