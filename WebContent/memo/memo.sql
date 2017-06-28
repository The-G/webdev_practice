
/* Drop Tables */

DROP TABLE t_memo CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE seq_memo;




/* Create Sequences */

CREATE SEQUENCE seq_memo;



/* Create Tables */

CREATE TABLE t_memo
(
	no number NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	name varchar2(20) NOT NULL,
	PRIMARY KEY (no)
);

select * from t_memo;

