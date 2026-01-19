SELECT
  order_hour,
  COUNT(DISTINCT order_id) AS total_orders
FROM order_products_clean
GROUP BY order_hour
ORDER BY order_hour;
