2022-0107-01)
 3. DELETE 문
  - 테이블내의 자료를 삭제할 때 사용
  - ROLLBACK의 대상
  (사용형식)
   DELETE FROM 테이블명
   [WHERE 조건];
   . WHERE 절이 생략되면 모든 자료를 삭제
   
 사용예)테이블 GOODS의 모든 자료를 삭제   
    DELETE FROM GOODS;
    
    SELECT * FROM GOODS;
    
    COMMIT;
 사용예)테이블 GOODS의 자료 중 상품코드가 'P102'보다 큰 자료를 삭제하시오.
    DELETE FROM GOODS
      WHERE GOOD_ID>='P102';
      
      SELECT * FROM GOODS;
    