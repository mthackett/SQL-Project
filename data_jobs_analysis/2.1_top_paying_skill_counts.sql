/*
Question: what are the skills associated with the top 10 highest paying remote data analysts?
- Use the top 10 highest paying data analyst jobs from the first query.
- Count the skills required for these roles.
Purpose: to see the skills associated with the top paying remote data analyst positions and how
often they were asked for.
*/
WITH highest_paying_jobs AS (
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    skills
    , COUNT(skills) AS jobs_with_skill
FROM
    highest_paying_jobs
INNER JOIN skills_job_dim
    ON highest_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills
ORDER BY jobs_with_skill DESC