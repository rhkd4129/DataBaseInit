-- 패키지
---------------------------------------------------------------------------------------
-----    Package
--  자주 사용하는 프로그램과 로직을 모듈화
--  응용 프로그램을 쉽게 개발 할 수 있음
--  프로그램의 처리 흐름을 노출하지 않아 보안 기능이 좋음
--  프로그램에 대한 유지보수 작업이 편리
--  같은 이름의 프로시저와 함수를 여러 개 생성

----------------------------------------------------------------------------------------
-- 1.Header -->  역할 : 선언 (Interface 역할)
--     여러 PROCEDURE 선언 가능

CREATE OR REPLACE PACKAGE emp_info AS
    PROCEDURE emp_info_main(p_deptno IN NUMBER);
    PROCEDURE all_emp_info;       -- 모든 사원의 사원 정보        -- 순서1
    PROCEDURE all_sal_info;         -- 부서별 급여 정보            -- 순서2   -- 하나씩 선언하는 중이라, 주석필요.
                                                                -- ||=>     밑에 바디 다 생성하면 주석 필요없음!
    -- 특정 부서의 사원 정보
    PROCEDURE dept_sal_info(p_deptno IN NUMBER);
    --글로벌 변수 사용가능    
END emp_info;


-- 2.Body 역할 : 실제 구현
CREATE OR REPLACE PACKAGE BODY emp_info AS              --PACKAGE BODY 

        PROCEDURE emp_info_main(p_deptno IN NUMBER)
-----------------------------------------------------------------
-- emp_info의 모든 프로시저 실행
-----------------------------------------------------------------
        IS
        BEGIN
                all_emp_info();
                all_sal_info();
                dept_sal_info(p_deptno => p_deptno);        -- java의 파라미터처럼
        END;
-----------------------------------------------------------------
-- 모든 사원의 사원 정보(사번, 이름, 입사일)
-- 1. CURSOR  : emp_cursor 
-- 2. FOR  IN
-- 3. DBMS  -> 각각 줄 바꾸어 사번,이름,입사일 
-- Exception -> DEFAULT 
-----------------------------------------------------------------
     --DECLARE
     PROCEDURE all_emp_info
     IS
     CURSOR emp_cursor
     IS
        SELECT ename, empno, TO_CHAR(hiredate,'YYYY/MM/DD') hiredate        -- tochar로 지정하지 않아도 된다.
        from emp;
     BEGIN
        DBMS_OUTPUT.ENABLE;                 --FOR문 있으니까 OPEN은 필요 없음.         
            DBMS_OUTPUT.PUT_LINE('all_emp_info');
        
        FOR emp_list IN emp_cursor LOOP         -- FETCH               
            DBMS_OUTPUT.PUT_LINE('사번: ' || emp_list.empno);
            DBMS_OUTPUT.PUT_LINE('이름: ' || emp_list.ename);
            DBMS_OUTPUT.PUT_LINE('입사일: ' || emp_list.hiredate);
        END LOOP;                               --CLOSE
        
        EXCEPTION
        WHEN OTHERS THEN                  -- 지정된 에러 외 발생 시
                DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
        END;
        
        
        PROCEDURE all_sal_info
-----------------------------------------------------------------------
-- 모든 사원의 부서별 급여 정보
-- 1. CURSOR  : empdept_cursor 
-- 2. FOR  IN
-- 3. DBMS  -> 각각 줄 바꾸어 부서명 ,전체급여평균 , 최대급여금액 , 최소급여금액
-----------------------------------------------------------------------
        IS
        CURSOR empdept_cursor
        IS
        Select d.dname 부서명, ROUND(avg(e.sal),3) 전체급여평균, max(e.sal) 최대급여금액, min(e.sal) 최소급여금액
        FROM dept d JOIN emp e
        ON d.deptno = e.deptno
        GROUP BY d.dname;
        
        BEGIN
        DBMS_OUTPUT.ENABLE;        
            DBMS_OUTPUT.PUT_LINE('all_sal_info');
        
        FOR emp_list IN empdept_cursor LOOP    
            DBMS_OUTPUT.PUT_LINE('부서명: ' || emp_list.부서명);
            DBMS_OUTPUT.PUT_LINE('전체급여평균: ' || emp_list.전체급여평균);
            DBMS_OUTPUT.PUT_LINE('최대급여금액: ' || emp_list.최대급여금액);
            DBMS_OUTPUT.PUT_LINE('최소급여금액: ' || emp_list.최소급여금액);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN               -- 지정된 에러 외 발생 시
                DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
        END;
