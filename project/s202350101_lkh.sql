        select u.user_name,p.project_s_name ,t.*
        from task t,  prj_step p , user_info u
        where  u.project_id = 1 and
            t.user_id = u.user_name and
            t.project_id  = p.project_id and
            t.project_step_seq  = p.project_step_seq;
            
            
SELECT t.user_id, u.user_name,  t.task_status, count(t.task_status) status_count
from TASK t , USER_INFO u
WHERE  t.project_id=1 and t.USER_ID = u.USER_ID
group by u.user_name,t.task_status,t.user_id
order by u.user_name, t.task_status;
  
        
        
   
        
        
select u.user_name , task_grabage.*,p.project_s_name from  (select * from task t where t.garbage = 1) task_grabage ,user_info u, prj_step p
where task_grabage.user_id = u.user_id and
task_grabage.project_id  = p.project_id and
task_grabage.project_step_seq  = p.project_step_seq and
task_grabage.project_id = 1;


select  u.user_name, count(t.task_status)
from TASK t , USER_INFO u
where t.project_id = 1 and  t.user_id = u.user_id
GROUP BY u.user_name, t.task_status;
    




SELECT u.user_name, SUM(task_status) 
from TASK t , USER_INFO u
where t.project_id = 1 and  t.user_id = u.user_id
GROUP BY t.user_id

select u.user_id;
    sum(case when task_status = 0 then 1 else 0 END) AS status_0_count,
    sum(case when task_status = 1 then 1 else 0 END) AS status_1_count,
    sum(case when task_status = 2 then 1 else 0 END) AS status_2_count
from TASK t , USER_INFO u
where t.project_id = 1 and  t.user_id = u.user_id
GROUP BY u.user_id;



SELECT u.user_name,
    SUM(CASE WHEN t.task_status = 0 THEN 1 ELSE 0 END) AS status_0_count,
    SUM(CASE WHEN t.task_status = 1 THEN 1 ELSE 0 END) AS status_1_count,
    SUM(CASE WHEN t.task_status = 2 THEN 1 ELSE 0 END) AS status_2_count
FROM TASK t  , USER_INFO u
WHERE t.project_id = 1 and t.user_id = u.user_id
GROUP BY u.user_name; 


select  *  from prj_step
where project_id = 1


select  *  from prj_step
where project_id = 1;

select user_name, user_id from user_info
where project_id = 1;

INSERT INTO task (task_id, project_id, user_id, project_step_seq, user_id,task_subject, task_content,
                        task_stat_time,task_end_itme,task_priority,task_status.garbage)
values (SELECT NVL(MAX(task_id), 0) + 1, 1, 3, 'tester4','맥스값생성','맥스값생성',,,2,1,1);
FROM task;

INSERT INTO task (task_id, project_id, project_step_seq, user_id, task_subject, task_content, task_stat_time, task_end_itme, task_priority, task_status, garbage)
SELECT NVL(MAX(task_id), 0) + 1, 1, 3, 'tester4', '맥스값생성', '맥스값생성', '23/11/0','23/11/3', 2, 1, 1)
FROM dual;
