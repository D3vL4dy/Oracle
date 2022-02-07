2022-0207-01)트리거(TRIGGER)
 - 특정 테이블에 발생된(발생될) 이벤트(INSERT,UPDATE,DELETE)에 의하여 별도의 동작이 필요한 일종의 프로시져
 (사용형식)
 CREATE TRIGGER 트리거명
  BEFORE|AFTER  INSERT|UPDATE|DELETE
  ON 테이블명
  [FOR EACH ROW]
  [WHEN 조건]
 [DECLARE]
  선언부;
 BEGIN
  트리거
 END;
 * 'BEFORE|AFTER' : timing으로 트리거 본문이 실행되는 시점
 * 'INSERT|UPDATE|DELETE' : event로 트리거 본문을 실행시키는 원인이 되는 dml명령. 조합 사용 가능(INSERT OR UPDATE 등)
 * 'ON 테이블명' : 트리거 원인이 되는 이벤트가 발생된 테이블명
 * 'FOR EACH ROW' : 행단위 트리거(이벤트 결과 각 행마다 트리거 수행). 생략하면 문장단위 트리거
 * 'WHEN 조건' : 행단위트리거에서만 사용할 수 있으며 트리거를 발생시키는 이벤트가 발생되는 테이블에서
                이벤트가 발생할 때 좀 더 구체적인 검색조건 제시에 사용
 
 * 트리거 유형
  - 행단위 트리거와 문장단위 트리거로 구분
   1)문장단위 트리거 : 이벤트 수행결과에 관계없이 1번만 수행 'FOR EACH ROW' 생략
   2)행단위 트리거 : 이벤트명령 실행 결과가 복수개의 행이 반환되는 경우 각 행마다 트리거 본문 실행 'FOR EACH ROW' 기술
   
 * 의사레코드
  - 행단위 트리거에서만 사용 가능
  ----------------------------------------------------------------
   의사레코드                       의미
  ----------------------------------------------------------------
   :NEW      이벤트가 INSERT, UPDATE 일때만 사용
             데이터가 삽입(갱신)될때 새롭게 입력되는 자료(행)를 지칭
             DELETE시 사용되면 모든 컬럼값이 NULL
  ----------------------------------------------------------------
   :OLD      이벤트가 DELETE, UPDATE 일때만 사용
             데이터가 삭제(갱신)될 때 해당 연산의 대상이 되는 자료(행)를 지칭
             INSERT시 사용되면 모든 컬럼값이 NULL
  ----------------------------------------------------------------
  
  * 트리거 함수
  - 이벤트로 정의된 명령을 구분하기 위해 사용
  -------------------------------------------------
     함수                    의미
  -------------------------------------------------
   INSERTING     이벤트가 INSERT이면 참(true)반환
   UPDATING      이벤트가 UPDATE이면 참(true)반환    
   DELETING      이벤트가 DELETE이면 참(true)반환    
  -------------------------------------------------             
             
 사용예)분류테이블(LPROD)에서 순번 10부터 모두 삭제하시오
       삭제후 '분류코드가 삭제되었습니다.' 라는 메시지를 출력하시오.
   CREATE TRIGGER TG_DEL_LPROD
     AFTER DELETE ON LPROD
   BEGIN
     DBMS_OUTPUT.PUT_LINE('분류코드가 삭제되었습니다.');
   END;
     
   DELETE FROM LPROD
    WHERE LPROD_ID=12;
             
   COMMIT;
             
   ROLLBACK;          
   
 사용예)CUSTOMER 테이블에 자료를 변경하면 '자료가 수정되었음'을 자료가 삭제되면 '자료가 삭제되었음'을 출력하는 트리거 작성
   CREATE TRIGGER TG_DELUPDATE_CUST
     AFTER UPDATE OR DELETE ON CUSTOMER
   BEGIN
     IF UPDATING THEN      
        DBMS_OUTPUT.PUT_LINE('자료가 수정되었음');
     ELSIF DELETING THEN   
        DBMS_OUTPUT.PUT_LINE('자료가 삭제되었음');  
     END IF;   
   END;
     
 예)CUSTOMER의 마일리지를 모두 500씩 증가    
   UPDATE CUSTOMER
      SET MEM_MILEAGE = MEM_MILEAGE + 500;
             
   COMMIT;
                       
 예)CUSTOMER의 자료 중 마일리지가 3000이하인 자료 삭제
   DELETE FROM CUSTOMER
    WHERE MEM_MILEAGE <= 3000;
   
   SELECT * FROM CUSTOMER;          
   
   