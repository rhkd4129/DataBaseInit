CREATE OR REPLACE PROCEDURE Emp_Info2
    (p_empno IN emp.empno%TYPE, --파라미터 
    P_ename OUT emp.ename%TYPE, -- 리턴값
    p_sal OUT emp.sal%TYPE
    ) 
IS
    v_empno emp.empno%TYPE;
BEGIN

    SELECT empno,ename,sal
    INTO v_empno,P_ename,P_sal  --변수 값을 담을때 into
    FROM  emp
    WHERE empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE('사원번호:'|| v_empno || CHR(10)||CHR(13)||'줄바꿈');    
    DBMS_OUTPUT.PUT_LINE(P_ename);
    DBMS_OUTPUT.PUT_LINE(P_sal);
END;