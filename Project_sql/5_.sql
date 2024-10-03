WITH Skills_demand as (
select 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count
    from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
),
Average_salary as (
select 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) as avg_salary
    from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
AND job_work_from_home = TRUE 
GROUP BY skills_job_dim.skill_id
)

SELECT 
    Skills_demand.skill_id,
    Skills_demand.skills,
    skills_demand.demand_count,
    Average_salary.avg_salary
FROM 
    Skills_demand
INNER JOIN Average_salary ON Skills_demand.skill_id = Average_salary.skill_id
wHERE 
    skills_demand.demand_count>10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25;