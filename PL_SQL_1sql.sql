
--HW
----------------------------------------------------------
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- 사원번호 : 5001,5002
-- 사원이름 : 55
-- 입 사 일 : 81/12/03
-- 데이터 삭제 성공
--  1. Parameter : 사번 입력
--  2. 사번 이용해 사원번호 ,사원이름 , 입 사 일 출력
--  3. 사번 해당하는 데이터 삭제 
----------------------------------------------------------
CREATE OR REPLACE Procedure  Delte_emp
    (p_empno  in emp.empno%type)
    IS
        v_empno emp.empno%type;
        v_name emp.ename%type;
        V_DATE emp.hiredate%type;
    BEGIN
        SELECT empno,ename,hiredate
        INTO v_empno,v_name,V_DATE
        FROM EMP
        where empno = p_empno ;
        
        DBMS_OUTPUT.PUT_LINE('사번'|| v_empno);
        DBMS_OUTPUT.PUT_LINE('이름'|| v_name);
        
        delete  from emp where empno = p_empno;
        
    END Delte_emp;
------------------------------------------------------------------------
---    PL/SQL의 개념
---   1. Oracle에서 지원하는 프로그래밍 언어의 특성을 수용한 SQL의 확장
---   2. PL/SQL Block내에서 SQL의 DML(데이터 조작어)문과 Query(검색어)문, 
---      그리고 절차형 언어(IF, LOOP) 등을 사용하여 절차적으로 프로그래밍을 가능하게 
---      한 강력한  트랜잭션 언어
---
---   1) 장점 
---      프로그램 개발의 모듈화 : 복잡한 프로그램을 의미있고 잘 정의된 작은 Block 분해
---      변수선언  : 테이블과 칼럼의 데이터 타입을 기반으로 하는 유동적인 변수를 선언
---      에러처리  : Exception 처리 루틴을 사용하여 Oracle 서버 에러를 처리
---      이식성    : Oracle과 PL/SQL을 지원하는어떤 호스트로도 프로그램 이동 가능
---      성능 향상 : 응용 프로그램의 성능을 향상
 
------------------------------------------------------------------------
--  Function  :  하나의 값을 돌려줘야 되는 경우에 Function을 생성
--  문1) 특정한 수에 세금을 7%로 계산하는 Function을 작성
---   조건 1: Function  -->   tax 
---   조건 2: parameter   -->   p_num  (급여)
---   조건 3: 계산을 통해 7% 값을 돌려줌
create or replace Function tax (p_num in number)
    RETURN number
IS

BEGIN   
    return  p_num*0.07;
END;

SELECT tax(100) FROM dual;
SELECT tax(200) FROM dual;

SELECT empno,ename,sal,tax(sal)
from emp;

﻿
-- EMP 테이블에서 사번을 입력받아 해당 사원의 급여에 따른 세금을 구함.
-- 급여가 2000 미만이면 급여의 6%,
-- 급여가 3000 미만이면 8%,
-- 5000 미만이면 10%,
-- 그 이상은 15%로 세금
--- FUNCTION emp_tax3
-- 1) Parameter : 사번 p_empno     변수 : v_sal(급여)   v_pct(세율계산값)
-- 2) 사번을 가지고 급여를 구함
-- 3) 급여를 가지고 세율 계산
-- 4) 계산 된 값 Return number


create or replace Function emp_tax3 (p_empno in emp.empno%type)
    RETURN NUMBER
IS
    v_sal  emp.sal%type;
    v_pct  NUMBER(7,2);   --소수점이 두자리
    
BEGIN   
    select sal  
    into v_sal
    from emp
    where  empno = p_empno;


    IF  v_sal <2000 THEN
        v_pct := v_sal*0.06;
    ELSIF v_sal <3000 THEN
         v_pct := v_sal*0.08;
    ELSIF v_sal <5000 THEN
         v_pct := v_sal*0.10;
    ELSE
        v_pct := v_sal*0.15;
    END IF;
    
    RETURN v_pct;
END emp_tax3;





SELECT ename,sal,emp_tax3(empno) emp_rate
from emp;


--프로시저 --
-----------------------------------------------------
--  Procedure up_emp 실행 결과
-- SQL> EXECUTE up_emp(1200);  -- 사번 
-- 결과       : 급여 인상 저장
--               시작문자
--   변수     :   v_job(업무)
--                  v_pct(세율)

-- 조건 1) job = SALE포함         v_pct : 10
--           IF              v_job LIKE 'SALE%' THEN
--     2)            MAN              v_pct : 7  
--     3)                                v_pct : 5
--   job에 따른 급여 인상을 수행  sal = sal+sal*v_pct/100
-- 확인 : DB -> TBL
-----------------------------------------------------
create or replace Procedure up_emp --부서 테이블을 인서트 
        (p_empno in emp.empno%type) 
--     (p_jab       in emp.job%Type)

IS
      v_job emp.job%type;
      v_pct NUMBER(3);

begin

    SELECT JOB
    INTO v_job
    from emp
    where empno = p_empno;


    IF  v_job LIKE 'SALE%' THEN
        v_pct := 10;
        
    ELSIF v_job LIKE 'MAN%'  THEN
        v_pct := 7;
    ELSE
        v_pct:=5;
    END IF;
    
    update emp 
    set sal = sal+sal*v_pct/100
    where empno = p_empno;
    
END up_emp;






---------------------------------------------------------
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동


create or replace Procedure DeptEmpSearch1
    (p_deptno emp.deptno%type)
IS
    v_empno emp.empno%type;
    v_ename emp.ename%type;
BEGIN
    SELECT empno,ename
    into v_empno,v_ename
    from emp
    where deptno = p_deptno;

    DBMS_OUTPUT.PUT_LINE('사원번호:'|| v_empno || CHR(10)||CHR(13)||'줄바꿈');    
    DBMS_OUTPUT.PUT_LINE(v_ename);
END DeptEmpSearch1;




---------------------------------------------------------
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch2(75);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
-- %ROWTYPE를 이용하는 방법


create or replace Procedure DeptEmpSearch_1
    (p_deptno emp.deptno%type)
IS
        v_emp emp%rowtype;
--    v_empno emp.empno%type;
--    v_ename emp.ename%type;

BEGIN
    SELECT *
    into v_emp
    from emp
    where deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE('사원번호:'|| v_emp.deptno || CHR(10)||CHR(13)||'줄바꿈');    
    DBMS_OUTPUT.PUT_LINE(v_emp.ename);
END DeptEmpSearch_1;
    




-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch3(10);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
-- %ROWTYPE를 이용하는 방법
-- EXCEPTION 이용하는 방법




create or replace Procedure DeptEmpSearch_3
    (p_deptno emp.deptno%type)
IS
        v_emp emp%rowtype;
BEGIN
    SELECT *
    into v_emp
    from emp
    where deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE('사원번호:'|| v_emp.deptno || CHR(10)||CHR(13)||'줄바꿈');    
    DBMS_OUTPUT.PUT_LINE(v_emp.ename);
    
    
    EXCEPTION
    WITH OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERR CODE 1:' ||TO_CHAR(SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERR CODE 2:' ||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERR CODE 3:' ||SQLCODE);
        
     
END DeptEmpSearch_3;
    
    






