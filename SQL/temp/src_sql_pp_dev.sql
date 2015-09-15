
CREATE OR REPLACE VIEW kuntur.v_agreement_item_ou AS 
	SELECT 
		agreement_item_ou.id/*id*/,
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


DROP VIEW kuntur.v_responsables;

CREATE OR REPLACE VIEW kuntur.v_responsables AS 
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
		person.birth_lng AS person_birth_lng /*Longitud Nacimiento*/,

	--------------------------------------------
		agreement_item.id as agreement_item_id,
		agreement_item.erased as agreement_item_erased,
		agreement_item.in_units as agreement_item_in_units,
		agreement_item.out_units as agreement_item_out_units,
		agreement_item.agreement_id as agreement_item_agreement_id,
		agreement_item.org_id as agreement_item_org_id,
	---------------------------------------------
		person_email.id as person_email_id,
		person_email.erased as person_email_erased,
		person_email.email as person_email_email,
		person_email.comment as person_email_comment,
		person_email.person_id as person_email_person_id,
	-----------------------------------------------
		person_phone.id as person_phone_id,
		person_phone.erased as person_phone_erased,
		person_phone.country_code as person_phone_country_code,
		person_phone.phone_number as person_phone_phone_number,
		person_phone.comment as person_phone_comment,
		person_phone.person_id as person_phone_person_id
	
	FROM kuntur.contact
	------------------------------------------
	LEFT JOIN kuntur.org org
		ON kuntur.contact.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.person person
		ON kuntur.contact.person_id = person.id
	------------------------------------------
	LEFT JOIN kuntur.agreement_item agreement_item
		ON agreement_item.org_id = org.id
	------------------------------------------
	LEFT JOIN kuntur.person_email person_email
		ON person_email.person_id = person.id

	LEFT JOIN kuntur.person_phone person_phone
		ON person_phone.person_id=person.id;

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

DROP VIEW kuntur.v_agreement;

CREATE OR REPLACE VIEW kuntur.v_agreement AS 
 SELECT agreement.id,
    agreement.erased,
    agreement.code,
    agreement.name,
    agreement.from_date,
    agreement.to_date,
    agreement.comment,
    agreement_type.id AS agreement_type_id,
    agreement_type.erased AS agreement_type_erased,
    agreement_type.code AS agreement_type_code,
    agreement_type.name AS agreement_type_name,
    agreement_type.comment AS agreement_type_comment,
    agreement_status.id AS agreement_status_id,
    agreement_status.erased AS agreement_status_erased,
    agreement_status.code AS agreement_status_code,
    agreement_status.name AS agreement_status_name,
    agreement_status.comment AS agreement_status_comment,
    org.id AS org_id,
    org.erased AS org_erased,
    org.short_name AS org_short_name,
    org.name AS org_name,
    org.original_name AS org_original_name,
    org.photo_url AS org_photo_url,
    org.web_site AS org_web_site,
    org.comment AS org_comment,
    org.country_code AS org_country_code,
    org.primary_org AS org_primary_org,
    ( SELECT count(*) AS count
           FROM kuntur.agreement_item ai
          WHERE agreement.id::text = ai.agreement_id::text) AS orgs
   FROM kuntur.agreement
     LEFT JOIN kuntur.agreement_type agreement_type ON agreement.agreement_type_id::text = agreement_type.id::text
     LEFT JOIN kuntur.agreement_status agreement_status ON agreement.agreement_status_id::text = agreement_status.id::text
     LEFT JOIN kuntur.org org ON agreement.org_id::text = org.id::text
  ORDER BY agreement.from_date DESC, agreement.to_date DESC;

DROP VIEW kuntur.v_agreement_contact;

CREATE OR REPLACE VIEW kuntur.v_agreement_contact AS 
 SELECT agreement_contact.id,
    agreement_contact.erased,
    agreement_item.id AS agreement_item_id,
    agreement_item.erased AS agreement_item_erased,
    agreement_item.in_units AS agreement_item_in_units,
    agreement_item.out_units AS agreement_item_out_units,
    contact.id AS contact_id,
    contact.erased AS contact_erased,
    contact.reception_student AS contact_reception_student,
    contact.sending_student AS contact_sending_student
   FROM kuntur.agreement_contact
     LEFT JOIN kuntur.agreement_item agreement_item ON agreement_contact.agreement_item_id::text = agreement_item.id::text
     LEFT JOIN kuntur.contact contact ON agreement_contact.contact_id::text = contact.id::text;

DROP VIEW kuntur.v_agreement_item;

