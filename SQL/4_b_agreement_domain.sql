
INSERT INTO kuntur.agreement_type(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'C', 'Convenio', 'Convenio unilateral');
INSERT INTO kuntur.agreement_type(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'P', 'Programa', 'Convenio multiateral');

INSERT INTO kuntur.agreement_status(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'B', 'Borrador', 'No Aprobado');
INSERT INTO kuntur.agreement_status(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'A', 'Aprobado', 'Aprobado');


INSERT INTO kuntur.group_system(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'admin', 'Administradores', 'Para los empleados de la PRI');
INSERT INTO kuntur.group_system(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'office', 'Despachos de Alumnos', 'Para los despachos de alumnos de las facultades');
INSERT INTO kuntur.group_system(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'coordinator', 'Coordinadores Académicos', 'Para los coordinadores académicos de las facultades');
INSERT INTO kuntur.group_system(id, erased, code, name, comment) VALUES (uuid_generate_v4()::varchar, false, 'student', 'Estudiantes', 'Para los estudiantes de intercambio');


