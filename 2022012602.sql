2022-0126-02)PL/SQL(Procedural Language SQL)
 - 표준 SQL에 절차적 언어의 특징이 추가
 - block 구조로 구성됨
 - DBMS에 미리 컴파일되어 저장되므로 빠른 실행과 네트워크를 효율적으로 이용하여 전체 SQL 실행 효율을 증대
 - 변수, 상수, 반복처리, 비교판단, 에러처리 가능
 - 표준 문법이 없음
 - User Defined Function(반환값이 있는 모듈), Stored Procedure, Trigger, Package, Anonymous block 등이 제공 --익명블록이 기본 구조
 
 1.Anonymous Block(익명블록)
  - PL/SQL의 기본 구조
  - 재 사용할 수 없음
 (사용형식)
    DECLARE
      선언부 - 변수,상수,커서 선언;
    BEGIN
      실행부 - 문제해결을 위한 비지니스 로직처리 SQL문;
      
      [EXCEPTION
        예외처리부;]
    END;    
    
 사용예) 1~100 사이의 짝수의 합과 홀수의 합을 구하시오.  
    DECLARE
      V_CNT NUMBER:=1; --(:=)할당연산자
      V_ESUM NUMBER:=0; --짝수
      V_OSUM NUMBER:=0; --홀수
    BEGIN
      LOOP --반복문의 기본 구조
        IF MOD(V_CNT,2)=0 THEN
          V_ESUM:=V_ESUM+V_CNT; 
        ELSE 
          V_OSUM:=V_OSUM+V_CNT; 
        END IF; 
        EXIT WHEN V_CNT >= 100; --조건이 참이면 LOOP 탈출
        V_CNT:=V_CNT+1;
      END LOOP; 
      DBMS_OUTPUT.PUT_LINE('짝수의 합 : '||V_ESUM); --DBMS_OUTPUT.PUT_LINE:출력명령
      DBMS_OUTPUT.PUT_LINE('홀수의 합 : '||V_OSUM);  
    END;  
        
   1)변수(상수) 선언
    - 개발언어의 변수,상수와 같은 의미
    (사용형식)
     변수(상수)명 [CONSTANT] 데이터타입[(크기)]| NOT NULL [:=초기값];
     . 상수선언은 'CONSTAN'예약어 사용
     . 상수선언시 초기화가 필요
     . 데이터타입 : 표준 SQL에서 사용하는 데이터타입,
                  PLS_INTEGER, BINARY_INTEGER : 4BYTE 정수
                  BOOLEAN 타입 사용 가능
                  
    ** 참조타입 -> 데이터타입 대신 기술
      테이블명.컬럼명%TYPE : 해당 테이블의 컬럼과 같은 타입/크기로 변수(상수)를 선언
      테이블명%ROWTYPE : 해당 테이블의 한 행 전체와 같은 타입으로 변수 선언(C언어의 STRUCTURE 타입과 유사)
     . 'NOT NULL' 지정시 반드시 초기값 지정해야함     
     
 사용예)임의의 부서번호(10~110번)를 생성하고 해당부서에 속한 사원 중 
       입사일이 가장 빠른 사원의 사원번호,사원명,입사일,부서명을 출력하시오.  
       --SELECT절 컬럼과 INTO절 변수와 타입,크기 일치해야함
       --%TYPE : 데이터 타입을 모를 때
       --커서(=배열)를 이용해 복수개의 데이터를 저장
 
    DECLARE 
     V_DEPTNO HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --부서코드
     V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --사원명
     V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --사원번호
     V_HDATE DATE; --입사일 
     V_DNAME VARCHAR2(100); --부서명
    BEGIN
     V_DEPTNO:TRUNC(DBME_RANDOM.VALUE(10,110),-1) --10~110사이의 정수 1의 자리에서 다 잘라서 반환
     SELECT TBL.AID, TBL.EMP_NAME, TBL.ADATE, TBL.BNAME
       INTO V_EID,V_NAME,V_HDATE,V_DNAME
       FROM (SELECT A.EMPLOYEE_ID AS AID, 
                    A.EMP_NAME AS ANAME, 
                    A.HIRE_DATE AS ADATE, 
                    B.DEPARTMENT_NAME AS BNAME
               INTO V_EID, V_ENAME, V_HDATE, V_DNAME
               FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
              WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.DEPARTMENT_ID = V_DEPTNO;
              ORDER BY 3) TBL
      WHERE ROWNUM=1;
      DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
      DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
      DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
      DBMS_OUTPUT.PUT_LINE('부서번호 : '||V_BNAME);
    END;
     ------------------------------------------------에러
     
 사용예)길이를 하나 입력받아 그 길이를 반지름으로하는 원의 너비,
       그 길이를 한 변으로하는 정사각형 너비를 각각 구하시오.
    ACCEPT P_LEN PROMPT '길이를 입력 : '   
    --ACCEPT에는 ;을 쓰지 않음
    DECLARE
      V_LENGTH NUMBER:=TO_NUMBER('&P_LEN');
      V_SQUARE NUMBER:=0; --사각형 너비
      V_CIRCLE NUMBER:=0; --원의 너비
      V_PIE CONSTANT NUMBER:=3.1415926;
    BEGIN
      V_SQUARE:=V_LENGTH*V_LENGTH;
      V_CIRCLE:=V_LENGTH*V_LENGTH*V_PIE;
      
      DBMS_OUTPUT.PUT_LINE('원의 너비 : '||V_CIRCLE);
      DBMS_OUTPUT.PUT_LINE('사각형의 너비 : '||V_SQUARE);
    END;  