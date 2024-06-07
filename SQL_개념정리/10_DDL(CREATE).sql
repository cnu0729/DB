/*
DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어

OBJECT  CREATE  ALTER   DROP
객체     만들고 수정하고 삭제하는 언어
--------------------------------------------------------------------------------
오라클에서 객체 : 테이블(TABLE) 뷰(VIEW) 시퀀스(SEQUENCE)
                 인텍스(INDEX) 패키지(PACKAGE) 트리거(TRIGGER)
                 프로시져(PROCEDURE) 함수(FUNCTION)
                 동의어(SYNONYM) 사용자(USER)
--------------------------------------------------------------------------------

CREATE
- 테이블이나 인덱스, 뷰 등 다양한 데이터 베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거할 수 있음

1. 테이블 생성하기
 - 테이블이란?
 -- 행(ROW)와 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체
 --- 데이터베이스 내에서 모든 데이터는 테이블을 통해 저장
 
 --- [ 표현식 ]
 CREATE TABLE 테이블명 (
            컬럼명 자료형(크기),
            컬럼명 자료형(크기),
            ...);
            
 ----- [ 자료형 ]
            NUMBER : 숫자형 (정수, 실수)
            
            CHAR(크기) : 고정길이 문자형 (2000BYTE)
            VARCHAR2(크기) : 가변길이 문자형 (4000BYTE) VARCHAR1의 업그레이드 버전
            
            ABC 문자열을 CHAR VARCHAR2 저장하면 어떻게 되는가?
            CHAR(10) 컬럼 : CHAR는 10을 모두 소진
            VARCHAR(10) 컬럼 : VARCHAR2 3만큼만 소진 나머지 7은 반환
            
            DATE : 날짜 타입
            BLOB : 대용량 사진 / 동영상 / 파일 데이터 저장 (4GB)
            CLOB : 대용량 문자 데이터 (4GB)
    
    UTF-8
    영어, 숫자, 특수문자 == 1BYTE
    나머지(한글 등)      == 3BYTE
*/

-- USER_MEMBER 테이블 생성
--- 필요한 컬럼 : 아이디 비밀번호 이름 주민번호 가입일 

-- 아이디    : USER_ID / 자료형 VARCHAR2(20)
-- 비밀번호  : USER_PW / 자료형 VARCHAR2(20)
-- 이름      : USER_NAME / 자료형 VARCHAR2(16) -- 한글 5글자 까지 OK
-- 주민번호  : USER_SSN / CHAR(14)  -- 14글자 고정
-- 가입일    : ENROLL_DATE / 자료형 DATE - DEFAULT SYSDATE -> 현재 시간 기본값

CREATE TABLE USER_MEMBER(
USER_ID VARCHAR2(20),
USER_PW VARCHAR2(20),
USER_NAME VARCHAR2(16),
USER_SSN CHAR(14),
ENROLL_DATE DATE DEFAULT SYSDATE
);

-- DEFAULT (=기본값) 컬럼의 기본값 지정 (필수 아님)
--> default 기본값을 지정하고 insert 나 update 문을 작성해줄 때
----> 지정한 기본값이 들어감

-- 테이블 잘 만들어졌는지 확인
SELECT * FROM USER_MEMBER;

-- 2. 컬럼에 주석으로 컬럼에 대한 설명 추가
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';

COMMENT ON COLUMN "USER_MEMBER".USER_ID IS '회원아이디';

-- 제약 조건 
-- unique primary key foreign key check

/*
제약조건 (CONSTRAINTS)
사용자가 원하는 조건의 데이터만 유지하기 위해 특정컬럼에 설정하는 제약

데이터 무결성 보장을 목적으로 함
+ 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
데이터 수정 / 삭제 가능 여부 검사 등을 목적으로 함
--> 제약 조건을 위배하는 DML 구문은 수행할 수 없음

제약 조건 종류
PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

-- 제약 조건 확인
-- USER_CONSTRAINTS : 사용자가 작성한 제약 조건을 확인하는 딕셔너리 뷰

OWNER              : 유저 아이디
CONSTRAINT_NAME    : 제약 조건 이름
CONSTRAINT_TYPE    : 제약 조건 유형
                     C : CHECK
                     P : PRIMARY KEY
                     U : UNIQUE
                     R : FOREIGN KEY
                     V : VIEW
                     O : 읽기 전용 뷰
TABLE_NAME         : 제약 조건이 적용된 테이블 이름
*/

