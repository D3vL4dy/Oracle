2022-0104-02)테이블 생성
 . CREATE TABLE 명령으로 생성
 (표현형식)
 CREATE TABLE 테이블명(
    컬럼명 데이터타입[(크기)] [NOT NULL] [DEFAULT 값] [,]
                            :
    컬럼명 데이터타입[(크기)] [NOT NULL] [DEFAULT 값] [,]                    
    [CONSTRAINT 기본키인덱스 PRIMARY KEY (컬럼명[,컬럼명,...])[,]
    [CONSTRAINT 외래키인덱스 FOREIGN KEY (컬럼명)
        REFERENCES 테이블명(컬럼명)[,]]
    [CONSTRAINT 외래키인덱스 FOREIGN KEY (컬럼명)
        REFERENCES 테이블명 (컬럼명)];
        
        
--데이터 입력은 자식 테이블 먼저 생성
 사용예)
    CREATE TABLE GOODS(
      GOOD_ID CHAR(4) NOT NULL,
      GOOD_NAME VARCHAR2(30),
      PRICE NUMBER(7),
      CONSTRAINT pk_goods PRIMARY KEY(GOOD_ID));
      
    CREATE TABLE CUSTOMERS(
      CUST_ID CHAR(3),
      CUST_NAME VARCHAR2(20),
      CUST_ADDR VARCHAR2(100),
      CONSTRAINT pk_customers PRIMARY KEY(CUST_ID));
      
    CREATE TABLE ORDERS(--135
      ORDER_ID CHAR(12), --기본키
      ORDER_DATE DATE DEFAULT SYSDATE,
      CUST_ID CHAR(3), --외래키
      CONSTRAINT pk_orders PRIMARY KEY(ORDER_ID),
      CONSTRAINT fk_orders_cust FOREIGN KEY(CUST_ID)
        REFERENCES CUSTOMERS(CUST_ID));
        
    CREATE TABLE ORDER_GOODS(
      ORDER_ID CHAR(12),
      GOOD_ID CHAR(4),
      ORDER_QTY NUMBER(4) DEFAULT 0,
      CONSTRAINT pk_ogoods PRIMARY KEY(ORDER_ID, GOOD_ID),
      CONSTRAINT fk_ogoods_order FOREIGN KEY(ORDER_ID)
        REFERENCES ORDERS(ORDER_ID),
      CONSTRAINT fk_ogoods_goods FOREIGN KEY(GOOD_ID)
        REFERENCES GOODS(GOOD_ID));