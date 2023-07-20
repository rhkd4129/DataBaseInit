create or replace Function func_sal
    (p_empno in number)
    RETURN number        --함수은 리턴값이 반드시 존재 
--autonomouns_transaction;
IS 
--    pragma autonomous_transation;
    PRAGMA AUTONOMOUS_TRANSACTION;
    vsal emp.sal%type;  --emp table에 sal과 같은 타입
BEGIN
-- 10% 임금인상
    UPDATE emp SET sal = sal*1.1
        WHERE empno = p_empno;
        commit;
        SELECT sal INTO vsal -- select -> vsal
        FROM emp
        WHERE empno = p_empno;
        RETURN vsal;
END;

--               프로시저           함수
-- RETYRB            X                MUST
-- 외부전달         OUT              RETURN
-- 주요목적        DML(하나이상의)     연산,계산(간단한)

--               프로시저           함수
-- RETYRB            X                MUST
-- 외부전달         OUT              RETURN
-- 주요목적        DML(하나이상의)     연산,계산(간단한)
--------------------------------------------------

SELECT func_sal(1000)
FROM dual;