/*함수 실습 코드*/

-- LENGTH --
-- 1. 직원 이름의 길이 이름_길이 로 작성
SELECT EMP_ID, EMP_NAME, LENGTH(EMP_NAME) AS "이름_길이"
FROM EMPLOYEE;

-- 2. 이메일 아이디의 길이 조회 이메일_길이로 작성]
SELECT EMP_ID, EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일_길이"
FROM EMPLOYEE;

-- 3. 전화번호 길이가 11자리인 길이 조회
SELECT EMP_ID, EMP_NAME, PHONE, LENGTH(PHONE)
FROM EMPLOYEE;

-- 4. 이메일의 길이가 15자 이상인 직원
SELECT EMP_ID, EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일_길이"
FROM EMPLOYEE
WHERE LENGTH(EMAIL) >= 15;

-- 5. 부서코드가 2글자인 직원 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE LENGTH(DEPT_CODE) = 2;

-- 6. 전화번호 010이 포함된 직원 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE INSTR(PHONE, '010')>0;

--→ LIKE로 변경
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '%010%';

-- SUBSTR 예제

-- 1. 이름의 세글자 가져오기
--→ EMP_NAME AS 이름_석자
SELECT EMP_NAME, SUBSTR(EMP_NAME, 1, 3) AS "이름_석자"
FROM EMPLOYEE;

SELECT EMP_NAME AS "이름이세글자인사람"
FROM EMPLOYEE
WHERE LENGTH(EMP_NAME) = 3 ;

-- 2. 전화번호의 마지막 네자리 가져오기 -4
SELECT EMP_NAME, SUBSTR(PHONE, -4) AS "마지막_네_자리"
FROM EMPLOYEE
-- NULL 값이 아닌 번호만 보길 원한다면
WHERE PHONE IS NOT NULL;

-- 3. 주민등록번호의 생년월일 추출
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 6) AS "생년월일"
FROM EMPLOYEE;

-- 4. 전화번호의 앞 세자리 추출
SELECT SUBSTR(PHONE, 1, 3) AS "앞 세자리"
FROM EMPLOYEE
-- NULL 값 빼고 출력
WHERE PHONE IS NOT NULL;

-- 5. 이메일 @ 뒤에 있는 도메인 추출
SELECT EMP_NAME, SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) AS "도메인"
FROM EMPLOYEE;

-- AVG 평균
-- 모든 사원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 올림 내림 반올림 활용해서 정수로 출력

-- 1. 올림 CEIL
SELECT CEIL(AVG(SALARY))
FROM EMPLOYEE;

-- 2. 내림 FLOOR
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- 3. 반올림 ROUND
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

/* COUNT 실습 */
-- 1. 전체 직원 수 조회
SELECT COUNT(*)
FROM EMPLOYEE;

-- 2. WHERE 사용 D9 부서 직원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3. WHERE 사용해서 보너스 받은 직원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS > 0;

/* AVG 평균 구하기 실습 */
-- 1. 전체 직원 평균 급여 조회
-- → AS 평균 급여 
SELECT AVG(SALARY) AS "평균급여"
FROM EMPLOYEE;

-- 2. 부서별 평균 급여 조회
SELECT DEPT_CODE AS "부서", AVG(SALARY) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;
/*
SELECT DEPT_CODE AS "부서", AVG(SALARY) AS "평균급여"
FROM EMPLOYEE;
↓ 에러 메세지 ↓
ORA-00937: not a single-group group function
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
108행, 8열에서 오류 발생
*/

-- 3. D5 부서의 평균 급여 조회
SELECT AVG(SALARY) AS "평균급여"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*** REPLACE 활용 실습 ***/

--1. 이메일 주소에서 모든 점 (.) 하이픈 (-) 대체
SELECT EMP_ID, EMAIL, REPLACE(EMAIL, '.', '-') AS "수정된 이메일"
FROM EMPLOYEE;

--2. 주민번호에서 모든 하이픈을 빈문자열로 대체
SELECT EMP_NAME, EMP_NO, REPLACE(EMP_NO, '-', '') AS "수정된 주민번호"
FROM EMPLOYEE;

-- 3. 이름에서 김을 KIM
SELECT EMP_NAME, REPLACE(EMP_NAME, '김', 'KIM') AS "수정된 이름"
FROM EMPLOYEE;

-- 4.직무코드 J 를 JOB
SELECT EMP_ID, JOB_CODE, REPLACE(JOB_CODE, 'J', 'JOB') AS "수정된 직무코드"
FROM EMPLOYEE;











