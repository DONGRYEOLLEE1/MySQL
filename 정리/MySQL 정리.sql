SHOW DATABASES;

USE world;

SHOW TABLE STATUS;
SHOW TABLES;
DESCRIBE city;

DESC country;
DESC countrylanguage;

## SELECT
SELECT Name, Population FROM city;

## WHERE
SELECT *
FROM city
WHERE Population < 8000000
AND Population > 7000000;

### 한국에 있는 도시들 보기
select * from city where CountryCode = 'KOR';

### 미국에 있는 도시들 보기
select * from city where CountryCode = 'USA';

### 한국에 있는 도시 중, 인구수가 100만이 넘는 도시
select * from city where CountryCode = 'KOR' and Population > 1000000;

## BETWEEN
SELECT * FROM city WHERE Population BETWEEN 7000000 AND 8000000;

## IN : 이산적인값의 조건에는 IN() 사용 가능
SELECT * FROM city WHERE Name IN('Seoul', 'New York', 'Tokyo');

### 한국, 미국, 일본의 도시
select * from city where CountryCode IN('KOR', 'USA', 'JPN');

## LIKE 
## 문자열의 내용 검색하기위해 LIKE 연산자 사용
## 문자 뒤에 %-무엇이든(%) 허용
## 한 글자와 매치하기 위해서는 '_' 사용
select * from city where CountryCode LIKE 'KO_';
select * from city where Name LIKE 'Tel %';   # 'Aviv'가 % 문자 하나로 매핑이 된다.

## Sub Query
## 쿼리문 안에 또 쿼리문이 들어있는것
## 서브쿼리의 결과가 둘 이상이 되면 에러 발생
select * from city where CountryCode = (SELECT CountryCode FROM CITY WHERE Name = 'Seoul');
select CountryCode from city where Name = 'Seoul';

## ANY
## 서브쿼리의 여러개의 결과 중 한 가지만 만족해도 가능
## SOME은 ANY와 동일한 의미로 사용
## =ANY구문은 IN과 동일한 의미
select * from city where Population > ANY (	select Population
from city
where District = 'New York'	); ## 서브쿼리의 결과는 6개인데, 쿼리문 조건을 만족하면 모두 출력 (ANY)

select * from city where Population > SOME (	select Population
from city
where District = 'New York'	);

## ALL
## 서브쿼리의 여러 개의 결과를 모두 만족시켜야 함
select * from city where Population > ALL (	select Population
from city
where District = 'New York'	); ## 즉, '뉴욕'의 도시보다 인구수가 많은 도시를 출력

## ORDER BY
## 결과가 출력되는 순서를 조절하는 구문
## 기본적으로 오름차순(ASC) 정렬
## 내림차순(DESC)정렬은 뒤에 DESC 적어주면 됨
## ASC는 default임 (생략가능)
select *
from city
order by Population;

## ORDER BY 구문을 혼합해 사용하는 구문도 가능하다
SELECT *
FROM CITY
ORDER BY COUNTRYCODE ASC, POPULATION DESC;

### 인구수로 내림차순하여 한국에 있는 도시 보기
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'KOR'
ORDER BY POPULATION DESC;

### 국가면적크기로 내림차순하여 나라 보기(COUNTRY TABLE)
SELECT NAME, SURFACEAREA
FROM COUNTRY
ORDER BY SURFACEAREA DESC;

## DISTINCT
## 중복된 것은 1개씩만 보여주면서 출력
## 테이블의 크기가 클수록 효율적
SELECT DISTINCT COUNTRYCODE
FROM CITY;

## LIMIT
## 출력 개수를 제한
## 상위의 N개만 출력하는 'LIMIT N' 구문
## 서버의 처리량을 많이 사용해 서버의 전반적인 성능을 나쁘게하는 악성 쿼리문 개선할 때 사용
SELECT *
FROM CITY
ORDER BY POPULATION DESC LIMIT 10;

