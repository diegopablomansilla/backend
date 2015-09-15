-- SELECT * FROM kuntur.org;

UPDATE kuntur.org SET short_name = TRIM(short_name);
UPDATE kuntur.org SET name = TRIM(name);
UPDATE kuntur.org SET original_name = TRIM(original_name);
UPDATE kuntur.org SET country_code = TRIM(country_code);
UPDATE kuntur.org SET original_name = TRIM(REPLACE(original_name, '(1)', ''));
UPDATE kuntur.org SET original_name = TRIM(REPLACE(original_name, '(3)', ''));


UPDATE kuntur.org SET name = TRIM(split_part(original_name, '/', 1 )) WHERE original_name ILIKE '%/%';
UPDATE kuntur.org SET original_name = TRIM(split_part(original_name, '/', 2 )) WHERE original_name ILIKE '%/%';


--SELECT COUNT(*) FROM kuntur.org WHERE name IS NOT NULL
--SELECT TRIM(split_part(original_name, '/', 1 )) AS name, TRIM(split_part(original_name, '/', 2 )) AS original_name FROM kuntur.org WHERE original_name ILIKE '%/%' -- 4318




--SELECT COUNT(*) FROM kuntur.org WHERE original_name ILIKE '%/%' -- 4318

--SELECT regexp_split_to_array(original_name, '/', 1 ) FROM kuntur.org WHERE original_name ILIKE '%/%' -- 4318

--SELECT * FROM kuntur.org WHERE original_name NOT ILIKE '%/%' -- 4318


-- correccion del código de Reino Unido
UPDATE kuntur.org SET country_code = 'GB' WHERE country_code = 'UK';

-- correccion del código de Turquia
UPDATE kuntur.org SET country_code = 'TR' WHERE country_code = 'TY';


