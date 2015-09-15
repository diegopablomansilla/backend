INSERT INTO kuntur.org(
            id, erased, short_name, name, original_name, url_photo, web_site, 
            comment, country_code, primary_org, org_type_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 'ECO', 'Economia', 'Economia', null, 'Eco', 'eco', 'ARG', false, 
	(SELECT ot.id FROM kuntur.org_type ot WHERE ot.code = 'F'), (SELECT o.id FROM kuntur.org o WHERE o.primary_org = true));

INSERT INTO kuntur.org(
            id, erased, short_name, name, original_name, url_photo, web_site, 
            comment, country_code, primary_org, org_type_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 'FILO', 'Filosofia', 'Fiósofo', null, 'Filo', 'fi', 'ARG', false, 
	(SELECT ot.id FROM kuntur.org_type ot WHERE ot.code = 'F'), (SELECT o.id FROM kuntur.org o WHERE o.primary_org = true));

INSERT INTO kuntur.org(
            id, erased, short_name, name, original_name, url_photo, web_site, 
            comment, country_code, primary_org, org_type_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 'DER', 'Derecho', 'Abogacia', null, 'Derechio', 'der', 'ARG', false, 
	(SELECT ot.id FROM kuntur.org_type ot WHERE ot.code = 'F'), (SELECT o.id FROM kuntur.org o WHERE o.primary_org = true));

INSERT INTO kuntur.agreement_type(id, erased, code, name, comment)  VALUES (uuid_generate_v4()::varchar, false, 'C', 'Convenio', 'Conevenio unilateral');
INSERT INTO kuntur.agreement_type(id, erased, code, name, comment)  VALUES (uuid_generate_v4()::varchar, false, 'P', 'Programa', 'Conevenio multiateral');

INSERT INTO kuntur.agreement_status(id, erased, code, name, comment)  VALUES (uuid_generate_v4()::varchar, false, 'B', 'Borrador', 'No Aprobado');
INSERT INTO kuntur.agreement_status(id, erased, code, name, comment)  VALUES (uuid_generate_v4()::varchar, false, 'A', 'Aprobado', 'Aprobado');


INSERT INTO kuntur.agreement(id, erased,number_agreement, title, from_date, to_date, comment, agreement_type_id, agreement_status_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 1, 'C01', now(), '2016-01-03', 'convenio C01', 
		(SELECT at.id FROM kuntur.agreement_type at WHERE at.code = 'C'), 
		(SELECT ast.id FROM kuntur.agreement_status ast WHERE ast.code = 'A'), 
		(SELECT o.id FROM kuntur.org o WHERE o.primary_org = true));




INSERT INTO kuntur.agreement_item(id, erased, in_units, out_units, agreement_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 100, 200, 
    (SELECT a.id FROM kuntur.agreement a WHERE a.title = 'C01'), 
    (SELECT o.id FROM kuntur.org o WHERE o.country_code = 'ARG' AND o.short_name = 'UCC'));

	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'ECO'));
	    

	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'FILO'));


	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 0, null, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'DER'));
		

INSERT INTO kuntur.agreement_item(id, erased, in_units, out_units, agreement_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 100, 200, 
    (SELECT a.id FROM kuntur.agreement a WHERE a.title = 'C01'), 
    (SELECT o.id FROM kuntur.org o WHERE o.country_code = 'ARG' AND o.short_name = 'UBA'));

	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'ECO'));
	    

	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'FILO'));


	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 0, null, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 1), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'DER'));



INSERT INTO kuntur.agreement_item(id, erased, in_units, out_units, agreement_id, org_id)
    VALUES (uuid_generate_v4()::varchar, false, 100, 200, 
    (SELECT a.id FROM kuntur.agreement a WHERE a.title = 'C01'), 
    (SELECT o.id FROM kuntur.org o WHERE o.country_code = 'ARG' AND o.short_name = 'IUA'));  

    	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 2), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'ECO'));
	    

	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 50, 100, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 2), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'FILO'));


	INSERT INTO kuntur.agreement_item_ou(id, erased, in_units, out_units, agreement_item_id, org_id)    
	    VALUES (uuid_generate_v4()::varchar, false, 0, null, (SELECT ai.id FROM kuntur.agreement_item ai LIMIT 1 OFFSET 2), 
			(SELECT ou.id FROM kuntur.org ou WHERE ou.short_name = 'DER'));      


INSERT INTO kuntur.person(
            id, erased, given_name, middle_name, family_name, birth_date, 
            male, url_photo, comment, birth_country_code,
            birth_admin_area_level1_code, birth_admin_area_level2, 
            birth_locality, birth_lat, birth_lng)
    VALUES (uuid_generate_v4()::varchar, false, 'Pedro', 'Juan', 'Perez', 
            '1979-01-01', true, null, null, 'AR', 'AR-X', null, 'Córdoba Capital', null, null);


INSERT INTO kuntur.contact(id, erased, reception_student, sending_student, org_id, person_id)
    VALUES (uuid_generate_v4()::varchar, false, true, false, 
	(SELECT o.id FROM kuntur.org o WHERE o.country_code = 'ARG' AND o.short_name = 'IUA'), 
	(SELECT p.id FROM kuntur.person p WHERE p.family_name = 'Perez' limit 1));

