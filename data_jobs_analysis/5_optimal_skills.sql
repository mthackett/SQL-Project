/*
Question: which skills are both high paying and in high demand for
remote data analysts?
Purpose: to highlight skills that are in high demand and highly
compensated, offering key insight for job seekers and career growth.
*/
-- CTE1: 
WITH remote_analyst_jobs AS (
    SELECT
        job_postings_fact.job_id
        , job_postings_fact.salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
),
-- CTE2: 
avg_skill_salaries AS (
    SELECT
        skills_job_dim.skill_id
        ,ROUND(AVG(remote_analyst_jobs.salary_year_avg), 0) AS avg_skill_salary
    FROM
        remote_analyst_jobs
    INNER JOIN skills_job_dim
        ON skills_job_dim.job_id = remote_analyst_jobs.job_id
    GROUP BY
        skills_job_dim.skill_id
),
-- CTE3
skill_demand AS (
SELECT
    skills_job_dim.skill_id
    , COUNT(skills_job_dim.skill_id) AS jobs_with_skill
FROM
    remote_analyst_jobs
INNER JOIN skills_job_dim
    ON remote_analyst_jobs.job_id = skills_job_dim.job_id
GROUP BY skills_job_dim.skill_id
)

SELECT
    skills_dim.skills
    , jobs_with_skill
    , avg_skill_salary
    , skills_dim.type AS skill_category
FROM
    avg_skill_salaries
INNER JOIN skill_demand
    ON avg_skill_salaries.skill_id = skill_demand.skill_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = avg_skill_salaries.skill_id

GROUP BY skills_dim.skills, avg_skill_salary, skill_category, jobs_with_skill
HAVING jobs_with_skill > 24
ORDER BY jobs_with_skill DESC

LIMIT 30;