-- correccion de los códigos de iso2 a iso3
UPDATE kuntur.org SET country_code = 'COL' WHERE country_code = 'CO';
UPDATE kuntur.org SET country_code = 'CHL' WHERE country_code = 'CL';
UPDATE kuntur.org SET country_code = 'ECU' WHERE country_code = 'EC';
UPDATE kuntur.org SET country_code = 'MEX' WHERE country_code = 'MX';
UPDATE kuntur.org SET country_code = 'PRY' WHERE country_code = 'PY';
UPDATE kuntur.org SET country_code = 'URY' WHERE country_code = 'UY';
UPDATE kuntur.org SET country_code = 'CRI' WHERE country_code = 'CR';
UPDATE kuntur.org SET country_code = 'HND' WHERE country_code = 'HN';
UPDATE kuntur.org SET country_code = 'PAN' WHERE country_code = 'PA';
UPDATE kuntur.org SET country_code = 'GTM' WHERE country_code = 'GT';
UPDATE kuntur.org SET country_code = 'CUB' WHERE country_code = 'CU';
UPDATE kuntur.org SET country_code = 'CAN' WHERE country_code = 'CA';
UPDATE kuntur.org SET country_code = 'AUT' WHERE country_code = 'AT';
UPDATE kuntur.org SET country_code = 'BEL' WHERE country_code = 'BE';
UPDATE kuntur.org SET country_code = 'DNK' WHERE country_code = 'DK';
UPDATE kuntur.org SET country_code = 'ESP' WHERE country_code = 'ES';
UPDATE kuntur.org SET country_code = 'FRA' WHERE country_code = 'FR';
UPDATE kuntur.org SET country_code = 'GRC' WHERE country_code = 'GR';
UPDATE kuntur.org SET country_code = 'NLD' WHERE country_code = 'NL';
UPDATE kuntur.org SET country_code = 'ITA' WHERE country_code = 'IT';
UPDATE kuntur.org SET country_code = 'NOR' WHERE country_code = 'NO';
UPDATE kuntur.org SET country_code = 'PRT' WHERE country_code = 'PT';
UPDATE kuntur.org SET country_code = 'SWE' WHERE country_code = 'SE';
UPDATE kuntur.org SET country_code = 'CHE' WHERE country_code = 'CH';
UPDATE kuntur.org SET country_code = 'IRL' WHERE country_code = 'IE';
UPDATE kuntur.org SET country_code = 'HUN' WHERE country_code = 'HU';
UPDATE kuntur.org SET country_code = 'POL' WHERE country_code = 'PL';
UPDATE kuntur.org SET country_code = 'TUR' WHERE country_code = 'TR';
UPDATE kuntur.org SET country_code = 'CHN' WHERE country_code = 'CN';
UPDATE kuntur.org SET country_code = 'ISR' WHERE country_code = 'IL';
UPDATE kuntur.org SET country_code = 'JPN' WHERE country_code = 'JP';
UPDATE kuntur.org SET country_code = 'AUS' WHERE country_code = 'AU';
UPDATE kuntur.org SET country_code = 'KOR' WHERE country_code = 'KR';
UPDATE kuntur.org SET country_code = 'SLV' WHERE country_code = 'SV';
UPDATE kuntur.org SET country_code = 'HTI' WHERE country_code = 'HT';
UPDATE kuntur.org SET country_code = 'LBN' WHERE country_code = 'LB';
UPDATE kuntur.org SET country_code = 'NIC' WHERE country_code = 'NI';
UPDATE kuntur.org SET country_code = 'ROU' WHERE country_code = 'RO';
UPDATE kuntur.org SET country_code = 'GBR' WHERE country_code = 'GB';
UPDATE kuntur.org SET country_code = 'SYR' WHERE country_code = 'SY';
UPDATE kuntur.org SET country_code = 'PRI' WHERE country_code = 'PR';
UPDATE kuntur.org SET country_code = 'ZAF' WHERE country_code = 'ZA';
UPDATE kuntur.org SET country_code = 'PNG' WHERE country_code = 'PG';
UPDATE kuntur.org SET country_code = 'MSR' WHERE country_code = 'MS';
UPDATE kuntur.org SET country_code = 'MNE' WHERE country_code = 'ME';
UPDATE kuntur.org SET country_code = 'MNG' WHERE country_code = 'MN';
UPDATE kuntur.org SET country_code = 'MDA' WHERE country_code = 'MD';
UPDATE kuntur.org SET country_code = 'FSM' WHERE country_code = 'FM';
UPDATE kuntur.org SET country_code = 'VEN' WHERE country_code = 'VE';
UPDATE kuntur.org SET country_code = 'MYT' WHERE country_code = 'YT';
UPDATE kuntur.org SET country_code = 'MRT' WHERE country_code = 'MR';
UPDATE kuntur.org SET country_code = 'MUS' WHERE country_code = 'MU';
UPDATE kuntur.org SET country_code = 'MTQ' WHERE country_code = 'MQ';
UPDATE kuntur.org SET country_code = 'MAR' WHERE country_code = 'MA';
UPDATE kuntur.org SET country_code = 'MLT' WHERE country_code = 'MT';
UPDATE kuntur.org SET country_code = 'MOZ' WHERE country_code = 'MZ';
UPDATE kuntur.org SET country_code = 'NAM' WHERE country_code = 'NA';
UPDATE kuntur.org SET country_code = 'NRU' WHERE country_code = 'NR';
UPDATE kuntur.org SET country_code = 'PSE' WHERE country_code = 'PS';
UPDATE kuntur.org SET country_code = 'PLW' WHERE country_code = 'PW';
UPDATE kuntur.org SET country_code = 'PAK' WHERE country_code = 'PK';
UPDATE kuntur.org SET country_code = 'OMN' WHERE country_code = 'OM';
UPDATE kuntur.org SET country_code = 'NZL' WHERE country_code = 'NZ';
UPDATE kuntur.org SET country_code = 'NCL' WHERE country_code = 'NC';
UPDATE kuntur.org SET country_code = 'NFK' WHERE country_code = 'NF';
UPDATE kuntur.org SET country_code = 'NIU' WHERE country_code = 'UN';
UPDATE kuntur.org SET country_code = 'NGA' WHERE country_code = 'NG';
UPDATE kuntur.org SET country_code = 'NER' WHERE country_code = 'NE';
UPDATE kuntur.org SET country_code = 'NPL' WHERE country_code = 'NP';
UPDATE kuntur.org SET country_code = 'MLI' WHERE country_code = 'ML';
UPDATE kuntur.org SET country_code = 'MDV' WHERE country_code = 'MV';
UPDATE kuntur.org SET country_code = 'MWI' WHERE country_code = 'MW';
UPDATE kuntur.org SET country_code = 'KEN' WHERE country_code = 'KE';
UPDATE kuntur.org SET country_code = 'KAZ' WHERE country_code = 'KZ';
UPDATE kuntur.org SET country_code = 'JOR' WHERE country_code = 'JO';
UPDATE kuntur.org SET country_code = 'JEY' WHERE country_code = 'JE';
UPDATE kuntur.org SET country_code = 'JAM' WHERE country_code = 'JM';
UPDATE kuntur.org SET country_code = 'VIR' WHERE country_code = 'VI';
UPDATE kuntur.org SET country_code = 'VGB' WHERE country_code = 'VG';
UPDATE kuntur.org SET country_code = 'UMI' WHERE country_code = 'UM';
UPDATE kuntur.org SET country_code = 'TCA' WHERE country_code = 'TC';
UPDATE kuntur.org SET country_code = 'SLB' WHERE country_code = 'SB';
UPDATE kuntur.org SET country_code = 'PCN' WHERE country_code = 'PN';
UPDATE kuntur.org SET country_code = 'KGZ' WHERE country_code = 'KG';
UPDATE kuntur.org SET country_code = 'KIR' WHERE country_code = 'KI';
UPDATE kuntur.org SET country_code = 'KWT' WHERE country_code = 'KW';
UPDATE kuntur.org SET country_code = 'MYS' WHERE country_code = 'MY';
UPDATE kuntur.org SET country_code = 'MDG' WHERE country_code = 'MG';
UPDATE kuntur.org SET country_code = 'MAC' WHERE country_code = 'MO';
UPDATE kuntur.org SET country_code = 'LUX' WHERE country_code = 'LU';
UPDATE kuntur.org SET country_code = 'ABW' WHERE country_code = 'AW';
UPDATE kuntur.org SET country_code = 'LTU' WHERE country_code = 'LT';
UPDATE kuntur.org SET country_code = 'LIE' WHERE country_code = 'LI';
UPDATE kuntur.org SET country_code = 'LBY' WHERE country_code = 'LY';
UPDATE kuntur.org SET country_code = 'LBR' WHERE country_code = 'LR';
UPDATE kuntur.org SET country_code = 'LVA' WHERE country_code = 'LV';
UPDATE kuntur.org SET country_code = 'LSO' WHERE country_code = 'LS';
UPDATE kuntur.org SET country_code = 'LAO' WHERE country_code = 'LA';
UPDATE kuntur.org SET country_code = 'MHL' WHERE country_code = 'MH';
UPDATE kuntur.org SET country_code = 'ZWE' WHERE country_code = 'ZW';
UPDATE kuntur.org SET country_code = 'TKL' WHERE country_code = 'TK';
UPDATE kuntur.org SET country_code = 'TGO' WHERE country_code = 'TG';
UPDATE kuntur.org SET country_code = 'TLS' WHERE country_code = 'TL';
UPDATE kuntur.org SET country_code = 'ATF' WHERE country_code = 'TF';
UPDATE kuntur.org SET country_code = 'IOT' WHERE country_code = 'IO';
UPDATE kuntur.org SET country_code = 'TJK' WHERE country_code = 'TJ';
UPDATE kuntur.org SET country_code = 'TZA' WHERE country_code = 'TZ';
UPDATE kuntur.org SET country_code = 'THA' WHERE country_code = 'TH';
UPDATE kuntur.org SET country_code = 'SJM' WHERE country_code = 'SJ';
UPDATE kuntur.org SET country_code = 'SUR' WHERE country_code = 'SR';
UPDATE kuntur.org SET country_code = 'SDN' WHERE country_code = 'SD';
UPDATE kuntur.org SET country_code = 'TON' WHERE country_code = 'TO';
UPDATE kuntur.org SET country_code = 'TTO' WHERE country_code = 'TT';
UPDATE kuntur.org SET country_code = 'TUN' WHERE country_code = 'TN';
UPDATE kuntur.org SET country_code = 'ZMB' WHERE country_code = 'ZM';
UPDATE kuntur.org SET country_code = 'DJI' WHERE country_code = 'DJ';
UPDATE kuntur.org SET country_code = 'YEM' WHERE country_code = 'YE';
UPDATE kuntur.org SET country_code = 'WLF' WHERE country_code = 'WF';
UPDATE kuntur.org SET country_code = 'VNM' WHERE country_code = 'VN';
UPDATE kuntur.org SET country_code = 'VUT' WHERE country_code = 'VU';
UPDATE kuntur.org SET country_code = 'UZB' WHERE country_code = 'UZ';
UPDATE kuntur.org SET country_code = 'UGA' WHERE country_code = 'UG';
UPDATE kuntur.org SET country_code = 'UKR' WHERE country_code = 'UA';
UPDATE kuntur.org SET country_code = 'TUV' WHERE country_code = 'TV';
UPDATE kuntur.org SET country_code = 'TKM' WHERE country_code = 'TM';
UPDATE kuntur.org SET country_code = 'SWZ' WHERE country_code = 'SZ';
UPDATE kuntur.org SET country_code = 'LKA' WHERE country_code = 'LK';
UPDATE kuntur.org SET country_code = 'SOM' WHERE country_code = 'SO';
UPDATE kuntur.org SET country_code = 'ESH' WHERE country_code = 'EH';
UPDATE kuntur.org SET country_code = 'RUS' WHERE country_code = 'RU';
UPDATE kuntur.org SET country_code = 'RWA' WHERE country_code = 'RW';
UPDATE kuntur.org SET country_code = 'REU' WHERE country_code = 'RE';
UPDATE kuntur.org SET country_code = 'DOM' WHERE country_code = 'DO';
UPDATE kuntur.org SET country_code = 'COD' WHERE country_code = 'CD';
UPDATE kuntur.org SET country_code = 'COG' WHERE country_code = 'CG';
UPDATE kuntur.org SET country_code = 'TWN' WHERE country_code = 'TW';
UPDATE kuntur.org SET country_code = 'CZE' WHERE country_code = 'CZ';
UPDATE kuntur.org SET country_code = 'CAF' WHERE country_code = 'CF';
UPDATE kuntur.org SET country_code = 'QAT' WHERE country_code = 'QA';
UPDATE kuntur.org SET country_code = 'WSM' WHERE country_code = 'WS';
UPDATE kuntur.org SET country_code = 'ASM' WHERE country_code = 'AS';
UPDATE kuntur.org SET country_code = 'KNA' WHERE country_code = 'KN';
UPDATE kuntur.org SET country_code = 'SGP' WHERE country_code = 'SG';
UPDATE kuntur.org SET country_code = 'SLE' WHERE country_code = 'SL';
UPDATE kuntur.org SET country_code = 'SYC' WHERE country_code = 'SC';
UPDATE kuntur.org SET country_code = 'SRB' WHERE country_code = 'RS';
UPDATE kuntur.org SET country_code = 'SEN' WHERE country_code = 'SN';
UPDATE kuntur.org SET country_code = 'STP' WHERE country_code = 'ST';
UPDATE kuntur.org SET country_code = 'LCA' WHERE country_code = 'LC';
UPDATE kuntur.org SET country_code = 'SHN' WHERE country_code = 'SH';
UPDATE kuntur.org SET country_code = 'VCT' WHERE country_code = 'VC';
UPDATE kuntur.org SET country_code = 'SPM' WHERE country_code = 'PM';
UPDATE kuntur.org SET country_code = 'SMR' WHERE country_code = 'SM';
UPDATE kuntur.org SET country_code = 'PYF' WHERE country_code = 'PF';
UPDATE kuntur.org SET country_code = 'EST' WHERE country_code = 'EE';
UPDATE kuntur.org SET country_code = 'CYP' WHERE country_code = 'CY';
UPDATE kuntur.org SET country_code = 'TCD' WHERE country_code = 'TD';
UPDATE kuntur.org SET country_code = 'CMR' WHERE country_code = 'CM';
UPDATE kuntur.org SET country_code = 'KHM' WHERE country_code = 'KH';
UPDATE kuntur.org SET country_code = 'CPV' WHERE country_code = 'CV';
UPDATE kuntur.org SET country_code = 'BTN' WHERE country_code = 'BT';
UPDATE kuntur.org SET country_code = 'BDI' WHERE country_code = 'BI';
UPDATE kuntur.org SET country_code = 'BFA' WHERE country_code = 'BF';
UPDATE kuntur.org SET country_code = 'BGR' WHERE country_code = 'BG';
UPDATE kuntur.org SET country_code = 'BRN' WHERE country_code = 'BN';
UPDATE kuntur.org SET country_code = 'VAT' WHERE country_code = 'VA';
UPDATE kuntur.org SET country_code = 'COM' WHERE country_code = 'KM';
UPDATE kuntur.org SET country_code = 'SVN' WHERE country_code = 'SI';
UPDATE kuntur.org SET country_code = 'SVK' WHERE country_code = 'SK';
UPDATE kuntur.org SET country_code = 'ERI' WHERE country_code = 'ER';
UPDATE kuntur.org SET country_code = 'ARE' WHERE country_code = 'AE';
UPDATE kuntur.org SET country_code = 'EGY' WHERE country_code = 'EG';
UPDATE kuntur.org SET country_code = 'DMA' WHERE country_code = 'DM';
UPDATE kuntur.org SET country_code = 'ARM' WHERE country_code = 'AM';
UPDATE kuntur.org SET country_code = 'HRV' WHERE country_code = 'HR';
UPDATE kuntur.org SET country_code = 'CIV' WHERE country_code = 'CI';
UPDATE kuntur.org SET country_code = 'PRK' WHERE country_code = 'KP';
UPDATE kuntur.org SET country_code = 'BWA' WHERE country_code = 'BW';
UPDATE kuntur.org SET country_code = 'BIH' WHERE country_code = 'BA';
UPDATE kuntur.org SET country_code = 'DZA' WHERE country_code = 'DZ';
UPDATE kuntur.org SET country_code = 'SAU' WHERE country_code = 'SA';
UPDATE kuntur.org SET country_code = 'ANT' WHERE country_code = 'AN';
UPDATE kuntur.org SET country_code = 'ATG' WHERE country_code = 'AG';
UPDATE kuntur.org SET country_code = 'ATA' WHERE country_code = 'AQ';
UPDATE kuntur.org SET country_code = 'AIA' WHERE country_code = 'AI';
UPDATE kuntur.org SET country_code = 'AGO' WHERE country_code = 'AO';
UPDATE kuntur.org SET country_code = 'AND' WHERE country_code = 'AD';
UPDATE kuntur.org SET country_code = 'ALB' WHERE country_code = 'AL';
UPDATE kuntur.org SET country_code = 'ALA' WHERE country_code = 'AX';
UPDATE kuntur.org SET country_code = 'MKD' WHERE country_code = 'MK';
UPDATE kuntur.org SET country_code = 'MMR' WHERE country_code = 'MM';
UPDATE kuntur.org SET country_code = 'BLR' WHERE country_code = 'BY';
UPDATE kuntur.org SET country_code = 'BMU' WHERE country_code = 'BM';
UPDATE kuntur.org SET country_code = 'BEN' WHERE country_code = 'BJ';
UPDATE kuntur.org SET country_code = 'BLZ' WHERE country_code = 'BZ';
UPDATE kuntur.org SET country_code = 'BRB' WHERE country_code = 'BB';
UPDATE kuntur.org SET country_code = 'BGD' WHERE country_code = 'BD';
UPDATE kuntur.org SET country_code = 'BHR' WHERE country_code = 'BH';
UPDATE kuntur.org SET country_code = 'BHS' WHERE country_code = 'BS';
UPDATE kuntur.org SET country_code = 'AZE' WHERE country_code = 'AZ';
UPDATE kuntur.org SET country_code = 'AFG' WHERE country_code = 'AF';
UPDATE kuntur.org SET country_code = 'ETH' WHERE country_code = 'ET';
UPDATE kuntur.org SET country_code = 'IDN' WHERE country_code = 'ID';
UPDATE kuntur.org SET country_code = 'GUM' WHERE country_code = 'GU';
UPDATE kuntur.org SET country_code = 'GLP' WHERE country_code = 'GP';
UPDATE kuntur.org SET country_code = 'CXR' WHERE country_code = 'CX';
UPDATE kuntur.org SET country_code = 'MCO' WHERE country_code = 'MC';
UPDATE kuntur.org SET country_code = 'GRL' WHERE country_code = 'GL';
UPDATE kuntur.org SET country_code = 'ISL' WHERE country_code = 'IS';
UPDATE kuntur.org SET country_code = 'GRD' WHERE country_code = 'GD';
UPDATE kuntur.org SET country_code = 'GIB' WHERE country_code = 'GI';
UPDATE kuntur.org SET country_code = 'GUF' WHERE country_code = 'GF';
UPDATE kuntur.org SET country_code = 'GGY' WHERE country_code = 'GG';
UPDATE kuntur.org SET country_code = 'GIN' WHERE country_code = 'GN';
UPDATE kuntur.org SET country_code = 'IRN' WHERE country_code = 'IR';
UPDATE kuntur.org SET country_code = 'IRQ' WHERE country_code = 'IQ';
UPDATE kuntur.org SET country_code = 'HKG' WHERE country_code = 'HK';
UPDATE kuntur.org SET country_code = 'BVT' WHERE country_code = 'BV';
UPDATE kuntur.org SET country_code = 'IMN' WHERE country_code = 'IM';
UPDATE kuntur.org SET country_code = 'GUY' WHERE country_code = 'GY';
UPDATE kuntur.org SET country_code = 'GNB' WHERE country_code = 'GW';
UPDATE kuntur.org SET country_code = 'MNP' WHERE country_code = 'MP';
UPDATE kuntur.org SET country_code = 'GHA' WHERE country_code = 'GH';
UPDATE kuntur.org SET country_code = 'CYM' WHERE country_code = 'KY';
UPDATE kuntur.org SET country_code = 'FRO' WHERE country_code = 'FO';
UPDATE kuntur.org SET country_code = 'GNQ' WHERE country_code = 'GQ';
UPDATE kuntur.org SET country_code = 'GAB' WHERE country_code = 'GA';
UPDATE kuntur.org SET country_code = 'SGS' WHERE country_code = 'GS';
UPDATE kuntur.org SET country_code = 'IND' WHERE country_code = 'IN';
UPDATE kuntur.org SET country_code = 'GMB' WHERE country_code = 'GM';
UPDATE kuntur.org SET country_code = 'FJI' WHERE country_code = 'FJ';
UPDATE kuntur.org SET country_code = 'COK' WHERE country_code = 'CK';
UPDATE kuntur.org SET country_code = 'FIN' WHERE country_code = 'FI';
UPDATE kuntur.org SET country_code = 'HMD' WHERE country_code = 'HM';
UPDATE kuntur.org SET country_code = 'PHL' WHERE country_code = 'PH';
UPDATE kuntur.org SET country_code = 'GEO' WHERE country_code = 'GE';
UPDATE kuntur.org SET country_code = 'CCK' WHERE country_code = 'CC';
UPDATE kuntur.org SET country_code = 'FLK' WHERE country_code = 'FK';
UPDATE kuntur.org SET country_code = 'BRA' WHERE country_code = 'BR';
UPDATE kuntur.org SET country_code = 'BOL' WHERE country_code = 'BO';
UPDATE kuntur.org SET country_code = 'DEU' WHERE country_code = 'DE';
UPDATE kuntur.org SET country_code = 'PER' WHERE country_code = 'PE';
UPDATE kuntur.org SET country_code = 'USA' WHERE country_code = 'US';
UPDATE kuntur.org SET country_code = 'ARG' WHERE country_code = 'AR';



-- Control para que no queden códigos distintos de 3
SELECT * FROM kuntur.org WHERE char_length(country_code) <> 3;
--SELECT * FROM kuntur.org;

UPDATE kuntur.org SET primary_org = true WHERE web_site = 'www.unc.edu.ar';

SELECT * FROM kuntur.org WHERE primary_org = true;
