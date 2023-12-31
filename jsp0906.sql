------------------------------------------------------------------------      
                            -- DDL --
------------------------------------------------------------------------

/* 사원 */
CREATE TABLE sawon (
   sabun NUMBER(4) NOT NULL, /* 사번 */
   sawon_name VARCHAR2(30), /* 이름 */
   sal NUMBER(10), /* 급여 */
   handphone VARCHAR2(13) /* 전화NO */
);

CREATE UNIQUE INDEX PK_sawon
   ON sawon (
      sabun ASC
   );

ALTER TABLE sawon
   ADD
      CONSTRAINT PK_sawon
      PRIMARY KEY (
         sabun
      );

COMMENT ON TABLE sawon IS '사원';

COMMENT ON COLUMN sawon.sabun IS '사번';

COMMENT ON COLUMN sawon.sawon_name IS '이름';

COMMENT ON COLUMN sawon.sal IS '급여';

COMMENT ON COLUMN sawon.handphone IS '전화NO';

/* 제품 */
CREATE TABLE item (
   item_code NUMBER(4) NOT NULL, /* 제품코드 */
   item_name VARCHAR2(100), /* 제품명 */
   item_kind VARCHAR2(1), /* 제품단위 */
   item_desc VARCHAR2(1000), /* 제품내용 */
   item_price NUMBER(10), /* 가격 */
   item_birth DATE /* 제품출시 */
);

CREATE UNIQUE INDEX PK_item
   ON item (
      item_code ASC
   );

ALTER TABLE item
   ADD
      CONSTRAINT PK_item
      PRIMARY KEY (
         item_code
      );

COMMENT ON TABLE item IS '제품';

COMMENT ON COLUMN item.item_code IS '제품코드';

COMMENT ON COLUMN item.item_name IS '제품명';

COMMENT ON COLUMN item.item_kind IS '제품단위';

COMMENT ON COLUMN item.item_desc IS '제품내용';

COMMENT ON COLUMN item.item_price IS '가격';

COMMENT ON COLUMN item.item_birth IS '제품출시';

/* 주문 */
CREATE TABLE order1 (
   order_date VARCHAR2(8) NOT NULL, /* 주문일자 */
   custcode NUMBER(4) NOT NULL, /* 거래처코드 */
   order_desc VARCHAR2(500), /* 거래처요청내역 */
   sabun NUMBER(4), /* 사번 */
   order_status VARCHAR2(1) /* 주문상태 */
);

CREATE UNIQUE INDEX PK_order1
   ON order1 (
      order_date ASC,
      custcode ASC
   );

ALTER TABLE order1
   ADD
      CONSTRAINT PK_order1
      PRIMARY KEY (
         order_date,
         custcode
      );

COMMENT ON TABLE order1 IS '주문';

COMMENT ON COLUMN order1.order_date IS '주문일자';

COMMENT ON COLUMN order1.custcode IS '거래처코드';

COMMENT ON COLUMN order1.order_desc IS '거래처요청내역';

COMMENT ON COLUMN order1.sabun IS '사번';

COMMENT ON COLUMN order1.order_status IS '주문상태';

/* 거래처 */
CREATE TABLE custom (
   custcode NUMBER(4) NOT NULL, /* 거래처코드 */
   custname VARCHAR2(100), /* 거래처명 */
   cust_tel VARCHAR2(13), /* 거래처TEL */
   cust_gubun VARCHAR2(1), /* 거래처구분 */
   cust_ceo VARCHAR2(20) /* 거래처대표 */
);

CREATE UNIQUE INDEX PK_custom
   ON custom (
      custcode ASC
   );

ALTER TABLE custom
   ADD
      CONSTRAINT PK_custom
      PRIMARY KEY (
         custcode
      );

COMMENT ON TABLE custom IS '거래처';

COMMENT ON COLUMN custom.custcode IS '거래처코드';

COMMENT ON COLUMN custom.custname IS '거래처명';

COMMENT ON COLUMN custom.cust_tel IS '거래처TEL';

COMMENT ON COLUMN custom.cust_gubun IS '거래처구분';

COMMENT ON COLUMN custom.cust_ceo IS '거래처대표';

