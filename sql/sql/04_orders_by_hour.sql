SELECT
  order_hour_of_day,
  COUNT(*) AS total_orders
FROM orders_clean
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;
