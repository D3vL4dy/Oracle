2022-0106-04)DML(Data Manipulation Language)
 1.데이터 삽입
  - INSERT INTO 명령으로 자료 삽입
  (사용형식)
  INSERT INTO 테이블명[(컬럼명[,컬럼명,...])]
    VALUES(값[,값,...]);
   . '테이블명' : 데이터 삽입 대상 테이블명
   . '[(컬럼명[,컬럼명,...])]' : 삽입할 컬럼을 선택할 경우 기술
   . '[(컬럼명[,컬럼명,...])]'이 생략되면 모든 컬럼에 기술된 순서에 맞게 자료를 VALUES절에 기술해야함
   . 테이블 생성시 컬럼에 NOT NULL제약조건이 기술된 경우 '[(컬럼명[,컬럼명,...])]'에서 생략 불가능함
   . '[(컬럼명[,컬럼명,...])]'와 VALUES절의 값의 갯수, 타입은 일치해야함
   
 사용예)테이블 GOODS에 다음 자료를 삽입하시오.
     [자료]
    --------------------------------------
     상품코드       상품명         단가
    --------------------------------------     
     P101         신라면         1000
     P102         안성탕면        1200
     P103         게토레이        800
     P104         삼다수          500
    --------------------------------------
    
    INSERT INTO GOODS VALUES('P101','신라면',1000);
    INSERT INTO GOODS(GOOD_ID,GOOD_NAME)
      VALUES('P102','안성탕면');
    INSERT INTO GOODS(GOOD_ID)
      VALUES('P103');
      
    SELECT * FROM GOODS;
 
 2.데이터 수정
  - 존재하는 데이터에 대한 값을 수정
  - UPDATE문을 사용
  (사용형식)
     UPDATE 테이블명
        SET 컬럼명=값[,
            컬럼명=값,
               :
            컬럼명=값]
     [WHERE 조건];
     . '테이블명' : 수정할 대상자료를 저장한 테이블
     . 'WHERE 조건' : 생략되면 해당 테이블의 모든 행을 수정하며, 
                     조건을 기술한 경우 조건을 만족하는 행(들)만 수정
     
 사용예)신라면의 가격을 1000으로 수정하시오.
    UPDATE GOODS
       SET G_PRICE = 1000
     WHERE GOOD_ID = 'P101';
 사용예)안성탕면의 가격을 1200으로 수정하시오.
    UPDATE GOODS
       SET G_PRICE = 1200
     WHERE GOOD_ID = 'P102';
 사용예)'P103'자료의 제품명을 '게토레이', 단가를 800으로 수정하시오.
    UPDATE GOODS
       SET GOOD_NAME = '게토레이', 
           G_PRICE = 800
     WHERE GOOD_ID = 'P103';     
           
    SELECT * FROM GOODS; --WHERE절이 생략되면 모든 행이 수정됨
    COMMIT;