## GROUP BY
## 그룹을 묶어주는 역할
## 집계함수(Aggregate Function)을 함께 사용
	## AVG() : 평균
    ## MIN() : 최소값
    ## MAX() : 최대값
    ## COUNT() : 행의 개수
    ## COUNT(DISTINCT) : 중복 제외된 행의 개수
    ## STDEV() : 표준편차
    ## VARIANCE() : 분산
## 효율적인 데이터 그룹화
## 읽기좋게 하기위해 별칭(Alias) 사용
SELECT COUNTRYCODE, AVG(POPULATION) AS AVERAGE
FROM CITY
GROUP BY COUNTRYCODE;

### 도시는 몇개인가???
SELECT COUNT(*)
FROM CITY;

### 도시들의 평균 인구수는??
SELECT AVG(POPULATION) AS '평균 인구수'
FROM CITY;

## HAVING 
## WHERE과 비슷한 개념으로 조건 제한
## 집계함수에 대해서 조건 제한하는 편리한 개념
## HAVING절은 반드시 GROUP BY 절 다음에 나와야 함
SELECT COUNTRYCODE, MAX(POPULATION)
FROM CITY
GROUP BY COUNTRYCODE
HAVING MAX(POPULATION) > 8000000;   ## 집계함수에 조건을 걸고싶을때 사용 가능 + 반드시 GROUPBY절 다음에 와야함

SELECT COUNTRYCODE, MAX(POPULATION) AS MAX
FROM CITY
WHERE MAX(POPULATION) > 8000000
GROUP BY COUNTRYCODE;   ## WHERE절에서 집계함수에 대한 조건을 걸어도 작동이 안된다.

## ROLLUP
## 종합 또는 중간합계가 필요한 경우 사용
## GROUPBY절과 함께 WITH ROLLUP문 사용
## 각각의 모든 집계 결과를 보여준다
SELECT COUNTRYCODE, NAME, SUM(POPULATION)
FROM CITY
GROUP BY COUNTRYCODE, NAME WITH ROLLUP;

## JOIN
## JOIN은 데이터베이스 내의 여러 테이블에서 가져온 레코드를 조합하여 하나의 테이블이나 결과집합으로 표현
SELECT *
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE;

### CITY COUNTRY COUNTRYLANGUAGE 테이블 3개를 JOIN 하기
SELECT * 
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
JOIN COUNTRYLANGUAGE ON CITY.COUNTRYCODE = COUNTRYLANGUAGE.COUNTRYCODE;

## MySQL 내장함수
## 사용자의 편의를 위해 다양한 기능의 내장함수를 미리 정의하여 제공
## 대표적인 내장 함수의 종류
	## 문자열 함수
    ## 수학 함수
    ## 날짜와 시간 함수
SELECT LENGTH('SDFDLSKFJLSKF');

## CONCAT()
## 전달받은 문자열을 모두 결합하여 하나의 문자열로 반환
## 전달받은 문자열 중 하나라도 NULL이 존재하면 NULL을 반환
SELECT CONCAT('My', 'sql Op', 'en Source') as d;

## LOCATE()
## 문자열 내에서 찾는 문자열이 처음으로 나타나는 위치를 찾아서 해당 위치를 반환
## 찾는 문자열이 문자열 내에 존재하지 않으면 0을 반환
## MySQL에서는 문자열의 시작 인덱스를 1부터 계산
SELECT LOCATE('abc', 'ababcsbababbabababc');

## LEFT(), RIGHT()
## LEFT() : 문자열의 왼쪽부터 지정한 개수만큼의 문자를 반환
## RIGHT() : 문자열읠 오른쪽부터 지정한 개수만큼의 문자를 반환
SELECT LEFT('MySQL is an open source relational database management system', 5),
RIGHT('MySQL is an open source relational database management system', 6);

## LOWER(), UPPER()
## LOWER() : 문자열의 문자를 모두 소문자로 변경
## UPPER() : 문자열의 문자를 모두 대문자로 변경
SELECT UPPER('MySQL is an open source relational database management system'),
LOWER('MySQL is an open source relational database management system');

