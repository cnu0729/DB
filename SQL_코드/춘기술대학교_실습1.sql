/*춘 대학교 탐방기*/
-- 1. 춘 기술대학교 학과 이름과 계열 조회
-- 컬럼명 학과명 계열로 표시

SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY "계열"
FROM TB_DEPARTMENT;

-- 2. 학과 정원을 조회
SELECT DEPARTMENT_NAME || '의 정원은' || CAPACITY || '명 입니다.'
FROM TB_DEPARTMENT;

-- 3. 국문학과에 다니는 여학생 중에 현재 휴학중인 여학생 조회
-- 국문학과 코드 DEPARTMENT_NO 001

SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN, 8, 1) = '2'
AND ABSENCE_YN = 'Y'
AND DEPARTMENT_NO = '001';

-- 4.
-- 도서관에서 대출 도서 장기 연체자들을 찾아 이름 게시하고자함
-- 그 대상자들의 학번이 다음과 같을 때 대상자를 찾는 적절한 SQL 쿼리 구문
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

-- 5. 입학 정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계ㅇ열 조회
SELECT DEPARTMENT_NAME, CATEGORY
FROM tb_department
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6
-- 춘 기술 대학교는 총장을 제외하고 모든 교수들이 소속학과를 가지고 있음
-- 춘 기술 대학교 총장 이름을 알아낼 수 있는 SQL 문장 작성
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7
--수강 신청을 하려고 한다. 선수과목 여부를 확인하는데, 선수과목이 존재하는 과목들은 어떤 과목인지 조회
SELECT * FROM TB_CLASS;

SELECT CLASS_NAME AS "과목", PREATTENDING_CLASS_NO AS "선수과목"
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 8. DISTINCT 활용해서
-- 춘 대학에는 어떤 카테고리 들이 있는지 조회
SELECT CATEGORY
FROM TB_DEPARTMENT
GROUP BY CATEGORY;

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

-- 9
-- 영문학과 (학과코드 002) 학생들의 학번과 이름, 입학년도를
-- 입학 년도가 빠른 순으로 표시
-- AS "학번" AS "이름" AS "입학년도"
SELECT STUDENT_NO AS "학번", 
       STUDENT_NAME AS "이름", 
       TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY entrance_date ASC;

-- 10
-- 춘 대학교 교수 중 이름이 세글자가 아닌 교수가 두명있음
-- 그 교수의 이름과 주민번호
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE professor_name NOT LIKE '___';

-- 14
-- 춘 기술 대학교의 2000년 도 이후 입학자들은 학번이 A로 시작
-- 2000년도 이전 학번을 받는 학생들의 학번과 이름 조회
-- STUDENT_NO, STUDENT_NAME
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 15 학번이 A517178 한아름 학점 총 평점
--AS 평점 반올림 정수
SELECT * FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

SELECT STUDENT_NO,ROUND(AVG(POINT),1) AS "반올림평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178'
GROUP BY STUDENT_NO;
/*
--> 소수점 몇 자리까지 표기
ROUND(AVG(POINT),1) <-- 소수점 한자리까지 표기
*/

-- 17 지도 교수를 배정받지 못한 학생수
SELECT COUNT(*) AS "학생수"
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 18
---- 학번이 A112113인 김고운 학생의 년도 별 평점 구하기
---- 화면 AS 년도 AS 년도 별 평점
---- 점수 반올림 소수점 한자리
SELECT * FROM TB_GRADE
WHERE STUDENT_NO = 'A112113';

SELECT SUBSTR(TERM_NO,1,4) AS "년도" , ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

-- 20
-- 춘대학교에 다니는 동명이인 학생들의 이름, 동명인 수 조회
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME AS "이름" , COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;





