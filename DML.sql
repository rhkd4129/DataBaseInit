--  ������ ���۾� (DML:Data Manpulation Language)  **                  ----------
-- 1.���� : ���̺� ���ο� �����͸� �Է��ϰų� ���� �����͸� ���� �Ǵ� �����ϱ� ���� ��ɾ�
-- 2. ���� 
--  1) INSERT : ���ο� ������ �Է� ��ɾ�
--  2) UPDATE : ���� ������ ���� ��ɾ�
--  3) DELETE : ���� ������ ���� ��ɾ�
--  4) MERGE : �ΰ��� ���̺��� �ϳ��� ���̺�� �����ϴ� ��ɾ�

-- 1) Insert
--NOT enough values
INSERT INTO DEPT VALUES(71,'�λ�');
INSERT INTO DEPT VALUES(71,'�λ�','�̴�');
INSERT INTO DEPT(deptno,Dname) VALUES (72,'ȸ����');
INSERT INTO DEPT(deptno,Dname,LOC) VALUES (72,'������','�Ŵ��');
-- unique constraint
INSERT INTO DEPT(deptno,LOC,Dname) VALUES (72,'������','ȸ����');
INSERT INTO DEPT(deptno,LOC) VALUES (73,'ȫ��');
INSERT INTO DEPT(deptno,LOC) VALUES (77,'���');


INSERT INTO professor( profno,name,position,hiredate,deptno)
            VALUES(9920,'������','������'  ,TO_DATE('2006/01/01','YYYY/MM/DD'),102);
INSERT INTO professor( profno,name,position,hiredate,deptno)
            VALUES(9910,'��̼�','���Ӱ���'  ,SYSDATE,102);          
        
DROP TABLE JOB3;
CREATE TABLE JOB3
(
    jobno       number(2)   PRIMARY KEY,
    jobname     VARCHAR2(20)
);


INSERT INTO JOB3 VALUES(10,'������');
INSERT INTO JOB3 VALUES(11,'�л�');
INSERT INTO JOB3 VALUES(12,'����');
INSERT INTO JOB3 VALUES(13,'�߼ұ��');

CREATE TABLE Religion
(
    religion_no NUMBER(2)  CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
    religion_name   VARCHAR2(20)
);

INSERT INTO JOB3 VALUES(10,'�⵵��');
INSERT INTO JOB3 VALUES(20,'ī�縯');
INSERT INTO JOB3 VALUES(30,'��');
INSERT INTO JOB3 VALUES(40,'����');

COMMIT;


-------------------------------------------------
-----   ���� �� �Է�                        ------
-------------------------------------------------
-- 1. ������ TBL�̿� �ű� TBL ����

CREATE Table dept_second
AS SELECT * FROM dept;

-- 2.���� TBL����
CREATE Table emp20
AS
    SELECT empno,ename,sal*12 annsal
    from emp
    where deptno = 20;
    
-- 3. TBL ������
CREATE TABLE dept30
AS 
    SELECT deptno,dname
    FROM DEPT
    where 1=0; -- 0�� 1�� ���� ���� ���� ���ʿ� ������ '
    
ALTER TABLE dept30
ADD(birth Date);


INSERT INTO dept30 VALUES(10,'�߾��б�',sysdate);
INSERT INTO dept30 VALUES(10,'�߾������б�',sysdate);
UPDATE dept30  SET deptno=10 where dname='�߾��б�';
--5COLUMN ���� -->���� data���ٴ� ���Դ� �ȵ�
ALTER TABLE dept30
Modify dname varchar2(30);


-- ���ϼ��� ������ ��������max���ٴ� 
ALTER TABLE dept30
Modify dname varchar2(10);

ALTER TABLE dept30
Drop column dname;


--7 TBL �� ����
RENAME dept30 to dept35;



--8 TBL ����
DROP Table dept35;



--9, Truncate
TRUNCATE table dept_second;


--ddl�� ����� ���ÿ� commit�� 
--dml�� Ŀ���ؾߵ� ���ۿ� ���� �Ǳ� ������ commit

CREATE TABLE height_info
(
    stduNo  number(5),
    NAME    VARCHAR2(20),
    height  number(5,2)

);
CREATE TABLE weight_info
(
    stduNo  number(5),
    NAME    VARCHAR2(20),
    weight  number(5,2)

);

-- INSERT ALL(unconditional INSERT ALL) ��ɹ�
-- ���������� ��� ������ ���Ǿ��� ���� ���̺� ���ÿ� �Է�
-- ���������� �÷� �̸��� �����Ͱ� �ԷµǴ� ���̺��� Į���� �ݵ�� �����ؾ� ��
INSERT ALL
INTO height_info  VALUES(stduNo,name,height)
INTO weight_info  VALUES(stduNo,name,weight)
SELECT studno,name,height,weight
FROM student
WHERE grade >='2';

