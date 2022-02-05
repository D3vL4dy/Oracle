2022-0106-02)날짜 자료형
 - 년, 월, 일, 시, 분, 초 등의 자료를 저장
 - 날짜형은 '+', '-' 연산이 가능
 - 기본 날짜형 : DATE, 시간대정보를 포함하는 TIMESTAMP형이 제공
 1) DATE
  . 기본날짜 타입
  . SYSDATE : 날짜함수로 시스템의 시각정보를 제공
  
 사용예)
    CREATE TABLE TEMP_05(
      COL1 DATE,
      COL2 DATE,
      COL3 DATE);
    
    INSERT INTO TEMP_05
      VALUES(SYSDATE, SYSDATE-5, '20100106'); --문자열은 날짜형으로 자동 형변환
      
    INSERT INTO TEMP_05
      VALUES(SYSDATE, SYSDATE+30, '20100228'); --날짜 유효성 검사 후 저장

    SELECT * FROM TEMP_05;
    
    (시각정보 출력 :TO_CHAR())
    SELECT TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS')
      FROM TEMP_05;
      
 2) TIMESTAMP      
  . 정교한 날짜정보(시간대 정보, 10억분의 1초) 제공
  . TIMESTAMP : 시간대 정보 없음
    TIMESTAMP WITH TIME ZONE : 시간대정보 포함
    TIMESTAMP WITH LOCAL TIME ZONE : 로컬서버가 위치한 시간대정보=>TIMESTAMP와 동일
    
 사용예)
    CREATE TABLE TEMP_06(
      COL1 TIMESTAMP,
      COL2 TIMESTAMP WITH TIME ZONE,
      COL3 TIMESTAMP WITH LOCAL TIME ZONE);
      
    INSERT INTO TEMP_06 VALUES(SYSDATE,SYSDATE,SYSDATE);  
    
    SELECT * FROM TEMP_06;