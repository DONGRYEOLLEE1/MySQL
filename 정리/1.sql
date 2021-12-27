CREATE DATABASE Account CHARACTER SET utf8mb4 COLLATE UTF8MB4_GENERAL_CI;
#'ci' 는 'case-insensitive'의 약자이며, 대소문자를 구부하지 않게 설정된다.

## 데이터베이스 선택
USE Account;

## 데이터베이스 삭제
DROP DATABASE Account;

## 테이블 생성
CREATE TABLE User(
ID INT, 
Name VARCHAR(30),
BirthDay DATE,
Age INT);

## 테이블에 필드(열) 추가
### ALTER TABLE [table name] ADD [column name][datatype]
ALTER TABLE User ADD PhoneNumber INT;

## 테이블 필드(열) 타입 변경
ALTER TABLE User MODIFY ID VARCHAR(20);

## 테이블 필드(열) 삭제
ALTER TABLE User DROP Age;

## 테이블에 레코드(행) 추가
INSERT INTO User(ID, Name, BirthDay) VALUES(1, '김태하', '1992-11-04');

## 테이블의 레코드(행) 선택
SELECT * FROM User;

## 테이블의 레코드(행) 내용 수정
### UDATE [table] SET [column]=[value] WHERE [condition];
# UPDATE User SET PhoneNumber = '010-1010-2020' WHERE Name = '김태하';

##테이블의 레코드(행) 삭제
DELETE FROM User WHERE Name = '김태하';

SHOW databases;