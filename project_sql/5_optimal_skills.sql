WITH filters AS (
    SELECT *
    FROM 
        job_postings_fact 
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND (
            job_work_from_home = TRUE
            OR job_location = ('Bogotá, Bogota, Colombia')
        )
), skills_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM filters f
    INNER JOIN skills_job_dim sjd ON f.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    GROUP BY sd.skill_id, sd.skills
), average_salary AS (   
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM filters f
    INNER JOIN skills_job_dim sjd ON f.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    GROUP BY
        sd.skill_id
)


SELECT 
    d.skill_id,
    d.skills,
    d.demand_count,
    a.avg_salary
FROM
    skills_demand d
INNER JOIN average_salary a ON d.skill_id = a.skill_id
WHERE
    demand_count > 10
ORDER BY d.demand_count DESC, a.avg_salary DESC
LIMIT 25



