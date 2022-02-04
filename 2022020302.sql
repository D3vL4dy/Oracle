2022-0203-02)커서(CURSOR)
 - 커서는 SQL 명령으로 영향받은 행들의 집합
 - SELECT문의 커서는 뷰와 같음
 - 커서는 묵시적커서(IMPLICITE CURSOR)와 명시적커서(EXPLICITE CURSOR)가 존재
 1. 묵시적 커서
  * 이름이 없는 커서
  * SELECT문의 경과 집합
  * 묵시적커서는 항상 CLOSE되어 있어 커서 내부의 자료 접근이 불가능
  * 묵시적 커서 속성
  ---------------------------------------------------------
   커서               의미
  ---------------------------------------------------------
  SQL%ISOPEN       커서가 접근가능한 상태(OPEN)인가를 판단하여
                   OPEN상태이면 참, 아니면 거짓을 반환
                   묵시적커서는 항상 FALSE 임
  SQL%FOUND        커서내의 행(ROW)가 존재하면 참, 없으면 거짓반환      
  SQL%NOTFOUND     커서내의 행(ROW)가 존재하면 거짓, 없으면 참반환
  SQL%ROWCOUNT     커서내의 행의 수 반환
  ---------------------------------------------------------
  
 2. 명시적 커서  
  * 이름이 부여된 커서
  * 보통 선언부에서 선언
  * 명시적커서는 '선언'->'OPEN'->'FETCH'->'CLOSE' 단계 순으로 처리 (단, FOR문은 예외)
  1)선언
   - 선언부에 기술
   (선언형식)
    CURSOR 커서명[(변수명 타입[,...])]
    IS
      SELECT 문;
     *'변수명'에 값을 할당하는 곳은 OPEN문에서 수행

  2)OPEN
   - 커서를 사용하기 위한 명령으로 선언된 커서를 접근 가능한 상태로 만듬
   - 커서에 매개변수를 사용한 경우 OPEN문에서 값을 배정
   - BEGIN 블록에 기술
  (사용형식)
   OPEN 커서명[(값,...)];

  3)FETCH 문
   - 커서내부에 각 행단위로 자료를 읽어 변수에 할당
   - BEGIN 블록에 기술되며 보통 반복문 내부에 기술
  (사용형식)
   FETCH 커서명 INTO 변수명[,변수명...]
    * 커서내부의 컬럼의 갯수와 순서 및 자료타입과 INTO절의 변수 갯수, 순서, 자료타입은 일치해야함
    * 커서컬럼 값을 변수에 차례대로 할당
    
  4)CLOSE 문
   - 사용이 종료된 커서는 반드시 CLOSE되어야 함
   - 커서는 다시 OPEN 가능하나 데이터를 FETCH, 갱신, 삭제할 수 없음
   
 사용예)부서번호 100번 부서에 속한 사원정보를 커서를 이용하여 출력하시오
     DECLARE 
       CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
       IS
         SELECT A.EMPLOYEE_ID,A.EMP_NAME,B.JOB_TITLE,A.HIRE_DATE 
           FROM HR.EMPLOYEES A, HR.JOBS B
          WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=P_DID;
       V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
       V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
       V_JTITLE HR.JOBS.JOB_TITLE%TYPE;
       V_HDATE HR.EMPLOYEES.HIRE_DATE%TYPE;
     BEGIN  
       OPEN CUR_EMP01(100);
       
       /*LOOP 구문사용
       LOOP
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;
        EXIT WHEN CUR_EMP01%NOTFOUND; -- 읽을 자료가 없을때
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('직무명 : '||V_JTITLE);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
       CLOSE CUR_EMP01;
     END;  
       
       /* WHILE 구문사용 
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;       
        WHILE CUR_EMP01%FOUND LOOP  
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('직무명 : '||V_JTITLE);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;        
       END LOOP;
       CLOSE CUR_EMP01;
     END;    
  
       /* FOR문 사용 */
     DECLARE 
       CURSOR CUR_EMP01
       IS
         SELECT A.EMPLOYEE_ID AS AEID,
                A.EMP_NAME AS AENAME,
                B.JOB_TITLE AS BJTITLE,
                A.HIRE_DATE AS AHDATE 
           FROM HR.EMPLOYEES A, HR.JOBS B
          WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=100;
     BEGIN   
       FOR REC IN CUR_EMP01 LOOP        
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.AEID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.AENAME);
        DBMS_OUTPUT.PUT_LINE('직무명 : '||REC.BJTITLE);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.AHDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
     END;     
 
 -- FOR문(IN-LINE SUBQUERY 사용) 
     DECLARE 
     BEGIN      
       FOR REC IN (SELECT A.EMPLOYEE_ID AS AEID,
                          A.EMP_NAME AS AENAME,
                          B.JOB_TITLE AS BJTITLE,
                          A.HIRE_DATE AS AHDATE 
                     FROM HR.EMPLOYEES A, HR.JOBS B
                    WHERE A.JOB_ID=B.JOB_ID
                      AND A.DEPARTMENT_ID=100)
       LOOP        
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.AEID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.AENAME);
        DBMS_OUTPUT.PUT_LINE('직무명 : '||REC.BJTITLE);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.AHDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
     END;     
  
 사용예)거주지가 '충남'인 회원들의 2005년 구매정보를 조회하시오   
       Alias는 회원번호, 회원명, 주소, 구매금액, 마일리지
 (커서 : 거주지가 충남인 회원들의 회원번호)
  
  DECLARE
   V_AMT NUMBER:=0;    --구매금액 계산한 걸 저장하는 곳
   V_RES VARCHAR2(500);
   CURSOR CUR_CART02 IS
     SELECT MEM_ID,MEM_NAME,MEM_ADD1||' '||MEM_ADD2 AS ADDR,
            MEM_MILEAGE
       FROM MEMBER
      WHERE MEM_ADD1 LIKE '충남%';
  BEGIN
   FOR REC IN CUR_CART02 LOOP
       SELECT SUM(CART_QTY*PROD_PRICE) INTO V_AMT
         FROM CART, PROD
        WHERE CART_MEMBER=REC.MEM_ID
          AND CART_PROD=PROD_ID
          AND CART_NO LIKE '2005%';
       V_RES:=REC.MEM_ID||' '||REC.MEM_NAME||' '||RPAD(REC.ADDR,30,' ')||LPAD(V_AMT,9,' ')||LPAD(REC.MEM_MILEAGE,6,' ');
       DBMS_OUTPUT.PUT_LINE(V_RES);
   END LOOP;    
  END;
 
 사용예)재고량이 많은 5개의 제품에 대한 2005년 매입정보를 조회하시오
       Alias는 제품코드, 제품명, 매입일자, 매입수량
 (커서 : 재고량이 많은 5개 제품코드 출력) 
  SELECT A.PROD_ID AS APID,
         A.REMAIN_J_99 AS AJ99
    FROM (SELECT PROD_ID, REMAIN_J_99
            FROM REMAIN
           ORDER BY 2 DESC) A
   WHERE ROWNUM <= 5;
   
   DECLARE
    CURSOR CUR_BUY01 IS
      SELECT A.PROD_ID AS APID
        FROM (SELECT PROD_ID, REMAIN_J_99
                FROM REMAIN
               ORDER BY 2 DESC) A
       WHERE ROWNUM <= 5;
       V_PNAME PROD.PROD_NAME%TYPE;
       V_QTY NUMBER:=0;
   BEGIN
    FOR REC IN CUR_BUY01 LOOP
      SELECT PROD_NAME INTO V_PNAME
        FROM PROD
       WHERE PROD_ID=REC.APID;
      SELECT SUM(BUY_QTY) INTO V_QTY
        FROM BUYPROD
       WHERE BUY_PROD=REC.APID
         AND EXTRACT(YEAR FROM BUY_DATE)=2005;
        DBMS_OUTPUT.PUT_LINE('제품코드 : '||REC.APID);
        DBMS_OUTPUT.PUT_LINE('제품명 : '||V_PNAME);
        DBMS_OUTPUT.PUT_LINE('매입수량합게 : '||V_QTY);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
      END LOOP;
    END;