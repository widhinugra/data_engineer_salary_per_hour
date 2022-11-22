query=`cat ./sq_dm_salary_per_hour.sql | jq -aRs .`

# Created by widhi
# Created at 2022-11-22

bq mk --transfer_config \
--project_id='decent-subset-350508' \ # bigquery project_id
--target_dataset='try' \ # bigquery dataset name
--display_name='sq_dm_salary_per_hour' \
--schedule='every day 18:00' \
--start_time='2022-06-28T18:00:00' \
--params='{"query":'"$query"', "destination_table_name_template":"dm_salary_per_hour", "write_disposition":"WRITE_TRUNCATE"}' \
--data_source=scheduled_query
