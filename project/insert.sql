
INSERT INTO task (task_id, project_id, project_step_seq,  user_id , task_subject, task_content,
                task_stat_time,task_end_itme,task_priority,task_status, garbage)
values (SELECT NVL(MAX(task_id), 0) + 1, 1, 3,'tester4','累诀积己','累诀积己ししし','23/11/0','23/11/3',2,1,0);
FROM task;

INSERT INTO task (task_id, project_id, project_step_seq, user_id, task_subject, task_content, task_stat_time, task_end_itme, task_priority, task_status, garbage)
VALUES (SELECT NVL(MAX(task_id), 0) +1 from task), 1, 3, 'tester4', '累诀积己', '累诀积己ししし', TO_DATE('23/11/2023', 'DD/MM/YYYY'), TO_DATE('23/11/2023', 'DD/MM/YYYY'), 2, 1, 0);





