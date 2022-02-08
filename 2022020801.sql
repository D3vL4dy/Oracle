2022-0208-01)트리거
 ** HR 계정의 사원테이블에 퇴직일자 컬럼을 추가하시오.
    ALTER TABLE EMPLOYEES ADD(RETIRE_DATE DATE);
    
 ** HR 계정에 퇴직자 테이블을 생성하시오.
    테이블명 : RETIRES
    컬럼명       데이터타입       NULLABLE       PK/FK
 -------------------------------------------------------
  EMPLOYEE_ID   NUMBER(6)       N.N          PK & FK
  RETIRE_DATE   DATE
  JOB_ID        VARCHAR2(10)                 FK
  DEPARTMENT_ID NUMBER(4)                    FK
 -------------------------------------------------------
    CREATE TABLE RETIRES(
      EMPLOYEE_ID   NUMBER(6),
      RETIRE_DATE   DATE,
      JOB_ID        VARCHAR2(10),
      DEPARTMENT_ID NUMBER(4),
      CONSTRAINT pk_retires PRIMARY KEY(EMPLOYEE_ID),
      CONSTRAINT fk_ret_emp FOREIGN KEY(EMPLOYEE_ID)
        REFERENCES EMPLOYEES(EMPLOYEE_ID),
      CONSTRAINT fk_ret_jobs FOREIGN KEY(JOB_ID)
        REFERENCES JOBS(JOB_ID),
      CONSTRAINT fk_ret_dept FOREIGN KEY(DEPARTMENT_ID)
        REFERENCES DEPARTMENTS(DEPARTMENT_ID)); 
      
      
        
 사용예) 사원테이블에서 2002년 이전에 입사한 사원들을 퇴직 처리하려한다.
        퇴직자는 사원테이블 퇴직일자에 오늘 날짜로 변경하기 전 퇴직자테이블에 정보를 입력해야한다.
        --사원테이블 퇴직자료를 업데이트 하기 전 퇴직자 테이블로 이동 
        --트리거는 BEFORE, 이벤트는 EMP 테이블에 UPDATE, RETIRES 테이블에 자료 입력
    CREATE TRIGGER tg_retires
     BEFORE  UPDATE ON EMPLOYEES 
     FOR EACH ROW --UPDATE 될 각 행마다 트리거 실행 (총 8번 INSERT 계속 실행)
     --DECLARE > 변수를 사용하지 않을 경우 닫아줌
     
     BEGIN
      INSERT INTO RETIRES
      --한 행의 컬럼 하나를 지칭할 때 :OLD.변수명
        VALUES(:OLD.EMPLOYEE_ID,SYSDATE,:OLD.JOB_ID,:OLD.DEPARTMENT_ID);
     END;
     
     
     UPDATE EMPLOYEES
        SET RETIRE_DATE = SYSDATE
      WHERE HIRE_DATE <= TO_DATE('20021231');  --8명의 자료가 옮겨옴
      