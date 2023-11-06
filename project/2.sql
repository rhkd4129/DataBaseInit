

SELECT *
    FROM TASK_SUB  t, user_info u
        WHERE t.task_id = 17 and
              t.project_id = 1 and
              t.worker_id = u.user_id


select  u.user_name, count(t.task_status)
from TASK t , USER_INFO u
where t.project_id = 1 and  t.user_id = u.user_id
GROUP BY u.user_name, t.task_status;
    


--proejct
select project_startdate,project_enddate  
from  prj_info
where project_id = 1;