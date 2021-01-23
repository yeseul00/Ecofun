drop table simple_bbs;

drop sequence simple_bbs_seq;

create table simple_bbs (
     id number(4) primary key,  --아이디
     writer varchar2(100),          --작성자
     title varchar2(100),      --제목
     content varchar2(100),      --내용
     bHit number(4) default 0,   -- 조회수
     bGroup number(4) default 0, --댓글
     bImg varchar2(200)         --이미지저장
 );

create sequence simple_bbs_seq; 
 
drop table bbs_member;

create table bbs_member(
  id varchar2(50) not null primary KEY,
  password varchar2(50) not null,
  name varchar2(50),
  gender varchar2(10),
  birth date,
  mail varchar2(100),
  phone varchar2(50),
  address varchar2(200),
  reg date default sysdate
);

insert into bbs_member (id,password, name, gender,birth,mail,phone,address)
                        values ('admin','11','관리자','남','2020-03-20','admin@gmail.com','01012341234','관리자입니다');

select simple_bbs_seq.nextval FROM DUAL;

insert into simple_bbs (id, writer, title, content, bImg)
                    values ('1', '관리자', '게시글테스트', '테스트입니다.', '/upload/20209252146202.jpg');

commit;