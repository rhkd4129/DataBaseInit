select u.user_name,p.project_s_name ,t.* from 
task t,  prj_step p , user_info u
where t.user_id = u.user_name and
t.project_id  = p.project_id and
t.project_step_seq  = p.project_step_seq and
t.task_id = 1 and t.project_id =1;




insert into task values(10,1,1,'tester4','삭제된작업','살려줘','23/11/2','23/11/5',2,1,1);



select u.user_name , task_grabage.*,p.project_s_name from  (select * from task t where t.garbage = 1) task_grabage ,user_info u, prj_step p
where task_grabage.user_id = u.user_id and
task_grabage.project_id  = p.project_id and
task_grabage.project_step_seq  = p.project_step_seq and
task_grabage.project_id = 1;



-- timeline
select t.*,u.user_name   from task t, user_info u
where t.user_id = u.user_id





