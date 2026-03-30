-- User Funnel
WITH session_users AS (SELECT user_id, MAX(CASE WHEN session_type = 'browse' THEN 1 END) AS browsed, MAX(CASE WHEN session_type = 'search' THEN 1 END) AS searched,
MAX(CASE WHEN session_type = 'checkout' THEN 1 END) AS checkout
FROM fd_sessions_large
GROUP BY user_id),

order_users AS (
    SELECT DISTINCT user_id FROM fd_orders_large
)

SELECT COUNT(CASE WHEN browsed = 1 THEN 1 END) AS users_browsed,
COUNT(CASE WHEN searched = 1 THEN 1 END) AS users_searched,
COUNT(CASE WHEN checkout = 1 THEN 1 END) AS users_checkout,
COUNT(o.user_id) AS users_ordered
FROM session_users s
LEFT JOIN order_users o ON s.user_id = o.user_id


-- Drop-offs
WITH user_funnel AS (SELECT user_id, MAX(CASE WHEN session_type = 'browse' THEN 1 END) AS browsed, MAX(CASE WHEN session_type = 'search' THEN 1 END) AS searched,
MAX(CASE WHEN session_type = 'checkout' THEN 1 END) AS checkout
FROM fd_sessions_large
GROUP BY user_id),

order_users AS (
    SELECT DISTINCT user_id FROM fd_orders_large
)

SELECT 
COUNT(CASE WHEN browsed = 1 AND searched IS NULL THEN 1 END) AS browse_search_drop,
COUNT(CASE WHEN searched = 1 AND checkout IS NULL THEN 1 END) AS search_checkout_drop,
COUNT(CASE WHEN checkout = 1 AND o.user_id IS NULL THEN 1 END) AS checkout_order_drop
FROM user_funnel f
LEFT JOIN order_users o ON f.user_id = o.user_id

