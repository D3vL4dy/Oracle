2022-0121-01)
 
 사용예)모든 부서별 인원수를 조회하시오.
       Alias 부서코드,부서명,인원수
       --일반 외부조인이나 ANSI 외부조인으로 할 수 없는 문제 FULL OUTER 조인 사용
       (외부 조인)
       SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'미배정') AS 부서코드,
              NVL(B.DEPARTMENT_NAME,'프리랜서') AS 부서명,
              COUNT(EMPLOYEE_ID) AS 인원수 --컬럼명을 사용하면 NULL은 카운트하지 않음.
              --COUNT(기본키) 사용
         FROM HR.EMPLOYEES A --부서코드:11개 (DEPART가 가진 부서코드 총 17개 부족)
             -- HR.DEPARTMENTS B --부서코드:27개 (EMP가 가진 NULL 1개)
         FULL OUTER JOIN HR.DEPARTMENTS B
              ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY B.DEPARTMENT_ID;
              
         
 (EMPLOYEES테이블에 사용된 부서) --전체 12개(NULL 포함)
   SELECT DISTINCT DEPARTMENT_ID --EMP 테이블에 있는 부서코드를 중복하지 않고 출력
     FROM HR.EMPLOYEES
    ORDER BY 1;  
    
 사용예)2005년 모든 상품별 매입/매풀수량을 집계하시오. --서브쿼리 사용
       Alias 상품코드,상품명,매입수량,매출수량
       
  (2005년 매입수량 집계)      
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          SUM(A.BUY_QTY) AS 매입수량
     FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
           A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
     GROUP BY B.PROD_ID, B.PROD_NAME   
     ORDER BY 1;
     
  (2005년 매출수량 집계)      
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          SUM(A.CART_QTY) AS 매출수량
     FROM CART A
     RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID AND
           A.CART_NO LIKE '2005%')
     GROUP BY B.PROD_ID, B.PROD_NAME   
     ORDER BY 1;     
           
  (한문장으로 구성)--조건 2개를 동시에 진행하면 수량이 맞지 않음 > 서브쿼리 사용
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          SUM(A.BUY_QTY) AS 매입수량,
          SUM(C.CART_QTY) AS 매출수량
     FROM BUYPROD A
    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
           A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
    LEFT OUTER JOIN CART C ON(C.CART_PROD = B.PROD_ID AND
           C.CART_NO LIKE '2005%')           
    GROUP BY B.PROD_ID, B.PROD_NAME   
    ORDER BY 1;
 
  (SUBQUERY 사용)
   SELECT A.PROD_ID AS 상품코드,
          A.PROD_NAME AS 상품명,
           AS 매입수량,
           AS 매출수량
     FROM PROD A,
          (2005년 상품별 매입수량집계) B,
          (2005년 상품별 매출수량집계) C
    WHERE A.PROD_ID = B.상품코드(+) --A를 기준으로 B가 확장
      AND A.PROD_ID = C.상품코드(+) --A를 기준으로 C가 확장
    ORDER BY 1;  
 
 
   SELECT A.PROD_ID AS 상품코드,
          A.PROD_NAME AS 상품명,
          NVL(B.BSUM,0) AS 매입수량,
          NVL(C.CSUM,0) AS 매출수량
     FROM PROD A,
          (SELECT BUY_PROD AS BID,
                  SUM(BUY_QTY) AS BSUM
             FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND ('20051231')
            GROUP BY BUY_PROD) B,
          (SELECT CART_PROD AS CID,
                  SUM(CART_QTY) AS CSUM
             FROM CART
            WHERE CART_NO LIKE '2005%'
            GROUP BY CART_PROD) C
    WHERE A.PROD_ID = B.BID(+) --A를 기준으로 B가 확장
      AND A.PROD_ID = C.CID(+) --A를 기준으로 C가 확장
    ORDER BY 1; 