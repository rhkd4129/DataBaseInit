/*  인덱스는 SQL 명령문의 처리 속도를 향상(*) 시키기 위해 칼럼에 대해 생성하는 객체
--  인덱스는 포인트를 이용하여 테이블에 저장된 데이터를 랜덤 액세스하기 위한 목적으로 사용
--  [1]인덱스의 종류
--   1)고유 인덱스 : 유일한 값을 가지는 칼럼에 대해 생성하는 인덱스로 모든 인덱스 키는
--    테이블의 하나의 행과 연결
*/
CREATE UNIQUE INDEX idx_dept_name
ON      department(dname);

--   2)비고유 인덱스
-- 문) 학생 테이블의 birthdate 칼럼을 비고유 인덱스로 생성하여라

CREATE INDEX idx_stud_birthdate
on student(birthdate);
--성능에만 영향을 미치고 제약조건에는 영향이 없다?

insert into student(studno,name,idnum,birthdate)
                VALUES(30102,'김유신','8012301036614','84/09/16');
--   3)단일 인덱스

--   4)결합 인덱스 :  두 개 이상의 칼럼을 결합하여 생성하는 인덱스
--     문) 학생 테이블의 deptno, grade 칼럼을 결합 인덱스로 생성
--          결합 인덱스의 이름은 idx_stud_dno_grade 로 정의

CREATE INDEX idx_stud_dno_grade
    ON student(deptno,grade);
    
    
SELECT *
FROM student
WHERE deptno = 101
AND grade=2;

--- Optimizer
--- 1) RBO (규칙대로) 2) 요즘은 CBO

--RBO변경
ALTER SESSION SET OPTIMIZER_MODE = RULE;

--SESSION 상에셔 변경될때
ALTER SESSION SET OPTIMIZER_MODE = rule   --RBO 규칙대로 
ALTER SESSION SET OPTIMIZER_MODE = CHOOSE  --RBO거나 CBO 

--CBO 비용에 따라 
ALTER SESSION SET OPTIMIZER_MODE = first_rows  --몇개마 ㄴ도착
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS  -- 다도착?

SELECT *
FROM student
WHERE deptno = 101
AND grade=2;


--   5)함수 기반 인덱스(FBI) function based index
--      오라클 8i 버전부터 지원하는 새로운 형태의 인덱스로 칼럼에 대한 연산이나 함수의 계산 결과를 
--      인덱스로 생성 가능
--      UPPER(column_name) 또는 LOWER(column_name) 키워드로 정의된
--      함수 기반 인덱스를 사용하면 대소문자 구분 없이 검색
CREATE INDEX uppercase_idx ON emp(UPPER(ename));


--ALTER SESSION SET OPTIMIZER_MODE = CHOOSE  --RBO거나 CBO
SELECT *
FROM emp
WHERE UPPER(ename) = 'KING';

-- 학생 테이블에 생성된 PK_STUDNO인덱스를 재구성
ALTER INDEX PK_STUDNO REBUILD;  

-- 1. index 조회
select index_name, table_name,column_name
from user_ind_columns;


-- 2, index 생성 emp(job)
CREATE INDEX idx_emp_job ON emp(job);


ALTER SESSION SET OPTIMIZER_MODE = RULE;
--3.조회
SELECT * FROM emp WHERE job='MANAGER';  --OK

SELECT * FROM emp WHERE job <> 'MANAGER';  -- RBO일때 부정형은 인덱스를? 타지 않는다?
 
SELECT * FROM EMP WHERE job like 'MA%';  -- INDEX 걸렷을시 ,처음부터 값이 정해져잇다. LIKE는 탄다?

SELECT * FROM EMP WHERE job like '%MA%';  --?? 이건안탄다? 

SELECT * FROM emp WHERE UPPER(JOB)= 'MENAGER';  --안된다 ? 애를 타게 하려면 FBI를 하면된다? 

--힌트?
SELECT /*+ first_rows*/ename FROM emp;
SELECT /*+ rule */ename FROM emp;


--옵티마이저 모드 확인
SELECT NAME,VALUE,ISDEFAULT,ISMODIFIED, DESCRIPTION
FROM V$SYSTEM_PARAMETER
WHERE NAME LIKE '%optimizr_mode%'


----------------------------------------------------------------------------------------