## REPLACE()
## 문자열에서 특정 문자열을 대체 문자열로 교체
SELECT REPLACE('MSSQL', 'MS', 'My');

## TRIM()
## 문자열의 앞이나 뒤, 또는 양쪽 모두에 있는 특정 문자를 제거
## TRIM() 함수에서 사용할 수 있는 지정자
	## BOTH : 전달받은 문자열의 양 끝에 존재하는 특정 문자를 제거 (기본 설정)
    ## LEADING : 전달받은 문자열 앞에 존재하는 특정 문자를 제거
    ## TRAILING : 전달받은 문자열 뒤에 존재하는 특정 문자를 제거
## 만약 지정자를 명시하지 않으면, 자동으로 BOTH로 설정
## 제거할 문자를 명시하지 않으면, 자동으로 공백을 제거
SELECT TRIM('                 MySQL          '),
TRIM(LEADING '#' FROM '###MySQL##'),
TRIM(TRAILING '#' FROM '###MySQL##');

## FORMAT()
## 숫자타입의 데이터를 세 자리마다 쉼표(,)를 사용하는 '#,###,###.##'형식으로 변환
## 반환되는 데이터의 형식은 문자열 타입
## 두번째 인수는 반올림할 소수부분의 자릿수
SELECT FORMAT(231254234234213.23431, 6);

## FLOOR(), CEIL(), ROUND()
## 각각, 내림, 올림, 반올림
SELECT FLOOR(10.95), CEIL(10.95), ROUND(10.95);

## SQRT() : 양의 제곱근
## POW() : 첫 번째 인수로는 밑수를 전달하고, 두 번째 인수로는 지수를 전달하여 거듭제곱 계산
## EXP() : 인수로 지수를 전달받아, e의 거듭제곱을 계산
## LOG() : 자연로그 값을 계산
SELECT SQRT(4), POW(2, 3), EXP(3), LOG(3);

## SIN, COS, TAN
SELECT SIN(PI()/2), COS(PI()), TAN(PI()/4);

## ABS(X) : 절대값을 반환
## RAND() : 0.0보다 크거나 같고 1.0보다 작은 하나의 실수를 무작위로 생성
SELECT ABS(-3), RAND(), ROUND(RAND() * 100, 0);

## NOW() : 현재 날짜와 시간을 반환, 반환되는 값은 'YYYY-MM-DD HH:MM:SS'또는 YYYYMMDDHHMMSS형태로 반환
## CURDATE() : 현재 날짜를 반환, 이때 반환되는 값은 'YYYY-MM-DD' 또는 YYYYMMDD 형태로 변환
## CURTIME() : 현재 시각을 반환, 이때 반환되는 값은 'HH:MM:SS' 또는 HHMMSS 형태로 반환
SELECT NOW(), CURDATE(), CURTIME();

## DATE() : 전달받은 값에 해당하는 날짜 정보를 반환
## MONTH() : 월에 해당하는 값을 반환하며, 0부터 12사이의 값을 가짐
## DAY() :일에 해당하는 값을 반환하며, 0부터 31사이의 값을 가짐
## HOUR() : 시간에 해당하는 값 반환, 0부터 23 사이의 값을 가짐
## MINUTE() : 분에 해당하는 값 반환, 0부터 59사이의 값을 가짐
## SECOND() : 초에 해당하는 값 반환, 0부터 59사이의 값을 가짐
SELECT
NOW(),
DATE(NOW()),
MONTH(NOW()),
DAY(NOW()),
HOUR(NOW()),
MINUTE(NOW()),
SECOND(NOW());

## MONTHNAME() : 월에 해당하는 이름을 반환
## DAYNAME() : 요일에 해당하는 이름을 반환
SELECT
NOW(),
MONTHNAME(NOW()),
DAYNAME(NOW());

