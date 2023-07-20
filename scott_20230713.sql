CREATE TABLE ex_type -- 테이블 생성 create table

( c char(10),        -- c라는 속성 생성 char타입으로 10bytes
  v VARCHAR2(10)     -- v라는 속성 생성 VARCHAR2타입으로 10bytes
);

Insert INTO ex_type
VALUES('sql','sql'); -- c와 v에 각각 sql이라는 데이터 삽임

-- char는 sql(3bytes)를 넣었을 시 뒤에 7bytes은 남아있다.
-- varchar는 3bytes룰 넣었을 때 나머지 7byte를 반납한다.


-- 기본 SELECT 명령어
SELECT *          --보여줄 컬럼
FROM ex_type      --전체 대상
WHERE c = 'sql';  -- 보여줄 주건

-- 컨트롤 f7 자동정령



-- 기본 SELECT 명령어
SELECT *          --보여줄 컬럼
FROM ex_type      --전체 대상
WHERE v = 'sql';  -- ;보여줄 주건


SELECT * 
FROM  ex_type
WHERE c=v  --둘이 다르다,. 공백떄문에.
;

-- 학생 테이블에서 ROWID와 학번출력
SELECT ROWNUM ,STUDNO,ROWID,NAME
FROM student
WHERE ROWNUM =1
;

--SELECT ROWNUM ,STUDNO,ROWID,NAME
--FROM student
--WHERE ROWNUM =2;  안나옴 ROWNUM은 1로 시작해야 작동하는 제안 사항이 있다.

CREATE TABLE ex_time
(id             NUMBER(2),
basicitime      TIMESTAMP,
standardtime    TIMESTAMP WITH TIME ZONE,
localtime       TIMESTAMP WITH LOCAL TIME ZONE);


INSERT INTO ex_time
VALUES(1,sysdate,sysdate,sysdate); --oracle에서 내부적으로 갖고 있는 시간 데이터 


SELECT * FROM ex_time;


SELECT MAX(SAL)
FROM EMP;

SELECT UPPER('abc')
FROM dual;

---- 학생 테이블에서 1학년 학생만 검색하여 학번 이름 학과 번호 출력 
SELECT studno ,name,grade FROM STUDENT
WHERE grade ='1';

-- 학생 테이블에서 몸무게가 70이하인 학생만 검색하여 학번 이름 학년 학과번호 몸무게 춝력
SELECT studno,name,grade,weight,DEPTNO FROM STUDENT
WHERE weight <=70;

-- 학생 테이블에서 1학년 이면서 몸무데게 70이상인 학생만 검색하여 이름 학년,몸무게 학과번호 춝력
SELECT studno ,name,grade,weight FROM student
WHERE  weight >70 or grade = '1';
-- 학생 테이블에서 학과번호가 ‘101’이 아닌 
-- 학생의 학번과 이름과 학과번호를 출력

SELECT studno ,name,grade,weight,DEPTNO FROM student
--WHERE  DEPTNO !='101';
WHERE not deptno = '101';


SELECT studno ,name,weight
FROM student
WHERE  50<= weight 
and weight <= 70;



SELECT studno ,name,weight 
FROM student
WHERE weight  BETWEEN 50 AND 70;

-- BETWEEN 학생테이블에서 81년에서 83년도에 태어난 학생의 이름과 생년월일을 출력


SELECT studno ,name,weight,BIRTHDATE 
FROM student
WHERE BIRTHDATE  BETWEEN '81/01/01' AND '83/12/31';


--IN 연산자를 사용하여 101번 학과와 102번 학과와 201번 학과 
-- 학생의 이름, 학년, 학과번호를 출력
SELECT studno ,name,weight,DEPTNO FROM student
WHERE DEPTNO IN(101,102,201);



-- 학생 테이블에서 성이 ‘김’씨인 학생의 이름, 학년, 학과 번호를 출력

