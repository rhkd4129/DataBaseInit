--  데이터 조작어 (DML:Data Manpulation Language)  **                  ----------
-- 1.정의 : 테이블에 새로운 데이터를 입력하거나 기존 데이터를 수정 또는 삭제하기 위한 명령어
-- 2. 종류 
--  1) INSERT : 새로운 데이터 입력 명령어
--  2) UPDATE : 기존 데이터 수정 명령어
--  3) DELETE : 기존 데이터 삭제 명령어
--  4) MERGE : 두개의 테이블을 하나의 테이블로 병합하는 명령어

-- 1) Insert
--NOT enough values
INSERT INTO DEPT VALUES(71,'인사');
INSERT INTO DEPT VALUES(71,'인사','이대');
INSERT INTO DEPT(deptno,Dname) VALUES (72,'회계팀');
INSERT INTO DEPT(deptno,Dname,LOC) VALUES (72,'자재팀','신대방');
-- unique constraint
INSERT INTO DEPT(deptno,LOC,Dname) VALUES (72,'충정로','회계팀');
INSERT INTO DEPT(deptno,LOC) VALUES (73,'홍대');
INSERT INTO DEPT(deptno,LOC) VALUES (77,'당산');


INSERT INTO professor( profno,name,position,hiredate,deptno)
            VALUES(9920,'최윤식','조교수'  ,TO_DATE('2006/01/01','YYYY/MM/DD'),102);
INSERT INTO professor( profno,name,position,hiredate,deptno)
            VALUES(9910,'백미선','전임강사'  ,SYSDATE,102);          
        
DROP TABLE JOB3;
CREATE TABLE JOB3
(
    jobno       number(2)   PRIMARY KEY,
    jobname     VARCHAR2(20)
);


INSERT INTO JOB3 VALUES(10,'공무원');
INSERT INTO JOB3 VALUES(11,'학생');
INSERT INTO JOB3 VALUES(12,'대기업');
INSERT INTO JOB3 VALUES(13,'중소기업');

CREATE TABLE Religion
(
    religion_no NUMBER(2)  CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
    religion_name   VARCHAR2(20)
);

INSERT INTO JOB3 VALUES(10,'기도교');
INSERT INTO JOB3 VALUES(20,'카톨릭');
INSERT INTO JOB3 VALUES(30,'붉');
INSERT INTO JOB3 VALUES(40,'무교');

COMMIT;


-------------------------------------------------
-----   다중 행 입력                        ------
-------------------------------------------------
-- 1. 생성된 TBL이용 신규 TBL 생성

CREATE Table dept_second
AS SELECT * FROM dept;

-- 2.가공 TBL생성
CREATE Table emp20
AS
    SELECT empno,ename,sal*12 annsal
    from emp
    where deptno = 20;
    
-- 3. TBL 구조만
CREATE TABLE dept30
AS 
    SELECT deptno,dname
    FROM DEPT
    where 1=0; -- 0과 1은 같을 수가 없다 애초에 부정형 '
    
ALTER TABLE dept30
ADD(birth Date);


INSERT INTO dept30 VALUES(10,'중앙학교',sysdate);
INSERT INTO dept30 VALUES(10,'중앙정보학교',sysdate);
UPDATE dept30  SET deptno=10 where dname='중앙학교';
--5COLUMN 변경 -->기존 data보다는 적게는 안됨
ALTER TABLE dept30
Modify dname varchar2(30);


-- 줄일수는 있지만 기존값의max보다는 
ALTER TABLE dept30
Modify dname varchar2(10);

ALTER TABLE dept30
Drop column dname;


--7 TBL 명 변경
RENAME dept30 to dept35;



--8 TBL 제거
DROP Table dept35;



--9, Truncate
TRUNCATE table dept_second;


--ddl은 실행과 동시에 commit됨 
--dml은 커밋해야됨 버퍼에 유지 되기 때문에 commit

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

-- INSERT ALL(unconditional INSERT ALL) 명령문
-- 서브쿼리의 결과 집합을 조건없이 여러 테이블에 동시에 입력
-- 서브쿼리의 컬럼 이름과 데이터가 입력되는 테이블의 칼럼이 반드시 동일해야 함
INSERT ALL
INTO height_info  VALUES(stduNo,name,height)
INTO weight_info  VALUES(stduNo,name,weight)
SELECT studno,name,height,weight
FROM student
WHERE grade >='2';

DELETE height_info;
DELETE weight_info;