CREATE OR REPLACE VIEW kuntur.v_agreement_item AS 
 SELECT agreement_item.id,
    agreement_item.erased,
    agreement_item.in_units,
    agreement_item.out_units,
    agreement.id AS agreement_id,
    agreement.erased AS agreement_erased,
    agreement.code AS agreement_code,
    agreement.name AS agreement_name,
    agreement.from_date AS agreement_from_date,
    agreement.to_date AS agreement_to_date,
    agreement.comment AS agreement_comment,
    org.id AS org_id,
    org.erased AS org_erased,
    org.short_name AS org_short_name,
    org.name AS org_name,
    org.original_name AS org_original_name,
    org.photo_url AS org_photo_url,
    org.web_site AS org_web_site,
    org.comment AS org_comment,
    org.country_code AS org_country_code,
    org.primary_org AS org_primary_org
   FROM kuntur.agreement_item
     LEFT JOIN kuntur.agreement agreement ON agreement_item.agreement_id::text = agreement.id::text
     LEFT JOIN kuntur.org org ON agreement_item.org_id::text = org.id::text
  ORDER BY org.short_name, org.name;

DROP VIEW kuntur.v_contact;

CREATE OR REPLACE VIEW kuntur.v_contact AS 
 SELECT contact.id,
    contact.erased,
    contact.reception_student,
    contact.sending_student,
    org.id AS org_id,
    org.erased AS org_erased,
    org.short_name AS org_short_name,
    org.name AS org_name,
    org.original_name AS org_original_name,
    org.photo_url AS org_photo_url,
    org.web_site AS org_web_site,
    org.comment AS org_comment,
    org.country_code AS org_country_code,
    org.primary_org AS org_primary_org,
    person.id AS person_id,
    person.erased AS person_erased,
    person.given_name AS person_given_name,
    person.middle_name AS person_middle_name,
    person.family_name AS person_family_name,
    person.birth_date AS person_birth_date,
    person.masculine AS person_masculine,
    person.photo_url AS person_photo_url,
    person.comment AS person_comment,
    person.birth_country_code AS person_birth_country_code,
    person.birth_country AS person_birth_country,
    person.birth_admin_area_level1_code AS person_birth_admin_area_level1_code,
    person.birth_admin_area_level1 AS person_birth_admin_area_level1,
    person.birth_admin_area_level2 AS person_birth_admin_area_level2,
    person.birth_locality AS person_birth_locality,
    person.birth_lat AS person_birth_lat,
    person.birth_lng AS person_birth_lng
   FROM kuntur.contact
     LEFT JOIN kuntur.org org ON contact.org_id::text = org.id::text
     LEFT JOIN kuntur.person person ON contact.person_id::text = person.id::text;



----==============================================================================



DROP VIEW IF EXISTS kuntur.v_plazas_util CASCADE;

CREATE OR REPLACE VIEW kuntur.v_plazas_util AS 

	SELECT 	o.short_name::text as rowid, 
		o2.short_name::text as att, 
		(coalesce(aiu.in_units::varchar, '*') || '-' ||  coalesce(aiu.out_units::varchar, '*'))::text AS val,		
		agreement_id
	FROM 	kuntur.agreement_item_ou aiu
	JOIN	kuntur.agreement_item ai
		ON ai.id = aiu.agreement_item_id
	JOIN	kuntur.org o
		ON o.id = ai.org_id
	JOIN	kuntur.org o2
		ON o2.id = aiu.org_id
		--WHERE ai.agreement_id = '50bcc67d-58a4-4416-bbdf-e66f9d3b8ca1'
	ORDER by 1, 2;

/*
SELECT 	rowid,
	att,
	val
	
FROM 	kuntur.v_plazas_util 
WHERE 	agreement_id = '50bcc67d-58a4-4416-bbdf-e66f9d3b8ca1';
*/


DROP FUNCTION IF EXISTS f_plazas(agreementId text);

CREATE OR REPLACE FUNCTION f_plazas(agreementId text) RETURNS TEXT AS $$

DECLARE cols VARCHAR;
DECLARE col2 VARCHAR;
DECLARE col3 VARCHAR;
DECLARE sql1 TEXT;
DECLARE result_var TEXT;

