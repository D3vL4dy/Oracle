 2022-0107-02)데이터 검색명령(SELECT)
 
 ** 객체삭제 (DROP)
  . 테이블 삭제
    DROP TABLE 테이블명;
    
 사용예)쇼핑몰 테이블(BUYER,BUYPROD,CART,LPROD,PROD,MEMBER)을
       제외한 모든 테이블 삭제
    DROP TABLE ORDER_GOODS;
    DROP TABLE ORDERS;
    DROP TABLE CUSTOMERS;
    DROP TABLE GOODS;
    
    DROP TABLE TEMP_01;
    DROP TABLE TEMP_02;
    DROP TABLE TEMP_03;
    DROP TABLE TEMP_04;
    DROP TABLE TEMP_05;
    DROP TABLE TEMP_06;
    DROP TABLE TEMP_07;
    DROP TABLE TEMP_08;
    DROP TABLE TEMP_09;
    
 **HR계정 활성화
  1. HR계정의 잠금해제
     ALTER USER HR ACCOUNT UNLOCK;
     
  2. HR계정 암호설정
     ALTER USER HR IDENTIFIED BY java;
     
     
 **데이터 검색 명령     
  - SELECT 문이 제공
  - SQL명령 중 가장 많이 사용되는 명령
  (사용형식)
  --실행 순서:FROM -> WHERE -> SELECT
   SELECT *|[DISTINCT]컬럼명 [AS 컬럼별칭][,] --DISTINCT:중복자료 제외
          컬럼명 [AS 컬럼별칭][,]
                    :
          컬럼명 [AS 컬럼별칭][,]]
     FROM 테이블명
   [WHERE 조건
     [AND 조건,...]]
   [GROUP BY 컬럼명[,컬럼명,...]] --특정 컬럼을 기준으로 묶음
  [HAVING 조건] 
   [ORDER BY 컬럼명|컬럼index [ASC|DESC][, --정렬
          컬럼명|컬럼index [ASC|DESC],...]];  
  
   . 'DISTINCT':중복배제
   . 'AS 컬럼별칭':컬럼에 부여한 또 다른 이름. 컬럼의 제목 출력
   . '컬럼별칭'에 특수문자(공백 등)나 예약어 등이 포함된 경우 반드시 " "로 묶어 주어야 함.
   . 특정 테이블이 없거나 불필요한 경우 시스템이 제공하는 더미(DUMMY)테이블인 DUAL을 사용
   
 사용예)회원테이블(MEMBER)에서 여성회원들의 정보를 조회하시오.
       Alias는 회원번호,회원명,주소,나이,마일리지이다.
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_ADD1||' '||MEM_ADD2 AS 주소,--||는 +
              EXTRACT(YEAR FROM SYSDATE) - --SYSDATE에서 YEAR만 추출
                EXTRACT(YEAR FROM MEM_BIR) AS 나이,
              MEM_MILEAGE AS 마일리지
         FROM MEMBER
        WHERE SUBSTR(MEM_REGNO2,1,1)='2' --주민번호 뒷자리에서,첫글자,하나
  
 사용예) 2636363*24242 값을 출력
    SELECT 2636363*24242 FROM DUAL; 
    
    SELECT SYSDATE FROM DUAL;
    
 1)연산자
  - 산술연산자(+,-,/,*,)
  - 비교(관계)연산자(>,<,=,>=,<=,!=(<>))
  - 논리연산자(NOT,AND,OR) 
  
 사용예)HR 계정의 사원테이블(EMPLOYEES)에서 보너스를 구하고 각 사원의 급여 지급액을 구하시오.
       보너스=기본급(SALARY)*영업실적(COMMISSION_PCT)
       지급액=기본급+보너스
       Alias는 사원번호,사원명,기본급,보너스,지급액이다.
       --NULL과 연산하면 +-*/값은 항상 NULL
       SELECT EMPLOYEE_ID AS 사원번호,
              FIRST_NAME||' '||LAST_NAME AS 사원명,
              SALARY AS 기본급,
              COMMISSION_PCT AS 영업실적,
              NVL(SALARY * COMMISSION_PCT,0) AS 보너스, --NVL:NULL처리 함수
              SALARY + NVL(SALARY * COMMISSION_PCT,0) AS 지급액
         FROM HR.EMPLOYEES; --HR.으로 정의했기 때문에 SELECT에서는 HR을 적지 않음
         --다른 계정의 테이블을 이용하려면 계정명을 적어줘야 함(.으로 접근)
         
 사용예)회원테이블에서 마일리지가 3000이상인 회원을 조회하시오.
       Alias는 회원번호,회원명,마일리지,직업
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_MILEAGE AS 마일리지,
              MEM_JOB AS 직업
         FROM MEMBER
        WHERE MEM_MILEAGE>=3000
        ORDER BY 3 DESC; --내림차순 정렬
       
 사용예)회원테이블에서 마일리지가 3000이상이면서 거주지가 '대전'인 회원을 조회하시오.
       Alias는 회원번호,회원명,마일리지,직업,성별 --AS:Alias의 예약어
       성별난에는 '여성회원', '남성회원' 중 하나를 출력
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_MILEAGE AS 마일리지,
              MEM_JOB AS 직업,
              CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' THEN
                        '남성회원'
              ELSE
                        '여성회원'
              END AS 성별          
         FROM MEMBER
        WHERE MEM_MILEAGE>=3000 
          AND MEM_ADD1 LIKE '대전%'; --대전으로 시작하면 다 만족
              
 사용예)년도를 입력받아 윤년과 평년을 구별하시오.
 
       ACCEPT P_YEAR PROMPT '년도입력 : '
       DECLARE
        V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
        V_RES VARCHAR2(100);
       BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR
           (MOD(V_YEAR,400)=0) THEN
           V_RES:=V_YEAR||'년도는 윤년입니다.';
        ELSE 
           V_RES:=V_YEAR||'년도는 평년입니다.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
       END;
       
 2)기타연산자
  - 범위지정이나 복수개의 표현식을 지정할 때 등을 표현
  - IN, ANY, SOME, ALL, BETWEEN, LIKE, EXISTS 등이 제공
  (1)IN 연산자 --IN 앞에 관계연산자 사용 불가(IN 앞에 =이 생략됨)
    . 질의 탐색을 위해 사용될 둘 이상의 표현식을 지정
    . 제시된 복수개의 자요 중 어느 하나와 일치하면 전체 결과가 참을 반환
    (사용형식)
    컬럼명 IN (값1[, 값2,...])
     - '컬럼명'에 저장된 값이 '값1[, 값2,...]'중 어느 하나와 일치하면 결과가 참(true)을 반환
     - =ANY, =SOME 으로 바꾸어 사용 가능함
     - 연속된 값은 BETWEEN으로, 불연속적인 값의 비교는 IN으로 수행
     - OR 연산자로 치환 가능
     
 사용예)사원테이블에서 부서번호 20, 50, 90, 110에 속한 사원정보를 조회하시오.
       Alias는 사원번호,사원명,부서번호,급여
    (OR 연산자 사용)
        SELECT EMPLOYEE_ID AS 사원번호,
               FIRST_NAME||' '||LAST_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID = 20
            OR DEPARTMENT_ID = 50
            OR DEPARTMENT_ID = 90 
            OR DEPARTMENT_ID = 110
         ORDER BY 3; --ASC 기본 --3:DEPARTMENT_ID
         
    (IN 연산자 사용)
        SELECT EMPLOYEE_ID AS 사원번호,
               FIRST_NAME||' '||LAST_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID IN (20,50,90,110) --WHERE가 참이어야 SELECT 수행
         ORDER BY 3;

  (2)ANY(SOME) 연산자 
    . IN 연산자와 유사한 기능 제공
    . 주어진 데이터 중 어느 하나의 값과 ANY(SOME)앞에 
      기술된 관계연산자를 만족하면 참(true)인 결과를 반환 
    (사용형식)
    컬럼명 관계연산자ANY|SOME(값1[,값2,...])
     
 사용예)사원테이블에서 부서번호 20, 50, 90, 110에 속한 사원정보를 조회하시오.
       Alias는 사원번호,사원명,부서번호,급여     
    (ANY 연산자 사용)
        SELECT EMPLOYEE_ID AS 사원번호,
               FIRST_NAME||' '||LAST_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID =ANY(20,50,90,110) --=ANY 사이에 공백이 있으면 안됨
         ORDER BY 3;  

 사용예)회원테이블에서 직업이 공무원인 회원들이 보유한 마일리지보다 많은 마일리지를 보유한 회원들을 조회하시오.
       --가장 적은 사람보다 많으면 됨
       Alias는 회원번호,회원명,직업,마일리지
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              MEM_JOB AS 직업,
              MEM_MILEAGE AS 마일리지
         FROM MEMBER
        WHERE MEM_MILEAGE >ANY(SELECT MEM_MILEAGE --ANY=SOME
                                FROM MEMBER
                               WHERE MEM_JOB='공무원'); 