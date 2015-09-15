select array_to_string(array(SELECT id FROM v_unc_in_study_program), '&')


-- select array(SELECT id FROM v_unc_in_study_program)




SELEct id, (string_to_array(comment, '|'))[1] from v_unc_in_study_program  


SELEct id, (string_to_array(comment, '|'))[2], (string_to_array(comment, '|'))[1], (string_to_array(comment, '|'))[0] from v_unc_in_study_program 
UNION 

 

SELEct unnest(string_to_array(comment, '|')) from v_unc_in_study_program  