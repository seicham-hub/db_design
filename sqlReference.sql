select name,kihonkyu,kihonkyu*1.5 AS next_kihonkyu from Syain;
select *,if(kihonkyu =200000 and id=2,"OK","NG") AS "お気に入り" ;


SELECT name,age FROM cusomers WHERE age >=28 and age<=40 name LIKE '%子' ORDER BY age DESC LIMIT 5;


DESCRIBE receipts
SELECT * FROM receipts ORDER BY id DESC LIMIT 10;
INSERT INTO receipts VALUES(301,100,"Store X",10000);


SELECT * FROM receipts ORDER BY id DESC LIMIT 10;

DELETE FROM receipts WHERE id =301;

SELECT * FROM prefectures WHERE name="" OR name IS NULL;
DELETE FROM prefectures WHERE name ="" OR name IS NULL;

SELECT *,age+1 FROM customers WHERE id BETWEEN 20 and 50;

UPDATE customers SET age = age+1 WHERE id BETWEEN 20 and 50;


SELECT * ,CEILING(RAND()*5)+1 FROM students WHERE class_no =6;
UPDATE students SET class_no = CEILING(RAND()*5);

SELECT * FROM students 
WHERE height<ALL(SELECT height+10 FROM students WHERE class_no IN(3,4))
AND class_no=1;


select *,TRIM(department) FROM employees;
UPDATE employees SET department = TRIM(department);


select *,ROUND(salary*0.9) from employees WHERE salary >=5000000;
-- update2回だと2回更新されるデータがあるのでダメ

select *,ROUND(salary*1.1) FROM employees WHERE salary < 5000000;

update employees SET salary = CASE
 WHEN salary >=5000000 THEN ROUND(salary*0.9)
 WHEN salary < 5000000 THEN ROUND(salary*1.1)
END

select *,CURDATE() from customers;
INSERT INTO customers VALUES (101,"名無権兵衛",0,CURDATE());


select * from customers;

ALTER TABLE customers ADD name_length INT;

select *,CHAR_LENGTH(name) FROM customers;
update customers SET name_length = CHAR_LENGTH(name);

ALTER TABLE tests_score ADD score INT;
UPDATE tests_score SET
score = CASE
    WHEN COALESCE(test_score_1,test_score_2,test_score_3) >=900
    THEN FLOOR(COALESCE(test_score_1,test_score_2,test_score_3)*1.2)
    WHEN COALESCE(test_score_1,test_score_2,test_score_3) >=600
    THEN FLOOR(COALESCE(test_score_1,test_score_2,test_score_3)*0.8)
    ELSE COALESCE(test_score_1,test_score_2,test_score_3)
END ;

select * from employees 
ORDER BY 
CASE department
    WHEN "マーケティング部" THEN 1
    WHEN "研究部" THEN 2
    WHEN "開発部" THEN 3
    WHEN "総務部" THEN 4
    WHEN "営業部" THEN 5
    WHEN "営業部" THEN 6
END;


-- 和集合
-- UNIONは重複する行は一つにまとめる。UNION ALLはそのまま。