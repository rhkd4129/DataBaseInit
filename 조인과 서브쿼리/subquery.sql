-----------------------------------------------------------------
----- SUB Query   ***
-- �ϳ��� SQL ��ɹ��� ����� �ٸ� SQL ��ɹ��� �����ϱ� ���� 
-- �� �� �̻��� SQL ��ɹ��� �ϳ��� SQL��ɹ����� �����Ͽ�
-- ó���ϴ� ���
-- ���� 
-- 1) ������ ��������
-- 2) ������ ��������


-------------------------------------------------------------------
--  1. ��ǥ : ���� ���̺��� ���������� ������ ������ ������ ��� ������ �̸� �˻�
    --    1-1 ���� ���̺��� ���������� ������ ���� �˻� SQL ��ɹ� ����     
SELECT name,position
from professor
where name='������';
    -- 1-2  ���� ���̺��� ���� Į������ 1���� ���� ��� ���� ������ ������ ���� ���� �˻� ��ɹ� ����
select name,position
from professor
where position='���Ӱ���';

SELECT name,position 
from professor
where position = (
                    SELECT position 
                    from professor 
                    where name = '������');
                    
                    
-- ���� 
-- 1) ������ ��������
--  ������������ �� �ϳ��� �ุ�� �˻��Ͽ� ���������� ��ȯ�ϴ� ���ǹ�
--  ���������� WHERE ������ ���������� ����� ���� ��쿡�� �ݵ�� ������ �� ������ �� 
--  �ϳ��� ����ؾ���

--  ��1) ����� ���̵� ��jun123���� �л��� ���� �г��� �л��� �й�, �̸�, �г��� ����Ͽ���
SELECT profno,name,grade
FROM student
where grade = ( 
                select grade 
                from student 
                where userid = 'jun123');
                
--  ��2)  101�� �а� �л����� ��� ������/���� �����԰� ���� �л��� �̸�, �г� , �а���ȣ, �����Ը�  ���
--  ���� : �а��� ���      
                
SELECT  name,grade,deptno,weight
FROM student
where weight  <( select avg(weight)
                 from student
                 where deptno =101)
order by deptno
; 


--  ��3) 20101�� �л��� �г��� ����, Ű�� 20101�� �л����� ū �л��� 
-- �̸�, �г�, Ű�� ����Ͽ���
--  ���� : �а��� ���

select name,grade,height
from student
where height > ( select height
                 from student
                where studno =20101
                ) 
                
and grade  = (
                select grade
                from student where 
                studno =20101)
order by deptno; 

-- ��4) 101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �а���ȣ, �����Ը� ����Ͽ���
--  ���� : �а��� ���

select name,deptno,weight
from student
where weight < (
                SELECT avg(weight)
                from student
                where deptno = 101)
order by deptno;



-- 2) ������ ��������
-- ������������ ��ȯ�Ǵ� ��� ���� �ϳ� �̻��� �� ����ϴ� ��������
-- ���������� WHERE ������ ���������� ����� ���� ��쿡�� ���� �� �� ������ �� ����Ͽ� ��
-- ���� �� �� ������ : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��, ��=���񱳸� ����
-- 2) ANY, SOME  : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��
-- 3) ALL             : ���� ������ �� ������ ���������� ����߿��� ��簪�� ��ġ�ϸ� ��, 
-- 4) EXISTS        : ���� ������ �� ������ ���������� ����߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- 1.  IN �����ڸ� �̿��� ���� �� ��������

SELECT name,grade,deptno
from student
where deptno=( --����� �������� ���� = �� �ȵȴ�.������ �������
               
                SELECT deptno
                from department
                where college=100
                );
                
SELECT name,grade,deptno
from student
where deptno IN ( --����� �������� ���� = �� �ȵȴ�.������ �������
                SELECT deptno
                from department
                where college=100  --> 101, 102�� ����
                );


--  2. ANY �����ڸ� �̿��� ���� �� ��������
-- ��)��� �л� �߿��� 4�г� �л� �߿��� Ű�� ���� ���� �л����� Ű�� ū �л��� �й�, �̸�, Ű�� ���
select studno, name,height
from student
where height > any(
                    -- 175,176,177 -->min����
                    select height
                    from student
                    where grade = '4'
                    );
--- 3. ALL �����ڸ� �̿��� ���� �� ��������
select studno, name,height
from student
where height >all(
                    -- 175,176,177 -->max
                    select height
                    from student
                    where grade = '4'
                    );

--- 4. EXISTS �����ڸ� �̿��� ���� �� ��������
SELECT profno,name,sal,comm,position  -- <--- �ٽ���
from professor
where exists(
            --�ϳ��� �����ϸ� (���̸�) ���ǰ� ������� 
            
            SELECT position
            from professor
            where comm is not null);
            
            
-- ��1)  ���������� �޴� ������ �� ���̶� ������ 
--       ��� ������ ���� ��ȣ, �̸�, �������� �׸��� �޿��� ���������� ��(NULLó��)�� ���

SELECT profno,name,comm,(sal+nvl(comm,0)) 
from professor 
where exists (
            select profno
            from professor
            where comm  iS not null);
            
-- ��2) �л� �߿��� ��goodstudent���̶�� ����� ���̵� ������ 1�� ����Ͽ���   

--select 1
--from student
--where exists (select userid
--            from student
--             where userid != 'goodstudent');

select 1 userid_exist
from dual
where not EXISTS(select userid
                from student 
                where userid='goodstudent');


select 1
from student
where userid not in ('goodstudent');

-- ���� �÷� ��������
-- ������������ ���� ���� Į�� ���� �˻��Ͽ� ���������� �������� ���ϴ� ��������
-- ���������� ������������ ���������� Į�� ����ŭ ����
-- ����
-- 1) PAIRWISE : Į���� ������ ��� ���ÿ� ���ϴ� ���
-- 2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���

-- 1) PAIRWISE ���� Į�� ��������
-- ��1)    PAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� 
--          �л��� �̸�, �г�, �����Ը� ����Ͽ���


select name,grade,weight
from student
where (grade,weight) in (select grade,min(weight)
                         from student
                         group by grade);

--  2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���
-- UNPAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ���


select name,grade,weight
from student
--1234
where grade in(select grade 
              from student 
            group by grade)
-- 52,42,70,72
and  weight in (SELECT MIN(weight)
                FROM stuent
                group by grade);
                
                
-- ��ȣ���� ��������     ***
-- ������������ ������������ �˻� ����� ��ȯ�ϴ� ��������

-- ��1)  �� �а� �л��� ��� Ű���� Ű�� ū �л��� �̸�, �а� ��ȣ, Ű�� ����Ͽ���
                    --< 1��from on join where group having select order
                    --< 3��
select deptno,name,grade ,height
from student s1   
where height > (select avg(height)
                from student s2
--                                 ������� 2 
                where s2.deptno = s1.deptno
                )
order by deptno;


-------------  HW  -----------------------


-- 1. Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷����϶�
select ename,hiredate from emp
where deptno = ( 
                select deptno
                from emp
                where ename = 'BLAKE');

-- 2. ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ��� ����. 
--    �� ����� �޿� �������� �����϶�

select ename,empno
from emp
where sal >= (
        select  avg(sal)
        from emp
        )
order by DESC;


-- 3. ���ʽ��� �޴� � ����� �μ� ��ȣ�� �޿��� ��ġ�ϴ� ����� �̸�, �μ� ��ȣ �׸��� �޿��� ���÷����϶�.