-------------------------------------
--특정 부서 급여 정보
-------------------------------------

        PROCEDURE dept_sal_info(p_deptno IN NUMBER)
        IS
        CURSOR
        empdept_cursor
        IS
-----------------------------------------------------------------
-- 특정 부서의 급여 정보
-- 1. CURSOR  : emp_cursor 
-- 2. FOR  IN
-- 3. DBMS  -> 각각 줄 바꾸어 부서명 ,전체급여평균 , 최대급여금액 , 최소급여금액
-- 4. EXCEPTION -> Default  *
-----------------------------------------------------------------
            SELECT d.dname 부서명, ROUND(avg(e.sal),3) 전체급여평균, max(e.sal) 최대급여금액, min(e.sal) 최소급여금액
            FROM dept d , emp e
            Where d.deptno = e.deptno
            AND e.deptno = p_deptno
            GROUP BY d.dname;
            
            /* join으로 해보기
            SELECT d.dname 부서명, ROUND(avg(e.sal),3) 전체급여평균, max(e.sal) 최대급여금액, min(e.sal) 최소급여금액
            FROM dept d join emp e
            ON d.deptno = e.deptno
            AND e.deptno = p_deptno
            GROUP BY d.dname;
            -- having : group by 결과에 추가 조건.
            -- group by의 추가 조건이 아니라면 on + and로 해야함
            */
            
        BEGIN
                DBMS_OUTPUT.ENABLE;
            DBMS_OUTPUT.PUT_LINE('dept_sal_info');
        
        FOR emp_list IN empdept_cursor LOOP    
            DBMS_OUTPUT.PUT_LINE('부서명: ' || emp_list.부서명);
            DBMS_OUTPUT.PUT_LINE('전체급여평균: ' || emp_list.전체급여평균);
            DBMS_OUTPUT.PUT_LINE('최대급여금액: ' || emp_list.최대급여금액);
            DBMS_OUTPUT.PUT_LINE('최소급여금액: ' || emp_list.최소급여금액);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
        
        EXCEPTION
        WHEN OTHERS THEN               -- 지정된 에러 외 발생 시
                DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생');
        END;
END;

-------------------------------------------------------



    PROCEDURE emp_info_main (p_deptno IN NUMBER);
    PROCEDURE all_emp_info;     -- 모든 사원의 사원 정보
    PROCEDURE all_sal_info;     -- 부서별 급여 정보
    -- 특정 부서의 사원 정보
    PROCEDURE dept_sal_info (p_deptno IN NUMBER);
    Procedure Insert_emp
        (p_empno  IN EMP.EMPNO%TYPE,
         p_ename  IN EMP.ENAME%TYPE,
         p_MGR    IN EMP.MGR%TYPE,
         p_sal    IN EMP.sal%TYPE,
         p_deptno IN NUMBER
         );

END  emp_info;


----------------------------------------------------------------
    -- emp_info의 Main Procedure(부서정보)
    -- 1. emp_info PACKAGE의 전체 Procedure 수행
     -----------------------------------------------------------------
   PROCEDURE emp_info_main (p_deptno IN NUMBER)
   IS
   BEGIN
      all_emp_info();
      all_sal_info();
      --dept_sal_info(p_deptno => p_deptno );
      dept_sal_info(p_deptno);
      Insert_emp
        (8111,
         '김태현',
         1400,
         3200,
         p_deptno 
         );
   END emp_info_main;
Procedure Insert_emp
        (p_empno  IN EMP.EMPNO%TYPE,
         p_ename  IN EMP.ENAME%TYPE,
         p_MGR    IN EMP.MGR%TYPE,
         p_sal    IN EMP.sal%TYPE,
         p_deptno IN NUMBER
         )
    IS
        v_comm   EMP.COMM%TYPE;
    BEGIN
        IF   g_job =  'MANAGER'  THEN
             v_comm  := 1000;
        ELSE 
             v_comm  := 150;    
        END IF;
        INSERT INTO emp(empno     ,ename,  job,   MGR,   hiredate, sal,  comm,  deptno)
        VALUES         (p_empno,  p_ename, g_job, p_MGR, SYSDATE,  p_sal,v_comm,p_DEPTNO); 
    END;
