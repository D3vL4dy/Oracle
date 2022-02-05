2022-0121-02)SUBQUERY
 - SQL 구문 안에 또 다른 SELECT 문이 존재하는 경우
 - JOIN 이나 복잡도를 개선하기 위해 사용
 - 모든 SUBQUERY문은 ()안에 기술해야함. 단, INSERT 문에 사용되는 SUBQUERY는 제외
 - 서브쿼리시 WHERE 절 등에서 연산과 같이 사용될 때 반드시 연산자 오른쪽에 위치
 - 서브쿼리의 분류
  . 사용 위치에 따라 : 일반서브쿼리(SELECT 절), 중첩서브쿼리(WHERE 절), In-line서브쿼리(FROM 절)
  . 메인쿼리와의 관계에 따라 : 관련성 없는 서브쿼리(메인쿼리에 사용된 테이블과 JOIN 없이 구성된 서브쿼리),
                           관련성 있는 서브쿼리(메인쿼리에 사용된 테이블과 JOIN 으로 연결된 서브쿼리)
  . 반환되는 행/열에 따라 : 단일열|다중열|단일행|다중행(IN, ANY, SOME 등)
                         서브쿼리 => 사용되는 연산자에 의한 구별
 - 알려지지 않은 조건에 근거한 값들을 검색하는 SELECT 문 등에 활용
 - 메인쿼리가 실행되기 전에 한번 실행한다.
 
 사용예)사원테이블에서 사원들의 평균임금보다 많은 급여를 받는 사원들의 사원번호,사원명,부서코드,급여를 조회하시오.
    (IN-LINE VIEW 서브쿼리) --FROM절 (서브쿼리의 실행횟수가 1번)
    
     (메인쿼리 : 사원들의 사원번호,사원명,부서코드,급여를 조회) --최종출력 
      SELECT A.EMPLOYEE_ID AS 사원번호,
             A.EMP_NAME AS 사원명,
             A.DEPARTMENT_ID AS 부서코드,
             A.SALARY AS 급여
        FROM HR.EMPLOYEES A,(평균임금) B
       WHERE A.SALARY > B.평균임금 
       ORDER BY 3;

     (서브쿼리 : 평균임금) --최종출력을 위해 값을 산출      
      SELECT AVG(SALARY) AS ASAL
        FROM HR.EMPLOYEES --FROM절 서브쿼리는 직접 실행 가능해야함
 
     (결합)
      SELECT A.EMPLOYEE_ID AS 사원번호,
             A.EMP_NAME AS 사원명,
             A.DEPARTMENT_ID AS 부서코드,
             A.SALARY AS 급여
        FROM HR.EMPLOYEES A,(SELECT AVG(SALARY) AS ASAL --참조되어지는 컬럼의 별칭은 되도록 영문 사용
                               FROM HR.EMPLOYEES) B
       WHERE A.SALARY > B.ASAL 
       ORDER BY 3;
 
    (중첩서브쿼리) --WHERE절 (행의 수만큼 반복 수행. 속도가 느림) 
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             DEPARTMENT_ID AS 부서코드,
             SALARY AS 급여
        FROM HR.EMPLOYEES
       WHERE SALARY > (SELECT AVG(SALARY)  --필요한 부분에 직접 사용
                         FROM HR.EMPLOYEES)
       ORDER BY 3; 
       
 사용예)회원테이블에서 회원의 직업별 최대마일리지를 갖고있는 회원정보를 조회하시오.      
       Alias 회원번호,회원명,직업,마일리지
     (메인쿼리 : 회원번호,회원명,직업,마일리지 조회)   
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE (MEM_JOB,MEM_MILEAGE) = (서브쿼리) --2개를 적으면 쌍으로 비교
     (서브쿼리 : 회원의 직업별 최대마일리지)       
      SELECT MEM_JOB,
             MAX(MEM_MILEAGE)
        FROM MEMBER
       GROUP BY MEM_JOB 
     (결합) 
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE (MEM_JOB,MEM_MILEAGE) IN (SELECT MEM_JOB,
                                             MAX(MEM_MILEAGE)
                                        FROM MEMBER
                                       GROUP BY MEM_JOB); --1과 9행이라서 =으로 비교가 안돼  
                                       
 (EXISTS 연산자 사용) --앞에 수식이나 컬럼이 오지 않음 
      SELECT A.MEM_ID AS 회원번호,
             A.MEM_NAME AS 회원명,
             A.MEM_JOB AS 직업,
             A.MEM_MILEAGE AS 마일리지
        FROM MEMBER A 
       WHERE EXISTS (SELECT 1 --의미없음 (뒤 조건이 만족하면 SELECT절이 수행되므로 아무거나 와도 상관없음)
                       FROM (SELECT MEM_JOB, --첫번째 사람의 직업과 SELECT절의 직업이 같으면 밑에 조건 수행
                                    MAX(MEM_MILEAGE) AS BMILE
                               FROM MEMBER 
                              GROUP BY MEM_JOB)B 
                      WHERE A.MEM_JOB = B.MEM_JOB
                        AND A.MEM_MILEAGE = B.BMILE); 
                        
                        
 사용예)상품테이블에서 상품의 판매가가 평균판매가보다 큰 상품을 조회하시오.
       Alias 상품번호,상품명,판매가,평균판매가
       SELECT A.PROD_ID AS 상품번호,
              A.PROD_NAME AS 상품명,
              A.PROD_PRICE AS 판매가,
              B.ASAL AS 평균판매가
         FROM PROD A, (SELECT ROUND(AVG(PROD_PRICE)) AS ASAL
                         FROM PROD) B
        WHERE PROD_PRICE > B.ASAL                     
        ORDER BY 1;                      
   
   
 사용예)장바구니테이블에서 회원별 최대 구매수량을 기록한 상품을 조회하시오.
       Alias 회원번호,회원명,상품명,구매수량 
       
       SELECT C.CART_MEMBER AS 회원번호,
              A.MEM_NAME AS 회원명,
              B.PROD_NAME AS 상품명,
              C.CART_QTY AS 구매수량 
         FROM MEMBER A, PROD B, CART C
        WHERE A.MEM_ID = C.CART_MEMBER
          AND B.PROD_ID = C.CART_PROD
          AND (C.CART_MEMBER,C.CART_QTY) IN (SELECT D.CART_MEMBER,
                                   MAX(D.CART_QTY)
                              FROM CART D
                             GROUP BY D.CART_MEMBER)
        ORDER BY 1;

  SELECT CART_MEMBER, CART_PROD, CART_QTY
    FROM CART
   WHERE CART_MEMBER = 'b001'
   ORDER BY 3 DESC;
 
 
     (서브쿼리 : 회원의 최대구매수량)
      SELECT CART_MEMBER,
             MAX(CART_QTY)
        FROM CART
       GROUP BY CART_MEMBER);
       
     (결합1) -- IN연산자 사용
      SELECT C.CART_MEMBER AS 회원번호,
              A.MEM_NAME AS 회원명,
              B.PROD_NAME AS 상품명,
              C.CART_QTY AS 구매수량 
         FROM MEMBER A, PROD B, CART C
        WHERE A.MEM_ID = C.CART_MEMBER
          AND B.PROD_ID = C.CART_PROD
          AND (C.CART_MEMBER,C.CART_QTY) IN (SELECT D.CART_MEMBER,
                                   MAX(D.CART_QTY)
                              FROM CART D
                             GROUP BY D.CART_MEMBER)
        ORDER BY 1;

     (결합2) -- =연산자 사용
      SELECT C.CART_MEMBER AS 회원번호,
              A.MEM_NAME AS 회원명,
              B.PROD_NAME AS 상품명,
              C.CART_QTY AS 구매수량 
         FROM MEMBER A, PROD B, CART C
        WHERE A.MEM_ID = C.CART_MEMBER
          AND B.PROD_ID = C.CART_PROD
          AND C.CART_QTY = (SELECT MAX(D.CART_QTY)
                              FROM CART D 
                             WHERE D.CART_MEMBER = C.CART_MEMBER)
        ORDER BY 1; 