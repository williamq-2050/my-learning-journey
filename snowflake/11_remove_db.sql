show databases;

alter database COPY_DB SET DATA_RETENTION_TIME_IN_DAYS  = 0;
alter database DEMO_DB SET DATA_RETENTION_TIME_IN_DAYS  = 0;
alter database EXERCISE_DB SET DATA_RETENTION_TIME_IN_DAYS  = 0;
alter database TIMETRAVEL_EXERCISE SET DATA_RETENTION_TIME_IN_DAYS  = 0;

drop database COPY_DB;
drop database DEMO_DB;
drop database EXERCISE_DB;
drop database TIMETRAVEL_EXERCISE;