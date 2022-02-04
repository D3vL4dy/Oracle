2022-0204-02)함수(User Defined Function : Function)
 - 특징은 PROCEDURE와 동일하나 반환값이 존재함
 - SELECT문의 SELECT절, WHERE절, UPDATE구문 등에 사용
 (사용형식)
  CREATE [OR REPLACE] FUNCTION 함수명[(
    변수명 [모드] 타입명 [:=[DEFAULT] 값][,]
                     :
    변수명 [모드] 타입명 [:=[DEFAULT] 값])
    RETURN 타입명
  AS|IS
    선언부;
  BEGIN
    실행부;
    RETURN expr;
    [EXCEPTION
        예외처리문;
    ]
  END;  
  
 (사용예)거래처코드를 입력받아 해당 거래처 정보를 조회하시오.(함수사용)
       Alias는 거래처코드, 상품코드, 상품명, 매입단가
   CREATE OR REPLACE FUNCTION FN_PROD_INFO(
     P_BID IN BUYER.BUYER_ID%TYPE)
     RETURN VARCHAR2
   IS
     V_RES VARCHAR2(100);
   BEGIN
     SELECT PROD_ID||' '||RPAD(PROD_NAME,20,' ')||
            LPAD(PROD_COST,8,' ')
       INTO V_RES
       FROM PROD
      WHERE PROD_BUYER=P_BID
        AND ROWNUM=1;
     RETURN V_RES;
     
     EXCEPTION 
       WHEN OTHERS THEN 
         DBMS_OUTPUT.PUT_LINE('에러발생'||SQLERRM);
         RETURN NULL;
   END; 
   
 (실행)
   SELECT BUYER_ID,
          BUYER_NAME,
          FN_PROD_INFO(BUYER_ID)
     FROM BUYER;
   
 (사용예)회원번호를 입력받아 회원명을 출력하는 함수 작성
   SELECT MEM_ID,
          MEM_NAME
     FROM MEMBER;
 
   CREATE OR REPLACE FUNCTION FN_MEM_NAME(
     P_MID IN MEMBER.MEM_ID%TYPE)
     RETURN MEMBER.MEM_NAME%TYPE
   IS
     V_NAME MEMBER.MEM_NAME%TYPE;
   BEGIN
     SELECT MEM_NAME INTO V_NAME
       FROM MEMBER
      WHERE MEM_ID=P_MID; 
     RETURN V_NAME; 
   END;
   
 (실행)
   SELECT MEM_ID AS 회원번호,
          FN_MEM_NAME(MEM_ID) AS 회원명
     FROM MEMBER;   