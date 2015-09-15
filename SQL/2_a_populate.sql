CREATE EXTENSION "uuid-ossp";



DELETE FROM kuntur.org CASCADE;
DELETE FROM kuntur.org_type CASCADE;
DELETE FROM kuntur.person_identity_type CASCADE;
DELETE FROM kuntur.enrrollment_status CASCADE;
DELETE FROM kuntur.admission_period_status CASCADE;

----------------------------------------------------------------

-- SELECT * FROM model.au_type


INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, 'U', 'Universidad', null);
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('f53150fc-55cc-4305-978d-4e7a9d61f063', false, 'F', 'Facultad', '1');
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('a0c285c3-adce-491d-a239-d09548834bc1', false, 'E', 'Escuela', '2');
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('f2393fd8-17bd-4f46-a79a-570f05d5ec69', false, 'C', 'Colegio', '3');
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('5f131f00-090a-4e4d-ac37-dde4711949f9', false, 'I', 'Instituto', '4');
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('a9677c7d-16c1-4398-9d26-aae72284c454', false, 'O', 'Centro', '5');
INSERT INTO kuntur.org_type(id, erased, code, name, comment) VALUES ('ad4feaca-687b-40ba-a5e7-db288857c827', false, 'S', 'Secretaría', '6');

--SELECT * FROM  kuntur.org_type;

 ---------------------------------------------------------------

INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'PASS', 'Pasaporte', null, null);
--INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
--	VALUES (uuid_generate_v4(), false, 'IDM', 'ID Mercosur', null, null);

-- DNI

INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'ARG_DNI', 'Documento Nacional de Identidad', 'ARG', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'ESP_DNI', 'Documento Nacional de Identidad', 'ESP', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'PER_DNI', 'Documento Nacional de Identidad', 'PER', null);

-- DUI

INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'SLV_DUI', 'Documento Único de Identidad', 'SLV', null);	

-- CI
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'URY_CI', 'Cédula de Identidad', 'URY', null);	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'BOL_CI', 'Cédula de Identidad', 'BOL', null);			
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'CHL_CI', 'Cédula de Identidad', 'CHL', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'CRI_CI', 'Cédula de Identidad', 'CRI', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'ECU_CI', 'Cédula de Identidad', 'ECU', null);	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'NIC_CI', 'Cédula de Identidad', 'NIC', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'VEN_CI', 'Cédula de Identidad', 'VEN', null);
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'LTU_CI', 'Cédula de Identidad', 'LTU', 'Asmens tapatybės kortelė, Personal Identity Card');		

-- CIC
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'PRY_CIC', 'Cédula de Identidad Civil', 'PRY', null);	

-- CC
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'COL_CC', 'Cédula de Ciudadanía', 'COL', null);	

-- RG
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'BRA_RG', 'Registro General', 'BRA', 'Carta de Identidad');				

-- CURP
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'MEX_CURP', 'Clave Única de Registro de Población', 'MEX', 'Credencial para Votar o Credencial de Elector');					

-- DIN
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'FRA_DIN', 'Documento de Identificación Nacional', 'FRA', 'Carte nationale d''identité');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'REU_DIN', 'Documento de Identificación Nacional', 'REU', 'Carte nationale d''identité');

