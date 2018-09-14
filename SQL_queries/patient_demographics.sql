/* DEMOGRAPHICS */

SELECT DISTINCT pat.pat_id, pat.pat_mrn_id AS mrn, pat.pat_last_name AS last_name, pat.pat_first_name AS first_name,
substr(pat.pat_middle_name,1,1) AS mid_initial, pat2.maiden_name AS maiden_name, pat.birth_date AS dob, c.name AS county,
s.name AS state, pat.zip AS zip, enc.contact_date AS encounter_date, floor(months_between(enc.contact_date, pat.birth_date)/12) AS age,

(CASE WHEN sex.abbr='oth' THEN 'o' ELSE sex.abbr END) AS sex, 

(SELECT listagg(race.name, ',') WITHIN GROUP (ORDER BY pr.line)
FROM clarity.patient_race pr, clarity.zc_patient_race race
WHERE pr.pat_id=pat.pat_id
AND race.patient_race_c=pr.patient_race_c) AS race
 
FROM clarity.pat_enc enc
INNER JOIN clarity.patient pat ON enc.pat_id=pat.pat_id
INNER JOIN clarity.patient_2 pat2 ON pat.pat_id=pat2.pat_id
LEFT OUTER JOIN clarity.zc_county c ON pat.county_c=c.county_c
INNER JOIN clarity.zc_state s ON pat.state_c=s.state_c
INNER JOIN clarity.zc_sex_2 sex ON pat.sex_c=sex.sex_2_c;
