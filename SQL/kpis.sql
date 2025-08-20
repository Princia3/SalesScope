CREATE OR REPLACE VIEW base_line_items AS
SELECT
  order_id,
  order_date,
  product_id,
  category,
  sub_category,
  quantity,
  list_price,
  cost_price,
  discount_percent,
  (list_price * (1 - discount_percent/100.0)) * quantity AS revenue,
  ((list_price * (1 - discount_percent/100.0)) - cost_price) * quantity AS profit
FROM orders;

--Revenue
SELECT
  date_trunc('month', order_date)::date AS month_start,
  ROUND(SUM(revenue), 2) AS monthly_revenue,
  ROUND(SUM(profit), 2)  AS monthly_profit
FROM base_line_items
GROUP BY 1
ORDER BY 1;

--Profit
SELECT
  ROUND(SUM(profit), 2)  AS total_profit,
  ROUND(SUM(revenue), 2) AS total_revenue,
  ROUND(100.0 * SUM(profit) / NULLIF(SUM(revenue), 0), 2) AS profit_margin_pct
FROM base_line_items;

--top cities
SELECT
  city,
  ROUND(SUM(revenue), 2) AS total_revenue,
  ROUND(SUM(profit), 2)  AS total_profit
FROM base_line_items
JOIN orders USING (order_id)
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;

--top products
SELECT
  product_id,
  sub_category,
  ROUND(SUM(revenue), 2) AS total_revenue,
  ROUND(SUM(profit), 2)  AS total_profit,
  SUM(quantity)          AS total_qty
FROM base_line_items
GROUP BY product_id, sub_category
ORDER BY total_revenue DESC
LIMIT 15;

-- profit by products
SELECT
  product_id,
  sub_category,
  ROUND(SUM(profit), 2)  AS total_profit,
  ROUND(SUM(revenue), 2) AS total_revenue,
  SUM(quantity)          AS total_qty
FROM base_line_items
GROUP BY product_id, sub_category
ORDER BY total_profit DESC
LIMIT 15;
