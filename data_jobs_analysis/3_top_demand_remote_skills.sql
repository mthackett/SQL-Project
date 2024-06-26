/*
Question: what are the highest demand skills for remote data analysts?
- Identify the top 10 skills for remote data analysts.
Purpose: to see the skills with the highest demand for remote data analysts.
*/
WITH remote_analyst_jobs AS (
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
)

SELECT
    skills
    , COUNT(skills) AS jobs_with_skill
FROM
    remote_analyst_jobs
INNER JOIN skills_job_dim
    ON remote_analyst_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills
ORDER BY jobs_with_skill DESC
LIMIT 10;