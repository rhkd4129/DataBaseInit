
--- �� ������Ʈ�� �ִ� ��� �۾��� ���� ���� Ȯ�� -> ���� ��Ʈ��?  (groupby��  1,2�� �����ϸ� select���� 1,2 �� �����ؾ� �Ѵ�
select project_id ,count(*) from task
group by task_status,project_id
having project_id = 1;

-- �� ������Ʈ�� ��ô�� 
select  user_id ,task_status from task
group by user_id,task_status;