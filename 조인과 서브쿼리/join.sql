----------------------------------------------------------------------
----                    9-1.     JOIN       ***              ---------
----------------------------------------------------------------------
-- 1) 조인의 개념
--  하나의 SQL 명령문에 의해 여러 테이블에 저장된 데이터를 한번에 조회할수 있는 기능

-- ex1-1) 학번이 10101인 학생의 이름과 소속 학과 이름을 출력하여라
SELECT studno,name,deptno
FROM student
WHERE studno = 10101;

-- ex1-2)학과를 가지고 학과이름
select dname
from department
where deptno = 101;

SELECT studno, name,
       student.deptno, department.dname,department.deptno
FROM student,department
where student.deptno = department.deptno;

SELECT studno,name,deptno,dname
FROM student s, department d
WHERE s.deptno = d.detpno;
--어느 테이블의 deptno인지 모름

SELECT s.studno,s.name, d.deptno,d.dname   --> alias로 해결
FROM student s, department d
WHERE s.deptno = d.deptno;
--어느 테이블의 deptno인지 모름


-- 전인하 학생의 학번, 이름, 학과 이름 그리고 학과 위치를 출력

select s.studno,s.name,d.deptno,d.loc
FROM student s, department d
where s.deptno = d.deptno and s.name = '전인하';


-- 몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
select s.studno,s.name,s.weight,d.dname,d.loc
FROM student s, department d
where s.deptno = d.deptno and s.weight>=80;

-- 카티션 곱  : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합
-- 개발자 실수
-- 개발 초기에 많은 data 생성

--create table name
--as
    SELECT s.studno, s.name,   s.weight,  d.dname,  d.loc,  d.deptno
    FROM student s, department d;

-- 둘다 같음

SELECT  s.studno, s.name,   s.weight,  d.dname,  d.loc,  d.deptno
FROM student s CROSS JOIN department d;


-- ***
-- 조인 대상 테이블에서 공통 칼럼을 ‘=‘(equal) 비교를 통해 같은 값을 가지는 행을 연결하여 결과를 생성하는 조인 방법
--  SQL 명령문에서 가장 많이 사용하는 조인 방법
-- 자연조인을 이용한 EQUI JOIN
-- 오라클 9i 버전부터 EQUI JOIN을 자연조인이라 명명
-- WHERE 절을 사용하지 않고  NATURAL JOIN 키워드 사용
-- 오라클에서 자동적으로 테이블의 모든 칼럼을 대상으로 공통 칼럼을 조사 후, 내부적으로 조인문 생성

SELECT s.studno,s.name, d.deptno,d.dname ,d.loc,d.deptno  
FROM student s, department d   --= =EQUI JOIN
WHERE s.deptno = d.deptno;
 --====--


 SELECT s.studno,s.name, d.deptno,d.dname ,d.loc,d.deptno
FROM student s
    NATURAL JOIN department d;
--                    ->> 공통된 컴럼은 별칭을 쓰면안됨
    
 
-- NATURAL조인은 조인 에트리뷰트에 테이블 별명을 사용하면 오류발샤ㅐㅇ
SELECT studno,name, deptno,dname ,loc,deptno
FROM student s
    NATURAL JOIN department d;
    
    
    
-- ANSI EQUI JOIN
 SELECT s.studno,s.name, d.deptno,d.dname ,d.loc,d.deptno 
FROM student s INNER JOIN department d
ON   s.deptno = d.deptno;
    
    
-- NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라

SELECT p.profno, p.name, deptno, d.dname
FROM professor p NATURAL JOIN department d;

-- NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라
SELECT s.name,s.grade, deptno,d.dname
FROM student s  NATURAL JOIN department d
where s.grade=4;

-- JOIN ~ USING 절을 이용한 EQUI JOIN
-- USING절에 조인 대상 칼럼을 지정
-- 칼럼 이름은 조인 대상 테이블에서 동일한 이름으로 정의되어 있어야함
-- 문1) JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
SELECT s.studno,s.name,deptno,dname
FROM student s JOIN department
                USING(deptno);
                
                
-- EQUI JOIN의 4가지 방법을 이용하여 성이 ‘김’씨인 학생들의 이름, 학과번호,학과이름을 출력
-- 1) WHERE 절을 사용한 방법
SELECT s.name,s.deptno, d.dname
FROM  student s, department d
where s.deptno = d.deptno and s.name like '김%%';


SELECT s.name,deptno, dname
FROM  student s NATURAL JOIN  department d
where s.name like '김%%';

