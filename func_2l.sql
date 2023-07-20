---------------------------------------------------------
---   8장. 그룹함수 
---- 테이블의 전체 행을 하나 이상의 컬럼을 기준으로 그룹화하여
---   그룹별로 결과를 출력하는 함수
---------------------------------------------------------

-- 1) COUNT 함수
-- 테이블에서 조건을 만족하는 행의 갯수를 반환하는 함수



-- 문1) 101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라

SELECT count(comm)
FROM PROFESSOR
WHERE deptno = 101;


--문2) 101번 학과 교수중에서 교수의 수를 출력하여라
SELECT count(*) --NULL값도 포함함
FROM PROFESSOR
WHERE deptno = 101;

--102번 학과 학생들의 몸무게 평균과 합계를 출력하여라

SELECT SUM(WEIGHT), AVG(WEIGHT) --NULL값이 있으면빼고 계산
FROM STUDENT
WHERE deptno = 102;

-- 교수 테이블에서 급여의 표준편차와 분산을 출력
select stddev(sal) , variance(sal)
from professor;

-- 학과별  학생들의 인원수, 몸무게 평균과 합계를 출력하여라
SELECT deptno,count(*),avg(weight),sum(weight)
from student
group by deptno;



-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라

--select deptno,count(*),count(comm) --?
select deptno,count(profno),count(comm)
from professor
group by deptno;

-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 단 학과별로 교수 수가 2명 이상인 학과만 출력
--select deptno,count(*),count(comm)
select deptno,count(*),count(comm)
from professor
group by deptno
HAVING count(profno)>1;
--HAVING count(*)>1;??

-- 학생 수가 4명이상이고 평균키가 168이상인  학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
-- 단, 평균 키와 평균 몸무게는 소수점 두 번째 자리에서 반올림 하고, 
-- 출력순서는 평균 키가 높은 순부터 내림차순으로 출력하고 
--   그 안에서 평균 몸무게가 높은 순부터 내림차순으로 출력

select grade,count(STUDNO)
            ,round(avg(weight),1) any_weight
            ,round(avg(height),1) any_height
from student
group by grade
having count(*)>4 and   round(avg(height)) >168
order by any_height desc,any_weight desc;




-- ROLLUP 연산자
-- GROUP BY 절의 그룹 조건에 따라 전체 행을 그룹화하고 각 그룹에 대해 부분합을 구하는 연산자
-- 문) 소속 학과별로 교수 급여 합계와 모든 학과 교수들의 급여 합계를 출력하여라

SELECT DEPTNO,SUM(SAL)
FROM PROFESSOR
GROUP BY ROLLUP(DEPTNO);

--문2) ROLLUP 연산자를 이용하여 학과 및 직급별 교수 수,
--학과별 교수 수, 전체 교수 수를 출력하여라
select DEPTNO,position,count(*)FROM PROFESSOR
group by rollup(DEPTNO,position);


-- CUBE 연산자
-- ROLLUP에 의한 그룹 결과와 GROUP BY 절에 기술된 조건에 따라 그룹 조합을 만드는 연산자
-- 문1) CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
SELECT deptno,position, count(*)
from   professor
group by cube(deptno,position);
-------------------------------------------------------------------------------------
----    9-0.    DeadLock                                                                                        ---------
-------------------------------------------------------------------------------------
-- Transaction A(develop)
update  emp
set     sal = sal*1.1
where   empno = 7369;



update  emp
set     sal = sal*1.1
where   empno = 7839;



-- Transaction B(sql-plus)
update  emp
set     comm = 500
where   empno = 7839

--개념적 모델링

--master table 기본정보 되는 tb 거래처 ,제품 tbㅣ등
--transaction 주기적(일/주/월) 발생tb 주문테이블등