create view v_borrame AS
SELECT

	enrrollment_id,
	'{'

		|| kuntur.json_att_util('id', enrrollment_log.id::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('erased', enrrollment_log.erased::VARCHAR, '', ', ', true)

		|| kuntur.json_att_util('codeStart', enrrollment_log.code_start::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('nameStart', enrrollment_log.name_start::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('codeEnd', enrrollment_log.code_end::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('nameEnd', enrrollment_log.name_end::VARCHAR, '"', ', ', true)

		|| kuntur.json_att_util('promotionDate', enrrollment_log.promotion_date::VARCHAR, '"', ', ', true)

		-------------------------------------------------------------------------------------------------------------

		|| '"userSystem":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', user_system.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', user_system.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('name', user_system.name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('email', user_system.email::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('givenName', person.given_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('middleName', person.middle_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('familyName', person.family_name::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('male', person.male::VARCHAR, '', ' ', true)
			|| '}', 'null') || ', '

		-------------------------------------------------------------------------------------------------------------

		-------------------------------------------------------------------------------------------------------------

		|| '"enrrollmentStatusA":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', enrrollment_status_a.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', enrrollment_status_a.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('code', enrrollment_status_a.code::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('name', enrrollment_status_a.name::VARCHAR, '"', ' ', true)
			|| '}', 'null') || ', '

		-------------------------------------------------------------------------------------------------------------

		-------------------------------------------------------------------------------------------------------------

		|| '"enrrollmentStatusB":' ||  COALESCE(
			'{'

				|| kuntur.json_att_util('id', enrrollment_status_b.id::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('erased', enrrollment_status_b.erased::VARCHAR, '', ', ', true)

				|| kuntur.json_att_util('code', enrrollment_status_b.code::VARCHAR, '"', ', ', true)

				|| kuntur.json_att_util('name', enrrollment_status_b.name::VARCHAR, '"', ' ', true)
			|| '}', 'null') || ' '

		-------------------------------------------------------------------------------------------------------------
	|| '}'
	
FROM kuntur.enrrollment_log
	LEFT JOIN kuntur.enrrollment_status enrrollment_status_b
		ON enrrollment_status_b.id = enrrollment_log.enrrollment_status_b_id 
	LEFT JOIN kuntur.enrrollment_status enrrollment_status_a
		ON enrrollment_status_a.id = enrrollment_log.enrrollment_status_a_id 
	LEFT JOIN kuntur.user_system
		ON user_system.id = enrrollment_log.user_system_id 
	LEFT JOIN kuntur.person
		ON user_system.id = person.id;

COPY (SELECT  * FROM v_borrame) TO '/home/java/Descargas/json.sql';

select * from kuntur.enrrollment where id = '489090263d5547d6013d55602f260003'
		