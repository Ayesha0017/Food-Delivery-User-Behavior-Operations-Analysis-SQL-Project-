-- Time to order
WITH user_sessions AS (
    SELECT user_id, MIN(session_start) AS first_session
    FROM fd_sessions_large 
    GROUP BY user_id
),
user_orders AS (
    SELECT user_id, MIN(order_time) AS first_order
    FROM fd_orders_large
    GROUP BY user_id
),
t1 AS (
    SELECT s.user_id, DATEDIFF(day, first_session, first_order) AS time_to_order
    FROM user_sessions s
    JOIN user_orders o ON s.user_id = o.user_id
)

SELECT 
AVG(time_to_order) AS avg_time_to_order,
MAX(median_time_to_order) AS median_time_to_order
FROM (
    SELECT 
        time_to_order,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY time_to_order) 
        OVER () AS median_time_to_order
    FROM t1
) t

-- Sessions before first order
WITH user_first_orders AS (
SELECT user_id, MIN(order_time) AS first_order
FROM fd_orders_large
GROUP BY user_id)

SELECT AVG(no_of_sessions) AS avg_sessions
FROM (
SELECT s.user_id, COUNT(*) AS no_of_sessions
FROM fd_sessions_large s
JOIN user_first_orders o ON s.user_id = o.user_id 
WHERE session_start < first_order
GROUP BY s.user_id) AS t1

-- Daily active users
SELECT CAST(session_start AS DATE) AS session_date, COUNT(DISTINCT user_id) AS DAU
FROM fd_sessions_large
GROUP BY CAST(session_start AS DATE)
ORDER BY session_date

-- Q6. Power users
WITH user_events AS (SELECT user_id, DATEPART(YEAR, session_start) AS yr, DATEPART(WEEK, session_start) AS week_num
FROM fd_sessions_large)

SELECT COUNT(*) AS power_user_count
FROM (
SELECT user_id
FROM user_events
GROUP BY user_id, yr, week_num
HAVING COUNT(*) > 3) AS t