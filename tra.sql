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
---------------------------------------------------------------------------------------


----------------------------------
-- SEQUENCE ***
-- ������ �ĺ���
-- �⺻ Ű ���� �ڵ����� �����ϱ� ���Ͽ� �Ϸù�ȣ ���� ��ü
-- ���� ���, �� �Խ��ǿ��� ���� ��ϵǴ� ������� ��ȣ�� �ϳ��� �Ҵ��Ͽ� �⺻Ű�� �����ϰ��� �Ҷ� 
-- �������� ���ϰ� �̿�
-- ���� ���̺��� ���� ����  -- > �Ϲ������δ� ������ ��� 
----------------------------------
-- 1) SEQUENCE ����
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : ������ ��ȣ�� ����ġ�� �⺻�� 1,  �Ϲ������� ?1 ���
--START WITH n : ������ ���۹�ȣ, �⺻���� 1
--MAXVALUE n : ���� ������ �������� �ִ밪
--MAXVALUE n : ������ ��ȣ�� ��ȯ������ ����ϴ� cycle�� ������ ���, MAXVALUE�� ������ �� ���� �����ϴ� ��������
--CYCLE | NOCYCLE : MAXVALUE �Ǵ� MINVALUE�� ������ �� �������� ��ȯ���� ������ ��ȣ�� ���� ���� ����
--CACHE n | NOCACHE : ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� ������ ����, �⺻���� 20

-- 2) SEQUENCE sample ����1

CREATE SEQUENCE sample_seq
INCREMENT BY 1
START with 10000;

-- 3) SEQUENCE sample ����2
SELECT sample_seq.nextVal FROM dual; --LAST NUMBER���� ����
SELECT sample_seq.CURRVAL FROM dual; --���簪�� �����´�.


CREATE Table dept_second
AS SELECT * FROM dept;


CREATE SEQUENCE dept_dno_seq
INCREMENT BY 1
START WITH 10;


-- 4) SEQUENCE dept_dno_seq�� �̿� dept_second �Է� --> �� ��� ����
INSERT INTO dept_second VALUES(dept_dno_seq.NEXTVAL,'Accouning','NEW WORK');

SELECT dept_dno_seq.CURRVAL FROM DUAL;


INSERT INTO dept_second VALUES(dept_dno_seq.NEXTVAL,'zzzzzzz','aaaa');

SELECT dept_dno_seq.CURRVAL FROM DUAL;


INSERT INTO dept_second VALUES(dept_dno_seq.NEXTVAL,'ȸ��','�̴�');
SELECT dept_dno_seq.CURRVAL FROM DUAL;


INSERT INTO dept_second VALUES(dept_dno_seq.NEXTVAL,'�λ���','���');


--max ��ȯ
insert into dept_second values((select max(deptno)+1 from dept_second)
    ,'�濵��'
    ,'�븲'
    );
--max�� nextval�� ������


/*
            max                   seq
����        sql           �׷��Լ� ��ü
������     Ʈ����� ����     ���� ����
        ������ ���а��ɼ�     
��������   pk���� �� ���� ���

*/

--max ��ȯ
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL,'�λ�3��','���3');
--����  -> max�� seq.nextval�� ����� ����



--5)  Data �������� ���� ��ȸ
SELECT sequence_name,min_value,max_value,increment_by from user_sequences;

-- ������ ����
DROP SEQUENCE sample_SEQ;

/*
------------------------------------------------------------------
     ������ ����
 1. ����ڿ� �����ͺ��̽� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺��� ����
 2. ���� ������ ������ ����Ŭ ������ ����
 3. ����Ŭ ������ ����Ÿ���̽��� ����, ����, ����� ����, ������ ���� ���� ������ �ݿ��ϱ� ����
    ������ ���� �� ����
 4. ����Ÿ���̽� �����ڳ� �Ϲ� ����ڴ� �б� ���� �信 ���� ������ ������ ������ ��ȸ�� ����
 5. �ǹ������� ���̺�, Į��, �� ��� ���� ������ ��ȸ�ϱ� ���� ���

------------------------------------------------------------------
------------------------------------------------------------------
-----     ������ ���� ���� ����
 1.�����ͺ��̽��� ������ ������ ��ü�� ���� ����
 2. ����Ŭ ����� �̸��� ��Ű�� ��ü �̸�
 3. ����ڿ��� �ο��� ���� ���Ѱ� ��
 4. ���Ἲ �������ǿ� ���� ����
 5. Į������ ������ �⺻��
 6. ��Ű�� ��ü�� �Ҵ�� ������ ũ��� ��� ���� ������ ũ�� ����
 7. ��ü ���� �� ���ſ� ���� ���� ����
 8.�����ͺ��̽� �̸�, ����, ������¥, ���۸��, �ν��Ͻ� �̸� ����
------------------------------------------------------------------
-------     ������ ���� ����
 1. USER_ : ��ü�� �����ڸ� ���� ������ ������ ���� ��
 user_tables�� ����ڰ� ������ ���̺� ���� ������ ��ȸ�� �� �ִ� ������ ���� ��.
*/


SELECT table_name,tablespace_name
FROM user_tables;

SELECT *
FROM user_catalog;

-- 2. ALL_    : �ڱ� ���� �Ǵ� ������ �ο� ���� ��ü�� ���� ������ ������ ���� ��
SELECT owner , table_name
FROM all_tables;
-- 3. DBA_   : �����ͺ��̽� �����ڸ� ���� ������ ������ ���� ��
SELECT owner, table_name
FROM dba_tables;