## DAYOFWEEK() : 일자가 해당 주에서 몇번째 날인지를 반환, 1부터 7사이의 값을 반환(일요일 = 1, 토요일 = 7)
## DAYOFMONTH() : 일자가 해당 월에서 몇번째 날인지를 반환, 0부터 31사이의 값을 반환
## DAYOFYEAR() : 일자가 해당 연도에서 몇번째 날인지를 반환, 1부터 366사이의 값을 반환
SELECT
NOW(),
DAYOFWEEK(NOW()),
DAYOFMONTH(NOW()),
DAYOFYEAR(NOW());

## DATE_FORMAT() : 전달받은 형식에 맞춰 날짜와 시간정보를 문자열로 반환
SELECT
DATE_FORMAT(NOW(), '%D %y %a %d %m %n %j');


# SQL 고급

## CREATE TABLE AS SELCT
### 'city' 테이블과 똑같은 'city2' 테이블 생성
CREATE TABLE city2 AS SELECT * FROM city;

SELECT * FROM CITY2;
## CREATE DATABASE
## CREATE DATABASE 문은 새로운 데이터베이스를 생성
## USE 문으로 새 데이터베이스를 사용
CREATE DATABASE dd;

USE dd;

SELECT * FROM TEST;
DESC TEST;

CREATE TABLE test2 (
	id INT NOT NULL PRIMARY KEY,
    col1 INT NULL,
    col2 FLOAT NULL,
    col3 VARCHAR(45) NULL
);

SELECT * FROM TEST2;

## ALTER TABLE문과 함께 ADD문을 사용하면, 테이블에 컬럼을 추가할 수 있다.
ALTER TABLE test2
ADD col4 INT NULL;

SELECT * FROM TEST2;

DESC TEST2;

## 컬럼의 데이터타입 바꿔주기
ALTER TABLE TEST2
MODIFY col4 VARCHAR(20) NULL;

DESC TEST2;

## 컬럼 DROP
ALTER TABLE TEST2 DROP col4;
DESC TEST2;

## 인덱스INDEX
	## 테이블에서 원하는 데이터를 빠르게 찾기 위해 사용
	## 일반적으로 데이터를 검색할 때 순서대로 테이블 전체를 검색하므로 데이터가 많으면 많을수록 탐색하는 시간이 늘어남
	## 검색과 질의를 할 때 테이블 전체를 읽지 않기 때문에 빠름
	## 설정된 컬럼 값을 포함한 데이터의 삽입, 삭제, 수정 작업이 원본 테이블에서 이루어질 경우, 인덱스도 함께 수정되어야 함
    ## 인덱스가 있는 테이블은 처리속도가 느려질 수 있으므로 수정보다는 검색이 자주 사용되는 테이블에서 사용하는것이 좋음

## CREATE INDEX : 인덱스를 생성
CREATE INDEX Col1Idx ON test (col1);
## SHOW INDEX : INDEX 정보 보기
SHOW INDEX FROM TEST;
## CREATE UNIQUE INDEX : 중복값을 허용하지않는 인덱스
CREATE UNIQUE INDEX Col2Idx ON test (col2);
SHOW INDEX FROM test;
## FULLTEXT INDEX : 일반적인 인덱스와 달리 매우 빠르게 테이블의 모든 텍스트 컬럼을 검색
ALTER TABLE TEST
ADD FULLTEXT Col3Idx(col3);
SHOW INDEX FROM TEST;

## INDEX 삭제 (ALTER) 
ALTER TABLE TEST DROP INDEX Col3Idx;
SHOW INDEX FROM TEST;

DROP INDEX Col2Idx ON TEST;
SHOW INDEX FROM TEST;

