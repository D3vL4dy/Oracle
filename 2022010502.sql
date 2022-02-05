2022-0105-02)데이터타입
 - 오라클에 사용되는 데이터 타입은 문자열(''), 숫자(NUMBER), 날짜, 이진자료 등이 제공
  1. 문자열자료
   . 문자자료(' '로 묶인 자료)를 저장하기 위한 타입
   . 가변길이와 고정길이로 구분
   1)CHAR(n[BYTE|CHAR]) --[]생략가능
     . 고정길이 데이터 저장
     . 최대 2000 BYTE까지 처리 가능
     . 'n[BYTE|CHAR]' : 확보하는 저장공간의 크기 지정
       'BYTE'가 default이며 'CHAR'은 n이 문자갯수를 의미
     . 한글 한글자는 3BYTE 임
     . 보통 기본키나 길이가 고정되고 고정된 길이가 중요한 경우(주민번호나 우편번호 등)에 사용

 사용예)
    CREATE TABLE TEMP_01(
      COL1 CHAR(10 BYTE),
      COL2 CHAR(10 CHAR),
      COL3 CHAR(10));
      
    INSERT INTO TEMP_01(COL1,COL2,COL3)
      VALUES('대전시','대전시 중구 오류동','중구');
      
    INSERT INTO TEMP_01 VALUES('대한', '대한민국', '민국');  
    SELECT * FROM TEMP_01;
    
    --LENGTHB():()안의 길이를 BYTE로 나타냄
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
      FROM TEMP_01;
    
   2)VARCHAR2(n[BYTE|CHAR]) --[]생략가능
     . 가변길이 문자열 저장
     . VARCHAR와 동일기능 제공
     . 최대 4000BYTE 저장 가능
     . 사용자가 정의한 데이터를 저장하고 남는 기억공간은 반환
     . 가장 널리 사용되는 타입
     
 사용예)
    CREATE TABLE TEMP_02(
      COL1  VARCHAR2(4000 BYTE),
      COL2  VARCHAR2(4000 CHAR),
      COL3  VARCHAR2(4000));
    INSERT INTO TEMP_02 
      VALUES('IL POSTINO','PERSIMMON','APPLE');
      
    SELECT * FROM TEMP_02;
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
      FROM TEMP_02;

   3)LONG --길이 지정X
     . 가변길이 자료 저장
     . 최대 2GB까지 저장 가능
     . 일부 기능은 사용 불가
     . 한 테이블에 1개의 LONG 타입만 사용 가능(기능개선 중단)
     . CLOB 타입으로 대체
     . SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서만 사용 가능
     
 사용예)
    CREATE TABLE TEMP_03(
      COL1 LONG, --데이터의 위치나 크기를 나타낼 수 없음
      COL2 VARCHAR2(200));
      
    INSERT INTO TEMP_03 
      VALUES('대전시 중구 계룡로 846 3층', '대덕인재개발원');
      
    SELECT * FROM TEMP_03;
    SELECT --LENGTHB(COL1),
           --LENGTH(COL1), (CLOB는 LENGTH 가능)
           LENGTHB(COL2)
      FROM TEMP_03;
     
    SELECT --SUBSTR(COL2,2,5) 
           SUBSTR(COL2,2,5)
      FROM TEMP_03;     

   4)CLOB(Character Lasrge Objects) --길이 지정X
     . 가변길이 문자열을 저장
     . 최대 4GB 까지 처리 가능
     . 한 테이블에 복수개의 CLOB 사용 가능
     . 일부 기능은 DBMS_LOB API 지원을 받아야 함 (예 LENGTHB 등은 제한)
     
 사용예) 
    CREATE TABLE TEMP_04(
      COL1 CLOB,
      COL2 CLOB,
      COL3 VARCHAR2(4000));
      
    INSERT INTO TEMP_04
      VALUES('대전시 중구 계룡로 846 3층', '대덕인재개발원', 'ILPOSTINO');
        
    SELECT * FROM TEMP_04;  
    SELECT DBMS_LOB.GETLENGTH(COL1),
           LENGTH(COL2), --글자 수 
           LENGTHB(COL3) --글자가 점유하고 있는 기억공간을 BYTE수로 반환
      FROM TEMP_04;