/* 주문상세 */
CREATE TABLE order1_detail (
   order_date VARCHAR2(8) NOT NULL, /* 주문일자 */
   custcode NUMBER(4) NOT NULL, /* 거래처코드 */
   item_code NUMBER(4) NOT NULL, /* 제품코드 */
   item_order_desc VARCHAR2(500), /* 제품요청내역 */
   cancel VARCHAR2(1) /* 반품구분 */
);

CREATE UNIQUE INDEX PK_order1_detail
   ON order1_detail (
      order_date ASC,
      custcode ASC,
      item_code ASC
   );

ALTER TABLE order1_detail
   ADD
      CONSTRAINT PK_order1_detail
      PRIMARY KEY (
         order_date,
         custcode,
         item_code
      );

COMMENT ON TABLE order1_detail IS '주문상세';

COMMENT ON COLUMN order1_detail.order_date IS '주문일자';

COMMENT ON COLUMN order1_detail.custcode IS '거래처코드';

COMMENT ON COLUMN order1_detail.item_code IS '제품코드';

COMMENT ON COLUMN order1_detail.item_order_desc IS '제품요청내역';

COMMENT ON COLUMN order1_detail.cancel IS '반품구분';

ALTER TABLE order1
   ADD
      CONSTRAINT FK_sawon_TO_order1
      FOREIGN KEY (
         sabun
      )
      REFERENCES sawon (
         sabun
      );

ALTER TABLE order1
   ADD
      CONSTRAINT FK_custom_TO_order1
      FOREIGN KEY (
         custcode
      )
      REFERENCES custom (
         custcode
      );

ALTER TABLE order1_detail
   ADD
      CONSTRAINT FK_order1_TO_order1_detail
      FOREIGN KEY (
         order_date,
         custcode
      )
      REFERENCES order1 (
         order_date,
         custcode
      );

ALTER TABLE order1_detail
   ADD
      CONSTRAINT FK_item_TO_order1_detail
      FOREIGN KEY (
         item_code
      )
      REFERENCES item (
         item_code
      );
      
------------------------------------------------------------------------      
                            -- DML --
------------------------------------------------------------------------
INSERT INTO SAWON values(1001, '강준우',3500, '010-2122-1456');
INSERT INTO SAWON values(1002, '강한빛',3600, '010-2322-2456');
INSERT INTO SAWON values(1003, '곽나희',3700, '010-2422-3456');
INSERT INTO SAWON values(1004, '곽승현',3800, '010-2622-4456');
INSERT INTO SAWON values(1005, '기도희',3900, '010-2522-5456');
INSERT INTO SAWON values(1006, '김용빈',3500, '010-2722-6456');
INSERT INTO SAWON values(1007, '김찬하',3100, '010-2822-7456');
INSERT INTO SAWON values(1008, '김태현',3200, '010-2922-8456');
INSERT INTO SAWON values(1009, '노보경',3300, '010-1232-9456');
INSERT INTO SAWON values(1010, '노상준',3400, '010-1222-0456');
INSERT INTO SAWON values(1011, '문경훈',3500, '010-2222-1456');
INSERT INTO SAWON values(1012, '민지혜',3600, '010-3222-3256');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5001, '준우상사', '02-2122-1456', '0', '박진기');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5002, '한빛상사', '02-2322-2456', '0', '석유림');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5003, '나희상사', '02-2422-3456', '0', '안영준');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5004, '승현상사', '02-2622-4456', '0', '엄민용');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5005, '도희상사', '02-2522-5456', '0', '유연아');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5006, '용빈상사', '02-2722-6456', '0', '유희라');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5007, '찬하상사', '02-2822-7456', '0', '윤상엽');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5008, '태현상사', '02-2922-8456', '0', '이광현');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5009, '보경상사', '02-1232-9456', '0', '이규현');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5010, '상준상사', '02-1222-0456', '0', '이금비');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5011, '경훈상사', '02-2222-1456', '0', '이진희');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5012, '지혜상사', '02-3222-3256', '0', '전준오');



INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7001', '브라우스', '39000', '레이스매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7002', '청치마', '35000', '청매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7003', '모자', '29000', '모매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7004', '스카프', '19000', '장미빛매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7005', '청바지', '50000', '매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7006', '와이셔스', '37000', '외매력', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7007', '운동화', '70000', '운매력', SYSDATE);

      
      
      
