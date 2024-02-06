use day_10_14;
show tables;

select * from employees;

-- windows関数
select *,avg(age) over(),count(*) over()
from employees;


select * ,avg(age) over(partition by department_id) as avg_age,
count(*) over(partition by department_id)as count_department
from employees;


select distinct concat(count(*) over(partition by floor(age/10)),"人") as age_count,floor(age/10)*10
from employees;


select *,sum(order_amount*order_price) over (partition by DATE_FORMAT(order_date,"%y/%m"))
from orders;


-- order by 
select
*,
count(*) over(order by age) as tmp_count
from
employees;

select * ,sum(order_price) over (order by order_date,customer_id) from orders;

select
floor(age/10),
count(*) over(order by floor(age/10))
from employees;

-- partition by + orderby
select 
*,
min(age) over(partition by department_id order by age ) as count_value
from employees;


-- 演習問題
-- 
-- 1. employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。
-- 
-- 両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。
-- 
-- 連結の際は、重複を削除するようにしてください。

select id,first_name,last_name,age from employees as e
where e.id < 10
union
select id,first_name,last_name,age from customers as c
where c.id <10;

select distinct 
ue.first_name, ue.last_name, ue.age
from (
select first_name, last_name, age from employees
where id < 10
union
select first_name, last_name, age from customers
where id <10
) as ue;
-- 
-- 2. departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
-- 
-- employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
-- 
-- salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
-- 
-- 月収はsalariesテーブルのpaymentカラムに格納されています


select * from departments where name = "営業部";

select p.first_name,p.last_name, max(p.payment),min(p.payment),avg(p.payment),sum(p.payment) 
from 
(select e.id as employee_id,e.first_name,e.last_name,s.payment from employees as e
inner join
(select id as department_id,name from departments where name = "営業部") as d
on e.department_id = d.department_id
inner join 
salaries as s 
ON s.employee_id = e.id) as p
group by p.first_name,p.last_name;

SELECT p.employee_id, e.first_name, e.last_name, 
       MAX(p.payment) AS max_payment, 
       MIN(p.payment) AS min_payment, 
       AVG(p.payment) AS avg_payment, 
       SUM(p.payment) AS sum_payment
FROM employees AS e
INNER JOIN (SELECT e.id AS employee_id, s.payment
            FROM departments AS d
            INNER JOIN employees AS e ON d.id = e.department_id
            INNER JOIN salaries AS s ON e.id = s.employee_id
            WHERE d.name = '営業部') AS p 
ON e.id = p.employee_id
GROUP BY p.employee_id, e.first_name, e.last_name;


select
	case when c.id < 5 then "5未満" else "5以上" end as category,
	count(s.id)
from
	classes AS c
	inner join enrollments as e on c.id = e.class_id 
	INNER JOIN students as s on e.student_id = s.id
group BY 
	category
;

select * from classes;
select * from enrollments;

-- 4. ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
-- 
-- employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています
SELECT
last_name ,
first_name ,
sum(s.payment) as sum_payment,
floor(avg(s.payment))as avg_payment
from employees as e join salaries as s on e.id = s.employee_id 
where e.age <40
group by e.id
having avg_payment > 7000000
;

-- 5. customer毎に、order_amountの合計値を計算してください。
-- 
-- customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
-- 
-- ordersテーブルのorder_amountの合計値を取得します。
-- 
-- SELECTの対象カラムに副問い合わせを用いて値を取得してください。
SELECT 
	customer_id,
	sum(order_amount) as order_sum 
FROM 
	customers as c 
	inner join orders as od on c.id = od.customer_id
GROUP BY 
	customer_id;

-- 6. customersテーブルからlast_nameに田がつくレコード、
-- 
-- ordersテーブルからorder_dateが2020-12-01以上のレコード、
-- 
-- storesテーブルからnameが山田商店のレコード同士を連結します
-- 
-- customersとorders, ordersとitems, itemsとstoresが紐づきます。
-- 
-- first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。

SELECT
	concat(last_name,first_name) as full_name,
	sum(customer_id) as sum_order_amount
FROM 
	(select * from customers where last_name like "%田%") as cs
	left outer join (select * from orders where order_date > "202-12-01") as od on od.customer_id = cs.id
	left outer join items as i on  od.item_id=i.id
	left outer join (select * from stores where name ="山田商店") as st on st.id = i.store_id 
GROUP BY 
	full_name
	;

-- 
-- 7. salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
-- 
-- employeesテーブルとsalariesテーブルを紐づけます。
-- 
-- EXISTSとINとINNER JOIN、それぞれの方法で記載してください

select
	*
from employees as e left outer join salaries as s on e.id =s.employee_id 
where payment>9000000;

select
	*
from employees where exists(
	select * from salaries where employees.id = salaries.employee_id and salaries.payment >9000000
)

-- 8. employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
-- 
-- EXISTSとINとLEFT JOIN、それぞれの方法で記載してください

select 
*
from employees as e left outer join salaries as s on e.id = s.employee_id 
where s.employee_id  IS NULL;  

select
*
from employees as e where not exists(
select * from salaries as s where e.id = s.employee_id);


-- 9. employeesテーブルとcustomersテーブルのage同士を比較します
-- 
-- customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
-- 
-- employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
-- 
-- 平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
-- 
-- WITH句を用いて記述します

with ages as(
	select 
	min(age) as min,
	avg(age) as avg,
	max(age) as max
	from customers
)
select
	last_name ,
	first_name ,
	age,
	ages.min,
	ages.avg,
	ages.max,
	case when age < ages.min then "最小未満"
	when age < ages.avg then "平均未満"
	when age < ages.max then "最大未満"
	else "エラー"
	end as "年齢制限"
from employees,ages ;


-- 10. customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
-- 
-- customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
-- 
-- 合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
-- 
-- 7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。
SELECT
	*,
	SUM(od.order_amount*od.order_price) OVER (PARTITION BY od.order_date)
FROM (SELECT * FROM customers WHERE age >50) AS c
INNER JOIN orders AS od ON c.id = od.customer_id ;

