-- Question: What are the most optimal skills to learn(what is the high demand & high-paying skill for data analyst)
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
    INNER JOIN
      skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
      skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
  GROUP BY
    skills_dim.skill_id
),

-- Skills with high average salaries for Data Analyst roles
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
    INNER JOIN
      skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
  AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
  skills_job_dim.skill_id
)

-- Return high demand and high salaries for top 10 skills
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND((average_salary.avg_salary),2) AS avg_salary
FROM
  skills_demand
  INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
  demand_count DESC,
  avg_salary DESC
LIMIT 10;