BEGIN
	--Busco la organizacion general (unc)
	SELECT o.short_name INTO col3
	FROM kuntur.org o inner join kuntur.agreement a on a.org_id=o.id where a.id=agreementId;

	--busco los nombres variables de las columnas a devolver
	SELECT 	string_agg(short_name, ',') INTO col2 FROM (
	SELECT short_name
	FROM kuntur.agreement_item_ou ou INNER JOIN kuntur.org o ON o.id= ou.org_id INNER JOIN kuntur.agreement_item ai ON ai.id=ou.agreement_item_id 
	WHERE ai.agreement_id=agreementId GROUP BY short_name
	--FROM 	kuntur.org o2 
	--WHERE 	o2.org_id is not null 
	ORDER BY 1) AS COSA;

	--busco las columnas variables a devolver
	SELECT 	'ORG text, ' || string_agg(short_name || ' text', ',') INTO cols FROM(
	SELECT short_name
	FROM kuntur.agreement_item_ou ou INNER JOIN kuntur.org o ON o.id= ou.org_id INNER JOIN kuntur.agreement_item ai ON ai.id=ou.agreement_item_id 
	WHERE ai.agreement_id=agreementId GROUP BY short_name
	--FROM 	kuntur.org o2 
	--WHERE 	o2.org_id is not null 
	ORDER BY 1) AS COSA;

	sql1 = ('select array_to_json(array_agg(row_to_json(t))) from (

	select org, unc, ' || col2 || ' from (
	(SELECT * FROM crosstab(''		
		SELECT 	rowid, 
			att,
			val
		FROM 	kuntur.v_plazas_util 
		WHERE agreement_id = ''''' || agreementId || '''''
		
	'') AS (' || cols || ')) uno join
(
select * from (select o.short_name, ai.in_units || ''-'' || ai.out_units as '|| col3 ||' from kuntur.agreement_item ai inner join kuntur.org o on o.id=ai.org_id  where ai.agreement_id=''' || agreementId || ''') w
) dos on dos.short_name=uno.org)

	) as t')::TEXT;

	--select row_to_json(t)
--	from (
--		select * from kuntur.agreement_item
	--) t


	EXECUTE sql1 INTO result_var;
	
	RETURN result_var;	
		
END; $$
LANGUAGE PLPGSQL;


DROP FUNCTION IF EXISTS f_responsablesByOrg(org text[]);

CREATE OR REPLACE FUNCTION f_responsablesByOrg(org text[]) RETURNS TEXT AS $$
DECLARE result_var TEXT;
DECLARE sql TEXT;
BEGIN
		select array_to_json(array_agg(row_to_json(t))) into result_var from (select * from kuntur.v_responsables res 
		where res.org_short_name =any(org)) as t;

		RETURN result_var;	
END; $$
LANGUAGE PLPGSQL;



DROP FUNCTION IF EXISTS f_org2lvl();

CREATE OR REPLACE FUNCTION f_org2lvl() RETURNS TEXT AS $$
DECLARE result_var TEXT;
DECLARE sql TEXT;
BEGIN
		select array_to_json(array_agg(row_to_json(t))) into result_var from 
		(
		select o2.* from kuntur.org o1 inner join kuntur.org o2 on o2.org_id=o1.id where o1.primary_org=true
		) as t;

		RETURN result_var;	
END; $$
LANGUAGE PLPGSQL;



-----------------------------------------

DROP FUNCTION f_responsablesbyorg(text[]);

CREATE OR REPLACE FUNCTION f_responsablesbyorg(orgs text[])
  RETURNS text AS
$BODY$
DECLARE result_var TEXT;
DECLARE sql TEXT;
BEGIN
	select array_to_json(array_agg(row_to_json(t))) into result_var from (SELECT 
	    contact.id,
	    contact.erased,
	    contact.reception_student,
	    contact.sending_student,
	    org.id AS org_id,
	    org.erased AS org_erased,
	    org.short_name AS org_short_name,
	    org.name AS org_name,
	    org.original_name AS org_original_name,
	    org.photo_url AS org_photo_url,
	    org.web_site AS org_web_site,
	    org.comment AS org_comment,
	    org.country_code AS org_country_code,
	    org.primary_org AS org_primary_org,
	    person.id AS person_id,
	    person.erased AS person_erased,
	    person.given_name AS person_given_name,
	    person.middle_name AS person_middle_name,
	    person.family_name AS person_family_name,
	    person.birth_date AS person_birth_date,
	    person.masculine AS person_masculine,
	    person.photo_url AS person_photo_url,
	    person.comment AS person_comment
	FROM kuntur.contact contact
	LEFT JOIN kuntur.person person ON person.id = contact.person_id
	LEFT JOIN kuntur.org org ON org.id = contact.org_id where org.id =any(orgs)) as t;

		RETURN result_var;	
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION f_responsablesbyorg(text[])
  OWNER TO postgres;

-----------------------------------------------------------