DESC USER_CONSTRAINTS;
-- 단축키 모두 지우기 CTRL SHIFR D

SELECT * FROM USER_CONSTRAINTS;

-- 1. NOT NULL
-- 해당 컬럼에 반드시 값이 존재해야하는 경우 사용
-- 삽입 / 수정시 NULL 값을 허용하지 않도록 컬럼 레벨에서 제한

-- NOT NULL을 지정한 테이블 생성
CREATE TABLE USER_TEST_TABLE (
    USER_NO NUMBER(10,0) NOT NULL, -- 컬럼 레벨 제약 조건 설정
    USER_ID VARCHAR2(30),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(20),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );

-- INSERT 모두 작성
INSERT INTO USER_TEST_TABLE
VALUES(1, '사용자1', 'PW1', '홍길동', '남', '010-1111-2222', 'hong@hong.co.kr');

-- INSERT 모두 작성
INSERT INTO USER_TEST_TABLE
VALUES(null, '사용자1', 'PW1', '홍길동', '남', '010-1111-2222', 'hong@hong.co.kr');
/*
SQL 오류: ORA-01400: cannot insert NULL into
NULL값을 넣을 수 없음

USER_NO NUMBER (10,0) NOT NULL
NULL 값을 넣을 수 없다 설정 했기 때문에 빈 값 NULL을 넣을 수 없는 것
*/

-- 2. UNIQUE 제약 조건
-- 컬럼에 입력 값에 대해서 중복을 제한하는 제약 조건
-- 컬럼 레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- 단, UNIQUE 제약 조건이 설정된 컬럼에 NULL 값은 삽입 가능
-- UNIQUE 컬럼 여러개 각 컬럼에다가 중복 삽입 가능
-- 테이블 상품명 / 개수 / 설명(UNIQUE)-NULL(하나) / 품절유무(UNIQUE)-NULL(하나)

-- UNIQUE 제약 조건이 들어간 조건 테이블 생성
CREATE TABLE UNIQUE_TABLE(
    USER_NO NUMBER(10,0),
    
    --USER_ID VARCHAR2(20) UNIQUE -- 컬럼 레벨 제약 조건 (이름X)
    -- (방법1)
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_U UNIQUE, -- CONSTRAINT 제약조건명 제약조건종료
                                                      -- 컬럼 레벨 제약 조건 (이름O)
                                                      
    -- (방법2)
    USER_NAME VARCHAR2(30), -- 테이블 레벨로 UNIQUE 제약 조건 설정
    
    -- 테이블 레벨 --
    -- UNIQUE(USER_NAME) -- 컬럼 레벨 제약 조건 (이름X)
    CONSTRAINT USER_NAME_U UNIQUE(USER_NAME)
);

-- KH_CAFE 테이블 만들기
-- CAFE_ID NUMBER 10 기본키 (PRIMARY KEY)
-- CAFE_NAME VARCHAR2 (100) 널 값 못들어가게 설정
-- CAFE_PHONE VARCHAR2 (20) 핸드폰 번호 카페 중복 X (방법1)
-- CAFE_ADDRESS VARCHAR2 (100) 주소 카페 중복 X (방법2)
CREATE TABLE KH_CAFE(
    CAFE_ID NUMBER(10,0) PRIMARY KEY,
    CAFE_NAME VARCHAR2(100) NOT NULL,
    CAFE_PHONE VARCHAR2(20) CONSTRAINT C_P_U UNIQUE,
    CAFE_ADDRESS VARCHAR2(100),
    CONSTRAINT C_A_U UNIQUE(CAFE_ADDRESS)
);
/*
ORA-00955: name is already used by an existing object
존재하기 떄문에 중복X
*/

INSERT INTO KH_CAFE
VALUES(1, '맥아커피', '02-1111-1111', '서울시 강남구 광남동 2길');

