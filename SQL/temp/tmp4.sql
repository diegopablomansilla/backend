-------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_org_json CASCADE;

CREATE OR REPLACE VIEW kuntur.v_org_json AS

	SELECT	'"org":{'
			|| '"id":{"val":' || COALESCE('"' || org.id || '"', 'null') || ', "mod":"R"}, '
			|| '"erased":{"val":' || COALESCE('' || org.erased || '', 'null') || ', "mod":"R"}, '
			|| '"short_name":{"val":' || COALESCE('"' || org.short_name || '"', 'null') || ', "mod":"R"}, '
			|| '"name":{"val":' || COALESCE('"' || org.name || '"', 'null') || ', "mod":"R"}, '
			|| '"original_name":{"val":' || COALESCE('"' || org.original_name || '"', 'null') || ', "mod":"R"}, '
			|| '"url_photo":{"val":' || COALESCE('"' || org.url_photo || '"', 'null') || ', "mod":"R"}, '
			|| '"web_site":{"val":' || COALESCE('"' || org.web_site || '"', 'null') || ', "mod":"R"}, '
			|| '"comment":{"val":' || COALESCE('"' || org.comment || '"', 'null') || ', "mod":"R"}, '
			|| '"country_code":{"val":' || COALESCE('"' || org.country_code || '"', 'null') || ', "mod":"R"}, '
			|| '"primary_org":{"val":' || COALESCE('' || org.primary_org || '', 'null') || ', "mod":"R"}, '
			|| '"code_ona":{"val":' || COALESCE('' || org.code_ona || '', 'null') || ', "mod":"R"}, '
			|| '"code_guarani":{"val":' || COALESCE('"' || org.code_guarani || '"', 'null') || ', "mod":"R"}'
		|| '}' AS org_json,			
		id
	FROM 	kuntur.org	
	WHERE	id = '48909026447a8fc901447af5bf310006';

-------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_user_system_json CASCADE;

CREATE OR REPLACE VIEW kuntur.v_user_system_json AS

	SELECT	'"userSystem":{'

			|| '"id":{"val":' || COALESCE('"' || user_system.id  || '"', 'null') || ', "mod":"R"}, '
			|| '"erased":{"val":' || COALESCE('' || user_system.erased  || '', 'null') || ', "mod":"R"}, '
			|| '"name":{"val":' || COALESCE('"' || user_system.name  || '"', 'null') || ', "mod":"R"}, '
			|| '"pass":{"val":' || COALESCE('"' || user_system.pass  || '"', 'null') || ', "mod":"R"}, '
			|| '"email":{"val":' || COALESCE('"' || user_system.email  || '"', 'null') || ', "mod":"R"}, '
			|| '"comment":{"val":' || COALESCE('"' || user_system.comment  || '"', 'null') || ', "mod":"R"}'
		|| '}' AS org_json,		
		id
	FROM 	kuntur.user_system	
	WHERE	id = '004e9f79-28e1-4f48-a1e9-c42ee122b6dd';	

-------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_student_json CASCADE;

CREATE OR REPLACE VIEW kuntur.v_student_json AS

	SELECT	'"student":{'

			|| '"id":{"val":' || COALESCE('"' || student.id  || '"', 'null') || ', "mod":"R"}, '
			|| '"erased":{"val":' || COALESCE('' || student.erased  || '', 'null') || ', "mod":"R"}, '
			|| '"file_number":{"val":' || COALESCE('' || student.file_number  || '', 'null') || ', "mod":"R"}, '
			|| '"institution_original_name":{"val":' || COALESCE('"' || student.institution_original_name  || '"', 'null') || ', "mod":"R"}, '
			|| '"institution_web_site":{"val":' || COALESCE('"' || student.institution_web_site  || '"', 'null') || ', "mod":"R"} ,'
			|| '"institution_country_code":{"val":' || COALESCE('"' || student.institution_country_code  || '"', 'null') || ', "mod":"R"}'
		|| '}' AS org_json,		
		id
	FROM 	kuntur.student
	WHERE	id = 'ec724951-cd3e-4f49-b2cc-6e9136124033';		

-------------------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS kuntur.v_admission_period_json CASCADE;

CREATE OR REPLACE VIEW kuntur.v_admission_period_json AS

	SELECT	'"admissionPeriod":{'
		