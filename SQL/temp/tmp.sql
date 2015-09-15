-- select * from kuntur.enrrollment_status
-- select * from kuntur.enrrollment_stakeholder order by enrrollment_id, code, user_system_id


SELECT 	s.code AS status_code, 
	es.code AS stakeholder_code,
	CASE 	
	
		WHEN  s.code = 'A' AND es.code = '2' THEN '1A'
		WHEN  s.code = 'A' AND es.code = '3' THEN '0'

		--WHEN  s.code = 'B' AND es.code = '3' THEN '2B'
		WHEN  s.code = 'B' AND es.code = '3' THEN '0'

		WHEN  s.code = 'C' AND es.code = '2' THEN '3C'
		WHEN  s.code = 'C' AND es.code = '3' THEN '0'

		WHEN  s.code = 'D' AND es.code = '2' THEN '4D'
		WHEN  s.code = 'D' AND es.code = '3' THEN '0'

		WHEN  s.code = 'E' AND es.code = '2' THEN '5E'
		WHEN  s.code = 'E' AND es.code = '3' THEN '0'

		--WHEN  s.code = 'F' AND es.code = '3' THEN '6F'
		WHEN  s.code = 'F' AND es.code = '3' THEN '0'

		WHEN  s.code = 'G' AND es.code = '2' THEN '7G'
		WHEN  s.code = 'G' AND es.code = '3' THEN '0'

		WHEN  s.code = 'H' AND es.code = '2' THEN '8H'
		WHEN  s.code = 'H' AND es.code = '3' THEN '0'

		--WHEN  s.code = 'I' AND es.code = '3' THEN '9I'
		WHEN  s.code = 'I' AND es.code = '3' THEN '0'

		WHEN  s.code = 'J' AND es.code = '2' THEN '10J'
		WHEN  s.code = 'J' AND es.code = '3' THEN '0'

		--WHEN  s.code = 'K' AND es.code = '2' THEN '11K'
		WHEN  s.code = 'K' AND es.code = '3' THEN '-1'

		-- WHEN  s.code = 'Z' AND es.code = '2' THEN '12Z'
		WHEN  s.code = 'Z' AND es.code = '3' THEN '-1'

		ELSE '-1'
		
	END AS gui_type	

FROM	kuntur.enrrollment_stakeholder es
JOIN	kuntur.enrrollment e
	ON e.id = es.enrrollment_id
JOIN	kuntur.enrrollment_status s
	ON s.id = e.enrrollment_status_id	
WHERE	es.enrrollment_id = '000000003f337709013f33cac635000e'
	--AND es.user_system_id = '4900a83e-af5f-49c8-9cc8-ca31f739691d'
	-- AND es.user_system_id = '4d47d7df-b6aa-48ce-9075-918d10a9da99'
	-- AND es.user_system_id = 'f6da808d-f231-4f0f-b068-ee65efedd337'
	-- AND es.user_system_id = '8af11fc2-2be1-4882-939f-e8d56703f8ae'
	-- AND es.user_system_id = '9431f54e-654a-46a7-82f1-7be9fc9b6f6e'
	-- AND es.user_system_id = '4e6a13cf-106c-4400-af44-99ff50b7ee1e'
	-- AND es.user_system_id = '187c2999-2533-4ca2-9d58-6f9aa366f281'
	-- AND es.user_system_id = '82be2216-2761-4746-94f8-82965a8ffea5'
	-- AND es.user_system_id = '8990c66d-9b70-4736-bff6-6f653582016c'
ORDER BY es.code

/*
SELECT  es.*	
FROM	kuntur.enrrollment_stakeholder es
JOIN	kuntur.enrrollment e
	ON e.id = es.enrrollment_id
JOIN	kuntur.enrrollment_status s
	ON s.id = e.enrrollment_status_id	
WHERE	es.enrrollment_id = '000000003f337709013f33cac635000e'
ORDER BY code
*/


