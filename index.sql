/*  �ε����� SQL ��ɹ��� ó�� �ӵ��� ���(*) ��Ű�� ���� Į���� ���� �����ϴ� ��ü
--  �ε����� ����Ʈ�� �̿��Ͽ� ���̺� ����� �����͸� ���� �׼����ϱ� ���� �������� ���
--  [1]�ε����� ����
--   1)���� �ε��� : ������ ���� ������ Į���� ���� �����ϴ� �ε����� ��� �ε��� Ű��
--    ���̺��� �ϳ��� ��� ����
*/
CREATE UNIQUE INDEX idx_dept_name
ON      department(dname);

--   2)����� �ε���
-- ��) �л� ���̺��� birthdate Į���� ����� �ε����� �����Ͽ���

CREATE INDEX idx_stud_birthdate
on student(birthdate);
--���ɿ��� ������ ��ġ�� �������ǿ��� ������ ����?

insert into student(studno,name,idnum,birthdate)
                VALUES(30102,'������','8012301036614','84/09/16');
--   3)���� �ε���

--   4)���� �ε��� :  �� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���
--     ��) �л� ���̺��� deptno, grade Į���� ���� �ε����� ����
--          ���� �ε����� �̸��� idx_stud_dno_grade �� ����

CREATE INDEX idx_stud_dno_grade
    ON student(deptno,grade);
    
    
SELECT *
FROM student
WHERE deptno = 101
AND grade=2;

--- Optimizer
--- 1) RBO (��Ģ���) 2) ������ CBO

--RBO����
ALTER SESSION SET OPTIMIZER_MODE = RULE;

--SESSION �󿡼� ����ɶ�
ALTER SESSION SET OPTIMIZER_MODE = rule   --RBO ��Ģ��� 
ALTER SESSION SET OPTIMIZER_MODE = CHOOSE  --RBO�ų� CBO 

--CBO ��뿡 ���� 
ALTER SESSION SET OPTIMIZER_MODE = first_rows  --��� ������
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS  -- �ٵ���?

SELECT *
FROM student
WHERE deptno = 101
AND grade=2;


--   5)�Լ� ��� �ε���(FBI) function based index
--      ����Ŭ 8i �������� �����ϴ� ���ο� ������ �ε����� Į���� ���� �����̳� �Լ��� ��� ����� 
--      �ε����� ���� ����
--      UPPER(column_name) �Ǵ� LOWER(column_name) Ű����� ���ǵ�
--      �Լ� ��� �ε����� ����ϸ� ��ҹ��� ���� ���� �˻�
CREATE INDEX uppercase_idx ON emp(UPPER(ename));


--ALTER SESSION SET OPTIMIZER_MODE = CHOOSE  --RBO�ų� CBO
SELECT *
FROM emp
WHERE UPPER(ename) = 'KING';

-- �л� ���̺� ������ PK_STUDNO�ε����� �籸��
ALTER INDEX PK_STUDNO REBUILD;  

-- 1. index ��ȸ
select index_name, table_name,column_name
from user_ind_columns;


-- 2, index ���� emp(job)
CREATE INDEX idx_emp_job ON emp(job);


ALTER SESSION SET OPTIMIZER_MODE = RULE;
--3.��ȸ
SELECT * FROM emp WHERE job='MANAGER';  --OK

SELECT * FROM emp WHERE job <> 'MANAGER';  -- RBO�϶� �������� �ε�����? Ÿ�� �ʴ´�?
 
SELECT * FROM EMP WHERE job like 'MA%';  -- INDEX �ɷ����� ,ó������ ���� �������մ�. LIKE�� ź��?

SELECT * FROM EMP WHERE job like '%MA%';  --?? �̰Ǿ�ź��? 

SELECT * FROM emp WHERE UPPER(JOB)= 'MENAGER';  --�ȵȴ� ? �ָ� Ÿ�� �Ϸ��� FBI�� �ϸ�ȴ�? 

--��Ʈ?
SELECT /*+ first_rows*/ename FROM emp;
SELECT /*+ rule */ename FROM emp;


--��Ƽ������ ��� Ȯ��
SELECT NAME,VALUE,ISDEFAULT,ISMODIFIED, DESCRIPTION
FROM V$SYSTEM_PARAMETER
WHERE NAME LIKE '%optimizr_mode%'


----------------------------------------------------------------------------------------