-- DI
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'DEU_DI', 'Documento de Identidad', 'DEU', 'PERSONALAUSWEIS, IDENTITY CARD, CARTE D''IDENTITE');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'ITA_DI', 'Documento de Identidad', 'ITA', 'CARTA DI IDENTITÀ');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'BEL_DI', 'Documento de Identidad', 'BEL', 'CARTE D''IDENTITE, IDENTITEITSKAART, PERSONALAUSWEIS, IDENTITY CARD');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'CHE_DI', 'Documento de Identidad', 'CHE', 'DENTITÄTSKARTE, CARTE D '' IDENTITÉ, CARTA D '' IDENTITÀ, CARTA D '' IDENTITAD, IDENTITY CARD');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'PRT_DI', 'Documento de Identidad', 'PRT', 'CARTÃO DE CIDADÃO, CITIZEN CARD');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'GBR_DI', 'Documento de Identidad', 'GBR', 'Identification Card');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'AUT_DI', 'Documento de Identidad', 'AUT', 'IDENTITÄTSAUSWEIS, DAUERAUFENTHALTSKARTE');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'BGR_DI', 'Documento de Identidad', 'BGR', 'ЛИЧНА КАРТА, IDENTITY CARD');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'CYP_DI', 'Documento de Identidad', 'CYP', 'ΔΕΛΤΙΟ ΤΑΥΤΟΤΗΤΑΣ_KIMLIK KARTI_IDENTITY CARD');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'CZE_DI', 'Documento de Identidad', 'CZE', 'OBČANSKÝ PRŮKAZ');	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'EST_DI', 'Documento de Identidad', 'EST', 'ISIKUTUNNISTUS, IDENTITY CARD');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'FIN_DI', 'Documento de Identidad', 'FIN', 'Henkilökortti, Identitetskort, Identity card');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, '_DI', 'Documento de Identidad', '', '');

INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'GRC_DI', 'Documento de Identidad', 'GRC', 'ΔΕΛΤΙΟ ΤΑΥΤΟΤΗΤΑΣ IDENTITY CARD');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'HUN_DI', 'Documento de Identidad', 'HUN', 'SZEMÉLYAZONOSÍTÓ IGAZOLVÁNY, IDENTITY CARD');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'LUX_DI', 'Documento de Identidad', 'LUX', 'Carte d''Identité, Identity Card, Personalausweis');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'LVA_DI', 'Documento de Identidad', 'LVA', 'PERSONAS APLIECĪBA, IDENTITY CARD, CARTE D''IDENTITÉ');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'MLT_DI', 'Documento de Identidad', 'MLT', 'KARTA TA'' L-IDENTITÀ');
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'NLD_DI', 'Documento de Identidad', 'NLD', 'NEDERLANDSE IDENTITEITSKAART, IDENTITY CARD, CARTE D''IDENTITÉ');
	

	
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'HTI_DI', 'Documento de Identidad', 'HTI', null);

-- TI
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'PRI_TI', 'Tarjeta de Identificación', 'PRI', null);	

-- DR
INSERT INTO kuntur.person_identity_type(id, erased, code, name, country_code, comment) 
	VALUES (uuid_generate_v4(), false, 'USA_DR', 'Documento de Residencia', 'USA', 'PERMANENT RESIDENT, EMPLOYMENT AUTHORIZATION CARD');		
	
 -- SELECT * FROM kuntur.person_identity_type ORDER BY name, code;	
	
 ---------------------------------------------------------------

 --SELECT DISTINCT s.id, s.name FROM sys_state_life_cycle s JOIN postulation p ON s.id = p.sys_state_life_cycle_id ORDER BY s.id, s.name

INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '259', 'Iniciada', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '260', 'Incompleta', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '261', 'En Evaluacion', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '262', 'Admitida', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '263', 'Modificacion Plan 2', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '264', 'Modificacion de Plan 1', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '265', 'Matriculado', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '266', 'Finalizada', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '267', 'Desistida', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '268', 'No Iniciada', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '270', 'En Matriculacion', NULL);
INSERT INTO kuntur.enrrollment_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, '271', 'En Carga de Actuacion Academica', NULL);

 -- SELECT * FROM kuntur.enrrollment_status ORDER BY name, code;

 ---------------------------------------------------------------

 --

INSERT INTO kuntur.admission_period_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, 'A', 'Abierto', NULL);
INSERT INTO kuntur.admission_period_status(id, erased, code, name, comment) VALUES (uuid_generate_v4(), false, 'C', 'Cerrado', NULL);

