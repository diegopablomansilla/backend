DROP VIEW IF EXISTS v_kuntur.person CASCADE;
CREATE OR REPLACE VIEW v_kuntur.person AS 
	SELECT 
		person.id /*id*/,
		person.erased /*erased*/,
		person.given_name /*Nombre de Pila*/,
		person.middle_name /*Segundo Nombre*/,
		person.family_name /*Apellido*/,
		person.birth_date /*Fecha de Nacimiento*/,
		person.male /*Masculino*/,
		person.url_photo /*Foto*/,
		person.comment /*Comentario*/,
		person.birth_country_code /*País Nacimiento - Código ISO 3166-1 Alfa-2*/,
		person.birth_admin_area_level1_code /*Provincia Nacimiento - Código ISO 3166-2*/,
		person.birth_admin_area_level2 /*Departamento / Distrito Nacimiento*/,
		person.birth_locality /*Localidad Nacimiento*/,
		person.birth_lat /*Latitud Nacimiento*/,
		person.birth_lng /*Longitud Nacimiento*/
	FROM kuntur.person