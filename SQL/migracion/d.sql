DELETE FROM kuntur.admission_period_agreement CASCADE;

DELETE FROM kuntur.admission_period_item CASCADE;

DELETE FROM kuntur.admission_period CASCADE;

DELETE FROM kuntur.agreement_item CASCADE;

DELETE FROM kuntur.agreement CASCADE;

INSERT INTO kuntur.admission_period(id, erased, number_admission_period, in_type, year, semester, title, from_date, to_date, comment, is_agreement, admission_period_status_id) VALUES ('84d48514-1c75-40be-8761-70baa9b97f94', false, null, true, 2016, 2, 'Convocatoria con convenio', now(), '2016-06-01', null, true, (SELECT id FROM kuntur.admission_period_status WHERE code = 'A'));

INSERT INTO kuntur.admission_period(id, erased, number_admission_period, in_type, year, semester, title, from_date, to_date, comment, is_agreement, admission_period_status_id) VALUES ('9a765956-bc70-4a1b-9a5f-44821f995547', false, null, true, 2016, 2, 'Convocatoria sin convenio', now(), '2016-06-01', null, false, (SELECT id FROM kuntur.admission_period_status WHERE code = 'A'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2', false, null, 'Convenio Bilateral', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('32e82cbc-af8c-4cc5-8f11-39fe39e7a75c', false, null, 'PAME', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('1fb4c1ff-1733-447b-8b14-1a87490a5aaa', false, null, 'JIMA', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('02e37204-f491-4b81-b0ba-25095eb21c2a', false, null, 'AUGM Grado', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('dc678f96-cac7-4145-95c0-ce7392d73545', false, null, 'AUGM Posgrado', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('b30e483f-a767-4865-9792-89d69cdbab6d', false, null, 'ARFITEC', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('0dc474ea-c290-4bb2-b205-17416a54c526', false, null, 'ARFAGRI', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('4a5321fc-bd3e-4455-a7c1-7df981a531f6', false, null, 'CCCS', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('cb182fbf-1ad6-4459-82a8-f2419256fae1', false, null, 'MACROUNIVERSIDADES', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('8295fc5d-bfa9-438f-8493-8f070cf11552', false, null, 'MARCA', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('dbb83da9-7ced-44cd-be15-bd1ad4e172aa', false, null, 'BCI - CREPUQ', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.agreement(id, erased, number_agreement, title, from_date, to_date, comment,  agreement_type_id, agreement_status_id, org_id)
 VALUES ('e92ecdfb-bbed-4150-92de-b36cef5d8979', false, null, 'PIMA', now(), null, null,
  (SELECT id FROM kuntur.agreement_type WHERE code = 'C'),
 (SELECT id FROM kuntur.agreement_status WHERE code = 'A'),
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unc.edu.ar'));

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('b0d555d7-b067-40e8-833a-94afc34d4720' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('0362c19d-0fe4-4b1a-9f1f-360ca588dd02' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('7c3dbc9d-733c-4774-be94-ec8932b4bc9d' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('85dd203a-9d15-40d6-b1a2-4b801aa4b87e' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('662b0e93-b4b9-4ad0-ab55-80600d18fdda' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('d13be4f2-68cc-42d7-907a-b2b17a8328d7' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('5da0d389-256b-4deb-9451-1e65c0a18bc3' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('2447e56d-18bc-41eb-843c-e4165dd30b49' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('a2f06f26-1d83-4e7b-9436-3de0771124d2' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('c485c334-1662-410e-a0ca-fd737f7071ed' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('b73a75a1-cbf2-44f8-aee8-33028433a30c' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_agreement(id, erased, agreement_id, admission_period_id) VALUES ('8548eea8-8772-4f2c-8311-a891db4de2a9' , false, 'e92ecdfb-bbed-4150-92de-b36cef5d8979', '84d48514-1c75-40be-8761-70baa9b97f94');

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('25aa40f1-52e5-4f73-87b3-ab4c69c31b93', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umsa.bo'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('7247eefe-ba2a-42a8-8d59-7de293644420', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umsa.bo'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ff6a726c-6b6d-4a47-9b60-04542e86c887', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umsa.bo'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('99342664-4038-4ace-8453-7411e3330f53', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umss.edu.bo'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4d093d6a-b504-427b-81a8-ebdc0747d1a6', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umss.edu.bo'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ffa20f9a-2280-4b87-8970-b9f10f9d8d78', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upb.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('71287560-4b0c-490f-aad7-ee711a2a260e', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upb.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('d1b18b25-da7b-4910-bd53-af313195d76d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univalle.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('75269466-7ba0-4901-8978-218fd3bea534', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univalle.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c558b18c-8932-484c-9fa4-4823c98ae553', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uto.edu.bo'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e632bf3e-bdc5-460e-8595-bf46e21b1bfe', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uto.edu.bo'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('d984d811-b998-4e74-9c04-3e28df06e11f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniritter.edu.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('94eeae26-f60a-4b0f-8d03-ca548f4285f5', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniritter.edu.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('7d400356-d773-420a-a92a-1758887c0942', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucminas.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6532bc59-4bd8-45f4-97a2-2ce93773f4c0', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucminas.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('dfce1a72-07bf-4569-b22c-2b9acb290c0c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucpr.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('fb14b983-d3b1-4309-a637-09f49f74d7c7', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucpr.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('755bc182-cd18-453b-9075-70264bbe5db7', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucb.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('254d27a3-3504-45b6-bfa8-66fa99f0bdf8', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucb.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('4213f886-f52a-4e8b-9a96-29999fef18fc', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unb.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('bf8f6a9a-5c59-4f5f-b4e8-08f302e5ca63', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unb.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e7cf8815-d10b-4bdb-8ec6-2d84969db7f5', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucs.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6688c80d-daf1-44c5-916d-8ece1b236f77', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucs.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('55fff15c-9da2-4b5c-9045-6a3f06fda131', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upf.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4c03e173-f0af-4a7e-92c5-f6b25bfb4b16', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upf.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a7ed953a-6380-4bba-868d-5e8956f95a06', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upf.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('b418b51c-917b-4691-8635-9ad18197a7f0', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4fda59d9-39ae-45b6-9329-19715ad3c9ee', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('19f1b150-7ee7-4828-a4fb-853e2dfbd373', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('78d3e589-82d7-418c-918a-cf7209ce8768', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usp.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('b4414b3e-fd7e-4368-a8fb-fd32bf579e6e', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisinos.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('91b950db-54ae-4ac2-b803-a231376a938e', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisinos.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('f55e4c4d-dd98-467a-a8a5-b0b983f3bd81', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicamp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('5f57c8aa-f8cf-445e-9cfe-98ba53adbef7', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicamp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('945a0a14-1008-4b80-991e-3a21ebfabc74', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicamp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e62e9e90-11bf-4176-8fd1-ca8f4bd5c5f8', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicamp.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('9a06a29c-971c-4b4e-8e6c-d5133cbc4626', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unesp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('057ff23b-faf5-4c5a-89d3-45162310df59', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unesp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f15cadcc-0e59-4564-a004-b65295fbba39', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unesp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('552f14e4-d831-4ddc-a891-11225f687319', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unesp.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f7994b86-1bc2-474b-b0da-fd11ff54f359', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unesp.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('3a0af22d-d606-4f75-b51e-dccfaa684f8d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufba.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('917e77a7-d172-436b-9f95-5ff0a9227112', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufba.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1b7507bb-06da-4532-bb58-20810654f578', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufgd.edu.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e3c2b0c8-ac0c-4d55-87b7-d922f7139a45', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufgd.edu.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('194ac550-1000-4f98-8d9a-3e86ebde44a4', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b9a64c36-2c33-4421-afd5-7173e9c1e72d', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('447fed5d-fd46-4e91-a9bf-d7181f1eafe0', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a70ffd6d-1a28-4613-b68c-0307f47b7d5b', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufg.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('f682f406-c7b4-4721-90b3-ab8b0c98ec10', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufmg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('5a86c551-818d-433c-b408-d4a15619bed4', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufmg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('302c1f79-976d-4a9d-a499-1039ce5d0314', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufmg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c43927b0-a575-4a6c-aa86-874d2070c325', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufmg.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('7e0ad9d9-8610-4a2d-892d-ac014d1c9b07', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufmg.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('725cebef-a7ee-4a36-8cb1-01462c821490', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'ufsc.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('979e2dbd-6106-45df-9fc2-b1eae6c58d44', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'ufsc.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('db0a3e8a-0ec0-4997-84eb-ac2d4c4d9793', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'ufsc.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('b9fe1e44-3824-4c47-8aa8-cef996a66112', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufsm.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('44e93187-8ec0-4321-92cb-d68d598222d2', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufsm.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('489418b2-a7ae-40f4-8af3-e77e885c976a', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufsm.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c668c155-0421-4dc5-8d7e-0860f7a26428', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufscar.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4f53a1e4-84bf-42f3-8f32-bb9b8acfd19d', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufscar.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a94c1751-f8da-4b62-8929-79d8d4e0401e', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufscar.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b87baa65-0c5a-4eea-b5db-4258d90611ec', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufscar.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a2384756-8d9a-4d07-bce8-5ca7e79cd1c1', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufpr.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a3eb675c-94ca-4937-8d73-393b0b3666f9', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufpr.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b73b1725-b79b-40cd-b773-30276613b46c', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufpr.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('eeb067b0-72db-43ba-99af-ff02fbc350d7', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufpr.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1da4115d-149e-4b0d-b645-4be32e1b951a', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufpr.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('cf6dc526-8614-4d7f-a482-c6c2a5d3fd6f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrj.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('218fab63-bd9d-4beb-89fc-5976832bb6fa', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrj.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('14559055-609c-4921-afba-839ed90e3bf2', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrn.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a407cf83-27ed-4af9-8567-7bf3eeb60dc4', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrn.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('910ec42e-d6ee-4adc-a410-dc78324438d9', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrgs.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('48f6d651-8322-4828-b093-59c60d50117e', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrgs.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('423867d2-36fc-4fe1-ac28-0c1ebb0aa38a', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrgs.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('92f32788-b1cd-4fd2-bfda-93acf98d54c8', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrgs.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('3b111200-bd23-4807-ba00-4c28db0049c4', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ufrgs.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('8e9c8790-f4fd-426b-8cff-6893faec146f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uff.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('584c37a3-d963-4369-84d9-a9f86553566a', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uff.br'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('38242a22-53fe-4620-918d-f1513b5d0d9b', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uff.br'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('10302852-d93f-408b-8081-ca81a9b0ca0d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ubishops.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1d9b9b28-1534-47a1-b24f-66ab4e096647', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ubishops.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ff7c065f-b8e4-43eb-b03e-2824e04d67ae', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.concordia.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('28326c2f-6b9a-4dc2-a6ba-677573362b4f', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.concordia.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('82eeb475-8d46-4c28-8ce1-0388d725034a', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.concordia.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('3a3520c6-a363-442b-ab30-81db845c7f8c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enap.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('dedaac23-4423-4e3b-802a-da0bbcba5be2', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enap.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c3c0e9f4-0415-43fa-acc9-ad1a0833f162', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polymtl.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('46ff5531-e3c1-4664-8f2e-403608de2476', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polymtl.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('24cb97a4-ed8f-4802-9287-12c0cd5a303b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.mcgill.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ec7fc986-1542-41db-ac5f-c8867e5e17f4', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.mcgill.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0c2791ca-7ee5-48f8-97e0-e741d01554e3', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umontreal.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b07d534f-9058-4f77-a29c-b4e38a4624a5', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umontreal.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2e34167f-f044-4856-9582-8508106b3938', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.umontreal.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('247259cb-b1b8-440d-9f2e-ec220f91e6f7', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usherbrooke.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c3f0c66b-de1b-4b28-ac1a-fbd3c6d43f9b', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usherbrooke.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e1b12426-9905-4eb1-957f-45addf0e39a7', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uquebec.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4e20dc42-a951-4e45-8441-69fa8acde394', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uquebec.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('5c8c3391-497a-48f5-8622-9784064848b9', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqat.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('dded9d6b-9459-4bee-a5ee-018ae914a488', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqat.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('639d2346-c404-438b-b9f6-4d58f350dcb9', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqac.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('257c15f9-a60d-4cd8-88ec-e3bb52109663', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqac.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a24dc764-080e-46c3-8bab-260c72c44975', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqam.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('81b8ec67-507e-4acd-b49b-a4a0c2832149', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqam.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fe2077e6-58b7-4ed9-a07d-b171a4bbad28', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'uqo.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('24da1737-e1b6-4e4c-80a3-27efea87aaf2', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'uqo.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('482b7fdd-2d55-4612-93f5-6c0dbeee45c1', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqar.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('770ab19e-5646-47af-bc7a-f7eaf1127004', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqar.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ad4db870-5964-48b9-a7de-69bb40331a15', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqtr.ca'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('323758d7-19d0-4928-b853-82fc0599d868', false, null, null, 'dbb83da9-7ced-44cd-be15-bd1ad4e172aa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uqtr.ca'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('6c35c7b1-177c-4da7-90a3-54257c7ef950', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unige.ch'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('04a26408-cec0-46b5-b55d-2a8875c9faee', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unige.ch'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0c853f4a-0b74-46d7-bc57-fbd3c5399755', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ubo.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4cfd66e3-6fb2-49b9-a28e-c8ba6f054560', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ubo.cl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('01d61eb9-21dc-49c6-a5f1-c1a2c979e64f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uchile.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('34edf49e-03c5-4241-a615-bc0d413c09bd', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uchile.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2db85783-40cd-4c26-b6db-fb4505369b3b', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uchile.cl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('49f5605c-4cd8-417a-a72c-f9d2d3ea0a97', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upla.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8e79776e-7ebb-49d2-a4de-4f45c3913e51', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upla.cl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('686327b6-dfa2-44e4-9025-66d8dd7fcb0f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usach.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d8db2d9e-506f-40d7-bf44-ea050e17b799', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usach.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2e9ba621-233c-4dec-b7b6-fbe9f3f7fd12', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usach.cl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e3c13e49-9140-414a-8749-09df9679667d', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usach.cl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('8985cb70-4cf0-4d7f-a968-c4a401c43f7d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.javeriana.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1f5642a8-6bd8-40cd-b1e3-a9d054767f71', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.javeriana.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('5e667b85-675a-4958-ac53-b9c41a16bcd1', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucatolica.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('bbc2fa93-796e-4d63-a094-747c7f4b4f00', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucatolica.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('135a3e44-4a42-46a7-8bec-0f83b18e9c5a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udea.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('50225d9d-91b6-4bea-8a45-44b83ebc826e', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udea.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('616d6cac-e0b1-4ae6-8581-dc094d3839af', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniboyaca.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b65c9cf8-6516-4154-bcf6-c1c654cf2d67', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniboyaca.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('af08f182-91b8-43b1-9ba1-66139c7657c2', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisabana.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('0a110f1f-d67f-46c6-b1c1-054b0517925c', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisabana.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('640b87c4-ada6-4694-950c-e32044c1a09c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ustabuca.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1cb3033a-1e8c-4ea5-b24e-abfd5434b937', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ustabuca.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('74a47d47-e816-4f96-98bc-8f852b514472', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ustatunja.edu.co'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c2408c59-5c47-4359-a045-2e959ee1d90c', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ustatunja.edu.co'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ea89fad5-f2b8-4b5a-b8ea-19af7cb525b3', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.fu-berlin.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f6666f08-250d-4845-bbf2-46036cb8b4e8', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.fu-berlin.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('eb45f5ca-1036-4b1a-aa73-e7cd80c2b12b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-jena.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f4154f0a-4841-46b3-bcc6-20e3e59681dc', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-jena.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('19f22ccf-1c4d-4472-9202-dab271563c89', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hs-bremen.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('35f82761-a9a5-43cb-be94-0e8d3fa41ad9', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hs-bremen.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0e0f9d8b-14aa-4c3f-834d-f61062915d83', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hs-esslingen.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('de9be70d-9975-44de-a220-aa10ba8d5727', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hs-esslingen.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('da87c047-0945-4049-9caf-4acee4db9d1c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hft-stuttgart.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('861e8e3c-46ef-4736-a134-0b1a1aef2256', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hft-stuttgart.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('9a13ac40-e9ee-4701-8534-eb14e4f781ba', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-frankfurt.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('0c997f88-992a-40c0-a167-18cb30d8a535', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-frankfurt.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('04cde7e8-a447-4ced-8792-f433f1274796', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-mainz.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8439cc28-7633-4dda-b20d-e5cfd9102895', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-mainz.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('d913e7b6-9302-4c68-8b88-8d1444f03a52', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.kit.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6e0eb6ed-d753-4d1f-af14-7a17b8502eb6', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.kit.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0762aa61-fb51-4eef-a696-cfe319126fa0', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-erfurt.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('112a9ceb-d6d9-4bef-b586-8e86cdf5199b', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-erfurt.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e1854411-275a-492f-a2f0-d07f9346644d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-regensburg.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('24e7aae9-4ce7-4ff7-8d31-8cda21b8a373', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-regensburg.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('bf3fdd9e-1088-4efa-8285-cc3555061cc8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-tuebingen.de'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('0f643fdc-9c77-405e-96e5-e23056a7249e', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni-tuebingen.de'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('90fed18a-5deb-4ffe-aecc-f37271cf5c2f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.au.dk'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('dbec3c8f-27be-4029-94d7-7dfd8e3a3f53', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.au.dk'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0b0d7285-d3fa-4020-aa08-0d1c0659db53', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('85979771-473b-4dfb-aeaa-3fdaac0fb3a5', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fa80c7de-df6d-44ab-9d7f-dff5046aaccf', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucm.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('795cb8e0-8cb5-4b12-b17d-9a01cffac727', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucm.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0de0abf2-82a0-4e6e-a593-cd785dacd5ce', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uco.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('3fe2b43a-1efc-47b5-98e4-38ecf2bb5ae2', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uco.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('16f678fb-1283-47cc-9e14-17d086cc9cee', false, null, null, 'e92ecdfb-bbed-4150-92de-b36cef5d8979',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uco.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('6b99189a-1241-4844-ba75-9525c8f71d7e', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unirioja.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('372200b4-f73d-4498-ad75-c85045156d56', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unirioja.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('53851648-dad2-470b-92b7-ba6dd2101bde', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ulpgc.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a495b620-ab6d-496f-ba51-78613f7d467b', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ulpgc.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('719689ee-3173-4f77-8729-0b81cfe2c942', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uma.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('83290963-a62b-4204-8640-25de1c52e54b', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uma.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4b38d0e6-84d1-416b-8285-5ebfc1bdef4f', false, null, null, 'e92ecdfb-bbed-4150-92de-b36cef5d8979',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uma.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('458db4ac-f2a0-4d88-bb2b-6331e0c0ddd8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.um.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ed674a68-ba02-43ec-937e-7fa3854628dc', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.um.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c563bd31-b7e2-4481-ab1d-9021d47cf166', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unizar.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2c98ebee-f98f-4e86-9ace-2b581a9b4c91', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unizar.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e38f9260-e190-44e7-a916-25560da5521b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uned.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c9d13156-4c75-41ce-8b1b-d88a2088815c', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uned.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('cf645849-cb96-454b-8acf-45691422eaa8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upm.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ea8335e1-62ba-4b03-a0e5-3ac4c1b7daab', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upm.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('52685c99-1b25-477c-926a-2b679d9a280d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usc.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('be7e8113-a593-4ba7-a0c8-0ac11ddbc196', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.usc.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e4e58766-60de-4d4e-bf91-61a729a1675b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uib.es'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('86bc185e-144e-4b86-af40-71225a68272d', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uib.es'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('28d0e2c2-a1d4-4cce-9ec0-79d434e596ea', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upf.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('fab35613-9cd9-46bb-9b57-567fcb671b33', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.upf.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('bf2927d3-560c-4827-a9bf-9acb1d8dccf2', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ec-lyon.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2d1ea536-bc77-42d9-9e9a-23e5587b6289', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ec-lyon.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('772ff241-8731-415c-9936-bde8c83b7092', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.centrale-marseille.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b13e380c-480d-4df4-9315-2807c8348b05', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.centrale-marseille.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('db489e2e-3307-41de-b529-0fda82bcc5ba', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.centrale-marseille.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('aa506d61-559b-4427-bf68-35ff8f0c428f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ecp.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('46b6cdfa-106b-4bed-bc0c-392130dfa4cc', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ecp.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e8cffbd5-fa42-486c-b345-0bf806fe0138', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.em-strasbourg.eu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e66253d6-dbb6-429b-a736-106c9a556354', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.em-strasbourg.eu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('409fd1bd-9f92-4d6c-9205-d9b1b0f67241', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enim.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('84deeefa-f442-48ae-864c-48ae535a831a', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enim.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('75524fb5-0661-4bad-b69f-79a19d1c9df8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enit.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('24a884a0-4af4-4d11-a441-bacddf01f244', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.enit.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a3d92c93-4e79-4af5-8252-012e4d7729d4', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.versailles.archi.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('bf7f8fe5-a63a-4d27-98ff-9bfd718d1264', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.versailles.archi.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('4ebfa04c-eda9-4f39-9f49-4ab91eff1c7b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-strasbourg.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b21d0bf8-624e-4b65-8ae7-a0edd3b6ca73', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-strasbourg.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('515cb996-8529-47bf-b9c3-5fb70083240a', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-strasbourg.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('67ceb3ef-fabd-49f9-9db9-f422ea10f772', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ensam.eu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('141eced0-6e3a-4537-bc6e-88121a95e645', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ensam.eu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('7d4a3032-5237-4e79-b9d2-c16e9d7b161f', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ensam.eu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('389c63b5-b3e5-4d82-b718-adfc5e0c26ab', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.mines-stetienne.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('854e4132-59ba-48a3-82ec-59242092d64a', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.mines-stetienne.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a5302cb4-4d5a-4f73-a47a-f2deddcd5d94', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.mines-stetienne.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('da5e1b68-6ddd-4e28-a413-4cbdf0913c25', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.oniris-nantes.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f1eb9784-47c0-48ce-b791-75e8e93fdcfb', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.oniris-nantes.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c445051a-4d5b-471a-bb49-347d65d35953', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.groupe-esa.com'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('0afe8b28-80b6-448b-9532-2af844b1f518', false, null, null, '0dc474ea-c290-4bb2-b205-17416a54c526',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.groupe-esa.com'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('137580f6-84a0-418c-b706-a5d44df28328', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.estia.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d2f153b5-4ab3-4f8e-ac82-931198c90a29', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.estia.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a4ede5da-d678-4f64-91f4-a43e45a14525', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.estia.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('dd9f9e79-0656-4460-8c87-2976b4d8a6d8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-lyon.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('96ef5ae6-2de7-45a9-b296-06be6dbd1ca0', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-lyon.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a7fc8380-820d-4b8c-a230-531bea16ca0e', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-rennes.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('84cd25fa-c1e3-4f8e-a70b-f32e7731325e', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-rennes.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('d33f75f6-e53f-4a13-91c9-ad51c70e4df8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-rouen.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('acc42a53-399b-49e5-92d3-d9c6e6a915a6', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-rouen.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fd274fcb-5252-415c-acf9-6d4be178fa4a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-toulouse.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c58b61e2-b3c8-4ce6-a0d5-bccbd8e4113d', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.insa-toulouse.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('6990f14b-958c-46c7-b877-77f37cc2ac77', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.isae.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b4e4dae2-ac0d-41d8-973e-d525aab4d050', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.isae.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('3790e495-7e5b-4593-b70c-9e72d6913272', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.telecom-bretagne.eu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('aa479b60-01f3-452a-92b5-dd71623b8348', false, null, null, 'b30e483f-a767-4865-9792-89d69cdbab6d',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.telecom-bretagne.eu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('9186aad7-6ec0-4dd6-af45-9c897e851a09', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lyon1.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('cb9fed20-6ff9-4160-add0-809cf0625531', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lyon1.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('2f5a54c4-3268-4329-b3cf-77a6a52043ef', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp1.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e00b0757-8af5-4593-a979-0059eb86f3aa', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp1.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('87092c95-dd76-40e1-be65-3de6046fc187', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uvsq.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('34192c63-a381-4c68-b576-9e84bc72dd35', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uvsq.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ed9bf91e-37c1-4803-9bff-b82281089c2a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lille1.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4f8e9a73-75fd-4321-938f-a66dec38b035', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lille1.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('9a061edb-5d41-4f6a-8699-8dff6f198530', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lille2.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('be677c8a-293a-4828-8f7e-f4cda1baff87', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-lille2.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1ef6bce1-83fe-4794-955d-0e1a65249a7b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ujf-grenoble.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e9a1ff90-540f-46ea-bc1c-7bc6c61a4773', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ujf-grenoble.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('de3f6c55-58cf-490b-b106-4a903ac1b44c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp3.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('bb9ef236-9eb5-41cb-a94c-71c483f46f0f', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp3.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a050ec44-78bb-4328-897c-0be56afe7c5e', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp2.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6d206240-865c-4496-89ac-513e3ba3e9c3', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-montp2.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ed345c6a-88e7-4d81-b40d-ab9f0ed0261f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.dauphine.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('06e1cf34-c7fa-4ca8-8382-0d5c6267008a', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.dauphine.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('8dcf4f3e-7aa6-44c2-8445-4b0839a358e1', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-rennes2.fr'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('23f545b2-ab6a-49ae-b860-6617109f2dc3', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.univ-rennes2.fr'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('85cbf2e8-31dc-451e-a0b0-a9807e0a6834', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.bristol.ac.uk'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a6adae25-dae6-4d4c-b006-b03af09611a0', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.bristol.ac.uk'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('946546e0-5088-47a5-9924-f4eb28c7befe', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.nottingham.ac.uk'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b6b5079c-2b68-449a-ad55-7ecb1269d6dd', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.nottingham.ac.uk'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('3fa23fac-e07d-4a3e-8801-db9ebc8dae4d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.stir.ac.uk'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e4d1110b-3e36-4a8b-8268-09544482fdd9', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.stir.ac.uk'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0b4bb1f4-676a-437a-8cd7-ec5886e21221', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polimi.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('271d2442-5d2b-4c6d-bd6d-a61ab7e8856d', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polimi.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('99a8bba6-cf0f-49eb-8628-1cde47129c8a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polito.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f7da36b4-f55a-4b04-ac78-b01f8ad776a8', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.polito.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('76079edb-a0d7-4683-97f5-471946e9aa5c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisa.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8d595f22-3c53-4def-a81a-b76c4b27afb9', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unisa.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('5833dedd-8716-4e07-b2c1-bf472f898466', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unitn.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2a49c520-8518-46c1-a877-9e62b3d823a1', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unitn.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('135d011a-049d-46b5-97ed-558445b4733c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniud.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2cf44f29-f318-46ec-8713-db6ad916d94e', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uniud.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('8c1ca2d5-beae-48dc-bc29-7fbf581b44e7', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unibo.it'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('459280a8-7a94-48e2-add4-37aa834daf93', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unibo.it'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c9571c78-81c0-43ec-995e-3a4b9dedbc9e', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.buap.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('31fecd4f-6eef-44e4-8efb-55d50c8f0031', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.buap.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('802e50b6-741a-4166-9e4a-223337c4da10', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.buap.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('75357527-4f78-45a7-b36e-87fba569faf2', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ipn.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('aee38ae1-3884-4c6e-9a4a-7f07b1221bf6', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ipn.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('5db6f958-e731-4370-b161-f40411a63806', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ipn.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('7ea95ad7-b1d4-4e31-9af7-b9a4ad37ea7a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'portal.chapingo.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d9f7113f-4214-4a96-8831-8fa6e3500476', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'portal.chapingo.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('53c326f6-98f9-432a-95e1-907629db3ac8', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unach.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4ba81ff4-c6c4-4cbf-8d54-2cd12082e88e', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unach.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('060c6030-405c-482c-a1f5-3566a8bef8ae', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uacj.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('bc779eab-9fe4-4fc0-940d-6e2470b5107a', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uacj.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('8267aba7-8662-42ed-811c-0e98d4a94c39', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaslp.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c32e3c1f-3149-4a4f-b5d8-af7894cee539', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaslp.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('45431d47-75c0-444b-96a2-ea6ac141a067', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uasnet.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('352c3937-1313-4a6e-a019-c12fde55e12e', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uasnet.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('33528bdc-e4e3-4c55-b055-0a34784bc42a', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uady.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a27a44b5-2157-4962-b356-655700deb7ea', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uady.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1639a35f-2891-460d-95ac-89315d1033db', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unacar.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d52c73bb-1aeb-4953-8cc4-eb531f658d71', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unacar.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('5bcbf01b-99c8-4387-919c-3ac7d5d48b71', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaeh.edu.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4a982f92-830d-45d0-b505-aad9af328086', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaeh.edu.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('4b39bebd-2060-4522-9000-ea3728b75600', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaem.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('5d25142f-6629-4766-b517-e106c70d5967', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaem.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('b95c85d3-d60b-4576-b88f-11f5b48b7ddf', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uaem.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('2da42f79-8c93-4b56-a061-4080a5cccb98', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f841c9a4-3597-40ac-a191-0502b03cf338', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('26d8074d-8b83-4523-9f09-c316eb84664c', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('477457eb-c3f0-451b-a81b-027aa4a4130a', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uam.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('14133b13-58a2-4cec-93f4-47a59d75fed9', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicach.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('144d5845-ba19-455a-8a67-80c730ef36e7', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unicach.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0248e0f4-721a-45d6-83e2-044d7108ca4b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucol.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('44884c71-eb45-4e4f-8862-8a4179629ee4', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ucol.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fc4bf11a-e88a-4cc2-b11b-22eeb1c63945', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udg.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ab15a710-9366-42bd-b3e9-74c04393562f', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udg.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('f8e9fba4-b41a-478d-a4b2-9db14e6ab668', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udg.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('25f7f5cd-ec0f-4c64-b0c0-4446d3e09fa0', false, null, null, 'e92ecdfb-bbed-4150-92de-b36cef5d8979',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.udg.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('13f3a2eb-4ecb-4ef3-a967-00cb97891b08', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ugto.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('07e2a5e5-eabc-4e6d-a700-029a83039dd2', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ugto.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('9277f84b-f616-4e95-ae7e-5a454213fff1', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ugto.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a2f3334f-a428-4866-97be-af0afa898a71', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uia.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1f7bcd22-2f7f-4646-9f72-23b0c945da37', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uia.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8a7364e4-3c61-4056-a7b9-e300156dcc88', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uia.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a9e96cb4-a1d9-4143-90b1-f67d5eb3b2b7', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ujed.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e4b04217-c5d1-4fef-953b-ca44d12a94a8', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ujed.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('20ba714d-849d-42c1-b0af-999c7580f2ed', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('3cdca0db-84fe-4205-a346-3f039d1f7f05', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('a367f6e2-a3ed-4cd0-899f-a9c2770f5fd7', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unam.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('0ffc73f4-b22c-4a3a-982c-f0b9c1c7a98d', false, null, null, 'cb182fbf-1ad6-4459-82a8-f2419256fae1',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.unam.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('0e3070fd-053a-4fab-ab95-202bb316cd39', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'web.upaep.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('eec60b32-72bc-419b-ab67-07d0ee9a9662', false, null, null, '1fb4c1ff-1733-447b-8b14-1a87490a5aaa',
 (SELECT id FROM kuntur.org WHERE web_site = 'web.upaep.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('2b3973f2-c22b-4783-b9cf-e68719f1a516', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uv.mx'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('4dabd11f-4a11-4e98-b6f5-09fa3134b172', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uv.mx'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('d3428c48-cc47-4bb2-96e1-ff5c5c1b533b', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.eur.nl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d3d83de6-6d00-44d9-9327-dfc6ebd61da8', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.eur.nl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('094d731d-a7f4-4605-a308-0d2560b25418', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.leidenuniv.nl'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('2d96d870-1c76-4f9b-9f45-0a6f19692ee7', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.leidenuniv.nl'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('925598b3-5b90-4141-82da-b1748e7504e9', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ntnu.no'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d32cc8fb-a439-48c3-90aa-7fc5a8e59264', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ntnu.no'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1f3933f9-011d-4015-a8e3-614f770c07a2', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uio.no'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('9cd4abe5-4922-4375-adce-8f1dc80d078d', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uio.no'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('917f69b7-3177-4c15-9edd-fd2578941a25', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucp.edu.pe'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6981e43d-598d-4a26-a331-23912505b917', false, null, null, '32e82cbc-af8c-4cc5-8f11-39fe39e7a75c',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pucp.edu.pe'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('c109ac33-a28a-4259-8e3c-74c39c6c96f5', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8c0c30bc-790f-47ed-9bf7-a524ed755ad6', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('08cfbb71-9e2c-4a13-ac55-04ddaaa28f43', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('47282858-2bb8-4dbd-aa57-1647f4b514ae', false, null, null, 'cb182fbf-1ad6-4459-82a8-f2419256fae1',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1b73dab5-2f70-407a-8ef3-33a141c2e707', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('cac656f4-ac95-4108-baeb-7b0372e1f60b', false, null, null, 'e92ecdfb-bbed-4150-92de-b36cef5d8979',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.una.py'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e35c6e45-c513-4020-ba5d-a4c834c6269c', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni.edu.py'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('74e6ae08-30ce-4066-b493-093c74754182', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.uni.edu.py'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('37777fb1-d228-468a-bdc3-b3685dd6ae01', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.universidad.edu.uy'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('3dccfe07-008c-4548-b43a-e201ff552f16', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.universidad.edu.uy'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('9e71cc52-cdc6-41f1-888f-1e71698d888e', false, null, null, '02e37204-f491-4b81-b0ba-25095eb21c2a',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.universidad.edu.uy'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('1ee4adcf-ce98-4408-bc8b-b46c08693072', false, null, null, 'dc678f96-cac7-4145-95c0-ce7392d73545',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.universidad.edu.uy'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c6e2e810-8c44-4d93-9439-65d0367b1a44', false, null, null, '8295fc5d-bfa9-438f-8493-8f070cf11552',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.universidad.edu.uy'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('00abea7d-771a-414e-a6d0-9ac4fb70ed34', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.adelphi.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('72eb77e7-5560-4bb2-a9a6-04a24676b747', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.adelphi.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('482dfd74-c5d8-4b43-a3ac-7041355fedf4', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.baylor.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6d37d264-18cc-41fb-9c85-1273a6f38a32', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.baylor.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('e89d09d4-3af7-43bc-9c6f-92f7246718dd', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.cofc.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('d3fb0ac0-4d29-4ed5-aa1a-192b5e6de354', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.cofc.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('ba0c2eef-2d12-40f2-a7b3-5e84059a25e0', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.concordiacollege.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('88079e31-13ae-4a2e-9f0a-115e62ae0b07', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.concordiacollege.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('a3a88c21-17bd-4b7e-8cf2-f32257740c4f', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.eastern.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ee3abe11-dbb1-443b-b326-5098f65f0c7d', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.eastern.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1e7fdcb2-1987-424f-9446-31e279f36107', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.elon.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('e35642c1-661d-4092-8cdf-bd8304df4d1c', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.elon.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('edeac71f-e3e0-4380-aaea-438d384ba084', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.goucher.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('cbecc195-03c6-4b0a-86ea-42e15dcc379d', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.goucher.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fcb6c6fc-02bb-47f7-9e02-b0e640291c75', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hillsdale.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('9e027515-355a-439e-97a1-ad34c56d026d', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.hillsdale.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('2bf87332-a72d-44f1-bf73-d7ecaca6803d', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ithaca.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('ea7b74ed-84e8-4fa3-92ae-7112ba7795af', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ithaca.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('1bcd2931-fc8c-4897-8a17-927048a90e46', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pacificu.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('70ce4610-7466-4d0d-ac3a-45cc45d9c766', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.pacificu.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('be0e06ce-344b-4d81-86a4-df5687295ced', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.stmarys-ca.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('6b2af604-f8e3-42bc-a7cd-a3bb11ba098a', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.stmarys-ca.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('731e76a5-9fd3-4eaf-bd09-9df06a21dae0', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.geneseo.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('8ff10c07-0d22-4b83-b3fc-b9a7ae09bda6', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.geneseo.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('56c2cf25-aff8-441e-ba5f-917d11766500', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.utexas.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('c2113324-b9cc-40d1-94c4-3be8c15b1013', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.utexas.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('fe60ba2b-c73b-408f-aba9-0da32f862224', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.virginia.edu'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('46143b74-f8da-4c2c-b880-de68ccfaca07', false, null, null, '4a5321fc-bd3e-4455-a7c1-7df981a531f6',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.virginia.edu'));

INSERT INTO kuntur.admission_period_item (id, erased, in_units, out_units, admission_period_id, org_id)
 VALUES ('89802a3f-81b5-4913-9e57-cbc8aa77d1c4', false, null, null, '84d48514-1c75-40be-8761-70baa9b97f94',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ihecs.be'));

INSERT INTO kuntur.agreement_item (id, erased, in_units, out_units, agreement_id, org_id)
 VALUES ('205c1467-e1d9-4fe6-bea0-45ad2113212a', false, null, null, '6d724f30-9d9c-4a91-bd1f-3aa270d1d4d2',
 (SELECT id FROM kuntur.org WHERE web_site = 'www.ihecs.be'));