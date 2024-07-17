-- Question: What are the top paying data analyst jobs, and what skills are required?
-- Gets the top 10 paying data analyst jobs
WITH top_paying_jobs AS (
        SELECT
            job_id,
            job_title,
            salary_year_avg
        FROM
            job_postings_fact
        WHERE
            job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
            AND job_location = 'Anywhere'
        ORDER BY
            salary_year_avg DESC
        LIMIT 10
)
-- Skills required for data analyst jobs
-- skills_job_dim = skills for with each job
-- skills_dim = skill name
SELECT
    top_paying_jobs.job_id,
    job_title,
    salary_year_avg,
    skills
FROM
    top_paying_jobs
    INNER JOIN
        skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

-- The highest paying job listed is 'Associate Director - Data Insights, with a salary of $255,829.5.
-- Highest essential skills for these top roles include SQL, Python, R, Azure, and Databricks.