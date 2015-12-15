
INSERT INTO kuntur.enrrollment_log(
            id, erased, code_start, name_start, code_end, name_end, promotion_date, 
            enrrollment_status_a_id, enrrollment_status_b_id, enrrollment_id, 
            user_system_id)
/*    VALUES (?, false, ?, ?, ?, ?, ?, ?, ?, ?, ?);
*/


with states as (
	select s2.id as cur_id, s2.code as cur_state, s1.code, s1.name, s1.id, min(s3.code) as code_end
	from kuntur.enrrollment_status s3
	inner join
	 kuntur.enrrollment_status s2
	on s2.code >= s3.code
	inner join
	 kuntur.enrrollment_status s1
	on s1.code < s3.code
	group by s2.id, s1.code, s1.name, s1.id
	order by 2
    )

SELECT 	/*e.id,
	s.cur_state as code,*/
	uuid_generate_v4() AS id,
	false AS erased,
	s.code AS code_start,
	s.name AS name_start,
	s.code_end,
	(SELECT s2.name FROM kuntur.enrrollment_status s2 WHERE s.code_end = s2.code) AS name_end,
	now() AS promotion_date,
	s.id AS enrrollment_status_a_id,
	(SELECT s2.id FROM kuntur.enrrollment_status s2 WHERE s.code_end = s2.code) AS enrrollment_status_b_id,
	--(SELECT e.id FROM kuntur.enrrollment e WHERE e.enrrollment_status_id = (SELECT s3.id FROM kuntur.enrrollment_status s3 WHERE s3.code = 'K') LIMIT 1) AS enrrollment_id
	e.id AS enrrollment_id,
	(select id from kuntur.user_system where email ilike '%correa%') as user_id
FROM 	kuntur.enrrollment e
JOIN	states s
on	e.enrrollment_status_id = s.cur_id
WHERE   s.code <> 'z' 
	--AND e.id = '000000003ed279e4013ed2f017000376'
ORDER BY e.id, s.code	

-- select * from kuntur.enrrollment_log order by enrrollment_id, code_start
