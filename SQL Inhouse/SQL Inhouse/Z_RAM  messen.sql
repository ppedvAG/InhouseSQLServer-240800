--Setting 900---6000

SELECT 
	physical_memory_in_use_kb/1024 AS sql_physical_memory_in_use_MB, 
    large_page_allocations_kb/1024 AS sql_large_page_allocations_MB, 
    locked_page_allocations_kb/1024 AS sql_locked_page_allocations_MB,
    virtual_address_space_reserved_kb/1024 AS sql_VAS_reserved_MB, 
    virtual_address_space_committed_kb/1024 AS sql_VAS_committed_MB, 
    virtual_address_space_available_kb/1024 AS sql_VAS_available_MB,
    page_fault_count AS sql_page_fault_count,
    memory_utilization_percentage AS sql_memory_utilization_percentage, 
    process_physical_memory_low AS sql_process_physical_memory_low, 
    process_virtual_memory_low AS sql_process_virtual_memory_low
FROM sys.dm_os_process_memory;


select physical_memory_kb/1024	 as PhysMemMB,
		virtual_memory_kb/1024	 as VirtMemMB,
		committed_kb/1024		 as commitedtMB,
		committed_target_kb/1024 as targetMB,
		visible_target_kb/1024	 as VisTargMB
from sys.dm_os_sys_info

select * from sys.dm_os_sys_memory
/*
Benachrichtigung zum Systemstatus: 
Speicherressourcen sind ausreichend. 
Ein Wert von 1 gibt an, dass das Signal für 
ausreichende Speicherressourcen von Windows festgelegt 
wurde.

Benachrichtigung zum Systemstatus: 
Speicherressourcen sind nicht ausreichend. 
Ein Wert von 1 gibt an, dass das Signal für 
nicht ausreichende Speicherressourcen 
von Windows festgelegt wurde. 
*/
SELECT 'Waiting_tasks' AS [Information], owt.session_id,
    owt.wait_duration_ms, owt.wait_type, owt.blocking_session_id,
    owt.resource_description, es.program_name, est.text,
    est.dbid, eqp.query_plan, er.database_id, es.cpu_time,
    es.memory_usage*8 AS memory_usage_KB
FROM sys.dm_os_waiting_tasks owt
INNER JOIN sys.dm_exec_sessions es ON owt.session_id = es.session_id
INNER JOIN sys.dm_exec_requests er ON es.session_id = er.session_id
OUTER APPLY sys.dm_exec_sql_text (er.sql_handle) est
OUTER APPLY sys.dm_exec_query_plan (er.plan_handle) eqp
WHERE es.is_user_process = 1
ORDER BY owt.session_id;
GO


--Wie gehe ich vor:
--Wieviel haben wir
SELECT total_physical_memory_kb / 1024 AS MemoryMb 
FROM sys.dm_os_sys_memory

--was bekommen wir maximal
SELECT name, value_in_use FROM sys.configurations 
WHERE name LIKE 'max server memory%'

--Kann auch über max gehen:
--gilt nur  für den SQL-Pufferpool gilt 
--und verschiedene andere Komponenten innerhalb von SQL mehr Speicher verbrauchen können. 
--Es muss jedoch gesagt werden, dass der Pufferpool hauptsächlich 
--das größte Element der SQL-Speicherzuweisung ist.


--Wo wird der Speicher verbaucht
SELECT TOP(5) [type] AS [ClerkType],
SUM(pages_kb) / 1024 AS [SizeMb]
FROM sys.dm_os_memory_clerks WITH (NOLOCK)
GROUP BY [type]
ORDER BY SUM(pages_kb) DESC

--CACHESTORE_SQLCP --Pläne Anweisungen direkt gegen SQL Server
--CACHESTORE_OBJCP Proc Pläne
--CACHESTORE_PHDR algebrisierte Bäume für verschiedene Objekte 
--Lock...

--SQLQERESERVATIONS
--Welche Abfrage verbraucht den Speicher ..

SELECT session_id, requested_memory_kb / 1024 as RequestedMemMb, 
granted_memory_kb / 1024 as GrantedMemMb, text
FROM sys.dm_exec_query_memory_grants qmg
CROSS APPLY sys.dm_exec_sql_text(sql_handle)

--für welche DB verbrauchen wir wieviel Speicher

SELECT TOP 5 DB_NAME(database_id) AS [Database Name],
COUNT(*) * 8/1024.0 AS [Cached Size (MB)]
FROM sys.dm_os_buffer_descriptors WITH (NOLOCK)
GROUP BY DB_NAME(database_id)
ORDER BY [Cached Size (MB)] DESC OPTION (RECOMPILE);



 