# DML Data Manipulation Language
	# 데이터 조작 언어
    # 데이터를 조작(선택, 삽입, 수정, 삭제)하는데 사용되는 언어
    # DML구문이 사용되는 대상은 테이블의 행
    # SELECT, INSERT, UPDATE, DELETE
	
# DDL Data Definition Language
	# 데이터 정의 언어
    # 데이터베이스 테이블, 뷰, 인덱스 등의 데이터베이스 개체를 생성/삭제/변경하는 역할
    # Transaction 발생시키지 않음
    # CREATE, DROP, ALTER
    # ROLLBACK이나 COMMIT 사용 불가
    
# DCL Data Control Language
	# 데이터 제어 언어
    # 사용자에게 어떤 권한을 부여하거나 빼앗을 때 주로 사용하는 구문
    # GRANT, REVOKE
    
# TCL Transaction Control Language
	# 트랜잭션이 발생하는 SQL
    # 테이블의 데이터를 변경(입력/수정/삭제)할 때, 실제 테이블에 완전히 적용하지 않고, 임시로 적용시키며 취소 가능
    # DML에서 실행한 사항을 관리
    # COMMIT, ROLLBACK, SAVEPOINT
    

USE CLASSICMODELS;
SELECT *
FROM ORDERDETAILS
JOIN PRODUCTS ON ORDERDETAILS.PRODUCTCODE = PRODUCTS.PRODUCTCODE
ORDER BY BUYPRICE DESC;