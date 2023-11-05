 -- doughnut_chart 
select  task_status, count(*) as task_status_count from task
where project_id = 1
group by task_status
order by TASK_STATUS;


  Workload_chart
--SELECT u.user_name,
    SUM(CASE WHEN t.task_status = 0 THEN 1 ELSE 0 END) AS status_0_count,
    SUM(CASE WHEN t.task_status = 1 THEN 1 ELSE 0 END) AS status_1_count,
    SUM(CASE WHEN t.task_status = 2 THEN 1 ELSE 0 END) AS status_2_count
FROM TASK t  , USER_INFO u
WHERE t.project_id = 1 and t.user_id = u.user_id
GROUP BY u.user_name; 


--task all count
select count(task_id)  from task 
where project_id = 1;


-- task List
SELECT * 
FROM (SELECT rownum rn, a.*  
    From (SELECT t.*, p.project_s_name, u.user_name
    FROM task t
        INNER JOIN prj_step p ON t.project_id = p.project_id AND t.project_step_seq = p.project_step_seq
        INNER JOIN user_info u ON t.user_id = u.user_id
    WHERE t.project_id = 1 AND t.garbage = 0) a
    )
    where rn between 1 and 5;
 
    


--task Detail 
select u.user_name,p.project_s_name ,t.*
    from task t,  prj_step p , user_info u
    where t.user_id = u.user_name and
    t.project_id  = p.project_id and
    t.project_step_seq  = p.project_step_seq and
    t.task_id = 1 and t.project_id =1;

--
-- timeLine -- 
select t.*,u.user_name   from task t, user_info u
where t.user_id = u.user_id


-- garbage   
 SELECT *
        FROM (
                 SELECT rownum rn, a.*
                 FROM (
                          SELECT u.user_name, t.*, p.project_s_name
                          FROM task t
                                   INNER JOIN prj_step p ON t.project_id = p.project_id AND t.project_step_seq = p.project_step_seq
                                   INNER JOIN user_info u ON t.user_id = u.user_id
                          WHERE t.garbage = 1 AND t.project_id = 1
                      ) a
             ) WHERE rn BETWEEN 1 AND 5 
--Fom 데이터를 갖져올 테이블 또는 뷰를 지정하고
--where에 맞는 조건을 필터링해서 가져오고  그다음 조인을하고 그다음 그룹일지정한다.

