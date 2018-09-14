/* FLOWSHEET/VITALS */

SELECT DISTINCT p.pat_id, p.pat_mrn_id AS MRN, to_char(ipfm.recorded_time,'YYYY-mm-dd HH24:MI:SS') AS recorded_time,
ipflog.disp_name AS display_name, ipfm.meas_value AS vital_value
 
FROM clarity.ip_flwsht_meas ipfm   
INNER JOIN clarity.ip_flwsht_rec ipfr ON ipfr.fsd_id=ipfm.fsd_id
LEFT OUTER JOIN clarity.ip_flo_gp_data ipflog ON ipfm.flo_meas_id=ipflog.flo_meas_id
INNER JOIN clarity.pat_enc pe ON pe.inpatient_data_id=ipfr.inpatient_data_id
INNER JOIN clarity.patient p ON pe.pat_id=p.pat_id   
 
WHERE ipfm.flo_meas_id IN ('5','11','14')
AND ipfm.meas_value IS NOT NULL;
