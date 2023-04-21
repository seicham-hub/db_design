show tables;

select * from students order by id DESC;

show index from students;

alter table students add column name varchar(255);

UPDATE students set name= concat(last_name,first_name);

INSERT INTO students value (81,"Taro","",4,"Taro");

explain select * from students where name="Taro";


create index idx_students_name ON students(name);

explain select * from students where lower(name) ="taro";


create index idx_students_lower_name ON students((lower(name)));

select * from users where first_name="涼平";

create unique index idx_users_unique_firstname on users(first_name);
