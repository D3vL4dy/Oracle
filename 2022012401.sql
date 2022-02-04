2022-0124-01)
 사용예)2005년(일반조건) 모든(외부조인) 거래처별(그룹함수) 매입금액합계를 조회하시오
       Alias 거래처코드,거래처명,매입금액합계
    (일반적인 외부조인) --거래처코드가 13개인데 12개만 출력됨 
    --(일반조건이 사용되었기 때문에 외부조인이 아닌 내부조인 처리)
     SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
        FROM BUYER A, BUYPROD B, PROD C --A,B 직접 조인 불가
       WHERE B.BUY_PROD(+) = C.PROD_ID --(거래처는 PROD보다 BUYER가 많음)
         AND A.BUYER_ID = C.PROD_BUYER(+)
         AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE ('20051231')
       GROUP BY A.BUYER_ID, A.BUYER_NAME
       ORDER BY 1;
       
    (ANSI 외부조인) --13개 출력
     SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
        FROM BUYER A
        LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER) 
        LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID
         AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE ('20051231')) --AND 대신 WHERE 사용하면 내부조인
       GROUP BY A.BUYER_ID, A.BUYER_NAME
       ORDER BY 1;
       
    (ANSI 외부조인) --AND 대신 WHERE 사용하면 내부조인       
       SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
        FROM BUYER A
        LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER) 
        LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID)
       WHERE B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE ('20051231') 
       GROUP BY A.BUYER_ID, A.BUYER_NAME
       ORDER BY 1;
       
    (SUBQUERY 사용 외부조인)       
      SELECT A.BUYER_ID AS 거래처코드,
             A.BUYER_NAME AS 거래처명,
             SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
        FROM BUYER A, (2005년도 거래처별 매입금액계산) B
        LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER) 
        LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID)
       WHERE B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE ('20051231') 
       GROUP BY A.BUYER_ID, A.BUYER_NAME
       ORDER BY 1;
       
    (SUBQUERY : 2005년도 거래처별 매입금액계산) --서브쿼리에 바깥쪽 테이블과 조인될 수 있는 조건을 무조건 만들어야함
      SELECT A.BUYER_ID AS BID,
             SUM(B.BUY_QTY * C.PROD_COST) AS BSUM
        FROM BUYER A, PROD C, BUYPROD B
       WHERE C.PROD_ID = B.BUY_PROD
         AND A.BUYER_ID = C.PROD_BUYER
         AND EXTRACT(YEAR FROM B.BUY_DATE)=2005 --B.BUY_DATE에서 연도 추출
       GROUP BY A.BUYER_ID;
    
    (결합)
      SELECT D.BUYER_ID AS 거래처코드,
             D.BUYER_NAME AS 거래처명,
             NVL(E.BSUM,0) AS 매입금액합계
        FROM BUYER D,(SELECT A.BUYER_ID AS BID,
                             SUM(B.BUY_QTY * C.PROD_COST) AS BSUM
                        FROM BUYER A, PROD C, BUYPROD B
                       WHERE C.PROD_ID = B.BUY_PROD
                         AND A.BUYER_ID = C.PROD_BUYER
                         AND EXTRACT(YEAR FROM B.BUY_DATE)=2005
                       GROUP BY A.BUYER_ID) E
       WHERE D.BUYER_ID = E.BID(+)
       ORDER BY 1; 
         
       
       
 사용예)회원테이블에서 직업이 자영업인 회원들의 마일리지보다 더 많은 마일리지를 보유하고 있는 회원정보를 조회하시오.
       Alias 회원번호,회원명,직업,마일리지 
       
    (메인쿼리:회원번호,회원명,직업,마일리지)
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE > (직업이 자영업인 회원들의 마일리지)
       ORDER BY 1;
       
    (서브쿼리:직업이 자영업인 회원들의 마일리지)       
      SELECT MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_JOB = '자영업'
              
    (결합)
      SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_MILEAGE > ALL(SELECT MEM_MILEAGE --1개와 1개 비교되는 게 아닌 1개와 5개 비교됨 (ALL:다중행 연산자 사용)
                                 FROM MEMBER
                                WHERE MEM_JOB = '자영업')
       ORDER BY 1;      
       