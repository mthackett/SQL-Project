/*
Question: what are the highest demand skills for data analysts overall?
- Identify the top 10 skills for all data analyst positions.
Purpose: to see the skills with the highest demand for all data analyst 
job postings to see if there is a significant difference in the skills demanded.
*/
WITH analyst_jobs AS (
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
)

SELECT
    skills
    , COUNT(skills) AS jobs_with_skill
FROM
    analyst_jobs
INNER JOIN skills_job_dim
    ON analyst_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills
ORDER BY jobs_with_skill DESC
LIMIT 10;

-- We observe that the top 7 skill ranks are identical. The remote jobs
-- had Azure and Looker, while the rest had Word and SAP. 
-- The remote postings had more emphasis on cloud and web based tools.