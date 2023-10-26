------------------------------------------------------------------------      
                            -- DDL --
------------------------------------------------------------------------

/* ��� */
CREATE TABLE sawon (
   sabun NUMBER(4) NOT NULL, /* ��� */
   sawon_name VARCHAR2(30), /* �̸� */
   sal NUMBER(10), /* �޿� */
   handphone VARCHAR2(13) /* ��ȭNO */
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

COMMENT ON TABLE sawon IS '���';

COMMENT ON COLUMN sawon.sabun IS '���';

COMMENT ON COLUMN sawon.sawon_name IS '�̸�';

COMMENT ON COLUMN sawon.sal IS '�޿�';

COMMENT ON COLUMN sawon.handphone IS '��ȭNO';

/* ��ǰ */
CREATE TABLE item (
   item_code NUMBER(4) NOT NULL, /* ��ǰ�ڵ� */
   item_name VARCHAR2(100), /* ��ǰ�� */
   item_kind VARCHAR2(1), /* ��ǰ���� */
   item_desc VARCHAR2(1000), /* ��ǰ���� */
   item_price NUMBER(10), /* ���� */
   item_birth DATE /* ��ǰ��� */
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

COMMENT ON TABLE item IS '��ǰ';

COMMENT ON COLUMN item.item_code IS '��ǰ�ڵ�';

COMMENT ON COLUMN item.item_name IS '��ǰ��';

COMMENT ON COLUMN item.item_kind IS '��ǰ����';

COMMENT ON COLUMN item.item_desc IS '��ǰ����';

COMMENT ON COLUMN item.item_price IS '����';

COMMENT ON COLUMN item.item_birth IS '��ǰ���';

/* �ֹ� */
CREATE TABLE order1 (
   order_date VARCHAR2(8) NOT NULL, /* �ֹ����� */
   custcode NUMBER(4) NOT NULL, /* �ŷ�ó�ڵ� */
   order_desc VARCHAR2(500), /* �ŷ�ó��û���� */
   sabun NUMBER(4), /* ��� */
   order_status VARCHAR2(1) /* �ֹ����� */
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

COMMENT ON TABLE order1 IS '�ֹ�';

COMMENT ON COLUMN order1.order_date IS '�ֹ�����';

COMMENT ON COLUMN order1.custcode IS '�ŷ�ó�ڵ�';

COMMENT ON COLUMN order1.order_desc IS '�ŷ�ó��û����';

COMMENT ON COLUMN order1.sabun IS '���';

COMMENT ON COLUMN order1.order_status IS '�ֹ�����';

/* �ŷ�ó */
CREATE TABLE custom (
   custcode NUMBER(4) NOT NULL, /* �ŷ�ó�ڵ� */
   custname VARCHAR2(100), /* �ŷ�ó�� */
   cust_tel VARCHAR2(13), /* �ŷ�óTEL */
   cust_gubun VARCHAR2(1), /* �ŷ�ó���� */
   cust_ceo VARCHAR2(20) /* �ŷ�ó��ǥ */
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

COMMENT ON TABLE custom IS '�ŷ�ó';

COMMENT ON COLUMN custom.custcode IS '�ŷ�ó�ڵ�';

COMMENT ON COLUMN custom.custname IS '�ŷ�ó��';

COMMENT ON COLUMN custom.cust_tel IS '�ŷ�óTEL';

COMMENT ON COLUMN custom.cust_gubun IS '�ŷ�ó����';

COMMENT ON COLUMN custom.cust_ceo IS '�ŷ�ó��ǥ';

/* �ֹ��� */
CREATE TABLE order1_detail (
   order_date VARCHAR2(8) NOT NULL, /* �ֹ����� */
   custcode NUMBER(4) NOT NULL, /* �ŷ�ó�ڵ� */
   item_code NUMBER(4) NOT NULL, /* ��ǰ�ڵ� */
   item_order_desc VARCHAR2(500), /* ��ǰ��û���� */
   cancel VARCHAR2(1) /* ��ǰ���� */
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

COMMENT ON TABLE order1_detail IS '�ֹ���';

COMMENT ON COLUMN order1_detail.order_date IS '�ֹ�����';

COMMENT ON COLUMN order1_detail.custcode IS '�ŷ�ó�ڵ�';

COMMENT ON COLUMN order1_detail.item_code IS '��ǰ�ڵ�';

COMMENT ON COLUMN order1_detail.item_order_desc IS '��ǰ��û����';

COMMENT ON COLUMN order1_detail.cancel IS '��ǰ����';

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
INSERT INTO SAWON values(1001, '���ؿ�',3500, '010-2122-1456');
INSERT INTO SAWON values(1002, '���Ѻ�',3600, '010-2322-2456');
INSERT INTO SAWON values(1003, '������',3700, '010-2422-3456');
INSERT INTO SAWON values(1004, '������',3800, '010-2622-4456');
INSERT INTO SAWON values(1005, '�⵵��',3900, '010-2522-5456');
INSERT INTO SAWON values(1006, '����',3500, '010-2722-6456');
INSERT INTO SAWON values(1007, '������',3100, '010-2822-7456');
INSERT INTO SAWON values(1008, '������',3200, '010-2922-8456');
INSERT INTO SAWON values(1009, '�뺸��',3300, '010-1232-9456');
INSERT INTO SAWON values(1010, '�����',3400, '010-1222-0456');
INSERT INTO SAWON values(1011, '������',3500, '010-2222-1456');
INSERT INTO SAWON values(1012, '������',3600, '010-3222-3256');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5001, '�ؿ���', '02-2122-1456', '0', '������');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5002, '�Ѻ����', '02-2322-2456', '0', '������');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5003, '������', '02-2422-3456', '0', '�ȿ���');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5004, '�������', '02-2622-4456', '0', '���ο�');

INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5005, '������', '02-2522-5456', '0', '������');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5006, '�����', '02-2722-6456', '0', '�����');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5007, '���ϻ��', '02-2822-7456', '0', '����');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5008, '�������', '02-2922-8456', '0', '�̱���');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5009, '������', '02-1232-9456', '0', '�̱���');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5010, '���ػ��', '02-1222-0456', '0', '�̱ݺ�');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5011, '���ƻ��', '02-2222-1456', '0', '������');
INSERT INTO custom (CUSTCODE, CUSTNAME, CUST_TEL, CUST_GUBUN, CUST_CEO)VALUES 
(5012, '�������', '02-3222-3256', '0', '���ؿ�');



INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7001', '���콺', '39000', '���̽��ŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7002', 'ûġ��', '35000', 'û�ŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7003', '����', '29000', '��ŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7004', '��ī��', '19000', '��̺��ŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7005', 'û����', '50000', '�ŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7006', '���̼Ž�', '37000', '�ܸŷ�', SYSDATE);

INSERT INTO item (ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_DESC, ITEM_BIRTH) VALUES
('7007', '�ȭ', '70000', '��ŷ�', SYSDATE);

      
      
      
