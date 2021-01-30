select query,
       calls
       total_time/calls ms_per_call,
from pg_stat_statements 
order by 3 desc limit 50;
       
