
--- 팀 프로젝트에 있는 모든 작업에 대한 상태 확인 -> 도넛 차트로?  (groupby에  1,2를 지정하면 select에도 1,2 를 지정해야 한다
select project_id ,count(*) from task
group by task_status,project_id
having project_id = 1;

-- 팀 프로젝트의 진척률 
select  user_id ,task_status from task
group by user_id,task_status;