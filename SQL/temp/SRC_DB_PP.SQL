--Crea vista de agreement, tipos y estados.

DROP VIEW IF EXISTS  kuntur.v_agreement_item CASCADE;

CREATE OR REPLACE VIEW kuntur.v_agreement_item AS 


	SELECT 
		agreement_item.id /*id*/,
		agreement_item.erased /*erased*/,
		agreement_item.in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		agreement_item.out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		agreement.id AS agreement_id /*id*/,
		agreement.erased AS agreement_erased /*erased*/,
		agreement.code AS agreement_code /*Código*/,
		agreement.name AS agreement_name /*Nombre*/,
		agreement.from_date AS agreement_from_date /*Fecha Inicio*/,
		agreement.to_date AS agreement_to_date /*Fecha Fin*/,
		agreement.comment AS agreement_comment /*Comentario*/,
	------------------------------------------
		org.id AS org_id /*id*/,
		org.erased AS org_erased /*erased*/,
		org.short_name AS org_short_name /*Sigla*/,
		org.name AS org_name /*Nombre*/,
		org.original_name AS org_original_name /*Nombre en el idioma original*/,
		org.photo_url AS org_photo_url /*Logo*/,
		org.web_site AS org_web_site /*Sitio Web*/,
		org.comment AS org_comment /*Comentario*/,
		org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org.primary_org AS org_primary_org /*Institución Primaria del Sistema*/

	FROM kuntur.agreement_item
	------------------------------------------
	LEFT JOIN kuntur.agreement agreement
		ON kuntur.agreement_item.agreement_id = agreement.id
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.agreement_item.org_id = org.id
	------------------------------------------
	ORDER BY 	org_short_name, 
			org_name;

--- ==================================================================


DROP VIEW IF EXISTS  kuntur.v_agreement CASCADE;

CREATE OR REPLACE VIEW kuntur.v_agreement AS 

	SELECT 
		agreement.id /*id*/,
		agreement.erased /*erased*/,
		agreement.code /*Código*/,
		agreement.name /*Nombre*/,
		agreement.from_date /*Fecha Inicio*/,
		agreement.to_date /*Fecha Fin*/,
		agreement.comment /*Comentario*/,
	------------------------------------------
		agreement_type.id AS agreement_type_id /*id*/,
		agreement_type.erased AS agreement_type_erased /*erased*/,
		agreement_type.code AS agreement_type_code /*Código*/,
		agreement_type.name AS agreement_type_name /*Nombre*/,
		agreement_type.comment AS agreement_type_comment /*Comentario*/,
	------------------------------------------
		agreement_status.id AS agreement_status_id /*id*/,
		agreement_status.erased AS agreement_status_erased /*erased*/,
		agreement_status.code AS agreement_status_code /*Código*/,
		agreement_status.name AS agreement_status_name /*Nombre*/,
		agreement_status.comment AS agreement_status_comment /*Comentario*/,
	------------------------------------------
		org.id AS org_id /*id*/,
		org.erased AS org_erased /*erased*/,
		org.short_name AS org_short_name /*Sigla*/,
		org.name AS org_name /*Nombre*/,
		org.original_name AS org_original_name /*Nombre en el idioma original*/,
		org.photo_url AS org_photo_url /*Logo*/,
		org.web_site AS org_web_site /*Sitio Web*/,
		org.comment AS org_comment /*Comentario*/,
		org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org.primary_org AS org_primary_org, /*Institución Primaria del Sistema*/
	------------------------------------------
		(
			SELECT 	count(*) 
			FROM 	kuntur.agreement_item ai
			WHERE 	agreement.id = ai.agreement_id 
		) AS orgs
	FROM kuntur.agreement
	------------------------------------------
	LEFT JOIN kuntur.agreement_type agreement_type
		ON kuntur.agreement.agreement_type_id = agreement_type.id
	------------------------------------------
	LEFT JOIN kuntur.agreement_status agreement_status
		ON kuntur.agreement.agreement_status_id = agreement_status.id
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.agreement.org_id = org.id
	------------------------------------------
	ORDER BY 	from_date DESC, 
			to_date	DESC;

-- SELECT * FROM kuntur.v_agreement;	

 
DROP FUNCTION IF EXISTS findAgreements(busqueda TEXT) CASCADE;

