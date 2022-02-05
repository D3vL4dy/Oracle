2022-0117-01)
 사용예)상품테이블에서 상품분류별 평균판매가,평균매입가를 조회하시오.
    SELECT PROD_LGU AS 상품분류코드,
           ROUND(AVG(PROD_PRICE)) AS 평균판매가,
           ROUND(AVG(PROD_COST)) AS 평균매입가,
           ROUND(AVG(PROD_PRICE) - AVG(PROD_COST)) AS 평균조수익
      FROM PROD
     GROUP BY PROD_LGU
     ORDER BY 1;
     
 사용예)사원테이블에서 근무지가 미국 이외인 부서에 근무하는 사원들의 평균급여와 평균근속년수를 조회하시오.
       부서코드,부서명,평균급여,평균근속년수 --부서를 부서코드에서 찾고 위치코드를 LOCATIONS테이블에서 찾고 COUNTRYY_ID에서 미국은 US로 되어있음
       SELECT A.DEPARTMENT_ID AS 부서코드,
              B.DEPARTMENT_NAME AS 부서명,
              ROUND(AVG(A.SALARY),1) AS 평균급여,
              ROUND(AVG(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM A.HIRE_DATE))) AS 평균근속년수
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
              HR.LOCATIONS C
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID --사원이 근무하고 있는 주소를 알아내기 위한 조건
          AND B.LOCATION_ID = C.LOCATION_ID
          AND C.COUNTRY_ID!='US'
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME 
        ORDER BY 1;
          
 **COUNT 함수
  - 각 그룹내의 행의 수(자료 수)를 반환
  (사용형식)
    COUNT(컬럼명|*)
     . 외부조인과 같은 특별한 경우를 제외하고 '*'를 사용하며, 이 경우 모든 컬럼이 NULL인 행도 COUNT됨
     . '컬럼명' : 해당 컬럼명에 NULL이 아닌 자료의 수를 반환하며, 주로 외부조인에 사용.
                 이때에는 해당 테이블의 기본키를 사용하는 것이 안전함
         
 사용예)사원테이블에서 각 부서별 사원수를 조회하시오.
    SELECT DEPARTMENT_ID AS 부서코드,
           COUNT(*) AS 사원수,
           COUNT(EMPLOYEE_ID) AS 사원수2,
           COUNT(SALARY) AS 사원수3
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;     
    
 사용예)사원테이블에서 부서에 근무하는 사원수가 5명 이상인 부서를 조회하시오.
    SELECT DEPARTMENT_ID AS 부서코드,
           COUNT(*) AS 사원수
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) >= 5
     ORDER BY 1; 
     
 사용예)상품테이블에서 분류별 상품수를 조회하시오.
    SELECT PROD_LGU AS 상품코드,
           COUNT(*) AS 상품수
      FROM PROD
     GROUP BY PROD_LGU
     ORDER BY 1; 
 
 사용예)2005년 5~7월 장바구니테이블에서 월별 매출건수를 조회하시오.
    SELECT SUBSTR(A.CNO,5,2)||'월' AS 월,
           COUNT(*) AS 매출건수 
      FROM (SELECT DISTINCT CART_NO AS CNO
              FROM CART
             WHERE SUBSTR(CART_NO,1,6) BETWEEN '200505' AND '200507'
             GROUP BY CART_NO) A
     GROUP BY SUBSTR(A.CNO,5,2)
     ORDER BY 1;          
         
         
 **MAX(컬럼명|수식), MIN(컬럼명|수식)        
         
 사용예)사원테이블에서 각 부서별 최대급여와, 최소급여를 조회하시오.
    SELECT DEPARTMENT_ID AS 부서코드,
           MAX(SALARY) AS 최대급여,
           MIN(SALARY) AS 최소급여
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;
    
 사용예)사원테이블에서 각 부서별 최대급여와, 최소급여를 수령하는 사원을 조회하시오.         
    SELECT A.DEPARTMENT_ID AS 부서코드,
           A.EMP_NAME AS 사원명, 
           B.MXS AS 최대급여액
      FROM HR.EMPLOYEES A,
           (SELECT DEPARTMENT_ID AS DID,
                   MAX(SALARY) AS MXS
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) B
     WHERE B.DID = A.DEPARTMENT_ID
       AND A.SALARY = B.MXS
     ORDER BY 1;    
         
    SELECT A.DEPARTMENT_ID AS 부서코드,
           A.EMP_NAME AS 사원명, 
           B.MNS AS 최소급여액
      FROM HR.EMPLOYEES A,
           (SELECT DEPARTMENT_ID AS DID,
                   MIN(SALARY) AS MNS
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) B
     WHERE B.DID = A.DEPARTMENT_ID
       AND A.SALARY = B.MNS
     ORDER BY 1;    
     
 사용예)2005년 1월 제품별 최소 매입금액을 조회하시오. 
    (제품별 매입액)
    SELECT A.BID AS 제품코드,
           MIN(A.SQC) AS 최소매입금액
      FROM (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS SQC --MIN(SUM):그룹함수는 그룹함수를 포함할 수 없음
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131') 
             GROUP BY BUY_PROD) A
     GROUP BY A.BID
     ORDER BY 1;
         
 사용예)2005년 1월 제품별 매입금액합계 중 최소 금액을 기록한 제품을 조회하시오.
       Alias 제품코드,매입금액  
    (제품별 매입액)
    SELECT C.BID AS 제품코드,
           C.SQC AS 매입금액
      FROM (SELECT MIN(A.SQC) AS MBS 
              FROM (SELECT BUY_PROD AS BID, --각 제품별 1월 매입금액 전부 계산(제품코드,매입금액합계)
                           SUM(BUY_QTY * BUY_COST) AS SQC 
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131') 
                     GROUP BY BUY_PROD) A)B,
           (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS SQC
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
             GROUP BY BUY_PROD) C
     WHERE C.SQC = B.MBS;        