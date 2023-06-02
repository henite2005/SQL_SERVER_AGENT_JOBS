---How To Find The SQL Server Agent Job Names and Steps Where SSIS Package Is Used---

USE [msdb]
GO
SELECT 
   Srv.srvname AS ServerName,
   Job.name AS JobName,
   JStep.step_id,
   JStep.step_name AS StepName,
   JStep.command,
   Job.enabled 
FROM   dbo.sysjobs Job
JOIN   dbo.sysjobsteps JStep
   ON  JStep.job_id = Job.job_id 
JOIN   MASTER.dbo.sysservers Srv
   ON  Srv.srvid = Job.originating_server_id
WHERE  JStep.subsystem='SSIS'
ORDER BY Job.name,step_id
