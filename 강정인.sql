2022-0119-02)
    제출일자 : 2022년 1월 28일
    제출방법 : 파일전송(\\Sem\공유폴더\Oracle\homework01)
    파일명 : 메모장 등을 활용하여 txt 또는 doc 또는 hwp 파일로 저장하여 전송
            파일명은 이름작성일자.txt(ex 홍길동20220127.txt)
            
            
 숙제]사원테이블에서 부서별 평균임금을 구하고 해당부서에 속한 사원 중 자기부서의 평균 급여보다 많은 급여를 받는 사원을 조회하시오.          
     Alias 사원번호,사원명,부서명,부서평균급여,급여  --(부서평균급여<=급여)
    
       --내가 속한 집단의 평균 급여보다 더 많은 급여를 받고 있는 사원들
     SELECT A.EMPLOYEE_ID AS 사원번호,
            A.EMP_NAME AS 사원명,
            B.DEPARTMENT_NAME AS 부서명,
            C.ASAL AS 부서평균급여,
            A.SALARY AS 급여
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
            (SELECT DEPARTMENT_ID AS BID,
                    AVG(SALARY) AS ASAL
               FROM HR.EMPLOYEES
              GROUP BY DEPARTMENT_ID) C 
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND B.DEPARTMENT_ID = C.BID
        AND A.SALARY >= C.ASAL
      ORDER BY 1;
    
    
            
            
            