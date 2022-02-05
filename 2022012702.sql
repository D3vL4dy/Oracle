2022-0127-02)반복문
 - 오라클에서 제공하는 반복문은 LOOP(조건이 맞으면 반복을 벗어남), WHILE(조건이 맞을 때 반복), FOR 문이 있음
 --대부분 커서와 같이 사용

 1. LOOP
  - 반복문의 기본 구조 제공
  - 무한 루프
  - JAVA의 DO문과 유사
  (사용형식)
  LOOP
   반복처리 명령문(들);
  [EXIT WHEN 조건;]
        :
  END LOOP;
   . EXIT WHEN 조건 : '조건'이 참인 경우 반복문을 벗어남
   
 사용예)구구단의 6단을 LOOP문을 이용하여 작성
    DECLARE
      V_CNT NUMBER:=1;
    BEGIN
      LOOP
        EXIT WHEN V_CNT>9;
        DBMS_OUTPUT.PUT_LINE('6 * ' ||V_CNT||'='||V_CNT*6);
        V_CNT:=V_CNT+1;
      END LOOP;
    END;  
    
 사용예)상품테이블에서 분류코드 'P102'에 속한 상품정보를 모두 삭제하시오.
       'P102'에 속한 상품코드는 'P102000001'부터 'P102000007'이다.
       
    DECLARE
      V_START NUMBER:=0; --시작값(6자리수)
      V_END   NUMBER:=0; --끝값(6자리수)
      V_CNT   NUMBER:=0; --상품코드를 1씩 증가시킬 값
      V_PID GOODS.PROD_ID%TYPE; --(상품코드) 
      
    BEGIN
      SELECT MIN(TO_NUMBER(SUBSTR(PROD_ID,5))) INTO V_START
        FROM GOODS 
       WHERE PROD_LGU = 'P102';
      V_CNT:=V_START; 
       
      SELECT MAX(TO_NUMBER(SUBSTR(PROD_ID,5))) INTO V_END
        FROM GOODS 
       WHERE PROD_LGU = 'P102'; 
      
      LOOP
        EXIT WHEN V_CNT>V_END;
        V_PID:='P102'||TRIM(TO_CHAR(V_CNT,'000000')); 
        DELETE FROM GOODS
         WHERE PROD_ID=V_PID;
        V_CNT:=V_CNT+1;
      END LOOP;
    END;  
    ROLLBACK;   