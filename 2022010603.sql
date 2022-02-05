2022-0106-03)기타 자료형
 - 2진 자료를 저장
 - RAW, BLOB, BFILE 타입 제공
 - 오라클에서 해석이나 변환은 수행하지 않음
 
 1)RAW(크기)
  . 작은규모의 2진자료 저장
  . 최대 2000BYTE 까지 저장 가능
  . 인덱스 처리 가능
  . 16진수와 2진수 저장
  
 사용예)  
    CREATE TABLE TEMP_07(
      COL1  RAW(2000),
      COL2  RAW(500));
      
    INSERT INTO TEMP_07 VALUES(HEXTORAW('a5C7FF25'),
                               '10100101110001111111111100100101');
                               
    SELECT * FROM TEMP_07;                           

 2)BFILE
  . 이진자료 저장
  . 대상자료는 데이터베이스 밖에 저장되고 데이터베이스에는 경로정보 저장
  . 최대 4GB 저장 가능
  
 사용형식)
    컬럼명 BFILE
     . 보통 디렉토리객체를 생성하여 사용

 사용예)
    1.테이블생성
     CREATE TABLE TEMP_08(
       COL1 BFILE);
       
    2.그림파일 준비
    
    3.디렉토리객체 생성
     CREATE DIRECTORY 별칭 AS '절대경로명'
    
     CREATE DIRECTORY TEST_DIR
         AS 'D:\A_TeachingMaterial\02_Oracle\workspace';
    4.데이터 삽입
     INSERT INTO TEMP_08
       VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
       
     SELECT * FROM TEMP_08;

 3)BLOB(Binary Large OBjects)
  . 원본자료를 테이블 내부에 저장
  . 2진자료 저장형식
  . 최대 4GB까지 저장 가능
  
 사용형식)
   컬럼명 BLOB
   
 사용예)
  1. 테이블 생성
   CREATE TABLE TEMP_09(
     COL1 BLOB);
  
  2. 익명블록 작성-자료삽입
   DECLARE --선언부
    L_DIR   VARCHAR2(20) := 'TEST_DIR';
    L_FILE  VARCHAR2(30) := 'SAMPLE.jpg';
    L_BFILE BFILE;
    L_BLOB  BLOB;
   BEGIN --실행부
    INSERT INTO TEMP_09(COL1) VALUES(EMPTY_BLOB())
      RETURN COL1 INTO L_BLOB;
   
    L_BFILE := BFILENAME(L_DIR, L_FILE);
    DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
    DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
    DBMS_LOB.FILECLOSE(L_BFILE);
    
    COMMIT;
   END;
   
   SELECT * FROM TEMP_09;