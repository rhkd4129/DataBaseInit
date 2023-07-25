
-------------------------------------
---- ������ ���ǹ�
-------------------------------------
-- 1. ������ ������ ���̽� ���� ������� 2���� ���̺� ����
-- 2. ������ ������ ���̽����� �����Ͱ��� �θ� ���踦 ǥ���� �� �ִ� Į���� �����Ͽ� 
--    �������� ���踦 ǥ��
-- 3. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ����(recursive relationship)
-- 4. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ��� ��� ����

-- ����
-- SELECT ��ɹ����� START WITH�� CONNECT BY ���� �̿�
-- ������ ���ǹ������� �������� ��� ���İ� ���� ��ġ ����
-- ��� ������  top-down �Ǵ� bottom-up
-- ����) CONNECT BY PRIOR �� START WITH���� ANSI SQL ǥ���� �ƴ�

-- ��1) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �ܴ�,�к�
-- �а������� top-down ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 10�� �μ�

select deptno,dname,college
from department
start with deptno =10  -- <-topdown�� ����
connect by prior deptno = college;  -- �ڽ��� ���� �θ� �ڿ�  
-- prior(������, ..���ٿ켱�ϴ�)




-- ��2)������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �а�,�к�
-- �ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 102�� �μ��̴�

select      deptno,dname,college
from        department
start with  deptno =102  
connect by prior college = deptno;  --bottom-up�� �θ� ���� 


--- ��3) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �μ� �̸��� �˻��Ͽ� �ܴ�, �к�, �а�����
---         top-down �������� ����Ͽ���. ��, ���� �����ʹ� ���������С��̰�,
---        �� LEVEL(����)���� �������� 2ĭ �̵��Ͽ� ���
select level,LPAD('---',(LEVEL-1)*2) || dname ������  --deptno, ename,college
from department
start with dname ='��������'
connect by prior deptno = college;


------------------------------------------------------
---      TableSpace  
---  ����  :�����ͺ��̽� ������Ʈ �� ���� �����͸� �����ϴ� ����
--           �̰��� �����ͺ��̽��� �������� �κ��̸�, ���׸�Ʈ�� �����Ǵ� ��� DBMS�� ���� 
--           �����(���׸�Ʈ)�� �Ҵ�
-------------------------------------------------------
-- 1. TableSpace ����
create TABLESpace user5 datafile 'C:\oraclexe\tables\user5.ora' SIZE 100M;
create TABLESpace user6 datafile 'C:\oraclexe\tables\user6.ora' SIZE 100M;
create TABLESpace user7 datafile 'C:\oraclexe\tables\user7.ora' SIZE 100M;
create TABLESpace user8 datafile 'C:\oraclexe\tables\user8.ora' SIZE 100M;

-- 2. ���̺��� ���̺� �����̽� ����
--    1) ���̺��� NDEX�� Table��  ���̺� �����̽� ��ȸ
SELECT INDEX_NAME, TABLE_NAME, tablespace_name
FROM USER_INDEXES;


select table_name , tablespace_name
from user_tables;
--   2) �� ���̺� ���� Tablespace �� ���� 
--      �ش� Index ���� ���� �� Table �� Tablespace ����

alter index PK_RELIGIONNO3 REBUILD TABLESPACE user5;
alter table religion MOVE TABLESPACE user5;


--table �����̽� size����
alter Database datafile 'C:\oraclexe\tables.user5.ora' Resize 200M;




------------------------------------------------------
--system���� ����  Admin���� 
--table space�Ҵ�
create TABLESpace user5 datafile 'C:\oraclexe\tables\user8.ora' SIZE 100M;
create TABLESpace user6 datafile 'C:\oraclexe\tables\user9.ora' SIZE 100M;


--    USER ����   scott2  / tiger
create user scott2 identified by tiger
default tablespace user9;
grant dba to scott2;
-- scott2��� DBA���մ°͵��� user9�� �Ҵ�ȴ�. 

---- ���Ѻο��ϰ�  scott2����  END
--------------------------------------------

--SCOTT2 ������ 
--CREATE TABLE DEPT3
--    (DEPTNO number(2) PRIMARY KEY,
--      DNAME VARCHAR2(14),
--      LOC VARCHAR2(13));
--    ���� �� SQLȮ���ϸ�  =>  TABLESPACE "USER9"  ENABLE   Ȯ�ΰ���
--------------------------------------------------------