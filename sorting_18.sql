-- 정렬
-- 학생 테이블에서 학년을 오름차(내림차)순으로 정렬하여 이름, 학년, 전화번호를 출력


SELECT name,grade,tel FROM STUDENT ORDER BY  grade asc; --기본값 --오름

SELECT name,grade,tel FROM STUDENT ORDER BY  grade desc;

-- 모든 사원의 이름과 급여 및 부서번호를 출력하는데,  
-- 부서 번호로 결과를 정렬한 다음 급여에 대해서는 내림차순으로 정렬

SELECT  ename,sal,comm
FROM  EMP 
ORDER BY  deptno ,sal desc;


-- 부서 10과 30에 속하는 모든 사원의 이름과 부서번호를 이름의 알파벳 순으로 
-- 정렬되도록 질의문(emp)

SELECT ENAME,DEPTNO FROM EMP
--WHERE DEPTNO BETWEEN 10 AND 30 
WHERE DEPTNO IN (10,30)
--WHERE DEPTNO =  10 OR DEPTNO =  30???
ORDER BY ENAME ;

---- homework ----
-- HW1
-- 1982년에 입사한 모든 사원의 이름과 입사일을 구하는 질의문

-- HW2
-- 보너스를 받는 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는 질의문을 형성. 
-- 단 급여와 보너스에 대해서 급여/보너스순으로 내림차순 정렬

SELECT ename ,sal, comm FROM EMP
WHERE comm is NOT NULL
ORDER BY sal,comm DESC;


--강한빛	3630	100
--test3	3500	100
--강준우	3300	200
--ALLEN	1600	300
--MARTIN	1250	1400
--WARD	1250	500

-- HW3
-- 보너스가 급여의 20% 이상이고 부서번호가 30인 모든 사원에 대해서 
-- 이름, 급여 그리고 보너스, 부서번호를 출력하는 질의문을 형성하라

SELECT ename ,sal, comm,deptno FROM EMP
WHERE (SAL*0.2 < COMM) AND (DEPTNO = 30);
--WARD	1250	500	30
--MARTIN	1250	1400

