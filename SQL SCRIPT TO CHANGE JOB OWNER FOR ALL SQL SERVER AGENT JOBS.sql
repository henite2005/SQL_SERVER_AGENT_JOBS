---SQL SCRIPT TO CHANGE JOB OWNER FOR ALL SQL SERVER AGENT JOBS---

STEP-1: The Below Query will return you Job names and their owners.

SELECT J.NAME AS JobName,L.NAME AS OwnerName
FROM msdb..sysjobs J
LEFT JOIN master.sys.syslogins L ON J.owner_sid = L.sid


STEP-2: --Provide the New Owner for The Jobs you like to Change, I am using henite2005

DECLARE @NewOWNERName VARCHAR(100)
SET @NewOWNERName = 'henite2005'
DECLARE @OldJobOwner VARCHAR(100)
DECLARE @JobName VARCHAR(1000)
DECLARE Job_Cursor CURSOR
FOR
--Here, change your Query as per requirements, I am selecting all Job where owner<>henite2005
SELECT J.NAME AS JobName
    ,L.NAME AS OwnerName
FROM msdb..sysjobs J
LEFT JOIN master.sys.syslogins L ON J.owner_sid = L.sid
WHERE L.NAME <> @NewOWNERName
OPEN Job_Cursor
FETCH NEXT
FROM Job_Cursor
INTO @JobName
    ,@OldJobOwner
WHILE (@@FETCH_STATUS <> - 1)
BEGIN
    EXEC msdb..sp_update_job @job_name = @JobName
        ,@owner_login_name = @NewOWNERName

    PRINT 'Ownerd Change for ' + @JobName + 'Job from ' + @OldJobOwner + ' to '
 + @NewOWNERName

    FETCH NEXT
    FROM Job_Cursor
    INTO @JobName
        ,@OldJobOwner
END
CLOSE Job_Cursor
DEALLOCATE Job_Cursor