DELETE height_info;
DELETE weight_info;



-- �л� ���̺��� 2�г� �̻��� �л��� �˻��Ͽ� 
-- height_info ���̺��� Ű�� 170���� ū �л��� �й�, �̸�, Ű�� �Է�
-- weight_info ���̺��� �����԰� 70���� ū �л��� �й�, �̸�, �����Ը� 
-- ���� �Է��Ͽ���


INSERT ALL
WHEN height> 170 Then
    INTO height_info VALUES(studNo, name,height)
WHEN weight> 70 Then
    INTO weight_info VALUES(studNo, name,height)
SELECT studno,name,height,weight
FROM student
WHERE grade >='2';




-- ������ ���� ����
-- UPDATE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� ���� ����
--- Update 
-- ��1) ���� ��ȣ�� 9903�� ������ ���� ������ ���α������� �����Ͽ���

UPDATE PROFESSOR SET
position='�α���'
where profno = 9903;

Rollback;

--  ��2) ���������� �̿��Ͽ� �й��� 10201�� �л��� �г�� �а� ��ȣ��
--        10103 �й� �л��� �г�� �а� ��ȣ�� �����ϰ� �����Ͽ���
UPDATE student set 
(grade,deptno )=(  --�̱� row�� ���ͼ� ==�� ��
                    select grade,deptno 
                    from student 
                    where  deptno =  10103)
                    
where deptno = 10201;              
-- ������ ���� ����
-- DELETE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� �� ����

-- ��1) �л� ���̺��� �й��� 20103�� �л��� �����͸� ����

delete from student where studno = 20103;

--  ��2) �л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ���.
DELETE from student 
where deptno = (select deptno 
                from department
                where dname = '��ǻ�Ͱ��а�');
RoLLBACK;


----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE ����
--     ������ ���� �ΰ��� ���̺��� ���Ͽ� �ϳ��� ���̺�� ��ġ�� ���� ������ ���۾�
--     WHEN ���� ���������� ��� ���̺� �ش� ���� �����ϸ� UPDATE ��ɹ��� ���� ���ο� ������ ����,
--     �׷��� ������ INSERT ��ɹ����� ���ο� ���� ����
------------------------------------------------------------------------------------

-- 1] MERGE �����۾� 
--  ��Ȳ 
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert


CREATE TABLE PROFESSOR_TEMP
as SELECT * from professor
    WHERE position = '����';
    
    
UPDATE PROFESSOR_TEMP
SET        position = '������'
WHERE position ='����';

INSERT INTO professor_temp
values(9999,'�����','arom21','���Ӱ���',200,sysdate,10,101);


-- 2] professor MERGE ���� 
-- ��ǥ : professor_temp�� �ִ� ���� ������ ������ professor Table�� Update
--          �����  ���� �ű� Insert ������ professor Table�� Insert
-- 1) ������ �������� 2�� Update
-- 2) ����� ���� �ű� Insert

merge into professor p
using professor_temp f 
on (p.profno = f.profno) --������ �Ǵ��÷�
when matched then --pk�� ������ ������ update
    update set p.position = f.position
when not matched then   --pk�� ������ �ű� insert
   insert values(f.profno,f.name,f.userid,f.position,f.sal,f.hiredate,f.comm,f.deptno);
   
   
   
---------------------------------------------------------------------------------
-- Ʈ����� ����  ***
-- ������ �����ͺ��̽����� ����Ǵ� ���� ���� SQL��ɹ��� �ϳ��� ���� �۾� ������ ó���ϴ� ����
-- COMMIT : Ʈ������� �������� ����
--               Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ��ũ�� ���������� �����ϰ� 
--               Ʈ������� ����
--               �ش� Ʈ����ǿ� �Ҵ�� CPU, �޸� ���� �ڿ��� ����
--               ���� �ٸ� Ʈ������� �����ϴ� ����
--               COMMIT ��ɹ� �����ϱ� ���� �ϳ��� Ʈ����� ������ �����
--               �ٸ� Ʈ����ǿ��� ������ �� ������ �����Ͽ� �ϰ��� ����
 
-- ROLLBACK : Ʈ������� ��ü ���
--                   Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ���� ����ϰ� Ʈ������� ����
--                   CPU,�޸� ���� �ش� Ʈ����ǿ� �Ҵ�� �ڿ��� ����, Ʈ������� ���� ����
---------------------------------------------------------------------------------