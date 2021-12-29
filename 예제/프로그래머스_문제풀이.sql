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

# 4. 동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.

## 내가 제출한 답
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS WHERE NOT INTAKE_CONDITION = 'Aged' ORDER BY ANIMAL_ID ASC;

# 5. 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
## 내가 제출한 답
SELECT ANIMAL_ID, NAME from ANIMAL_INS;

# 6. 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
## 내가 제출한 답
SELECT ANIMAL_ID, NAME, DATETIME from ANIMAL_INS ORDER BY NAME ASC, DATETIME DESC;

# 7. 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
## 내가 제출한 답
SELECT NAME from ANIMAL_INS ORDER BY DATETIME ASC LIMIT 1;

# 8. 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
## 내가 제출한 답
SELECT DATETIME 시간 FROM ANIMAL_INS ORDER BY DATETIME DESC LIMIT 1;

# 9. 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
## 내가 제출한 답
SELECT DATETIME 시간 FROM ANIMAL_INS ORDER BY DATETIME ASC LIMIT 1;

# 10. 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
## 내가 제출한 답
SELECT COUNT(ANIMAL_ID) count FROM ANIMAL_INS;

# 11. 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
## 내가 제출한 답
SELECT COUNT(DISTINCT NAME) count FROM ANIMAL_INS;

# 12. 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
## 내가 제출한 답
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) FROM ANIMAL_INS GROUP BY ANIMAL_TYPE ORDER BY ANIMAL_TYPE;

# 13. 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
## 내가 제출한 답 1
SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS 
GROUP BY NAME
HAVING COUNT(NAME) > 1;

## 내가 제출한 답 2
SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS 
GROUP BY NAME
HAVING COUNT > 1
ORDER BY NAME

# 14. 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
## 내가 제출한 답
SELECT HOUR(ANIMAL_OUTS.DATETIME) AS HOUR, COUNT(ANIMAL_OUTS.ANIMAL_ID) AS COUNT
FROM ANIMAL_OUTS
WHERE HOUR(ANIMAL_OUTS.DATETIME) >= 9 AND HOUR(ANIMAL_OUTS.DATETIME) <= 19
GROUP BY HOUR
ORDER BY HOUR ASC;

# 15. 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
## 내가 제출한 답
