
--sort by items sold & calculate profit earned
select p.product_id,p.product_name,p.supplier_id,sum(o.quantity) as total_sold, sum(p.sale_price * o.quantity) as sale, 
sum(((p.sale_price - p.purchase_price) * o.quantity)) as profit from orders o
JOIN products p ON o.product_id = p.product_id
group by p.product_name,p.product_id,p.supplier_id
order by profit DESC;

--check how many suppliers we have for each product, having purchase_price > sale_price 
select Distinct p.product_id,p.product_name,p.supplier_id,p.sale_price,p.purchase_price
from products p
where p.purchase_price > p.sale_price
order by p.product_name
;


--calculate the loss we will be making on these products
with CTE_prd as ( 
select Distinct p.product_id,p.product_name,p.supplier_id,p.sale_price,p.purchase_price
from products p
where p.purchase_price > p.sale_price
)
select c.product_id,c.product_name, c.purchase_price,c.sale_price,sum(o.quantity) as quantity,
(sum(c.sale_price * o.quantity) - sum(c.purchase_price * o.quantity) ) as loss from CTE_prd c 
JOIN orders o on c.product_id = o.product_id
group by c.product_id,c.product_id,c.product_name, c.purchase_price,c.sale_price;




--select least sold product

with cte_least as(
select p.product_id,p.product_name,sum(o.quantity)as quantity  from products p JOIN
orders o on p.product_id = o.product_id
group by p.product_id, p.product_name)
select product_id,product_name,quantity from cte_least
where quantity < 100
;



--supplier on which the store relies most
select p.supplier_id, count(p.product_id) as products_supplied, s.name
from products p JOIN suppliers s on p.supplier_id = s.supplier_id
group by p.supplier_id, s.name
order by count(p.product_id) DESC;

--customers who have registered with store but haven't made any purchase
select c.id,c.email from
customers c LEFT JOIN orders o on c.id = o.customer_id
where o.customer_id IS NULL;
