import pandas as pd

pd.options.mode.chained_assignment = None  # default='warn'

employees_df = pd.read_csv('data/employees.csv')
timesheets_df = pd.read_csv('data/timesheets.csv')

employees_df['join_date'] = pd.to_datetime(employees_df['join_date'])
employees_df['resign_date'] = pd.to_datetime(employees_df['resign_date'])

timesheets_df['checkin'] = pd.to_datetime(timesheets_df['checkin'])
timesheets_df['checkout'] = pd.to_datetime(timesheets_df['checkout'])
timesheets_df['date'] = pd.to_datetime(timesheets_df['date'])

left_join = pd.merge(timesheets_df, 
                     employees_df, 
                     left_on ='employee_id', 
                     right_on ='employe_id', 
                     how ='left')

data_csv = left_join[((left_join['checkin'].notnull()) & (left_join['checkout'].notnull())) & ((left_join['resign_date'] >= left_join['date']) | (left_join['resign_date'].isnull()))]
working_hours = (data_csv['checkout'] - data_csv['checkin']).astype('timedelta64[h]')

data_csv['working_hours'] = working_hours
data_csv['year'] = data_csv['date'].dt.year
data_csv['month'] = data_csv['date'].dt.month

data_group = data_csv.groupby(["year", "month","branch_id","employe_id"]).agg(sum_working_hours=('working_hours', 'sum'), salary=('salary', 'max'), employee=('employe_id','max'))


data_final = data_group.groupby(["year", "month","branch_id"]).agg(total_working_hours=('sum_working_hours', 'sum'), total_salary=('salary', 'sum'), total_employee=('employee','count'))
data_final['salary_per_hour'] = data_final['total_salary']/data_final['total_working_hours']

print(data_final)



