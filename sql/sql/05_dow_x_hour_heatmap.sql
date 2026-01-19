SELECT
  order_dow,
  order_hour_of_day,
  COUNT(*) AS total_orders
FROM orders_clean
GROUP BY order_dow, order_hour_of_day
ORDER BY order_dow, order_hour_of_day;
