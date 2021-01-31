#### Quick Test for functionality

## running a vacuum in 1 session
## the existing pg_stat_progress_vacuum shows overall details from the calling pid
test=>
test=> select * from pg_stat_progress_vacuum;
-[ RECORD 1 ]------+------------------
pid                | 60099
datid              | 16385
datname            | test
relid              | 16389
phase              | vacuuming indexes
heap_blks_total    | 16579
heap_blks_scanned  | 2566
heap_blks_vacuumed | 1282
index_vacuum_count | 1
max_dead_tuples    | 174761
num_dead_tuples    | 174488

## the new pg_stat_progress_vacuum_worker shows the phase and indrelid of the current worker
test=> select * from pg_stat_progress_vacuum_worker;
-[ RECORD 1 ]----+------------------------------
pid              | 60099
datid            | 16385
datname          | test
relid            | 16389
is_leader        | t
phase_start_time | 2021-01-30 19:44:29.305905-06
phase            | vacuuming indexes
indrelid         | 16392
-[ RECORD 2 ]----+------------------------------
pid              | 61718
datid            | 16385
datname          | test
relid            | 16389
is_leader        | f
phase_start_time | 2021-01-30 19:44:37.790307-06
phase            | vacuuming indexes
indrelid         | 16400
-[ RECORD 3 ]----+------------------------------
pid              | 61719
datid            | 16385
datname          | test
relid            | 16389
is_leader        | f
phase_start_time | 2021-01-30 19:44:36.812942-06
phase            | vacuuming indexes
indrelid         | 16399

## connecting as a user without permissions on the relation. As expected, data is not advertised

test=> select * from pg_stat_progress_vacuum;
-[ RECORD 1 ]------+------
pid                | 60099
datid              | 16385
datname            | test
relid              |
phase              |
heap_blks_total    |
heap_blks_scanned  |
heap_blks_vacuumed |
index_vacuum_count |
max_dead_tuples    |
num_dead_tuples    |

test=>
test=> select * from pg_stat_progress_vacuum_worker;
-[ RECORD 1 ]----+------
pid              | 60099
datid            | 16385
datname          | test
relid            |
is_leader        |
phase_start_time |
phase            |
indrelid         |
-[ RECORD 2 ]----+------
pid              | 62058
datid            | 16385
datname          | test
relid            |
is_leader        |
phase_start_time |
phase            |
indrelid         |
-[ RECORD 3 ]----+------
pid              | 62059
datid            | 16385
datname          | test
relid            |
is_leader        |
phase_start_time |
phase            |
indrelid         |