CREATE OR REPLACE FUNCTION findAgreements(busqueda TEXT)
	RETURNS SETOF kuntur.v_agreement AS $$
	BEGIN
		RETURN QUERY SELECT	*
		FROM 	kuntur.v_agreement
		WHERE 	translate(coalesce(code::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE 	translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
			OR translate(coalesce(name::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE 	translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 	
			OR translate(coalesce(comment::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE 	translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 		
			
			--OR translate(coalesce(agreement_type_code::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
			--	ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
			OR translate(coalesce(agreement_type_name::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
			OR translate(coalesce(agreement_type_comment::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 		

				
			--OR translate(coalesce(agreement_status_code::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
			--	ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')
			OR translate(coalesce(agreement_status_name::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')
			OR translate(coalesce(agreement_status_comment::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN')

			OR lower(busqueda) IN (SELECT lower(ai.org_short_name) FROM kuntur.v_agreement_item ai WHERE v_agreement.id = ai.agreement_id)
			OR lower(busqueda) IN (SELECT lower(ai.org_name) FROM kuntur.v_agreement_item ai WHERE v_agreement.id = ai.agreement_id)
			OR lower(busqueda) IN (SELECT lower(ai.org_comment) FROM kuntur.v_agreement_item ai WHERE v_agreement.id = ai.agreement_id)
		;	
				
	END; $$
	LANGUAGE PLPGSQL;

--SELECT * FROM findAgreements('iua') ORDER BY name DESC;

-- ======================================================================================

DROP VIEW IF EXISTS  kuntur.v_contact CASCADE;

CREATE OR REPLACE VIEW kuntur.v_contact AS 
	SELECT 
		contact.id /*id*/,
		contact.erased /*erased*/,
		contact.reception_student /*Responsable de Estudiantes a Recibir*/,
		contact.sending_student /*Responsable de Estudiantes a Enviar*/,
	------------------------------------------
		org.id AS org_id /*id*/,
		org.erased AS org_erased /*erased*/,
		org.short_name AS org_short_name /*Sigla*/,
		org.name AS org_name /*Nombre*/,
		org.original_name AS org_original_name /*Nombre en el idioma original*/,
		org.photo_url AS org_photo_url /*Logo*/,
		org.web_site AS org_web_site /*Sitio Web*/,
		org.comment AS org_comment /*Comentario*/,
		org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org.primary_org AS org_primary_org /*Institución Primaria del Sistema*/,
	------------------------------------------
		person.id AS person_id /*id*/,
		person.erased AS person_erased /*erased*/,
		person.given_name AS person_given_name /*Nombre de Pila*/,
		person.middle_name AS person_middle_name /*Segundo Nombre*/,
		person.family_name AS person_family_name /*Apellido*/,
		person.birth_date AS person_birth_date /*Fecha de Nacimiento*/,
		person.masculine AS person_masculine /*Masculino*/,
		person.photo_url AS person_photo_url /*Foto*/,
		person.comment AS person_comment /*Comentario*/,
		person.birth_country_code AS person_birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		person.birth_country AS person_birth_country /*País Nacimiento*/,
		person.birth_admin_area_level1_code AS person_birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		person.birth_admin_area_level1 AS person_birth_admin_area_level1 /*Provincia Nacimiento*/,
		person.birth_admin_area_level2 AS person_birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		person.birth_locality AS person_birth_locality /*Localidad Nacimiento*/,
		person.birth_lat AS person_birth_lat /*Latitud Nacimiento*/,
		person.birth_lng AS person_birth_lng /*Longitud Nacimiento*/
	FROM kuntur.contact
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.contact.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.person person
		ON kuntur.contact.person_id = person.id;

------====================================================================================================

CREATE OR REPLACE VIEW kuntur.v_agreement_item_ou AS 
	SELECT 
		agreement_item_ou.id /*id*/,
		agreement_item_ou.erased /*erased*/,
		agreement_item_ou.in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		agreement_item_ou.out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		agreement_item.id AS agreement_item_id /*id*/,
		agreement_item.erased AS agreement_item_erased /*erased*/,
		agreement_item.in_units AS agreement_item_in_units /*Cantidad Plazas de Estudiantes a Recibir*/,
		agreement_item.out_units AS agreement_item_out_units /*Cantidad de Estudiantes a Enviar*/,
	------------------------------------------
		org.id AS org_id /*id*/,
		org.erased AS org_erased /*erased*/,
		org.short_name AS org_short_name /*Sigla*/,
		org.name AS org_name /*Nombre*/,
		org.original_name AS org_original_name /*Nombre en el idioma original*/,
		org.photo_url AS org_photo_url /*Logo*/,
		org.web_site AS org_web_site /*Sitio Web*/,
		org.comment AS org_comment /*Comentario*/,
		org.country_code AS org_country_code /*País - Código ISO 3166-1 Alfa-2*/,
		org.primary_org AS org_primary_org /*Institución Primaria del Sistema*/
	FROM kuntur.agreement_item_ou
	------------------------------------------
	LEFT JOIN kuntur.agreement_item agreement_item
		ON kuntur.agreement_item_ou.agreement_item_id = agreement_item.id
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.agreement_item_ou.org_id = org.id;
