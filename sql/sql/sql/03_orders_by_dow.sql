SELECT
  order_dow,
  CASE order_dow
    WHEN 0 THEN 'Sun'
    WHEN 1 THEN 'Mon'
    WHEN 2 THEN 'Tue'
    WHEN 3 THEN 'Wed'
    WHEN 4 THEN 'Thu'
    WHEN 5 THEN 'Fri'
    WHEN 6 THEN 'Sat'
  END AS dow_name,
  COUNT(*) AS total_orders
FROM orders_clean
GROUP BY order_dow
ORDER BY order_dow;
