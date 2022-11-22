with data_csv as (
  select t.employe_id, e.salary, e.branch_id, t.date, EXTRACT(HOUR FROM (t.checkout- t.checkin)) as working_hours, t.checkin, t.checkout, EXTRACT(YEAR from date) as year, EXTRACT(MONTH from date) as month
  from `decent-subset-350508.try.timesheets` t
  left join `decent-subset-350508.try.employees` e on e.employe_id = t.employe_id
  where 
    (t.checkin is not null and t.checkout is not null) and
    (e.resign_date >= t.date or e.resign_date is null)
),
data_group as (
  select year, month, branch_id, employe_id, count(*), sum(working_hours) as sum_working_hours, max(salary) as salary
  from data_csv
  group by year, month, branch_id, employe_id
  order by year, month, branch_id, employe_id
),
data_final as (
  select year, month, branch_id, sum(sum_working_hours) as total_working_hours, sum(salary) as total_salary, count(*) as employe_id_count, ROUND(sum(salary)/sum(sum_working_hours),2) as salary_per_hour
  from data_group
  group by year, month, branch_id
  order by year, month, branch_id
)
SELECT year, month, branch_id, salary_per_hour from data_final

