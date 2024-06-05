/****** DECODE 실습 ******/

-- 1) 주어진 학생의 성적을 기준으로 등급 출력
-- SELECT STUDENT_NAME. STUDENT_SSN, DECODE 성별 확인
-- FROM TB_STUDENT
SELECT STUDENT_NAME AS "이름", STUDENT_SSN AS "주민번호",
       DECODE(SUBSTR(STUDENT_NO, 8, 1),
              '1', 'M',
              '2', 'F') AS "성별"
FROM TB_STUDENT;

-- 2)
SELECT EMP_NAME, DEPT_CODE,
       DECODE(DEPT_CODE,
       'D1', '인사관리부',
       'D2', '회계관리부',
       'D3', '마케팅부',
       'D4', '국내영업부',
       '기타') AS "부서"
FROM EMPLOYEE
ORDER BY DEPT_CODE;

-- 3)
-- 2)
SELECT EMP_NAME, JOB_CODE,
       DECODE(JOB_CODE,
       'J1', '대표',
       'J2', '부사장',
       'J3', '부장',
       'J4', '차장',
       'J5', '과장',
       'J6', '대리',
       'J7', '사원',
       '알수없음') AS "직급"
FROM EMPLOYEE;


/****** CASE WHEN THEN ELSE END 실습 ******/
-- 1) 급여에 따라 등급 설정 
--    600만 이상 S1 500만 이상 S2 400만 이상 S3 나머지 급여 등급 표기
SELECT EMP_NAME AS "이름" , SALARY AS "급여",
    CASE
        WHEN SALARY >= 6000000 THEN 'S1'
        WHEN SALARY >= 5000000 THEN 'S2'
        WHEN SALARY >= 4000000 THEN 'S3'
        ELSE 'S4'
    END 급여등급
FROM EMPLOYEE;

-- 2) 사원의 근무 일 수에 따른 근속 기간 분류하는 CASE
----- SELECT EMP_NAME, HIRE_DATE,
----- FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 >= 20 THEN '20년 이상')
----- 10 10년 이상
-- 10년 미만 근속 기간 분류
SELECT EMP_NAME AS "이름", HIRE_DATE AS "입사일",
    CASE
        WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) >= 20 THEN '20년 이상'
        WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) >= 10 THEN '10년 이상'
        ELSE '10년 미만'
    END 근속기간
FROM EMPLOYEE;


