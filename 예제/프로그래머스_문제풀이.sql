# 1
# `ANIMAL_INS` 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블이다.
# 테이블 구조는 다음과 같으며, 'ANIMAL_ID', 'ANIMAL_TYPE', 'DATETIME', 'INTAKE_CONDITION', 'NAME', 'SEX_UPON_INTAKE'는
# 각각 동물의 아이디, 생물 종, 보호시작일, 보호시작시 상태, 이름, 성별 및 중성화 여부를 나타낸다.

# 동물 보호소에 들어온 모든 동물이 정보를 'ANIMAL_ID'순으로 조회하는 SQL문을 작성하라.

## 내가 제출한 답
SELECT * from ANIMAL_INS order by ANIMAL_ID ASC;


# 2
# 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성하라.
# 이때 결과는 'ANIMAL_ID' 역순으로 보여주라.

## 내가 제출한 답
SELECT NAME, DATETIME from ANIMAL_INS ORDER BY ANIMAL_ID DESC;


# 3
# 동물보호소에 들어온 동물 중 아픈동물의 아이디와 이름을 조회하는 SQL 문을 작성하라.
# 이때 결과는 아이디 순으로 조회하라.

## 내가 제출한 답
SELECT ANIMAL_ID, NAME from ANIMAL_INS WHERE INTAKE_CONDITION = 'Sick' ORDER BY ANIMAL_ID ASC;

