2022-0208-02)
 ** CART테이블에 다음 자료를 저장하시오.
    구매일자 : 오늘
    구매회원 : d001
    구매상품
    -------------------
     상품번호      수량
    -------------------
    P201000003     3
    P201000015     2
    P301000003     4
    P302000016     3
  
    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
      P_DATE DATE)
      RETURN VARCHAR2
    IS
      V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD');
      V_FLAG NUMBER:=0;
    BEGIN
      SELECT COUNT(*) INTO V_FLAG
        FROM CART
       WHERE SUBSTR(CART_NO,1,8)=V_CNO; --같은 값이 있으면 V_FLAG에 넣기
       
      IF V_FLAG=0 THEN --판매자료가 하나도 없음 
         V_CNO:=V_CNO||TRIM('00001');
      ELSE
         SELECT MAX(CART_NO)+1 INTO V_CNO
           FROM CART
          WHERE SUBSTR(CART_NO,1,8)=V_CNO;
      END IF;
      RETURN V_CNO;
    END;

 (실행)
 --CART테이블에 문자열로 구성된 CARTNO를 자동으로 생성
    SELECT FN_CREATE_CARTNO(SYSDATE)
      FROM DUAL;
      
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
           FN_CREATE_CARTNO(TO_DATE('20050513')) 
      FROM DUAL;     
      
      
 ** CART테이블에 다음 자료를 저장하시오.
    구매일자 : 오늘(20050728)
    구매회원 : d001
    구매상품     
    -------------------
     상품번호      수량
    -------------------
    P201000003     3
    P201000015     2
    
   INSERT INTO CART
     VALUES('d001',FN_CREATE_CARTNO(TO_DATE('20050728')), 'P201000003', 3);
            
   UPDATE CART
      SET CART_QTY=30
    WHERE CART_NO='2005072800005'
      AND CART_PROD='P201000003';
      
   DELETE FROM CART
    WHERE CART_NO='2005072800005'
      AND CART_PROD='P201000003';
      
    
    --트리거에서 처리해야 할 내용 : 재고 UPDATE, 마일리지 UPDATE
    CREATE OR REPLACE TRIGGER TG_CART_CHANGE
      AFTER  INSERT OR UPDATE OR DELETE  ON CART
      FOR EACH ROW
    DECLARE  
      V_QTY NUMBER:=0; --재고를 변경할 최종 수량
      V_PID PROD.PROD_ID%TYPE; --상품코드
      V_MILE NUMBER:=0; --마일리지
      V_DATE DATE; --날짜
      V_MID MEMBER.MEM_ID%TYPE; --회원번호
    BEGIN
      IF INSERTING THEN --신규판매자료
         V_QTY:=:NEW.CART_QTY;
         V_PID:=:NEW.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
         V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF UPDATING THEN --판매수량변경
         V_QTY:=:NEW.CART_QTY - :OLD.CART_QTY;
         V_PID:=:NEW.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
         V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF DELETING THEN --판매취소
         V_QTY:=-(:OLD.CART_QTY);
         V_PID:=:OLD.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
         V_MID:=:OLD.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      END IF;
         UPDATE REMAIN
            SET REMAIN_O=REMAIN_O+V_QTY,
                REMAIN_J_99=REMAIN_J_99-V_QTY,
                REMAIN_DATE=V_DATE
          WHERE PROD_ID=V_PID
            AND REMAIN_YEAR=EXTRACT(YEAR FROM V_DATE);
          
         UPDATE MEMBER
            SET MEM_MILEAGE=MEM_MILEAGE+V_MILE
          WHERE MEM_ID=V_MID;
    END;
    
  ROLLBACK;  
    
 (재고조회)
    SELECT * FROM REMAIN
     WHERE PROD_ID='P201000003';
     
    SELECT MEM_MILEAGE
      FROM MEMBER
     WHERE MEM_ID='d001'; 
     
     COMMIT;
