WITH company_job_count as (
SELECT   
    company_id,
    count(*) as total_jobs
FROM
    job_postings_fact

GROUP BY
    company_id
)

SELECT
company_dim.name as company_name,
company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;



WITH Top_5_skills as (
SELECT
    skill_id,
    count(*) as no_of_jobs
FROM
    skills_job_dim
GROUP BY
    skill_id
)


SELECT
    skills_dim.skills as Skill_name,
    Top_5_skills.no_of_jobs
FROM
    skills_dim
LEFT JOIN 
    Top_5_skills ON Top_5_skills.skill_id = skills_dim.skill_id
ORDER BY
    no_of_jobs DESC
LIMIT
    5;

WITH CompanyJobCounts AS (
    SELECT
        company_id,
        COUNT(*) AS job_postings_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_id,
    job_postings_count,
    CASE
        WHEN job_postings_count < 10 THEN 'Small'
        WHEN job_postings_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM
    CompanyJobCounts;




SELECT
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs
) AS Quarter1_jobs_postings
WHERE
    salary_year_avg > 70000 AND
    Job_title_short ='Data_Analyst'
ORDER BY
   salary_year_avg DESC; 