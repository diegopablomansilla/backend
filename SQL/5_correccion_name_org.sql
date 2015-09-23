UPDATE kuntur.ORG SET name = original_name WHERE name IS NULL;

-- SELECT DISTINCT country_code FROM kuntur.org ORDER BY country_code;

-- SELECT * FROM kuntur.org WHERE country_code ILIKE '%INT%';

UPDATE kuntur.org SET country_code = 'ITA' WHERE web_site = 'www.ied.it';
UPDATE kuntur.org SET country_code = 'FRA' WHERE web_site = 'www.escpeurope.eu';
UPDATE kuntur.org SET country_code = 'KGZ' WHERE web_site = 'www.ucentralasia.org';
UPDATE kuntur.org SET country_code = 'RUS' WHERE web_site = 'www.uarctic.org';

UPDATE kuntur.org SET original_name = REPLACE(original_name, '(4)', '');
UPDATE kuntur.org SET name = REPLACE(name, '(4)', '');

-- select * from kuntur.org where original_name ilike '%&%'
-- select * from kuntur.org where original_name ilike '%#%'
-- select * from kuntur.org where original_name ilike '%;%'


-- select * from kuntur.org where original_name ilike '%&#039;%'
UPDATE kuntur.org SET original_name = REPLACE(original_name, '&#039;', '''');
UPDATE kuntur.org SET name = REPLACE(name, '&#039;', '''');

-- select * from kuntur.org where original_name ilike '%&amp;%'
UPDATE kuntur.org SET original_name = REPLACE(original_name, '&amp;', '&');
UPDATE kuntur.org SET name = REPLACE(name, '&amp;', '&');



UPDATE kuntur.org SET original_name = TRIM(original_name);
UPDATE kuntur.org SET name = TRIM(name);
