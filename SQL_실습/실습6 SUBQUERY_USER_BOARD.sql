CREATE TABLE USERS(
    USERID NUMBER NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL,
    PASSWORD VARCHAR2(100) NOT NULL,
    CREATEDDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE USER_SEQ; 

INSERT INTO USERS
VALUES(user_seq.nextval, '홍길동', 'hong@example.com', 'password123', sysdate);

INSERT INTO USERS
VALUES(user_seq.nextval, '김철수', 'kim@example.com', 'mypassword', sysdate);

INSERT INTO USERS
VALUES(user_seq.nextval, '이영희', 'lee@example.com', 'securepass', sysdate);

CREATE TABLE BOARD(
    POSTID NUMBER NOT NULL,
    USEID NUMBER NOT NULL,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT CLOB NOT NULL,
    CREATEDDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE BOARD_SEQ;

INSERT INTO BOARD VALUES(board_seq.nextval, 1, '첫 번째 게시물', '이것은 첫 번째 게시물의 내용입니다.', SYSDATE);
INSERT INTO BOARD VALUES(board_seq.nextval, 2, '두 번째 게시물', '이것은 두 번째 게시물의 내용입니다.', SYSDATE);
INSERT INTO BOARD VALUES(board_seq.nextval, 3, '세 번째 게시물', '이것은 세 번째 게시물의 내용입니다.', SYSDATE);