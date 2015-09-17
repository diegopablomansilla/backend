
INSERT INTO kuntur.agreement_type(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'C', 'Convenio', 'Convenio unilateral');
INSERT INTO kuntur.agreement_type(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'P', 'Programa', 'Convenio multiateral');

INSERT INTO kuntur.agreement_status(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'B', 'Borrador', 'No Aprobado');
INSERT INTO kuntur.agreement_status(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'A', 'Aprobado', 'Aprobado');