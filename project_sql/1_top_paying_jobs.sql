/*
    Question:
    What are the top-paying Data Analyst jobs?
    - Identify the top 10 highest-paying Data Analyst roles that are available remotely.
    - Focuses on the job postings with spicified salaries (remove nulls)
    - Highlight the top-paying opportunities for Data Analysis.
*/



SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    AND (
            job_work_from_home = TRUE
            OR job_location = ('Bogotá, Bogota, Colombia')
        )
ORDER BY
    salary_year_avg DESC
LIMIT 50


