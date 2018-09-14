/* MEDICATIONS */

(SELECT DISTINCT p.pat_id, p.pat_mrn_id, pe.pat_enc_csn_id, om.order_med_id, om.start_date, om.end_date,
cm.generic_name AS med_name, pc.name AS pharm_class, psc.name AS pharm_subclass, om.order_status_c
 
FROM clarity.patient p
INNER JOIN clarity.pat_enc_hsp pe ON p.pat_id=pe.pat_id
INNER JOIN clarity.order_med om ON pe.pat_enc_csn_id=om.pat_enc_csn_id        
INNER JOIN clarity.clarity_medication cm ON om.medication_id=cm.medication_id
LEFT OUTER JOIN clarity.mar_admin_info mai ON om.order_med_id=mai.order_med_id
INNER JOIN clarity.zc_pharm_class pc ON cm.pharm_class_c=pc.pharm_class_c
INNER JOIN clarity.zc_pharm_subclass psc ON cm.pharm_subclass_c=psc.pharm_subclass_c
 
WHERE om.order_status_c <> 4 /*not canceled*/
AND om.order_class_c <> 3 /*no historical meds*/
AND mai.mar_action_c IN (1,6,7,9,12,13,101,104,105,115,116,118,119,131))
 
UNION

(SELECT DISTINCT p.pat_id, p.pat_mrn_id, pe.pat_enc_csn_id, om.order_med_id, om.start_date, om.end_date,
cm.generic_name AS med_name, pc.name AS pharm_class, psc.name AS pharm_subclass, om.order_status_c
 
FROM clarity.patient p
INNER JOIN clarity.pat_enc_hsp pe ON p.pat_id=pe.pat_id
INNER JOIN clarity.order_med om ON pe.pat_enc_csn_id=om.pat_enc_csn_id        
INNER JOIN clarity.order_medmixinfo omi ON om.order_med_id=omi.order_med_id
LEFT OUTER JOIN clarity.mar_admin_info mai ON om.order_med_id=mai.order_med_id
INNER JOIN clarity.clarity_medication cm ON omi.medication_id=cm.medication_id
INNER JOIN clarity.zc_pharm_class pc ON cm.pharm_class_c=pc.pharm_class_c
INNER JOIN clarity.zc_pharm_subclass psc ON cm.pharm_subclass_c=psc.pharm_subclass_c
 
WHERE om.order_status_c <> 4 /*not canceled*/
AND om.order_class_c <> 3 /*no historical meds*/
AND mai.mar_action_c  IN (1,6,7,9,12,13,101,104,105,115,116,118,119,131));
