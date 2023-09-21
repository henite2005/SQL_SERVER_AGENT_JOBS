STEP-1: Below Query will return you Job names and their owners.

SELECT J.NAME AS JobName
    ,L.NAME AS OwnerName
FROM msdb..sysjobs J
LEFT JOIN master.sys.syslogins L 
ON J.owner_sid = L.sid



STEP-2: Use below query to return all job names with owners and even for those logins does not exists.

SELECT NAME AS JobName
    ,SUSER_SNAME(owner_sid) AS JobOwner
FROM msdb..sysjobs
ORDER BY NAME

