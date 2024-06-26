/*
Question: which skills are both high paying and in high demand?
Purpose: to highlight skills that are in high demand and highly
compensated, offering key insight for job seekers and career growth.
*/
--- CTE1: highest 30 paying skills
WITH avg_skill_salaries AS (
SELECT
    skills
    ,ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_skill_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_skill_salary DESC
LIMIT 30
)


SELECT
    avg_skill_salaries.skills
    , COUNT(avg_skill_salaries.skills) AS jobs_with_skill
    , avg_skill_salaries.avg_skill_salary
    , skills_dim.type AS skill_category
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN avg_skill_salaries
    ON avg_skill_salaries.skills = skills_dim.skills
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY avg_skill_salaries.skills, avg_skill_salaries.avg_skill_salary
    ,skill_category
ORDER BY jobs_with_skill DESC
--LIMIT 10;


