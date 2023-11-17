
-- 팀프로젝트 1번에 대한 작업 인원들(경훈이 형꺼 그대로 갖고온거)

INSERT INTO USER_INFO 
(USER_ID, CLASS_ID, PROJECT_ID, USER_PW, USER_NAME, USER_GENDER, USER_NUMBER, USER_BIRTH, USER_ADDRESS, USER_EMAIL, USER_AUTH, ATTACH_NAME, ATTACH_PATH, DEL_STATUS, CHAT_ROOM_SES) VALUES 
('owen123', 1, '1', 'tiger', '김진명', 'M', '010-4839-2232', '98/08/13', '서울특별시 중랑구 면목로44나길 7(면목동) 02213', 'owen123@gmail.com', 'student', 'user_default.png', 'upload', 0, '');
INSERT INTO USER_INFO 
(USER_ID, CLASS_ID, PROJECT_ID, USER_PW, USER_NAME, USER_GENDER, USER_NUMBER, USER_BIRTH, USER_ADDRESS, USER_EMAIL, USER_AUTH, ATTACH_NAME, ATTACH_PATH, DEL_STATUS, CHAT_ROOM_SES) VALUES 
('jacob332', 1, '1', 'tiger', '서민수', 'M', '010-7739-9982', '92/08/13', '경기도 광주시 도척면 고녹길 158 12815', 'jacob332@naver.com', 'student', 'user_default.png', 'upload', 0, '');
INSERT INTO USER_INFO 
(USER_ID, CLASS_ID, PROJECT_ID, USER_PW, USER_NAME, USER_GENDER, USER_NUMBER, USER_BIRTH, USER_ADDRESS, USER_EMAIL, USER_AUTH, ATTACH_NAME, ATTACH_PATH, DEL_STATUS, CHAT_ROOM_SES) VALUES 
('isaac774', 1, '1', 'tiger', '김민정', 'F', '010-3827-5999', '94/10/13', '서울특별시 도봉구 도봉로164길 26-24(도봉동) 01326', 'isaac774@daum.net', 'student', 'user_default.png', 'upload', 0, '');

INSERT INTO USER_INFO 
(USER_ID, CLASS_ID, PROJECT_ID, USER_PW, USER_NAME, USER_GENDER, USER_NUMBER, USER_BIRTH, USER_ADDRESS, USER_EMAIL, USER_AUTH, ATTACH_NAME, ATTACH_PATH, DEL_STATUS, CHAT_ROOM_SES) VALUES 
('levi9232', 1, '1', 'tiger', '김난주', 'M', '010-8587-8832', '96/1/23', '서울특별시 서대문구 포방터6길 9(홍은동) 03606', 'levi9232@gmail.com', 'student', 'user_default.png', 'upload', 0, '');


------------------------------------     팀프로젝트 1번에 대한 작업들    ----------------- -----------------
        -- 팀프로젝트 1번에 프로젝트 1단계에 대한 작업
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('1', '1', '1', 'owen123', '요구사항 정의 ', '요구사항을 도출하고 검토하고 명세하고 샤샤샤 ', TO_DATE('2023-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '1', '0');
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('2', '1', '1', 'owen123', 'ERD 설계', '테이블 먼저 만들고 왜래키 만들고 정규화하고 교수님한테 검토받고 깨지고....', TO_DATE('2023-09-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-10-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '0', '0', '0');


        
         -- 팀프로젝트 1번에 프로젝트 2단계에 대한 작업
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('3', '1', '2', 'jacob332', 'ERD 정규화', 'ERD 정규화작업 먼저 단일키와 복합키 유무를 결정하고 테이블을 필요에 따라 분리합니다.......', TO_DATE('2023-11-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '1', '0');
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('4', '1', '2', 'isaac774', 'ERD 정규화 마무리 작업', '정규화 작업 마무리하고 교수님게 최종 검토 받을  준비 하기 ', TO_DATE('2023-11-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '1', '0');
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('5', '1', '2', 'levi9232', '프로젝트 구조 설꼐', '먼저 하나의 컴퓨터에서 프로젝트 하나 생성후 STATIC이나 VIEW 네이밍룰 같은거 결정하는 작업 ', TO_DATE('2023-11-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '1', '0');


        -- 팀프로젝트 1번에 프로젝트 3단계에 대한 작업
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('6', '1', '3', 'levi9232', '각자 맡은 부분 코딩하기 ', '이제 코딩시작이고 각자 맡은 부분에 가장 핵심적인 부분을 중점적으로 코딩하기 ', TO_DATE('2023-11-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '2', '0');
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('7', '1', '3', 'isaac774', '1차통합', '먼저 각자 기능 구현한거(코딩) 오류 ㅊ최대한 잡아서 1차 통합시작 그리고 통합후 안되는 오류 검토후 최종 배포 ', TO_DATE('2023-11-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '2', '0');


        -- 팀프로젝트 1번에 프로젝트 4단계에 대한 작업
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('8', '1', '4', 'owen123', '2차 작업 (구현) ', '1차 배포된 것을 토대로 다시 각자 맡은 부분 구현하기  구현하면서 테이블 업데이트나 공통적이 부분 수정시 꼭 말해주기 ', TO_DATE('2023-11-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '2', '0');
INSERT INTO TASK (TASK_ID, PROJECT_ID, PROJECT_STEP_SEQ, USER_ID, TASK_SUBJECT, TASK_CONTENT, TASK_STAT_TIME, TASK_END_ITME, TASK_PRIORITY, TASK_STATUS, GARBAGE) VALUES ('9', '1', '4', 'owen123', '2차 통합(디자인)', '2치 통합후 에러 제거후  디자인쪽도 어떤식으로 할지 회의해서 정하기 ', TO_DATE('2023-11-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-11-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '0', '1', '0');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 작업1번에 대한 공동 작업자들 
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (1,1,'jacob332');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (1,1,'isaac774');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (1,1,'levi9232');

-- 작업 2번에 대한 공동작업자들
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (2,1,'isaac774');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (2,1,'levi9232');


-- 작업 5번에 대한 공동작업자들
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (5,1,'jacob332');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (5,1,'isaac774');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (5,1,'owen123');


-- 작업 6번에 대한 공동작업자들
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES( 6,1,'jacob332');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (6,1,'isaac774');


-- 작업 8번에 대한 공동작업자들
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (8,1,'jacob332');
INSERT INTO TASK_SUB (TASK_ID, PROJECT_ID, WORKER_ID) VALUES (8,1,'isaac774');







