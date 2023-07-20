--DECODE 함수 *****
--DECODE 함수는 기존 프로그래밍 언어에서 IF문이나 CASE 문으로 표현되는 복잡한 알고리즘을 
--하나의 SQL 명령문으로 간단하게 표현할 수 있는 유용한 기능 
--DECODE 함수에서 비교 연산자는 ‘=‘만 가능

--교수 테이블에서 교수의 소속 학과 번호를 학과 이름으로 변환하여 출력하여라. 
--학과 번호가 101이면 ‘컴퓨터공학과’, 102이면 ‘멀티미디어학과’, 201이면 ‘전자공학과’, 
--나머지 학과 번호는 ‘기계공학과’(default)로 변환


SELECT name,deptno,
    DECODE(deptno,  101,'컴퓨터공학과'
                 ,  102,'멀티미디어'
                 ,  201,'전자공학',
                        '기계공학과')
FROM professor                        ;


-- CASE 함수
-- CASE 함수는 DECODE 함수의 기능을 확장한 함수 
-- DECODE 함수는 표현식 또는 칼럼 값이 ‘=‘ 비교를 통해 조건과 일치하는 경우에만 
-- 다른 값으로 대치할 수 있지만
-- CASE 함수에서는 산술 연산, 관계 연산, 논리 연산과 같은 다양한 비교가 가능
-- 또한 WHEN 절에서 표현식을 다양하게 정의
-- 8.1.7에서부터 지원되었으며, 9i에서 SQL, PL/SQL에서 완벽히 지원 
-- DECODE 함수에 비해 직관적인 문법체계와 다양한 비교 표현식 사용
SELECT name,deptno, 
        CASE WHEN deptno =101 Then '컴공'
            WHEN deptno = 102 Then '멀티미디어'
            WHEN deptno = 201 Then '전자공'
            ELSE                    '기꼐공'
        end deptname
FROM professor;

-- 교수 테이블에서 name , deptno , sal , bonus 출력
-- 소속 학과에 따라 보너스를 다르게 계산하여 출력하여라. (별명 --> bonus)
-- 학과 번호별로 보너스는 다음과 같이 계산한다.
-- 학과 번호가 101이면 보너스는 급여의 10%, 102이면 20%, 201이면 30%, 나머지 학과는 0
SELECT name,deptno,sal,
        CASE WHEN deptno =101 Then sal*0.1
            WHEN deptno = 102 Then sal*0.2
            WHEN deptno = 201 Then sal*0.3
            ELSE                    0
        end bonus
FROM professor;       





