2022-0117-02)ROLLUP 과 CUBE
 - GROUP BY 절에서 사용되어 다양한 집계를 제공
 1)ROLLUP --n+1개의 집계 반환
  . 그룹내의 집계를 사용된 컬럼들을 레벨별로 구분하여 레벨별 집계와 전체 집계를 반환
  . 반드시 GROUP BY 절에서만 사용해야 함
  (사용 형식)
   GROUP BY ROLLUP(컬럼명1[,컬럼명2,...,컬럼명n1)[,컬럼명,..]
    - ROLLUP( )안에 기술된 컬럼명n 부터 컬럼명1 까지 레벨을 부여하여 각 레벨별 집계와 전체집계 반환
    - ROLLUP( )안에 기술된 컬럼이 수가 n개이면 전체 집계의 종류는 n+1개임
    - (컬럼명1[,컬럼명2,...,컬럼명n 모두를 기준으로 집계를 반환한 뒤 
      컬럼명1[,컬럼명2을 기준으로 집계 반환, 컬럼명1을 기준으로 집계 반환, 전체집계 반환
      
 사용예)2005년 4~7월 사이의 판매자료를 대상으로 월별,회원별,제품별 판매집계를 구하시오.
       Alias 월,회원번호,제품번호,판매수량집계
    (GROUP BY 절만 사용)
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 제품번호,
              SUM(CART_QTY) AS 판매수량집계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD
        ORDER BY 1;
        
    (ROLLUP 절만 사용)
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 제품번호,
              SUM(CART_QTY) AS 판매수량집계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD)
        ORDER BY 1;
       
 **부분 ROLLUP
  - GROUP BY 절에 사용된 컬럼 중 일부만 ROLLUP 의 대상이 되는 경우
  ex)GROUP BY A1,ROLLUP(B1,B2,B3) 로 기술된 경우
     . A1,B1,B2,B3 컬럼을 기준으로 합계 반환
     . A1,B1,B2 컬럼을 기준으로 합계 반환
     . A1,B1 컬럼을 기준으로 합계 반환
     . A1 컬럼을 기준으로 합계 반환
     
 사용예)    
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 제품번호,
              SUM(CART_QTY) AS 판매수량집계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY SUBSTR(CART_NO,5,2),ROLLUP(CART_MEMBER,CART_PROD) --부분ROLLUP : 전체집계X
        ORDER BY 1; 
        
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 제품번호,
              SUM(CART_QTY) AS 판매수량집계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),CART_MEMBER),CART_PROD --월별 집계가 끝난 후 제품별 집계가 나옴
        ORDER BY 1; 
 
 2)CUBE --2^n개의 집계 반환
  . 그룹내의 집계에 사용된 컬럼들을 조합 가능한 경우의 가지수 만큼 집계 반환
  . 반드시 GROUP BY 절에서만 사용해야 함
  (사용 형식)
   GROUP BY CUBE(컬럼명1[,컬럼명2,...,컬럼명n1)[,컬럼명,..] 
    - CUBE 안에 사용된 컬럼의 수가 n개이면 2의 n승 가지만큼 집계의 종류 반환
    ex)GROUP BY CUBE(A1,B1,C1)
      => A1,B1,C1을 기준으로 하는 집계
         A1,B1을 기준으로 하는 집계
         A1,C1을 기준으로 하는 집계
         B1,C1을 기준으로 하는 집계
         A1을 기준으로 하는 집계
         B1을 기준으로 하는 집계
         C1을 기준으로 하는 집계
         전체 집계
         
 사용예)
       SELECT SUBSTR(CART_NO,5,2) AS 월,
              CART_MEMBER AS 회원번호,
              CART_PROD AS 제품번호,
              SUM(CART_QTY) AS 판매수량집계
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY CUBE(SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD)
        ORDER BY 1;