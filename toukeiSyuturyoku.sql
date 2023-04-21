show variables like "chara%";

-- 統計情報の確認

SELECT * FROM mysql.innodb_table_stats order by last_update DESC ;

SELECT * FROM prefectures;

DELETE FROM prefectures where prefecture_code =48 and name="不明";

-- 統計情報の手動更新
analyze table prefectures;


-- SQLを実行せずに実行計画だけ表示
explain SELECT * FROM customers;

-- SQLを実行して実行計画だけ表示
explain analyze SELECT * FROM customers;

SELECT * FROM customers;

explain analyze SELECT * FROM customers;

/*
-> Table scan on customers  (cost=50450.00 rows=497050) (actual time=0.346..326.654 rows=500000 loops=1)
*/
EXPLAIN select * from customers WHERE id =1;

/*
* -> Rows fetched before execution  (cost=0.00..0.00 rows=1) (actual time=0.000..0.000 rows=1 loops=1)
*/

EXPLAIN ANALYZE select * from customers WHERE id <10;

/*
-> Filter: (customers.id < 10)  (cost=2.06 rows=9) (actual time=0.019..0.094 rows=9 loops=1)
    -> Index range scan on customers using PRIMARY over (id < 10)  (cost=2.06 rows=9) (actual time=0.017..0.091 rows=9 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name ="Olivia";

/*
-> Filter: (customers.first_name = 'Olivia')  (cost=50450.00 rows=49705) (actual time=0.187..379.635 rows=503 loops=1)
    -> Table scan on customers  (cost=50450.00 rows=497050) (actual time=0.183..318.376 rows=500000 loops=1)
*/

CREATE INDEX icx_customer_first_name on customers(first_name);

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name ="Olivia";
/*
-> Index lookup on customers using icx_customer_first_name (first_name='Olivia')  (cost=176.05 rows=503) (actual time=0.892..3.806 rows=503 loops=1)

*/


EXPLAIN ANALYZE SELECT * FROM customers WHERE gender="F";
/*
-> Filter: (customers.gender = 'F')  (cost=50450.00 rows=49705) (actual time=0.120..353.348 rows=250065 loops=1)
    -> Table scan on customers  (cost=50450.00 rows=497050) (actual time=0.116..284.778 rows=500000 loops=1)
*/

CREATE index idx_customer_gender on customers(gender);
EXPLAIN ANALYZE SELECT * FROM customers WHERE gender="F";

/*
-> Index lookup on customers using idx_customer_gender (gender='F'), with index condition: (customers.gender = 'F')  (cost=27087.50 rows=248525) (actual time=9.043..886.767 rows=250065 loops=1)

*/

DROP INDEX idx_customer_gender ON customers;
DROP INDEX icx_customer_first_name on customers;