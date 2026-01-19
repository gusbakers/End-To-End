
SELECT
  p.product_name,
  SUM(op.quantity) AS units_sold,
  COUNT(DISTINCT op.order_id) AS orders_count
FROM order_products_clean op
JOIN products p
  ON op.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC, orders_count DESC
LIMIT 10;


