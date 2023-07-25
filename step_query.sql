
-------------------------------------
---- 계층적 질의문
-------------------------------------
-- 1. 관계형 데이터 베이스 모델은 평면적인 2차원 테이블 구조
-- 2. 관계형 데이터 베이스에서 데이터간의 부모 관계를 표현할 수 있는 칼럼을 지정하여 
--    계층적인 관계를 표현
-- 3. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)
-- 4. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력 기능 제공

-- 사용법
-- SELECT 명령문에서 START WITH와 CONNECT BY 절을 이용
-- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치 제어
-- 출력 형식은  top-down 또는 bottom-up
-- 참고) CONNECT BY PRIOR 및 START WITH절은 ANSI SQL 표준이 아님

-- 문1) 계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 단대,학부
-- 학과순으로 top-down 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 10번 부서

select deptno,dname,college
from department
start with deptno =10  -- <-topdown일 시작
connect by prior deptno = college;  -- 자식이 먼저 부모가 뒤에  
-- prior(사전의, ..보다우선하는)




-- 문2)계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 학과,학부
-- 단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 102번 부서이다

select      deptno,dname,college
from        department
start with  deptno =102  
connect by prior college = deptno;  --bottom-up은 부모가 먼저 


--- 문3) 계층적 질의문을 사용하여 부서 테이블에서 부서 이름을 검색하여 단대, 학부, 학과순의
---         top-down 형식으로 출력하여라. 단, 시작 데이터는 ‘공과대학’이고,
---        각 LEVEL(레벨)별로 우측으로 2칸 이동하여 출력
select level,LPAD('---',(LEVEL-1)*2) || dname 조직도  --deptno, ename,college
from department
start with dname ='공과대학'
connect by prior deptno = college;


------------------------------------------------------
---      TableSpace  
---  정의  :데이터베이스 오브젝트 내 실제 데이터를 저장하는 공간
--           이것은 데이터베이스의 물리적인 부분이며, 세그먼트로 관리되는 모든 DBMS에 대해 
--           저장소(세그먼트)를 할당
-------------------------------------------------------
-- 1. TableSpace 생성
create TABLESpace user5 datafile 'C:\oraclexe\tables\user5.ora' SIZE 100M;
create TABLESpace user6 datafile 'C:\oraclexe\tables\user6.ora' SIZE 100M;
create TABLESpace user7 datafile 'C:\oraclexe\tables\user7.ora' SIZE 100M;
create TABLESpace user8 datafile 'C:\oraclexe\tables\user8.ora' SIZE 100M;

-- 2. 테이블의 테이블 스페이스 변경
--    1) 테이블의 NDEX와 Table의  테이블 스페이스 조회
SELECT INDEX_NAME, TABLE_NAME, tablespace_name
FROM USER_INDEXES;


select table_name , tablespace_name
from user_tables;
--   2) 각 테이블 별로 Tablespace 를 변경 
--      해당 Index 먼저 변경 후 Table 의 Tablespace 변경

alter index PK_RELIGIONNO3 REBUILD TABLESPACE user5;
alter table religion MOVE TABLESPACE user5;


--table 스페이스 size변경
alter Database datafile 'C:\oraclexe\tables.user5.ora' Resize 200M;




------------------------------------------------------
--system에서 실행  Admin권한 
--table space할당
create TABLESpace user5 datafile 'C:\oraclexe\tables\user8.ora' SIZE 100M;
create TABLESpace user6 datafile 'C:\oraclexe\tables\user9.ora' SIZE 100M;


--    USER 생성   scott2  / tiger
create user scott2 identified by tiger
default tablespace user9;
grant dba to scott2;
-- scott2라는 DBA에잇는것들은 user9에 할당된다. 

---- 권한부여하고  scott2생성  END
--------------------------------------------

--SCOTT2 쿼리에 
--CREATE TABLE DEPT3
--    (DEPTNO number(2) PRIMARY KEY,
--      DNAME VARCHAR2(14),
--      LOC VARCHAR2(13));
--    생성 후 SQL확인하면  =>  TABLESPACE "USER9"  ENABLE   확인가능
--------------------------------------------------------