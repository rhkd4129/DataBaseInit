
INSERT INTO task (task_id, project_id, project_step_seq,  user_id , task_subject, task_content,
                task_stat_time,task_end_itme,task_priority,task_status, garbage)
values (SELECT NVL(MAX(task_id), 0) + 1, 1, 3,'tester4','작업생성','작업생성ㅇㅇㅇ','23/11/0','23/11/3',2,1,0);
FROM task;

INSERT INTO task (task_id, project_id, project_step_seq, user_id, task_subject, task_content, task_stat_time, task_end_itme, task_priority, task_status, garbage)
VALUES (SELECT NVL(MAX(task_id), 0) +1 from task), 1, 3, 'tester4', '작업생성', '작업생성ㅇㅇㅇ', TO_DATE('23/11/2023', 'DD/MM/YYYY'), TO_DATE('23/11/2023', 'DD/MM/YYYY'), 2, 1, 0);


-- task update
UPDATE 
    task
SET 
    PROJECT_STEP_SEQ =4 ,
    task_subject = '수정한거',
    task_content = '수정한거',
    task_stat_time = '23/11/5',
    task_end_itme = '23/11/1',
    task_priority = 1,
    task_status = 1
WHERE 
    task_id =29 and  project_id =1;

-- task_worker_update
UPDATE
    task_sub
SET
    worker_id = ''
WHERE 
    task_id  =1 and project_id = 2


-- task_attach_update
UPDATE
    task_attach
set
    attach_name
    attach_path


