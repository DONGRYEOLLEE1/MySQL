# 현재 데이터베이스 확인
show databases;

# 새로운 데이터베이스 만들기
create database DS;

# 확인 
show databases;

# 사용하기
use DS;
# DS에 속해있는 테이블 확인하기
show tables;
# prof라는 이름의 테이블 만들기
create table prof (no int(2), name varchar(10), dept varchar(20), room varchar(10));

show tables;

# prof 테이블의 전체 구조와 속성을 학인
desc prof;

# 위의 결과값 형식에 맞춰 1행의 데이터 속성들을 입력하자
insert into prof values (1, 'Kim', 'Data Analysis', '210');

# prof 테이블의 모든 데이터확인하기 
select * from prof;

# 위와 마찬가지로 2행의 데이터 속성 입력하기
insert into prof values (2, 'Lee', 'Data Mining', '211');

# 3행의 데이터 속성 입력하기
insert into prof values (3, 'Park', 'Statistics', '230');

# 해당 테이블 모든 데이터 확인
select * from prof;

# prof 테이블의 name과 room열의 모든 데이터 확인
select name, room from prof;

# name의 속성이 'Park'에 해당하는 데이터만 확인
select * from prof where name = 'Park';

# dept의 속성이 'Data Analysis'에 해당하는 데이터만 확인하기
select * from prof where dept = 'Data Analysis';

# prof 테이블의 name열의 데이터만 확인하기
select name from prof;

# name열에서 dept의 속성이 'Data Analysis'에 해당하는 데이터만 확인하기
select name from prof where dept = 'Data Analysis';

# dept의 속성이 'Data Mining'이면서 room의 속성이 '205'인 데이터 확인 ( 매칭 데이터 없음 )
select * from prof where dept = 'Data Mining' && room = '205';

# prof테이블의 모든 데이터 확인
select * from prof;

# name의 속성이 'Kim'인 데이터의 room의 속성을 '208'로 변경
UPDATE prof SET room = '208' WHERE name = 'Kim';

update prof set dept = 'Machine Learning' where dept = 'Data Analysis';