## VIEW
	# VIEW는 데이터베이스에 존재하는 일종의 가상 테이블
    # 실제 테이블처럼 행과 열을 가지고 있지만, 실제로 데이터를 저장하진 않음
    # MySQL에서 뷰는 다른 테이블이나 다른 뷰에 저장되어 있는 데이터를 보여주는 역할만 수행
    # 뷰를 사용하면 여러 테이블이나 뷰를 하나의 테이블처럼 볼 수 있음
    # 장점
		# 특정 사용자에게 테이블 전체가 아닌 필요한 칼럼만 보여줄 수 있음
        # 복잡한 쿼리를 단순화해서 사용 가능
        # 쿼리 재사용 가능
	# 단점
		# 한 번 정의된 뷰는 변경할 수 없음
        # 삽입, 삭제, 갱신 작업에 많은 제한 사항을 가짐
        # 자신만의 인덱스를 가질 수 없음
        
## CREATE VIEW문을 사용해 뷰를 생성
CREATE VIEW testView AS
SELECT Col1, Col2
FROM test;

SELECT * FROM TESTVIEW;

## ALTER VIEW문을 사용해 뷰를 수정
ALTER VIEW TESTVIEW AS
SELECT Col1, Col2, Col3
FROM TEST;

SELECT * FROM TEST;

## DROP VIEW문을 사용해 생성된 뷰를 삭제
DROP VIEW TESTVIEW;


### city, country, countrylanguage 테이블을 JOIN하고, 한국에 대한 정보만 뷰 생성하기
USE WORLD;

SELECT *
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
JOIN COUNTRYLANGUAGE ON CITY.COUNTRYCODE = COUNTRYLANGUAGE.COUNTRYCODE;

CREATE VIEW ALLVIEW AS 
SELECT CITY.NAME, COUNTRY.SURFACEAREA, CITY.POPULATION, COUNTRYLANGUAGE.LANGUAGE
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
JOIN COUNTRYLANGUAGE ON CITY.COUNTRYCODE = COUNTRYLANGUAGE.COUNTRYCODE
WHERE CITY.COUNTRYCODE = 'KOR';

SELECT * FROM ALLVIEW;

## INSERT
	# 테이블 이름 다음에 나오는 열 생략 가능
    # 생략할 경우 VALUE 다음에 나오는 값들의 순서 및 개수가 테이블이 정의된 열 순서 및 개수와 동일해야 함
USE DD;

INSERT INTO TEST
VALUE(1, 123, 1.1, 'Test');

SELECT * FROM TEST;

## INSERT INTO SELECT : TEST 테이블에 있는 내용을 TEST2 테이블에 삽입
INSERT INTO TEST2 SELECT * FROM TEST;

SELECT * FROM TEST2;

## UPDATE 
	# 기존에 입력되어 있는 값을 변경하는 구문
    # WHERE절 생략 가능하나 테이블의 전체 행의 내용 변경
UPDATE TEST
SET COL1 = 1, COL2 = 1.0, COL3 = 'test'
WHERE ID = 1;  ## WHERE절을 안쓰면 모든 값이 다 바뀜

SELECT * FROM TEST;

## DELETE
	# 행 단위로 데이터를 삭제하는 구문
    # DELETE FROM 테이블이름 WHERE 조건;
    # 데이터는 지워지지만 테이블 용량을 줄어들지 않음
    # 원하는 데이터만 지울 수 있음
    # 삭제 후 잘못 삭제한 것을 되돌릴 수 있음
DELETE FROM TEST
WHERE ID = 1;

SELECT * FROM TEST;

## TRUNCATE
	# 용량이 줄어들고, 인덱스 등도 모두 삭제
    # 테이블은 삭제하지는 않고, 데이터만 삭제
    # 한꺼번에 다 지워야 함
    # 삭제 후 절대 되돌릴 수 없음
TRUNCATE TABLE TEST;

SELECT * FROM TEST;

## DROP TABLE
	# 테이블 전체를 삭제, 공간, 객체를 삭제
    # 삭제 후 절대 되돌릴 수 없음
DROP TABLE TEST;
SELECT * FROM TEST;

## DROP DATABASE
DROP DATABASE DD;