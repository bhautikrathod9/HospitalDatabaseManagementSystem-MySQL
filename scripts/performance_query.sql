-- Check query performance
SELECT 
    SCHEMA_NAME,
    SUM(COUNT_READ) as total_reads,
    SUM(COUNT_WRITE) as total_writes,
    SUM(SUM_TIMER_READ) as read_time,
    SUM(SUM_TIMER_WRITE) as write_time
FROM performance_schema.table_io_waits_summary_by_table 
WHERE SCHEMA_NAME = 'hospital_management_system'
GROUP BY SCHEMA_NAME;

-- Monitor slow queries
SELECT 
    sql_text,
    exec_count,
    avg_timer_wait/1000000000 as avg_time_seconds
FROM performance_schema.events_statements_summary_by_digest 
ORDER BY avg_timer_wait DESC 
LIMIT 10;