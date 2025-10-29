-- c##을 사용 안하도록 설정
-- 오라클 버전이 업데이트 되면서 사용자 아이디 앞에 c##을 붙이도록 설정되어있다
-- hr 사용자 생성 => c##hr
--sys AS sysbda

--@C:\Users\soldesk\Downloads\db-sample-schemas-main\db-sample-schemas-main\human_resources\hr_install.SQL 

--@C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.SQL 

ALTER SESSION SET "_oracle_script"= TRUE;

-- 권한 부여 : GRANT
GRANT CREATE VIEW TO SCOTT;

GRANT CREATE PUBLIC SYNONYM TO SCOTT;
GRANT CREATE SYNONYM TO SCOTT;