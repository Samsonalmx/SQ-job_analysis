
WITH Top_paying_job as (


SELECT
    job_id,
    job_title,
    salary_year_avg,
    name as company_name
FROM
    job_postings_fact
left join company_dim on company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' and
    job_location = 'New York, NY' and
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
limit 10
)

SELECT *
    from Top_paying_job