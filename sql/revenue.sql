-- Daily revenue + % change (drop detection)
WITH daily_revenue_cte AS (SELECT CAST(order_time AS DATE) AS order_date, SUM(order_value) AS daily_revenue
FROM fd_orders_large
GROUP BY CAST(order_time AS DATE))

SELECT order_date, daily_revenue, (daily_revenue - prev_revenue) * 1.0/NULLIF(prev_revenue, 0) AS percent_change,
CASE WHEN (daily_revenue - prev_revenue) * 1.0 / NULLIF(prev_revenue, 0) < 0 THEN 'Drop' ELSE 'No_Drop'
END AS drop_flag
FROM (
SELECT order_date, 	daily_revenue, LAG(daily_revenue) OVER(ORDER BY order_date) AS prev_revenue
FROM daily_revenue_cte) AS t1

-- Average order value trend
SELECT CAST(order_time AS DATE) AS order_date, AVG(order_value) AS AOV
FROM fd_orders_large
GROUP BY CAST(order_time AS DATE)
ORDER BY order_date

-- Delivery performance
SELECT AVG(delivery_time_minutes) AS avg_delivery_time
FROM fd_orders_large

SELECT TOP 5
CAST(order_time AS DATE) AS order_date,
AVG(delivery_time_minutes) AS avg_delivery_time
FROM fd_orders_large
GROUP BY CAST(order_time AS DATE)
ORDER BY avg_delivery_time DESC

-- High-value users
WITH users_revenue AS (SELECT user_id, SUM(order_value) AS revenue
FROM fd_orders_large
GROUP BY user_id)

SELECT COUNT(user_id) AS no_of_high_value_users
FROM (
SELECT user_id, revenue, NTILE(5) OVER(ORDER BY revenue DESC) AS rnk
FROM users_revenue) AS t1
WHERE rnk = 1
