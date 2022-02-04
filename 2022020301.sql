2022-0203-01)
2.WHILE 문 
 - 개발언어의 WHILE문과 같은 구조 및 기능 제공 
 
 (사용형식)
 WHILE 조건문 LOOP
    반복처리명령문(들);
    
    END LOOP; 
    .조건문의 판단 결과가 참이면 반복수행, 거짓이면 반복문을 
     벗어남 
-- 대부분의 반복문은 커서문과 함께 사용. 
사용예) 구구단의 6단을 WHILE문으로 구성하시오. 

    DECLARE 
        V_CNT NUMBER := 1;
        V_RES VARCHAR2(100);
    BEGIN 
        WHILE V_CNT <10 LOOP
        V_RES:= '6 * ' || V_CNT|| '='||V_CNT*6;
        DBMS_OUTPUT.PUT_LINE(V_RES);
        V_CNT:= V_CNT+1;
        END LOOP;
    END; 
    
사용예) 2005년도에 장바구니테이블에서 분류코드 'P102'에 속한
       상품들의 매출집계를 구하시오(커서이용) 
    Alias 상품코드, 상품명, 수량, 금액 
    
    ('P102'에 속한 상품코드)
    
    SELECT PROD_ID
    FROM PROD
    WHERE PROD_LGU='P102';
    
    DECLARE 
      V_PID PROD.PROD_ID%TYPE;
      V_PNAME PROD.PROD_NAME%TYPE;
      V_QTY NUMBER:=0; --수량합계
      V_AMT NUMBER:=0; --금액합계
      CURSOR CUR_CART01 IS SELECT PROD_ID
    FROM PROD
    WHERE PROD_LGU='P102';
    BEGIN
    OPEN CUR_CART01; 
    FETCH CUR_CART01 INTO V_PID;
    WHILE CUR_CART01%FOUND LOOP
    SELECT B.PROD_NAME, SUM(A.CART_QTY),SUM(A.CART_QTY*B.PROD_PRICE)
    INTO V_PNAME, V_QTY, V_AMT
    FROM CART A, PROD B
    WHERE B.PROD_ID = V_PID 
    AND A.CART_PROD = B.PROD_ID
    AND A.CART_NO LIKE '2005%'
    GROUP BY B.PROD_NAME;
    DBMS_OUTPUT.PUT_LINE('상품코드' || V_PID);
    DBMS_OUTPUT.PUT_LINE('상품명' || V_PNAME);
    DBMS_OUTPUT.PUT_LINE('수량' || V_QTY);
    DBMS_OUTPUT.PUT_LINE('금액' || V_AMT);
    DBMS_OUTPUT.PUT_LINE('------------------------');
    FETCH CUR_CART01 INTO V_PID;
    END LOOP;
    CLOSE CUR_CART01;
    END;

3. FOR 문 
 - 개발언어의 FOR문과 같은 기능 제공 
 - 반복 횟수가 중요하거나 반복횟수를 정확히 알고 있는 경우 사용 
 (사용형식- 일반 FOR문) 
    FOR 인덱스 IN[REVERSE] 초기값.. 최종값
    LOOP
        반복처리 명령문(들); 
        
    END LOOP; 
    . '인덱스' : 제어변수 역할(시스템에서 자동 생성) 
    . 'REVERSE' : 역순으로 반복하는 경우 
    . '초기값.. 최종값' : 초기값부터 최종값까지 1씩 증가시켜 인덱스에 할당 
    
사용예) 구구단의 6단을 출력 

    DECLARE 
    
    BEGIN
     FOR I IN 1..9 LOOP 
        DBMS_OUTPUT.PUT_LINE('6 * '||I||' = ' || 6*I);
     END LOOP;
    END;  

(사용형식- 커서 FOR문) 
    FOR 레코드명  IN 커서명 | 커서문 
    LOOP
        반복처리 명령문(들); 
        
    END LOOP;     
    . CURSOR문을 FOR문을 이용하여 처리하는 경우 OPEN/FETCH/CLOSE문 생략 
    . 커서 선언문도 FOR문 안에 IN-LINE 서브쿼리형식으로 기술 가능 
    . 커서내의 컬럼은 '레코드명.컬럼명'으로 참조 한다. 