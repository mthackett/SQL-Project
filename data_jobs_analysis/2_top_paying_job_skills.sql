/*
Question: what skills are needed for the highest paying data analyst roles?
- Use the top 10 highest paying data analyst jobs from the first query.
- Add the specific skills required for these roles.
Purpose: to provide a detailed look at the skills required by the highest.
paying roles to help job sekers understand which skills align with top salaries.
*/
WITH highest_paying_jobs AS (
    SELECT
        job_postings.job_id,
        job_title,
        company_dim.name AS company,
    --    job_location,
    --    job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact AS job_postings
    LEFT JOIN company_dim
        ON company_dim.company_id = job_postings.company_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    highest_paying_jobs.*,
    skills,
    type AS skill_category
FROM
    highest_paying_jobs
INNER JOIN skills_job_dim
    ON highest_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC