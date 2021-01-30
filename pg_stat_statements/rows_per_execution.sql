select query,
       rows
       total_time/rows rows_per_call,
from pg_stat_statements
order by 3 desc limit 50; 
