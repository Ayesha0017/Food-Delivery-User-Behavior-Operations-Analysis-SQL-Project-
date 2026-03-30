-- Cohort retention
WITH user_cohorts AS (SELECT user_id, DATEFROMPARTS(YEAR(signup_date), MONTH(signup_date), 1) AS signup_month
FROM fd_users_large),

user_activity AS (SELECT user_id, DATEFROMPARTS(YEAR(session_start), MONTH(session_start), 1) AS activity_month
FROM fd_sessions_large)

SELECT c.signup_month, a.activity_month,
DATEDIFF(month, c.signup_month, a.activity_month) AS cohort_month,
COUNT(DISTINCT a.user_id) AS active_users
FROM user_cohorts c
JOIN user_activity a ON c.user_id = a.user_id
GROUP BY c.signup_month, a.activity_month
ORDER BY c.signup_month, cohort_month

-- Repeat order rate:
WITH repeat_users AS (
SELECT user_id 
FROM fd_orders_large
GROUP BY user_id
HAVING COUNT(*) > 1),

users AS (SELECT COUNT(DISTINCT user_id) AS total_users
FROM fd_orders_large)

SELECT 
COUNT(DISTINCT CASE WHEN order_count > 1 THEN user_id END) * 100.0
/ COUNT(DISTINCT user_id) AS repeat_users_percent
FROM (
    SELECT user_id, COUNT(*) AS order_count
    FROM fd_orders_large
    GROUP BY user_id
) t