SELECT studno ,name,weight,DEPTNO FROM student
WHERE name LIKE '김%'; --김으로 시작하는 모든 것 


--학생 테이블에서 마지막 글자가 '경'인사람

SELECT studno ,name,weight,DEPTNO FROM student
WHERE name LIKE '%경'; --경으로 끝나는 경우 

-- 학생 테이블에서 이름이 3글자, 성은 ‘김’씨고 
-- 마지막 글자가 ‘영’으로 끝나는 학생의 이름, 학년, 학과 번호를 출력
SELECT studno ,name,weight,DEPTNO FROM student
WHERE name LIKE '김%영';
--WHERE name LIKE '김_영';


-- NULL 이해
SELECT empno,sal,comm
FROM EMP;


-- 문제점: comm이 NULL일 시 sal_comm도 Null
--해결책 :: comm이 NULL일 시  NVL(**)
SELECT empno,sal,comm,empno+sal
FROM EMP;

SELECT empno,sal,comm,sal+NVL(comm,0)
FROM EMP;


SELECT * 
FROM EMP
--WHERE COMM == NULL; X
--WHERE COMM IS NULL
WHERE comm IS NOT NULL;
------------------------------------------------------------
-- 교수 테이블에서 보직수당이 없는 교수의 이름, 직급, 보직수당을 출력
SELECT name,position,comm FROM PROFESSOR
WHERE comm IS NOT NULL;

-- 교수 테이블에서 교수의 이름, 직급,급여, 급여+보직수당 --> NULL해결
SELECT name,position,comm,sal+NVL(comm,0) sal_comm
FROM PROFESSOR;

-- 102번 학과의 학생 중에서 1학년 또는 4학년 학생의 이름, 학년, 학과 번호를 출력
SELECT studno ,name,DEPTNO FROM student
WHERE (grade = 1 or grade =4 ) and( DEPTNO =102);

SELECT studno ,name,DEPTNO FROM student
WHERE (grade IN(1,4)) and (DEPTNO =102);


-- 1학년 이면서 몸무게가 70kg 이상인 학생의 집합 -> TABLE stud_heavy
-- 스키마는 복제되지만 제약조건은 복제되지 않는다.



CREATE TABLE stud_heavy3
AS
    SELECT * FROM student
    WHERE grade = 1  and weight >=70;

-- 1학년 이면서 101번 학과에 소속된 학생

SELECT * FROM student
WHERE grade = 1  and DEPTNO=101;


CREATE TABLE stud_101
AS
    SELECT * FROM student
    WHERE grade = 1  and DEPTNO=101;
---------------------------------------------------------------------------

-- 집합연산자     
--  Union column이 다를 때 오류 발생
SELECT studno , name, userid FROM stud_heavy
UNION
SELECT studno, name from stud_101;



SELECT studno , name
FROM stud_heavy 
UNION --중복제거
SELECT studno, name
from stud_101;


SELECT studno , name
FROM stud_heavy
UNION ALL  --중복허용
SELECT studno, name
from stud_101;


SELECT studno , name
FROM stud_heavy
INTERSECT  --중복된것만
SELECT studno, name
from stud_101;



SELECT studno , name
FROM stud_heavy
MINUS
SELECT studno, name
from stud_101;
 ------------------ - DML --------------------------------
--                    1.CRUD  SELECT INSERT DELETE UPDATA
INSERT INTO EMP VALUES
(1100,'강준우','CLEARK',7902,to_date('13-07-2023','dd-mm-yyyy'),3000,200,20);
INSERT INTO EMP(empno,ename,sal,comm,deptno) VALUES
(1200,'test',30500,100,10);

UPDATE EMP SET JOB ='PRESIDENT'
    ,MGR = 7839
WHERE empno = 1000;



DELETE EMP
WHERE EMPNO = 1200;

-- 트랜잭션 업무를 처리하는 단위
-- 원자성, 고립성 지속성 일관성

commit;
rollback;