-- Function: kuntur.f_update_stakeholders(character varying)

-- DROP FUNCTION kuntur.f_update_stakeholders(character varying);

CREATE OR REPLACE FUNCTION kuntur.f_update_stakeholders(enrrollmentid character varying)
  RETURNS boolean AS
$BODY$
DECLARE
	statusId VARCHAR = null;
	statusCode VARCHAR = null;
	studentId VARCHAR = null;
	auxCount INTEGER = 0;

	org VARCHAR = null;
	person VARCHAR = null;
BEGIN

	SELECT enrrollment_status_id INTO statusId FROM kuntur.enrrollment WHERE id = enrrollmentId;

	SELECT code INTO statusCode FROM kuntur.enrrollment_status WHERE id = statusId;

	IF statusCode = 'A' OR statusCode = 'C' OR statusCode = 'E' OR statusCode = 'G' THEN--lo tiene el estudiante

		SELECT student_id INTO studentId FROM kuntur.enrrollment WHERE id = enrrollmentId;

		SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = studentid AND enrrollment_id = enrrollmentId;

		IF auxCount > 0 THEN	

			UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = enrrollmentId;

			UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = studentId AND enrrollment_id = enrrollmentId;

		ELSE

			INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, studentId, enrrollmentId);

		END IF;

		RETURN true;

	ELSIF statusCode = 'B' OR statusCode = 'F' OR statusCode = 'I' THEN--lo tiene la pri

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = enrrollmentId;

		RETURN true;

--------------------CORRECCION------------------------------
	ELSIF statusCode = 'D' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_coordinator WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;
	ELSIF statusCode = 'H' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_office WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;

	ELSIF statusCode = 'J' THEN

		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  code = 2 AND enrrollment_id = $1;

		FOR org IN SELECT DISTINCT org_id FROM --tengo q unir las dos tablas para obtener todas las organizaciones que intervienen en la postulacion y asi encontrar las personas de despacho correspondientes
			(SELECT org_id FROM kuntur.unc_in_study_program WHERE unc_in_enrrollment_id = enrrollmentid
				UNION
				SELECT org_id FROM kuntur.unc_in_academic_performance WHERE unc_in_enrrollment_id = enrrollmentid) AS a

		LOOP

			FOR person IN SELECT DISTINCT person_id FROM kuntur.unc_in_academic_office WHERE org_id = org

			LOOP

				SELECT count(*) INTO auxCount FROM kuntur.enrrollment_stakeholder WHERE user_system_id = person AND enrrollment_id = enrrollmentId;

				IF auxCount > 0 THEN	--controlo si tengo q actualizar enrrollment_stakeholder o ingresar un nuevo registro (para la persona y ese enrrollment)

					UPDATE kuntur.enrrollment_stakeholder SET code = 2 WHERE user_system_id = person AND enrrollment_id = $1;

				ELSE

					INSERT INTO kuntur.enrrollment_stakeholder (id, erased, code, user_system_id, enrrollment_id) VALUES (uuid_generate_v4()::varchar, false, 2, person, enrrollmentId);

				END IF;

			END LOOP;

		END LOOP;

		RETURN true;

--------------------FIN CORRECCION----------------------------
	
	
	ELSIF statusCode = 'K' OR statusCode = 'z' THEN


		UPDATE kuntur.enrrollment_stakeholder SET code = 1 WHERE  enrrollment_id = enrrollmentId;

		RETURN true;

	ELSE

		RETURN false;

	END IF;

		

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

------------------------------CORRECCION DE PERMISOS PARA ENRROLLMENT EXISTENTES----------------------------------------------------

UPDATE kuntur.enrrollment_stakeholder
SET code = 3
FROM
(SELECT es.*
	FROM kuntur.enrrollment_stakeholder es
JOIN
	kuntur.user_group ug
ON
	ug.user_system_id = es.user_system_id
JOIN
	kuntur.group_system gs
ON
	gs.id = ug.group_system_id
WHERE 
	gs.name ilike '%admin%'
AND
	es.code = 1
) x
WHERE x.id = kuntur.enrrollment_stakeholder.id

