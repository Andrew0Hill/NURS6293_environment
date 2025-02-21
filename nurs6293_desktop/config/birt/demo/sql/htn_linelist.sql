select distinct enc_diagnoses.dx_id, diagnoses.icd9_text, patient.pat_id, patient.dob, 
          date_part('YEAR',AGE(current_date, dob)) as age_in_years
from  enc_diagnoses join diagnoses on enc_diagnoses.dx_id = diagnoses.dx_id
join encounter on encounter.enc_id = enc_diagnoses.enc_id
join patient on encounter.pat_id = patient.pat_id
where lower(icd9_text) like '%hypertension%' 
and date_part('YEAR',AGE(current_date, dob)) > 100
order by date_part('YEAR',AGE(current_date, dob)) desc

