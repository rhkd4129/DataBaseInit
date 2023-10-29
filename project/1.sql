

 -- TASK_STATUS ,
select  count(*) as task_status_count from task
where project_id = 1
group by task_status
order by TASK_STATUS;


SELECT u.user_id, u.user_name, t.task_status, 
       COALESCE(COUNT(t.task_status), 0) as status_count
FROM USER_INFO u
LEFT JOIN TASK t ON t.user_id = u.user_id and t.project_id = 1
GROUP BY u.user_name, t.task_status, u.user_id
ORDER BY u.user_name, t.task_status;

-- 

select t.user_id, u.user_name,t.task_status, count(t.task_status) status_count 
from TASK t , USER_INFO u
WHERE  t.project_id=1 and t.USER_ID = u.USER_ID
group by u.user_name,t.task_status,t.user_id
order by u.user_name, t.task_status;

-- board
select  project_id , task_status ,task_subject from task order by TASK_STATUS;


--table
select  rownum rn , a.*
    from ( select u.user_name ,t.*  from task t , user_info u
where t.user_id = u.user_id)



SELECT * 
from (SELECT rownum rn, a.*
        FROM (select u.user_name ,t.*
            FROM task t, user_info u
            where t.user_id = u.user_id)a
        )
    where rn between 1 and 5;
        
			  		

SELECT rownum rn, a.*
        FROM (select u.user_name ,t.*
            FROM task t, user_info u
            where t.user_id = u.user_id)a
    




