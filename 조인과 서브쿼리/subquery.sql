-----------------------------------------------------------------
----- SUB Query   ***
-- 하나의 SQL 명령문의 결과를 다른 SQL 명령문에 전달하기 위해 
-- 두 개 이상의 SQL 명령문을 하나의 SQL명령문으로 연결하여
-- 처리하는 방법
-- 종류 
-- 1) 단일행 서브쿼리
-- 2) 다중행 서브쿼리


-------------------------------------------------------------------
--  1. 목표 : 교수 테이블에서 ‘전은지’ 교수와 직급이 동일한 모든 교수의 이름 검색
    --    1-1 교수 테이블에서 ‘전은지’ 교수의 직급 검색 SQL 명령문 실행     
SELECT name,position
from professor
where name='전은지';
    -- 1-2  교수 테이블의 직급 칼럼에서 1에서 얻은 결과 값과 동일한 직금을 가진 교수 검색 명령문 실행
select name,position
from professor
where position='전임강사';

SELECT name,position 
from professor
where position = (
                    SELECT position 
                    from professor 
                    where name = '전은지');
                    
                    
-- 종류 
-- 1) 단일행 서브쿼리
--  서브쿼리에서 단 하나의 행만을 검색하여 메인쿼리에 반환하는 질의문
--  메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 반드시 단일행 비교 연산자 중 
--  하나만 사용해야함

--  문1) 사용자 아이디가 ‘jun123’인 학생과 같은 학년인 학생의 학번, 이름, 학년을 출력하여라
SELECT profno,name,grade
FROM student
where grade = ( 
                select grade 
                from student 
                where userid = 'jun123');
                
--  문2)  101번 학과 학생들의 평균 몸무게/보다 몸무게가 적은 학생의 이름, 학년 , 학과번호, 몸무게를  출력
--  조건 : 학과별 출력      
                
SELECT  name,grade,deptno,weight
FROM student
where weight  <( select avg(weight)
                 from student
                 where deptno =101)
order by deptno
; 


--  문3) 20101번 학생과 학년이 같고, 키는 20101번 학생보다 큰 학생의 
-- 이름, 학년, 키를 출력하여라
--  조건 : 학과별 출력

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

-- 문4) 101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학과번호, 몸무게를 출력하여라
--  조건 : 학과별 출력

select name,deptno,weight
from student
where weight < (
                SELECT avg(weight)
                from student
                where deptno = 101)
order by deptno;



-- 2) 다중행 서브쿼리
-- 서브쿼리에서 반환되는 결과 행이 하나 이상일 때 사용하는 서브쿼리
-- 메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 다중 행 비교 연산자 를 사용하여 비교
-- 다중 행 비교 연산자 : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참, ‘=‘비교만 가능
-- 2) ANY, SOME  : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참
-- 3) ALL             : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 모든값이 일치하면 참, 
-- 4) EXISTS        : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참

-- 1.  IN 연산자를 이용한 다중 행 서브쿼리

SELECT name,grade,deptno
from student
where deptno=( --결과가 다중행일 때는 = 이 안된다.다중행 사용이유
               
                SELECT deptno
                from department
                where college=100
                );
                
SELECT name,grade,deptno
from student
where deptno IN ( --결과가 다중행일 때는 = 이 안된다.다중행 사용이유
                SELECT deptno
                from department
                where college=100  --> 101, 102랑 같음
                );


--  2. ANY 연산자를 이용한 다중 행 서브쿼리
-- 문)모든 학생 중에서 4학년 학생 중에서 키가 제일 작은 학생보다 키가 큰 학생의 학번, 이름, 키를 출력
select studno, name,height
from student
where height > any(
                    -- 175,176,177 -->min생각
                    select height
                    from student
                    where grade = '4'
                    );
--- 3. ALL 연산자를 이용한 다중 행 서브쿼리
select studno, name,height
from student
where height >all(
                    -- 175,176,177 -->max
                    select height
                    from student
                    where grade = '4'
                    );

--- 4. EXISTS 연산자를 이용한 다중 행 서브쿼리
SELECT profno,name,sal,comm,position  -- <--- 다실행
from professor
where exists(
            --하나라도 존재하면 (참이면) 조건과 관계없이 
            
            SELECT position
            from professor
            where comm is not null);
            
            
-- 문1)  보직수당을 받는 교수가 한 명이라도 있으면 
--       모든 교수의 교수 번호, 이름, 보직수당 그리고 급여와 보직수당의 합(NULL처리)을 출력

SELECT profno,name,comm,(sal+nvl(comm,0)) 
from professor 
where exists (
            select profno
            from professor
            where comm  iS not null);
            
-- 문2) 학생 중에서 ‘goodstudent’이라는 사용자 아이디가 없으면 1을 출력하여라   

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

-- 다중 컬럼 서브쿼리
-- 서브쿼리에서 여러 개의 칼럼 값을 검색하여 메인쿼리의 조건절과 비교하는 서브쿼리
-- 메인쿼리의 조건절에서도 서브쿼리의 칼럼 수만큼 지정
-- 종류
-- 1) PAIRWISE : 칼럼을 쌍으로 묶어서 동시에 비교하는 방식
-- 2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식

-- 1) PAIRWISE 다중 칼럼 서브쿼리
-- 문1)    PAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 
--          학생의 이름, 학년, 몸무게를 출력하여라


select name,grade,weight
from student
where (grade,weight) in (select grade,min(weight)
                         from student
                         group by grade);

--  2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식
-- UNPAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력


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
                
                
-- 상호연관 서브쿼리     ***
-- 메인쿼리절과 서브쿼리간에 검색 결과를 교환하는 서브쿼리

-- 문1)  각 학과 학생의 평균 키보다 키가 큰 학생의 이름, 학과 번호, 키를 출력하여라
                    --< 1번from on join where group having select order
                    --< 3번
select deptno,name,grade ,height
from student s1   
where height > (select avg(height)
                from student s2
--                                 실행순서 2 
                where s2.deptno = s1.deptno
                )
order by deptno;


-------------  HW  -----------------------


-- 1. Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이하라
select ename,hiredate from emp
where deptno = ( 
                select deptno
                from emp
                where ename = 'BLAKE');

-- 2. 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문을 생성. 
--    단 출력은 급여 내림차순 정렬하라

select ename,empno
from emp
where sal >= (
        select  avg(sal)
        from emp
        )
order by DESC;


-- 3. 보너스를 받는 어떤 사원의 부서 번호와 급여에 일치하는 사원의 이름, 부서 번호 그리고 급여를 디스플레이하라.