--ansi join
SELECT s.name,s.deptno, d.dname
FROM  student s INNER JOIN  department d
ON  s.deptno = d.deptno and s.name like '김%%';

---다 같은 동작이지만 방식이 다르다 ㅈㄴ많다

--join - using 절
SELECT s.studno,s.name,deptno,d.dname
FROM student s JOIN department d
                USING(deptno)
where s.name like '김%%';


-------------------------------------------------------------
-- NON-EQUI JOIN **
-- ‘<‘,BETWEEN a AND b 와 같이 ‘=‘ 조건이 아닌 연산자 사용
-- 교수 테이블과 급여 등급 테이블을 NON-EQUI JOIN하여 
-- 교수별로 급여 등급을 출력하여라

SELECT p.profno, p.name, p.sal,s.grade
from professor p , salgrade s
where p.sal between s.losal and s.hisal;


-- inner                     outer
--   natural                 left
--  inner                    right
--                        | full
--  ==                    |  +
--사용목적  정확시 (성능 up)| 정확성 보증 x 성능down


---------------------------------------------------------------------------
-- OUTER JOIN  ***
-- EQUI JOIN에서 양측 칼럼 값중의 하나가 NULL 이지만 조인 결과로 출력할 필요가 있는 경우
-- OUTER JOIN 사용


-- 기본 ex)

SELECT ename,job,sal,e.deptno,d.dname,loc
FROM  emp e,dept d
WHERE e.deptno = d.deptno;


SELECT ename,job,sal,e.deptno,d.dname,loc
FROM  emp e,dept d
WHERE e.deptno = d.deptno(+);

select s.name,s.grade,p.name,p.positon
from stduent s ,professor p
where s.profno = p.profno;




-- 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력
-- 단, 지도교수가 배정되지 않은 학생이름도 함께 출력하여라.
-- left outer join
SELECT s.name,s.grade,p.name,p.position
FROM student s ,professor p
where s.profno = p.profno(+); --outer조인으로 해결 

--right
SELECT s.name,s.grade,p.name,p.position
from student s ,professor p
where s.profno(+) = p.profno; --outer조인으로 해결 


--ANIS 조인

SELECT s.name,s.grade,p.name,p.position
from student s 
    left outer join professor p
    on s.profno = p.profno; --outer조인으로 해결 
--    where p.profno is null;



SELECT s.name,s.grade,p.name,p.position
from student s 
    right outer join professor p
    on s.profno = p.profno; --outer조인으로 해결 
--    where a.profno is null;

--3 ANIS FULL OUTER JOIN 
SELECT s.name,s.grade,p.name,p.position
from student s 
    full outer join professor p
    on s.profno = p.profno; --outer조인으로 해결 
--    where a.profno is null;





--- <<<   FULL OUTER JOIN  >>> -------------------------------
--학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
-- 단, 지도학생을 배정받지 않은 교수 이름 및 
--  지도교수가 배정되지 않은 학생이름  함께 출력하여라
--  Oracle 지원 안 함
--3 ANIS FULL OUTER JOIN 
SELECT s.name,s.grade,p.name,p.position
from student s 
    full outer join professor p
    on s.profno = p.profno; --outer조인으로 해결 


--== 같은거
SELECT s.name, s.grade ,p.name,p.position 
from student s ,professor p
where s.profno = p.profno(+)
UNION 
SELECT s.name, s.grade ,p.name,p.position
from student s ,professor p
where s.profno = p.profno(+);


-------                    SELF JOIN   **           ----------------       
-- 하나의 테이블내에 있는 칼럼끼리 연결하는 조인이 필요한 경우 사용
-- 조인 대상 테이블이 자신 하나라는 것 외에는 EQUI JO

select c.deptno ,c.dname,c.college,d.dname colleage_anme
from department c , department d
where c.college = d.deptno;

-- SELF JOIN --> 부서 번호가 201 이상인 부서 이름과 상위 부서의 이름을 출력
-- 결과 : xxx소속은 xxx학부
SELECT c.dname || '의 소속은 '||d.dname 
from department c , department d
where c.deptno = d.COLLEGE and d.deptno >= 201;


CREATE TABLE SALGRADE2
    (
        GRADE NUMBER(2,0),
        LOSAL NUMBER(5,0),
        HISAL NUMBER(5,0)
    );   
INSERT INTO salgrade2 VALUES(1,800,2000);
INSERT INTO salgrade2 VALUES(2,2001,3500);
INSERT INTO salgrade2 VALUES(3,3501,5500);
COMMIT;