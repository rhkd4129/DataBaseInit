--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.정의 : Oracle Server는 SQL문을 실행하고 처리한 정보를 저장하기 위해 
--        "Private SQL Area" 이라고 하는 작업영역을 이용
--       이 영역에 이름을 부여하고 저장된 정보를 처리할 수 있게 해주는데 이를 CURSOR
-- 2. 종류  :    Implicit(묵시적인) CURSOR -> DML문과 SELECT문에 의해 내부적으로 선언 
--                 Explicit(명시적인) CURSOR -> 사용자가 선언하고 이름을 정의해서 사용 
-- 3.attribute
--   1) SQL%ROWCOUNT : 가장 최근의 SQL문에 의해 처리된 Row 수
--   2) SQL%FOUND    : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 한 개이상이면 True
--   3) SQL%NOTFOUND : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 없으면True


-- 4. 4단계 ** 
--     1) DECLARE 단계 : 커서에 이름을 부여하고 커서내에서 수행할 SELECT문을 정의함으로써 CURSOR를 선언
--     2) OPEN 단계 : OPEN문은 참조되는 변수를 연결하고, SELECT문을 실행
--     3) FETCH 단계 : CURSOR로부터 Pointer가 존재하는 Record의 값을 변수에 전달
--     4) CLOSE 단계 : Record의 Active Set을 닫아 주고, 다시 새로운 Active Set을만들어 OPEN할 수 있게 해줌
--------------------------------------------------------------------------------
---------------------------------------------------------
-- EXECUTE 문을 이용해 함수를 실행합니다.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------




CREATE OR REPLACE PROCEDURE show_emp3
(p_empno IN emp.empno%type)
IS
    --1.DECLARE단계
    CURSOR emp_cursor IS
    SELECT ename,job,sal
    FROM emp
    WHERE empno LIKE p_empno||'%';
    
    v_name emp.ename%type;
    v_sal emp.sal%type;
    v_job emp.job%type;
BEGIN
--     2) OPEN 단계 
    OPEN emp_cursor;
    DBMS_OUTPUT.PUT_LINE('이름   ' ||'  업무' || '급여'  );
    DBMS_OUTPUT.PUT_LINE('__________________________' );
    
    LOOP
    -- 3 FETCH 하나씩 꺼넴
        FETCH emp_cursor INTO v_name ,v_job,v_sal;
        EXIT WHEN emp_cursor%NOTFOUND; --메모리끝 마지막
        
    END LOOP;
     DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT || '개의 행선택');
     --4 CLOSE단계
    CLOSE emp_cursor;
END show_emp3;




-----------------------------------------------------
-- Fetch 문    ***
-- SQL> EXECUTE  Cur_sal_Hap (5);
-- CURSOR 문 이용 구현 
-- 부서만큼 반복 
-- 	부서명 : 인사팀
-- 	인원수 : 5
-- 	급여합 : 5000


--    CURSOR  Cur_sal_Hap IS
--    SELECT e.dname , COUNT(*) cnt ,sum(e.sal) sumSal
--    FROM emp  e join dept d
--    on e.deptno = d.deptno 
--    WHERE d.deptno LIKE p_deptno||'7%';
--    group by e.dname;
----------------------------------------------------
create or replace PROCEDURE Cur_sal_Hap
    (p_deptno in emp.deptno%type)
IS

    CURSOR  dept_sum IS
    select dname,Count(*) cnt,SUM(sal) sumSal
    from emp e, dept d
    where e.deptno = d.deptno
    and e.deptno like p_deptno||'%'
    Group by dname;

    vcnt  number;
    vsumSal number;
    v_dname dept.dname%type;


BEGIN

    OPEN dept_sum;


    LOOP
    -- 3 FETCH 하나씩 꺼넴
        FETCH dept_sum INTO v_dname ,vcnt,vsumSal;
        EXIT WHEN dept_sum%NOTFOUND; --메모리끝 마지막
        DBMS_OUTPUT.PUT_LINE('부서명   ' || v_dname);
        DBMS_OUTPUT.PUT_LINE('인원수   ' || vcnt);
        DBMS_OUTPUT.PUT_LINE('급여합   ' || vsumSal);
        

    END LOOP;
     DBMS_OUTPUT.PUT_LINE(dept_sum%ROWCOUNT || '개의 행선택');
     --4 CLOSE단계
    CLOSE dept_sum;
END Cur_sal_Hap;

------------------------------------------------------------------------
-- FOR문을 사용하면 커서의 OPEN, FETCH, CLOSE가 자동 발생하므로 
-- 따로 기술할 필요가 없고, 레코드 이름도 자동
-- 선언되므로 따로 선언할 필요가 없다.
-----------------------------------------------------------------------
create or replace PROCEDURE ForCur_sal_Hap
IS
--    CURSOR  dept_sum IS
    --    select d.dname,Count(e.empno) cnt,SUM(e.sal) salary
    --    from emp e, dept d
    --    where e.deptno = d.deptno
    --    and e.deptno like p_deptno||'%'
    --    Group by d.dname;
      CURSOR  dept_sum IS
        select d.dname,Count(e.empno) cnt,SUM(e.sal) salary
        from emp e, dept d
        where e.deptno = d.deptno
        Group by d.dname;
