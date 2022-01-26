2022-0125-02)오라클객체
 - 오라클에서 제공하는 OBJECT로 VIEW,INDEX,PROCEDURE,FUNCTION,PACKAGE,TRIGGER,SYNONYM,SEQUENCE,DIRECTORY 등이 있음
 - 생성시 CREATE, 제거시 DROP 명령 사용
 
 1.VIEW
  - 가상의 테이블
  - 기존의 테이블이나 뷰를 통하여 새로운 SELECT 문의 결과를 테이블처럼 사용
  - 테이블과 독립적
  - 필요한 정보가 여러 테이블에 분산된 경우
  - 테이블의 모든 자료에 대한 접근을 제한하고 필요한 자료만을 제공하는 경우
  - VIEW 는 UPDATE, INSERT, DELETE 불가
  
 (사용형식) 
    CREATE [OR REPLACE] VIEW 뷰이름[(컬럼list)] --컬럼list > SELECT 문 별칭 > SELECT 문 컬럼명 순으로 뷰의 컬럼명 설정
    AS
      SELECT 문
     [WITH CHECK OPTION] --변경되어지는 상황에서 적용
     [WITH READ ONLY]; --VIEW를 수정해도 원본이 수정되는 것을 방지하기 위해 읽기전용으로 
     -- [WITH CHECK OPTION] [WITH READ ONLY] 동시 사용 불가
     
 사용예)회원테이블에서 마일리지가 2000이상인 회원의 회원번호,이름,직업,마일리지로 구성된 뷰를 생성하시오.
    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
    AS
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 이름,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE >= 2000; 
       
      SELECT * FROM V_MEM; 
     
     --컬럼명:별칭
    CREATE OR REPLACE VIEW V_MEM
    AS
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 이름,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE >= 2000; 
       
      SELECT * FROM V_MEM;     
     
     --컬럼명:SELECT문의 컬럼명
    CREATE OR REPLACE VIEW V_MEM
    AS
      SELECT MEM_ID,
             MEM_NAME,
             MEM_JOB,
             MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_MILEAGE >= 2000; 
       
      SELECT * FROM V_MEM;     
     
 사용예)생성된 뷰 V_MEM에서 'r001'회원의 마일리지를 500으로 변경하시오.    
     --MEM_MILEAGE >= 2000을 조건으로 뷰를 생성했는데 조건이 맞지 않아 자료가 삭제됨
    UPDATE V_MEM
       SET MEM_MILEAGE = 500
     WHERE MEM_ID = 'r001';
     
    SELECT * FROM V_MEM;
    
    SELECT MEM_ID, MEM_MILEAGE
      FROM MEMBER
     WHERE MEM_ID = 'r001';
  ROLLBACK;   
     
     
    CREATE OR REPLACE VIEW V_MEM
    AS
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 이름,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE >= 2000
      WITH CHECK OPTION; 
      
 사용예)뷰 V_MEM의 'r001'회원의 마일리지를 1500으로 변경하시오.
    UPDATE V_MEM
       SET 마일리지 = 1500
     WHERE 회원번호 = 'r001'; 
     
  ** 회원테이블에서 'n001'회원의 마일리지를 2500으로 변경하시오.   
    UPDATE MEMBER
       SET MEM_MILEAGE = 2500
     WHERE MEM_ID = 'n001'; 
    SELECT * FROM V_MEM;
    
  ** 회원테이블에서 'f001'회원의 마일리지를 1500으로 변경하시오.    
    UPDATE MEMBER
       SET MEM_MILEAGE = 1500
     WHERE MEM_ID = 'f001'; 
     ROLLBACK;
     COMMIT;
    
     
 CREATE OR REPLACE VIEW V_MEM
    AS
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 이름,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE >= 2000
      WITH READ ONLY
      WITH CHECK OPTION;
      
 ** 생성된 뷰 V_MEM의 모든 자료를 삭제하시오.
    DELETE FROM V_MEM;
    
 ** VIEW 사용시 주의할 점
   (1) VIEW 생성시 WITH절을 사용한 제약조건이 부여된 경우 ORDER BY 절 사용 불가
   (2) VIEW 생성에 집계함수가 사용된 경우 뷰에 INSERT, UPDATE, DELETE 를 사용할 수 없음 
   (3) VIEW 의 컬럼이 표현식 (CASE~WHEN)이나 함수가 사용도니 경우 컬럼추가 또는 수정이 불가 
   (4) Pseudo Column(CURVAL, NEXTVAL 등) 사용 불가
   
 사용예)
    CREATE OR REPLACE VIEW V_CART
    AS
      SELECT CART_PROD AS CID,
             COUNT(*) AS CNT --구매 횟수
        FROM CART
       WHERE CART_NO LIKE '200505%'
       GROUP BY CART_PROD
       ORDER BY 1;
     
     SELECT * FROM V_CART;
     
     UPDATE V_CART
        SET CNT = 10
      WHERE CID = 'P101000001';  
      
 사용예)
    CREATE OR REPLACE VIEW V_MEM02
    AS
      SELECT MEM_ID AS MID,
             MEM_NAME AS MNAME,
             CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                       SUBSTR(MEM_REGNO2,1,1) = '3' THEN 
                       '남성'
             ELSE
                       '여성'
             END AS GUBUN
        FROM MEMBER; 
        
      SELECT * FROM V_MEM02;  
        
    UPDATE V_MEM02
       SET GUBUN = '여성회원'
     WHERE GUBUN = '여성'; 
      
      