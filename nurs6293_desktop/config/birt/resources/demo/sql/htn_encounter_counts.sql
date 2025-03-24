select enc_diagnoses.dx_id, diagnoses.icd9_text, count(enc_id)
from enc_diagnoses join diagnoses on enc_diagnoses.dx_id = diagnoses.dx_id
where lower(icd9_text) like '%hypertension%' 
group by enc_diagnoses.dx_id, diagnoses.icd9_text
order by count(enc_id) desc
