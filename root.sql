-- 사용할 데이터베이스 지정
use sakila;

-- customer 테이블 조회
select * from customer;

-- first name이 MARIA 인 데이터 조회
select
	*
from
	customer
where
first_name = 'MARIA';
-- first name 열에서 데이터가 A, B, C 순으로 'MARIA' 보다 앞에 위치한 데이터 조회
select
	*
from
	customer
where
first_name < 'MARIA'
order by
first_name;

-- first name 이 'M' ~ 'O' 사이의 데이터가 아닌 데이터 조회
select
	*
from
	customer
where
	first_name not between 'M' and 'O'
order by
	first_name;
-- first name 이 'MARIA', 'LINDA' 인 데이터 조회
select
	*
from
	customer
where
	first_name in ('MARIA', 'LINDA');

-- first name 이 'A' 로 시작하는 데이터 조회
select
	*
from
	customer
where
	first_name like 'A%';


-- first name 이 'A' 로 시작하고 문자열 길이가 3인 데이터 조회
select
	*
from
	customer
where
	first_name like 'A%'
	and length(first_name) = 3 ;



-- first name 이 'A' 로 시작하고 'A' 로 끝나면서 문자열 길이가 4인 데이터 조회
select
	*
from
	customer
where
	first_name like 'A%A'
	and length(first_name) = 4 ;
-- film 테이블
-- special features 를 기준으로 그룹화 후 count() 사용
select
	f.special_features, COUNT(*)
from
	film f
group by
	f.special_features;

-- special features, rating 를 기준으로 그룹화 후 rating이 G인 데이터 조회
select
	f.special_features,
	f.rating
from
	film f
group by
	f.special_features,
	f.rating
having
	f.rating = 'G';
-- address 테이블
-- address_id 가 200미만 데이터 조회
select
	*
from
	address
where
	address_id < 200;
-- address id 가 5~10 범위에 해당하는 데이터 조회
select
	*
from
	address
where
	address_id between 5 and 10;
-- address2 열 데이터가 null 이 아닌 데이터 조회
select
	*
from
	address
where
	address2 is not null;
-- city 테이블
-- country id 가 103 or 86 이면서, city 열이 'Cheju', 'Sunnyvale', 'Dallas' 인 데이터 조회
select
	*
from
	city
where
	country_id in (103, 86)
	and city in ('Cheju', 'Sunnyvale', 'Dallas');
-- PAYMENT 테이블
-- PAYMENT DATE 가 2005-07-09 미만인 행 조회
select
	*
from
	payment
where
	payment_date < '2005-07-09'
order by payment_date;

-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n개의 데이터 보기 / 범위 지정해서 보기

-- customer 테이블에서 store_id 내림차순, first name 오름차순으로 10개 데이터 보기
select * from customer order by store_id desc , first_name asc limit 10;

-- limit n1, n2 : 상위 n1 다음행부터 n2 개의 행 조회
-- 101번째부터 10개
select * from customer order by store_id desc , first_name asc limit 100,10;

-- limit n1 offset n2 : n2개 건너 뛰고 n1개 출력 
-- 표준 sql 문법
select * from customer order by customer_id asc limit 10 offset 100;
select * from customer order by customer_id asc limit 100, 10;

-- 데이터 베이스 생성
create database if not exists EXAM;

use EXAM;

-- 테이블 생성
-- 데이터 유형
-- 숫자형 : TINYINT(1 BYTE), SMALLINT(2), MEDIUMINT(3), INT(4), BIGIN(8)
-- 실수형 : 1. 고정 소수점 방식
-- 			 DECIMAL / NUMERIC
--  		  2. 부동 소수점 방식
--    	     FLOAT, DOUBLE
-- 문자형 : CHAR(N) - 고정 길이 문자열
--		   VARCHAR(N)
-- 날짜형 : TIME / DATE / DATETIME / TIMESTAMP
create table TABLE1(
CO1 INT, COL2 VARCHAR(50), COL3 DATETIME
);

create table TABLE2(
CO1 INT auto_increment primary KEY, COL2 VARCHAR(50), COL3 DATETIME
);


insert into TABLE2(COL2, COL3) values('TEST', '2025-10-29');
insert into TABLE2(COL1, COL2, COL3) values(3, 'TEST', '2025-10-30');

select * from TABLE2;
alter table TABLE2 rename column col1 to COL1;
-- 현재 auto_increment 로 생성된 마지막 값 확인
select LAST_INSERT_ID();

-- auto_increment 시작값 변경
alter table TABLE2 auto_increment = 100;

-- auto_increment 증가값 변경
set @@AUTO_INCREMENT_INCREMENT = 1;

create table EXAM_INSERT_SELECT_FROM(
	COL1 INT,
	COL2 VARCHAR(10)
);
create table EXAM_INSERT_SELECT_TO(
	COL1 INT,
	COL2 VARCHAR(10)
);

insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values (1, 'Do');
insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values (2, 'It');
insert into EXAM_INSERT_SELECT_FROM(COL1, COL2) values (3, 'MySQL');

-- EXAM_INSERT_SELECT_FROM => EXAM_INSERT_SELECT_10
insert into EXAM_INSERT_SELECT_TO select * from EXAM_INSERT_SELECT_FROM;

create table EXAM_SELECT_NEW as select * from EXAM_INSERT_SELECT_FROM;




select * from EXAM_INSERT_SELECT_FROM;
select * from EXAM_INSERT_SELECT_TO;
select * from EXAM.exam_select_new ;
rename table EXAM_INSERT_SELECT_10 to EXAM_INSERT_SELECT_TO; 

create table exam_DATE_TABLE(
	COL1 DATE, COL2 TIME, COL3 DATETIME, COL4 TIMESTAMP 
);

insert into EXAM.exam_date_table values (NOW(), NOW(), NOW(), NOW());

select * FROM EXAM.exam_date_table edt ;

-- 사용자 생성
-- 아이디 대소문자 구별함
-- localhost : 내 컴퓨터(로컬 접속만 가능)
-- '%' : 모든 ip에서 접속 가능(외부 접속 허용)
CREATE USER 'TEST1'@'localhost' IDENTIFIED BY '12345';
CREATE USER 'TEST1'@'%' IDENTIFIED BY '12345';


-- grant 권한 목록 on 데이터베이스.테이블 to '사용자이름'@'호스트'
grant all privileges on exam.* to 'TEST1'@'localhost';
-- 변경사항 반영
flush privileges;

-- 사용자 삭제
drop user 'TEST1'@'localhost';

-- 비밀 번호 변경
-- alter  USER 'TEST1'@'localhost' IDENTIFIED BY '12345';







































