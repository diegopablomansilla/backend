
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario1', null, 'usuario1', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario2', null, 'usuario2', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario3', null, 'usuario3', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario4', null, 'usuario4', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario5', null, 'usuario5', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario6', null, 'usuario6', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario7', null, 'usuario7', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario8', null, 'usuario8', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario9', null, 'usuario9', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);
insert into kuntur.person values(uuid_generate_v4()::varchar, false, 'usuario10', null, 'usuario10', '2000-02-02', true, null, null, 'ARG', null, null, null, null, null);

insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario1'), false, 'usuario1', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario2'), false, 'usuario2', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario3'), false, 'usuario3', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario4'), false, 'usuario4', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario5'), false, 'usuario5', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario6'), false, 'usuario6', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario7'), false, 'usuario7', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario8'), false, 'usuario8', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario9'), false, 'usuario9', '1234', 'abiagetti@unc.edu.ar', null, true, null);
insert into kuntur.user_system values((select id from kuntur.person where given_name = 'usuario10'), false, 'usuario10', '1234', 'abiagetti@unc.edu.ar', null, true, null);

insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'office'), (select id from kuntur.person where given_name = 'usuario1'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'office'), (select id from kuntur.person where given_name = 'usuario3'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'office'), (select id from kuntur.person where given_name = 'usuario5'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'office'), (select id from kuntur.person where given_name = 'usuario7'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'office'), (select id from kuntur.person where given_name = 'usuario9'));

insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'coordinator'), (select id from kuntur.person where given_name = 'usuario2'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'coordinator'), (select id from kuntur.person where given_name = 'usuario4'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'coordinator'), (select id from kuntur.person where given_name = 'usuario6'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'coordinator'), (select id from kuntur.person where given_name = 'usuario8'));
insert into kuntur.user_group values(uuid_generate_v4()::varchar, false, (select id from kuntur.group_system where code = 'coordinator'), (select id from kuntur.person where given_name = 'usuario10'));

insert into kuntur.unc_in_academic_office values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario1'), (select id from kuntur.org where name = 'Facultad de Matemática, Astronomía y Física'));
insert into kuntur.unc_in_academic_office values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario3'), (select id from kuntur.org where name = 'Facultad de Ciencias Médicas'));
insert into kuntur.unc_in_academic_office values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario5'), (select id from kuntur.org where name = 'Facultad de Artes'));
insert into kuntur.unc_in_academic_office values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario7'), (select id from kuntur.org where name = 'Facultad de Lenguas'));
insert into kuntur.unc_in_academic_office values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario9'), (select id from kuntur.org where name = 'Facultad de Arquitectura, Urbanismo y Diseño'));


insert into kuntur.unc_in_academic_coordinator values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario2'), (select id from kuntur.org where name = 'Facultad de Matemática, Astronomía y Física'));
insert into kuntur.unc_in_academic_coordinator values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario4'), (select id from kuntur.org where name = 'Facultad de Ciencias Médicas'));
insert into kuntur.unc_in_academic_coordinator values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario6'), (select id from kuntur.org where name = 'Facultad de Artes'));
insert into kuntur.unc_in_academic_coordinator values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario8'), (select id from kuntur.org where name = 'Facultad de Lenguas'));
insert into kuntur.unc_in_academic_coordinator values(uuid_generate_v4()::varchar, false, (select id from kuntur.person where given_name = 'usuario10'), (select id from kuntur.org where name = 'Facultad de Arquitectura, Urbanismo y Diseño'));