/*
ALTER 를 사용하여 컬럼 크기 수정 가능
ALTER 테이블명 MODIFTY (수정할 컬럼명 수정할 크기);

ALTER TABLE KH_CAFE MODIFT (CAFE_PHONE VARCHAR2(20);
*/

COMMIT;

-- 13.PRIMARY KEY(기본키) 제약조건

-- 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미함
-- 테이블에 대한 식별자(IDENTIFIER) 역할을 함
-- NOT NULL + UNIQUE 제약 조건의 의미
-- 한 테이블 당 한개만 설정 가능
-- 컬럼 레벨, 테이블 레벨 둘 다 설정 가능
-- 한개 컬럼에 설정할 수 있고, 여러개의 컬럼을 묶어서 설정할 수 있음

/*
CREATE TABLE 테이블명(
-- (방법1)
    컬럼명 자료형(정수자리값,실수자리값) PRIMARY KEY,

-- (방법2)
    컬럼명 자료형(정수자리값,실수자리값) CONSTRAINT 인덱스에저장할이름 PRIMARY KEY

-- (방법3_
    컬럼명 자료형(정수자리값,실수자리값)
    CONSTRAINT 인덱스에저장할이름 PRIMARY KEY(연결할컬럼명)
);
*/

CREATE TABLE USER_PRIMARY_TABLE(
    USER_NO NUMBER(10,0) CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_NAME VARCHAR2(200)
);

COMMIT;

INSERT INTO USER_PRIMARY_TABLE VALUES (1, '홍길동');

INSERT INTO USER_PRIMARY_TABLE VALUES (1, '이순신');
--> 기본키 중복으로 오류
----> ORA-00001: unique constraint (KH_T.USER_NO_PK) violated
------> USER_PRIMARY_TABLE 테이블에서 USER_NO 컬럼에 1 값이 존재하는데
------> 추가로 1을 넣는다고 했기 때문에 중복으로 오류

INSERT INTO USER_PRIMARY_TABLE VALUES (NULL, '이순신');
---->NULL을 삽입 X

-- UNIQUE와 PRIMARY 차이점--
-- UNIQUE는 컬럼에서 NULL이 한 개는 허용됨 두개 이상 안됨
-- PRIMARY KEY NULL 값 안되고 중복 안됨

/*
FOREIGN KEY (외부키) 제약조건

-- 배달 어플 - 카페 참조

참조된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있음

FOREIGN KEY - 삭제, 테이블 부모까지 삭제하는데 있어 에러 발생

CONSTRAINT 인덱스값 REFERENCES 컬럼명(참조할키);
*/

/*--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CREATE TABLE 부모테이블(
    부모컬럼1 자료형(10,0) PRIMARY KEY,
    부모컬럼2 자료형(30) NOT NULL
    );

-- USER_GRADE GRADE_CODE 참조하는 테이블 생성
CREATE TABLE 자식테이블(
컬럼1 자료형(10,0) PRIMARY KEY,
컬럼2 자료형(20) UNIQUE,
컬럼3 자료형(30) NOT NULL,

(방법1) - 마음대로 삭제 못하게 한다.
컬럼4 NUMBER CONSTRAINT 인덱스이름 REFERENCES 부모테이블(부모컬럼1)

(방법2) - 부모키 삭제시 자식키를 NULL로 변경하는 옵션 : ON DELETE SET NULL
컬럼4 NUMBER CONSTRAINT 인덱스이름 REFERENCES 부모테이블(부모컬럼1) ON DELETE SET NULL

(방법3) - 부모키 삭제시 자식키도 함께 삭제시킨다. 
컬럼4 NUMBER CONSTRAINT 인덱스이름 REFERENCES 부모테이블(부모컬럼1) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER(10,0) PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );

INSERT INTO USER_GRADE VALUES(10,'일반회원');
INSERT INTO USER_GRADE VALUES(20,'우수회원');
INSERT INTO USER_GRADE VALUES(30,'특별회원');
COMMIT;

-- USER_GRADE GRADE_CODE 참조하는 테이블 생성
CREATE TABLE USER_FK(
USER_NO NUMBER(10,0) PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PW VARCHAR2(30) NOT NULL,
GRADE_CODE NUMBER CONSTRAINT G_C_F REFERENCES USER_GRADE(GRADE_CODE)
);

SELECT * FROM USER_GRADE;
/*
10 일반회원
20 우수회원
30 특별회원
*/

