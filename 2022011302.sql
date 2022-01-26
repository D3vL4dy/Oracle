2022-0113-02)NULL처리함수
 - NULL은 길이가 없는 자료
 - 연산에 NULL이 사용되면 모든 결과는 NULL이다.
 - NULL 관련 함수는 NVL, NVL2, NULLIF와 데이터가 NULL과 같은지 판단을 위해 IS NULL, IS NOT NULL 두 연산자가 제공됨
 
 1. IS NULL, IS NOT NULL
  . NULL값과 동등성 평가를 위한 연산자
  . NULL은 '=' 연산자로 판별 불가능
  
 사용예)사원테이블에서 영업실적코드(COMMISSION_PCT)가 NULL이 아닌 사원을 조회하시오
       Alias 사원번호,사원명,부서코드,영업실적코드
       SELECT EMPLOYEE_ID AS 사원번호,
              EMP_NAME AS 사원명,
              DEPARTMENT_ID AS 부서코드,
              COMMISSION_PCT AS 영업실적코드
         FROM HR.EMPLOYEES
        WHERE COMMISSION_PCT IS NOT NULL; 
         
 사용예)상품테이블에서 색상정보(PROD_COLOR)가 존재하지 않는 상품을 조회하시오.   
       Alias 상품코드,상품명,매입단가,색상정보 
       SELECT PROD_ID AS 상품코드,
              PROD_NAME AS 상품명,
              PROD_COST AS 매입단가,
              PROD_COLOR AS 색상정보
         FROM PROD
        WHERE PROD_COLOR IS NULL; 
        
 2. NULL 처리함수
  1)NVL(col, val)
   - 'col'의 값이 NULL이면 'val'을 반환하고 NULL이 아니면 'col'값을 반환
   - 'col'과 'val'은 반드시 같은 타입이어야 함
   
 사용예)2005년 6월 모든 상품에 대한 상품별 매입현황을 조회하시오. --외부조인은 '모든','전부' 라는 수식어가 붙음
       Alias 상품명,매입수량집계,매입금액집계
       
       (2005년 6월 매입 상품)
       SELECT DISTINCT BUY_PROD
         FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050601') 
                           AND TO_DATE('20050630'); 
        ORDER BY 1;
        
       
       SELECT B.PROD_NAME AS 상품명,
              NVL(SUM(A.BUY_QTY),0) AS 매입수량집계,
              SUM(A.BUY_QTY * B.PROD_COST) AS 매입금액집계 
         FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID 
          AND A.BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630'))
        GROUP BY B.PROD_NAME;                   
       
       COMMIT;
       
       
       
       
       
       
       
       
       
       
       
       
       
       