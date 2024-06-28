/*
Question: what are the highest paying non-senior job postings for remote data analysts?
Purpose: to provide the highest paying non-senior job postings to help inform a job 
search for entry or mid level job seekers.
*/
SELECT
    job_id,
    job_title,
    company_dim.name AS company,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND job_title !~* '(Director|Senior|Principal|Manager|Lead)'
ORDER BY
    salary_year_avg DESC
LIMIT 20;