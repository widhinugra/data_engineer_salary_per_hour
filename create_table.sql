CREATE TABLE IF NOT EXISTS `decent-subset-350508.try.dm_salary_per_hour_df`
(
    year INT64,
    month INT64,
    branch_id INT64,
    salary_per_hour FLOAT64
);

CREATE TABLE IF NOT EXISTS `decent-subset-350508.try.employees`
(
    employe_id INT64,
    branch_id INT64,
    salary INT64,
    join_date Date,
    resign_date Date
);

CREATE TABLE IF NOT EXISTS `decent-subset-350508.try.timesheets`
(
    timesheet_id INT64,
    employe_id INT64,
    date Date,
    checkin Time,
    checkout Time
);

LOAD DATA OVERWRITE `decent-subset-350508.try.employees`
FROM FILES (
  format = 'CSV',
  uris = ['gs://bucket/path/employees.csv']);

LOAD DATA OVERWRITE `decent-subset-350508.try.timesheets`
FROM FILES (
  format = 'CSV',
  uris = ['gs://bucket/path/timesheets.csv']);