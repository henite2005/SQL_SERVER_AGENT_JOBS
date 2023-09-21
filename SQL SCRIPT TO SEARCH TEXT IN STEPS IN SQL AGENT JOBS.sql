---How to search Text in Steps of SQL Server Agent Jobs---

USE [msdb]
GO
SELECT Job.name          AS JobName,
       Job.enabled       AS ActiveStatus,
       JobStep.step_name AS JobStepName,
      JobStep.command AS JobCommand
FROM   sysjobs Job
       INNER JOIN sysjobsteps JobStep
               ON Job.job_id = JobStep.job_id 
WHERE  JobStep.command LIKE '%Select count(*) from dbo.dba%'  --You can change here what you are searching for
