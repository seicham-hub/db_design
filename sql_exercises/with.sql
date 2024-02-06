-- with
-- departmentsから営業部の人を取り出して、employeesと結合する。

select
*
from employees as e
inner join departments as d
on e.department_id =d.id 
where d.name = "営業部";

with tmp_departments as(
select * from departments where name ="営業部"
)
select * from employees as e inner join tmp_departments
on e.department_id  = tmp_departments.id;


-- storesテーブルからはid1,2,3のものを取り出す。
-- itemsテーブルと紐づけ、itemsテーブルとordersテーブルを紐づける。
-- ordersテーブルのorder_amount*order_priceの合計値をstoresテーブルのstore_name毎に集計する。

-- 絞り込みはなるべく最初に実行した方がよい。データが多い中で結合すると時間がかかるため。

with tmp_stores as(
select * from stores where id in(1,2,3)
),tmp_items_orders as (
select 
items.id as item_id,
tmp_stores.id as store_id,
orders.id as order_id,
orders.order_amount as order_amount,
orders.order_price as order_price,
tmp_stores.name as store_name
from tmp_stores
inner join items 
on tmp_stores.id = items.store_id
inner join orders 
on orders.item_id  = items.id
)
select store_name,sum(order_amount*order_price) from tmp_items_orders
group by store_name;
