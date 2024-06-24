/*
Question: What are the highest paying data analyst jobs?
- Identify the top 10 highest paying remote data analyst roles.
- Focus on job postings with specified salaries.
Purpose: Find the highest paying job postings for data analysts to provide insight into 
the role.
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
ORDER BY
    salary_year_avg DESC
LIMIT 10;