BEGIN

    FOR emp_list In dept_sum LOOP
        DBMS_OUTPUT.PUT_LINE('부서명   ' || emp_list.dname);
        DBMS_OUTPUT.PUT_LINE('인원수   ' ||  emp_list.cnt);
        DBMS_OUTPUT.PUT_LINE('급여합   ' ||  emp_list.salary);
    END LOOP;
     
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('에러');
     
END ForCur_sal_Hap;
-----------------------------------------------------------
--오라클 PL/SQL은 자주 일어나는 몇가지 예외를 미리 정의해 놓았으며, 
--이러한 예외는 개발자가 따로 선언할 필요가 없다.
--미리 정의된 예외의 종류
-- NO_DATA_FOUND : SELECT문이 아무런 데이터 행을 반환하지 못할 때
-- DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복되는 데이터 INSERT 될 때
-- ZERO_DIVIDE : 0으로 나눌 때
-- INVALID_CURSOR : 잘못된 커서 연산
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PreException
    (v_deptno IN emp.deptno%TYPE)

IS
    v_emp  emp%ROWTYPE;
BEGIN
    SELECT empno, ename, deptno
    INTO v_emp.empno, v_emp.ename, v_emp.deptno
    FROM emp
    WHERE deptno = v_deptno;
    
    DBMS_OUTPUT.PUT_LINE('인원수   ' ||  v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('인원수   ' ||  v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('인원수   ' ||  v_emp.deptno);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('중복데이터가 존재 ');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('TOO_MNAY_ROWS  ');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND  ');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('기타');
END PreException;
        
-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  lowsal_err (최저급여 ->1500)  
----------------------------------------------------------

CREATE OR REPLACE PROCEDURE in_emp
 (
    p_name in emp.ename%type,
    p_sal in emp.sal%type,
    p_job in emp.job%type
 )

IS
    v_empno  emp.empno %TYPE;
    --개발자 defind error
    lowsal_err EXCEPTION;
BEGIN
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal >= 1500  then
        INSERT INTO emp(empno,ename,sal,job,deptno,hiredate)
        VALUES(v_empno,p_name,p_sal,p_job,10,SYSDATE);
    ELSE
        RAISE lowsal_err;
    END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('중복데이터가 존재 ');
        WHEN lowsal_err THEN
                DBMS_OUTPUT.PUT_LINE('지정한 글자가 너무많아 ');
END;


-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  highsal_err (최고급여 ->9000 이상 오류 발생)  
---   2. 기타조건
---      1) emp.ename은 Unique 제약조건이 걸려 있다고 가정 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max 번호 입력 
---      3) hiredate     : 시스템 날짜 입력 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column입력한다 가정 
------------------------------------

CREATE OR REPLACE PROCEDURE in_emp3
 (
    p_name in emp.ename%type, --DUP_VAL_ON_INDEX
    p_sal in emp.sal%type,  -- 개발자 DEFIND EROR :HEIGHSAL_ERR(최저급여 ->9000)
    p_job in emp.job%type
 )

IS
    v_empno  emp.empno %TYPE;
    --개발자 defind error
    highsal_err EXCEPTION;
BEGIN
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal <= 9000  then
        INSERT INTO emp(empno,ename,sal,job,hiredate)
        VALUES(v_empno,p_name,p_sal,p_job,SYSDATE);
    ELSE
        RAISE highsal_err;
    END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('중복데이터가 존재 ');
        WHEN highsal_err THEN
                DBMS_OUTPUT.PUT_LINE('지정한 글자가 너무많아 ');
END;


CREATE OR REPLACE PROCEDURE in_emp
 (
    p_name in emp.ename%type,
    p_sal in emp.sal%type,
    p_job in emp.job%type
 )

IS
    v_empno  emp.empno %TYPE;
    --개발자 defind error
    lowsal_err EXCEPTION;
BEGIN
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal >= 1500  then
        INSERT INTO emp(empno,ename,sal,job,deptno,hiredate)
        VALUES(v_empno,p_name,p_sal,p_job,10,SYSDATE);
    ELSE
        RAISE lowsal_err;
    END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('중복데이터가 존재 ');
        WHEN lowsal_err THEN
                DBMS_OUTPUT.PUT_LINE('지정한 글자가 너무많아 ');
END;

CREATE OR REPLACE PROCEDURE in_emp
 (
    p_name in emp.ename%type,
    p_sal in emp.sal%type,
    p_job in emp.job%type
 )

IS
    v_empno  emp.empno %TYPE;
    --개발자 defind error
    lowsal_err EXCEPTION;
BEGIN
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp;
    
    IF p_sal >= 1500  then
        INSERT INTO emp(empno,ename,sal,job,deptno,hiredate)
        VALUES(v_empno,p_name,p_sal,p_job,10,SYSDATE);
    ELSE
        RAISE lowsal_err;
    END IF;
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('중복데이터가 존재 ');
        WHEN lowsal_err THEN
                DBMS_OUTPUT.PUT_LINE('지정한 글자가 너무많아 ');
END;

--------------------------------------------------------------
--  HW2
-- 1. 파라메타 : (p_empno, p_ename  , p_job,p_MGR ,p_sal,p_DEPTNO )
-- 2. emp TBL에  Insert_emp Procedure 
-- 3. v_job =  'MANAGER' -> v_comm  := 1000;
--              아니면                  150; 
-- 4. Insert -> emp 
-- 5. 입사일은 현재일자
--------------------------------------------------------------
