
SELECT
  product_name,
  SUM(quantity) AS units_sold,
  COUNT(DISTINCT order_id) AS orders_count
FROM order_products_clean
GROUP BY product_name
ORDER BY units_sold DESC, orders_count DESC
LIMIT 10;