-- 학생 테이블에서 2학년 이상의 학생을 검색하여 
-- height_info 테이블에는 키가 170보다 큰 학생의 학번, 이름, 키를 입력
-- weight_info 테이블에는 몸무게가 70보다 큰 학생의 학번, 이름, 몸무게를 
-- 각각 입력하여라

-- INSERT ALL 
-- [WHEN 조건절1 THEN
-- INTO [table1] VLAUES[(column1, column2,…)]
-- [WHEN 조건절2 THEN
-- INTO [table2] VLAUES[(column1, column2,…)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,…)]
-- subquery;

INSERT ALL
WHEN height> 170 Then
    INTO height_info VALUES(studNo, name,height)
WHEN weight> 70 Then
    INTO weight_info VALUES(studNo, name,height)
SELECT studno,name,height,weight
FROM student
WHERE grade >='2';


-- 데이터 수정 개요
-- UPDATE 명령문은 테이블에 저장된 데이터 수정을 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행을 수정
--- Update 
-- 문1) 교수 번호가 9903인 교수의 현재 직급을 ‘부교수’로 수정하여라

UPDATE PROFESSOR SET
position='부교수'
where profno = 9903;

Rollback;

--  문2) 서브쿼리를 이용하여 학번이 10201인 학생의 학년과 학과 번호를
--        10103 학번 학생의 학년과 학과 번호와 동일하게 수정하여라

UPDATE student set 
(grade,deptno )=(  --싱글 row로 나와서 ==로 됨
                    select grade,deptno 
                    from student 
                    where  deptno =  10103)
                    
where deptno = 10201;              


-- 데이터 삭제 개요
-- DELETE 명령문은 테이블에 저장된 데이터 삭제를 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행 삭제

-- 문1) 학생 테이블에서 학번이 20103인 학생의 데이터를 삭제

delete from student where studno = 20103;

--  문2) 학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라.
DELETE from student 
where deptno = (select deptno 
                from department
                where dname = '컴퓨터공학과');
RoLLBACK;


----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE 개요
--     구조가 같은 두개의 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작어
--     WHEN 절의 조건절에서 결과 테이블에 해당 행이 존재하면 UPDATE 명령문에 의해 새로운 값으로 수정,
--     그렇지 않으면 INSERT 명령문으로 새로운 행을 삽입
------------------------------------------------------------------------------------

-- 1] MERGE 예비작업 
--  상황 
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert


CREATE TABLE PROFESSOR_TEMP
as SELECT * from professor
    WHERE position = '교수';
    
    
UPDATE PROFESSOR_TEMP
SET        position = '명예교수'
WHERE position ='교수';

INSERT INTO professor_temp
values(9999,'유희라','arom21','전임강사',200,sysdate,10,101);


-- 2] professor MERGE 수행 
-- 목표 : professor_temp에 있는 직위 수정된 내용을 professor Table에 Update
--          유희라  씨가 신규 Insert 내용을 professor Table에 Insert
-- 1) 교수가 명예교수로 2행 Update
-- 2) 유희라 씨가 신규 Insert

merge into professor p
using professor_temp f 
on (p.profno = f.profno) --기준이 되는컬럼
when matched then --pk가 같으면 직위를 update
    update set p.position = f.position
when not matched then   --pk가 없으면 신규 insert
   insert values(f.profno,f.name,f.userid,f.position,f.sal,f.hiredate,f.comm,f.deptno);
   
   
   
---------------------------------------------------------------------------------
-- 트랜잭션 개요  ***
-- 관계형 데이터베이스에서 실행되는 여러 개의 SQL명령문을 하나의 논리적 작업 단위로 처리하는 개념
-- COMMIT : 트랜잭션의 정상적인 종료
--               트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 디스크에 영구적으로 저장하고 
--               트랜잭션을 종료
--               해당 트랜잭션에 할당된 CPU, 메모리 같은 자원이 해제
--               서로 다른 트랜잭션을 구분하는 기준
--               COMMIT 명령문 실행하기 전에 하나의 트랜잭션 변경한 결과를
--               다른 트랜잭션에서 접근할 수 없도록 방지하여 일관성 유지
 
-- ROLLBACK : 트랜잭션의 전체 취소
--                   트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 전부 취소하고 트랜잭션을 종료
--                   CPU,메모리 같은 해당 트랜잭션에 할당된 자원을 해제, 트랜잭션을 강제 종료
---------------------------------------------------------------------------------


