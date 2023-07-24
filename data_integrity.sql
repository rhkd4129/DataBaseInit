/*
무결성 제약 조건

NOT NULL
고유키
기본키  유일성 ,NOTNULL ,최소성 -> 2개로 복합키 지정할수잇느데 하나로만으로도 설명가능한거 
참조키
CHECK


------------            제약조건(Constraint)        ***          ------------
  정의  : 데이터의 정확성과 일관성을 보장
 1. 테이블 생성시 무결성 제약조건을 정의 가능
 2. 테이블에 대해 정의, 데이터 딕셔너리에 저장되므로 응용 프로그램에서 입력된 
     모든 데이터에 대해 동일하게 적용
 3. 제약조건을 활성화, 비활성화 할 수 있는 융통성



------------            제약조건(Constraint)   종류      ***  ------------
1 .NOT NULL  : 열이 NULL을 포함할 수 없음
2. 기본키(primary key) : UNIQUE +  NOT NULL + 최소성  제약조건을 결합한 형태
3. 참조키(foreign key) :  테이블 간에 외래 키 관계를 설정 ***
4. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
-------------------------------------------------------------



 1.  제약조건(Constraint) 적용 위한 강좌(subject) 테이블 인스턴스
*/

CREATE TABLE subject
(

    subno    NUMBER(5)       CONSTRAINT subject_no_pk PRIMARY KEY,
    subname  VARCHAR2(20)    CONSTRAINT subject_name_nn NOT NULL,
    term     VARCHAR2(1)    CONSTRAINT subject_term_ck CHECK(term IN('1','2')),
    typeGubun VARCHAR2(1)    

);

COMMENT ON COLUMN subject.subno IS '수강번호';
COMMENT ON COLUMN subject.subname IS '수강과목';
COMMENT ON COLUMN subject.term IS '학기';

INSERT INTO subject(subno,subname,term,typeGubun)
                                VALUES (10000,'컴퓨터개론','1','1');


INSERT INTO subject(subno,subname,term,typegubun) 
                                values (10001,'DB개론','2','1');
                                    
INSERT INTO subject(subno,subname,term,typegubun) 
                                 values (10002,'JSP개론','1','1');
-- PK Constraint   --> Unique
-- PK Constraint   --> NN
-- subname NN
-- Check  Constraint   --> term


-- Table 선언시 못한것을 추후 정의 가능
-- Student Table 의 idnum을 unique로 선언
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); --KEY추가시

INSERT INTO student(studno,name,idnum) values(30101,'대조영','8012301036613');

INSERT INTO student(studno,name,idnum) values(30102,'강감찬','8012301036613')
--오류

ALTER TABLE student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL);



--C는 NOT NULL이나 CHECK
SELECT *--CONSTRAINT_name , CONSTRAINT_TYPE
FROM user_CONSTRAINTs
WHERE table_name IN('SUBJECT','STUDENT');


