SELECT
  d.department,
  ROUND(AVG(op.reordered), 4) AS reorder_rate,
  COUNT(*) AS line_items
FROM order_products_clean op
JOIN products p
  ON op.product_id = p.product_id
JOIN departments d
  ON p.department_id = d.department_id
GROUP BY d.department
HAVING line_items >= 100
ORDER BY reorder_rate DESC, line_items DESC;
