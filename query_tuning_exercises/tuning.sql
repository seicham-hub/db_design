SELECT count(*) FROM prefectures;
SELECT count(*) FROM customers;

CREATE index idx_customers_prefecture_code ON customers(prefecture_code);

-- customers > prefectures
-- EXISTS

EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr
WHERE EXISTS(SELECT 1 FROM customers as ct WHERE pr.prefecture_code =ct.prefecture_code);

/*
-> Nested loop semijoin  (cost=56488.52 rows=556223) (actual time=0.096..2.021 rows=41 loops=1)
    -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.037..0.060 rows=47 loops=1)
    -> Covering index lookup on ct using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=514868.52 rows=11835) (actual time=0.041..0.041 rows=1 loops=47)
*/

-- IN 
EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr
WHERE prefecture_code IN (SELECT prefecture_code FROM customers);
/*
-> Nested loop semijoin  (cost=56488.52 rows=556223) (actual time=0.057..0.900 rows=41 loops=1)
    -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.024..0.034 rows=47 loops=1)
    -> Covering index lookup on customers using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=514868.52 rows=11835) (actual time=0.018..0.018 rows=1 loops=47)
*/


CREATE table tmp(
id INT PRIMARY KEY,
name VARCHAR(50)
);

show tables;


-- マルチインサート
INSERT INTO tmp VALUES
(1,"A"),
(2,"B"),
(3,"C");

SELECT * from tmp;


CREATE table customer_summary AS
select ct.id,sum(sh.sales_amount) FROM customers AS ct
inner join sales_history AS sh
ON ct.id = sh.customer_id 
GROUP BY ct.id;



-- 練習問題

select * from sales_summary
where YEAR(sales_date) = "2021" and MONTH(sales_date) ="12";

-- 問題点：カラムに対して関数を用いているため、インデックスを利用できない
-- 改善案：関数を使わずに、同じ意味の構文にする

SELECT * FROM sales_summary
WHERE sales_date BETWEEN "2021-12-01" AND "2021-12-31";

-- 例題2
SELECT * FROM sales_history 
WHERE RTRIM(name) = "product_a";

-- 問題点:RTRIMを使用しているため、インデックスが利用できない


SELECT * FROM 
(select * from sales_history WHERE name LIKE "product_a%") as tmp
WHERE RTRIM(name) = "product_a";

-- 例題3
SELECT * FROM users
WHERE first_name IN (SELECT first_name FROM employees WHERE age <30)
AND last_name IN (SELECT last_name FROM employees WHERE age <30);


-- 服問い合わせを2回実行していて、絞り込みも同じになっている。
-- 副問い合わせを1回にして複数カラムに対する絞り込みをする。

SELECT * FROM users
WHERE (first_name,last_name) IN (SELECT first_name,last_name FROM employees WHERE age <30);

-- 例題4 性能を改善するためのインデックス作成案

select
ct.first_name,
ct.last_name,
st.name,
sum(sh.sales_amount)
FROM
	customers AS ct
	INNER JOIN sales_history AS sh ON ct.id=sh.customer_id
	INNER JOIN products AS pr ON sh.product_id = pr.id
	INNER JOIN stores AS st ON pr.store_id = st.id
WHERE 
	ct.first_name = "Olivia" and ct.last_name = "Roach"
GROUP BY
	ct.first_name,ct.last_name,st.name;

-- whereの絞り込みに条件を追加（customersテーブルのfirst_nameとlast_nameにそれぞれ、または複合インデックス）
-- 各外部キー、主キーになければインデックスを作成
	