INSERT INTO USER_FK VALUES (1,'USER01', 'PW01', 10);

SELECT * FROM USER_FK;

INSERT INTO USER_FK VALUES (2,'USER02', 'PW02', 20);
INSERT INTO USER_FK VALUES (3,'USER03', 'PW03', 30);
INSERT INTO USER_FK VALUES (4,'USER04', 'PW04', 40);
-- parent key not found 부모인 키 USER_GRADE 에 40 이라는 값이 없어서 넣을 수 없음

INSERT INTO USER_GRADE VALUES (40, '플래티넘회원');
INSERT INTO USER_FK VALUES (4,'USER04', 'PW04', 40);

INSERT INTO USER_FK VALUES(5, 'USER05', 'PW05', 50);
-- PARENT KEY NOT FOUND 부모인 키 USER_GRADE 에 50 이라는 값이 없어서 넣을 수 없음

INSERT INTO USER_GRADE VALUES (00, '임시회원'); --> 정수에서 맨 앞에 0 사라짐
--> 핸드폰 번호를 기입할 때는 VARCHAR2를 사용해서 010 모두 들어갈 수 있도록 설정
SELECT * FROM USER_GRADE;

-- 만약에 USER01 이라는 회원이 일반 회원으로 지정이 되어있는데
-- 직원이 실수로 일반회원을 없애려고 함
-- USER01 회원의 등급이 사라지기 때문에 마음대로 사라지게 할 수 없도록
-- 처음부터 설정

DELETE FROM USER_GRADE WHERE GRADE_CODE = 10;
-- ORA-02292: child record found
-- 10번을 참조하는 자식이 있으므로 삭제할 수 없음

-- 배달 어플 A 카페 폐업
-- 배달 어플 -> A카페 카페 마음대로 폐업은 못하지!!
-- A카페가 열어놓은 메뉴들은 모두 삭제하고 가
-- A카페 폐업할 때 연결된 메뉴까지 한 번에 삭제

-- CASCADE -- 부모키 삭제시 참조하는 자식의 행도 모숟 삭제

-- 삭제는 아니고 메뉴들을 NULL 값으로 변경하고 싶음
-- NULL 적용

--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
/*
 5. CHECK 제약 조건 : 컬럼에 기록되는 값에 조건을 설정할 수 있음
 CHEACK (컬럼명 비교연산자 비교값)
 비교값은 변하는 값이나 함수 사용 불가
*/

CREATE TABLE USER_CHECK(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PW VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK(GENDER IN ('남', '여'))
);
-- 앞으로 GENDER 컬럼에는 남 이나 여 라는 글자만 들어갈 수 있음

INSERT INTO USER_CHECK
VALUES(1, 'USER01', 'PW01', '홍길동', '남');

INSERT INTO USER_CHECK VALUES
(2, 'USER02', 'PW02', '박철수', '남자');
/*
ORA-02290: check constraint (KH_T.SYS_C007160) violated
제약조건으로 남이나 여만 가능하게 했는데 남자라는 조건이 들어와 에러 발생
*/

INSERT INTO USER_CHECK VALUES
(2, 'USER02', 'PW02', '박철수', '여');

INSERT INTO USER_CHECK VALUES
(3, 'USER03', 'PW03', '강영희', '려');

-- CHECK 사용 방법
-- 1번 방법 따로 INDEX 에 기록하지 않고 조건 설정만 할 경우
컬럼명 자료형() CHECK(컬럼명 IN ('조건1', '조건2'))

-- 2번 방법 따로 INDEX 에 기록한다음 조건 설정 할 경우 (한줄 작성)
컬럼명 자료형() CONSTRAINT 인덱스에기록할이름 CHECK(컬럼명 IN ('조건1', '조건2'))

-- 3번 방법 따로 INDEX 에 기록한다음 조건 설정 할 경우 (여러 줄 작성)
컬럼명 자료형,
CONSTRAINT 인덱스에기록할이름 CHECK(컬럼명 IN ('조건1', '조건2'))


















































