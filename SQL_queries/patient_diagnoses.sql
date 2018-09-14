/* DIAGNOSES */

SELECT DISTINCT p.pat_id, p.pat_mrn_id, 'enc' AS dxtype, eci.code, 1 AS dx

FROM clarity.patient p
INNER JOIN clarity.pat_enc pe ON p.pat_id=pe.pat_id
INNER JOIN clarity.pat_enc_dx ped ON pe.pat_enc_csn_id=ped.pat_enc_csn_id
INNER JOIN clarity.clarity_edg edg ON ped.dx_id = edg.dx_id
INNER JOIN clarity.edg_current_icd10 eci ON edg.dx_id = eci.dx_id

WHERE REGEXP_LIKE(eci.code, '^(J)');