DROP VIEW kuntur.v_responsables;

CREATE OR REPLACE VIEW kuntur.v_responsables AS 
  SELECT contact.id,
    contact.erased,
    contact.reception_student,
    contact.sending_student,
    org.id AS org_id,
    org.erased AS org_erased,
    org.short_name AS org_short_name,
    org.name AS org_name,
    org.original_name AS org_original_name,
    org.photo_url AS org_photo_url,
    org.web_site AS org_web_site,
    org.comment AS org_comment,
    org.country_code AS org_country_code,
    org.primary_org AS org_primary_org,
    person.id AS person_id,
    person.erased AS person_erased,
    person.given_name AS person_given_name,
    person.middle_name AS person_middle_name,
    person.family_name AS person_family_name,
    person.birth_date AS person_birth_date,
    person.masculine AS person_masculine,
    person.photo_url AS person_photo_url,
    person.comment AS person_comment,
    person.birth_country_code AS person_birth_country_code,
    person.birth_country AS person_birth_country,
    person.birth_admin_area_level1_code AS person_birth_admin_area_level1_code,
    person.birth_admin_area_level1 AS person_birth_admin_area_level1,
    person.birth_admin_area_level2 AS person_birth_admin_area_level2,
    person.birth_locality AS person_birth_locality,
    person.birth_lat AS person_birth_lat,
    person.birth_lng AS person_birth_lng,
    agreement_item.id AS agreement_item_id,
    agreement_item.erased AS agreement_item_erased,
    agreement_item.in_units AS agreement_item_in_units,
    agreement_item.out_units AS agreement_item_out_units,
    agreement_item.agreement_id AS agreement_item_agreement_id,
    agreement_item.org_id AS agreement_item_org_id,
    person_email.id AS person_email_id,
    person_email.erased AS person_email_erased,
    person_email.email AS person_email_email,
    person_email.comment AS person_email_comment,
    person_email.person_id AS person_email_person_id,
    person_phone.id AS person_phone_id,
    person_phone.erased AS person_phone_erased,
    person_phone.country_code AS person_phone_country_code,
    person_phone.phone_number AS person_phone_phone_number,
    person_phone.comment AS person_phone_comment,
    person_phone.person_id AS person_phone_person_id,
    agreement_contact.id AS agreement_contact_id,
    agreement_contact.erased AS agreement_contact_erased,
    agreement_contact.agreement_item_id AS agreement_contact_agreement_item_id,
    agreement_contact.contact_id AS agreement_contact_contact_id,
    agreement_contact.reception_student AS agreement_contact_reception_student,
    agreement_contact.sending_student AS agreement_contact_sending_student
   FROM kuntur.contact
     LEFT JOIN kuntur.org org ON contact.org_id::text = org.id::text
     LEFT JOIN kuntur.person person ON contact.person_id::text = person.id::text
     LEFT JOIN kuntur.agreement_contact agreement_contact ON agreement_contact.contact_id::text = contact.id::text
     LEFT JOIN kuntur.agreement_item agreement_item ON agreement_item.id::text = agreement_contact.agreement_item_id::text
     LEFT JOIN kuntur.person_email person_email ON person_email.person_id::text = person.id::text
     LEFT JOIN kuntur.person_phone person_phone ON person_phone.person_id::text = person.id::text;

ALTER TABLE kuntur.v_responsables
  OWNER TO postgres;

---------------------------------------------------------------


CREATE OR REPLACE  FUNCTION ftg_number_agreement_increment() RETURNS trigger AS $number_increment$
    BEGIN
       
         SELECT INTO NEW.number_agreement coalesce(MAX(number_agreement),0) + 1 
         FROM kuntur.agreement
         WHERE 	coalesce(agreement_id,'') = coalesce(NEW.agreement_id,'');
      
        RETURN NEW;
    END;
$number_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_number_agreement_increment BEFORE INSERT ON kuntur.agreement
    FOR EACH ROW EXECUTE PROCEDURE ftg_number_agreement_increment();

-------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION f_findagreementsById(busqueda text)
  RETURNS SETOF kuntur.v_agreement AS
$BODY$
	BEGIN
		RETURN QUERY SELECT	*
		FROM 	kuntur.v_agreement
		WHERE 	translate(coalesce(code::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN') 
				ILIKE 	translate(coalesce('%'||busqueda||'%'::varchar, ''), 'áéíóúÁÉÍÓÚäëïöüÄËÏÖÜñÑ','aeiouAEIOUaeiouAEIOUnN');	
				
	END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION findagreements(text)
  OWNER TO postgres;

