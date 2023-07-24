/*
���Ἲ ���� ����

NOT NULL
����Ű
�⺻Ű  ���ϼ� ,NOTNULL ,�ּҼ� -> 2���� ����Ű �����Ҽ��մ��� �ϳ��θ����ε� �������Ѱ� 
����Ű
CHECK


------------            ��������(Constraint)        ***          ------------
  ����  : �������� ��Ȯ���� �ϰ����� ����
 1. ���̺� ������ ���Ἲ ���������� ���� ����
 2. ���̺� ���� ����, ������ ��ųʸ��� ����ǹǷ� ���� ���α׷����� �Էµ� 
     ��� �����Ϳ� ���� �����ϰ� ����
 3. ���������� Ȱ��ȭ, ��Ȱ��ȭ �� �� �ִ� ���뼺



------------            ��������(Constraint)   ����      ***  ------------
1 .NOT NULL  : ���� NULL�� ������ �� ����
2. �⺻Ű(primary key) : UNIQUE +  NOT NULL + �ּҼ�  ���������� ������ ����
3. ����Ű(foreign key) :  ���̺� ���� �ܷ� Ű ���踦 ���� ***
4. CHECK : �ش� Į���� ���� ������ ������ ���� ������ ���� ����
-------------------------------------------------------------



 1.  ��������(Constraint) ���� ���� ����(subject) ���̺� �ν��Ͻ�
*/

CREATE TABLE subject
(

    subno    NUMBER(5)       CONSTRAINT subject_no_pk PRIMARY KEY,
    subname  VARCHAR2(20)    CONSTRAINT subject_name_nn NOT NULL,
    term     VARCHAR2(1)    CONSTRAINT subject_term_ck CHECK(term IN('1','2')),
    typeGubun VARCHAR2(1)    

);

COMMENT ON COLUMN subject.subno IS '������ȣ';
COMMENT ON COLUMN subject.subname IS '��������';
COMMENT ON COLUMN subject.term IS '�б�';

INSERT INTO subject(subno,subname,term,typeGubun)
                                VALUES (10000,'��ǻ�Ͱ���','1','1');


INSERT INTO subject(subno,subname,term,typegubun) 
                                values (10001,'DB����','2','1');
                                    
INSERT INTO subject(subno,subname,term,typegubun) 
                                 values (10002,'JSP����','1','1');
-- PK Constraint   --> Unique
-- PK Constraint   --> NN
-- subname NN
-- Check  Constraint   --> term


-- Table ����� ���Ѱ��� ���� ���� ����
-- Student Table �� idnum�� unique�� ����
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); --KEY�߰���

INSERT INTO student(studno,name,idnum) values(30101,'������','8012301036613');

INSERT INTO student(studno,name,idnum) values(30102,'������','8012301036613')
--����

ALTER TABLE student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL);



--C�� NOT NULL�̳� CHECK
SELECT *--CONSTRAINT_name , CONSTRAINT_TYPE
FROM user_CONSTRAINTs
WHERE table_name IN('SUBJECT','STUDENT');