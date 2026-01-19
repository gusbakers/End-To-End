SELECT
  department,
  ROUND(AVG(reordered), 4) AS reorder_rate,
  COUNT(*) AS line_items
FROM order_products_clean
GROUP BY department
ORDER BY reorder_rate DESC, line_items DESC;
