# How many users do we have?
Answer: **130**

Query:
``` sql
SELECT count(distinct user_id) FROM dbt_marco_g.stg_users;
```

# On average, how many orders do we receive per hour?
Answer: **8.125**

Query:
``` sql
WITH orders_per_hour AS (
    SELECT
        date(created_at),
        date_part('hour', created_at),
        count(distinct order_id) AS order_count_per_hour
    FROM dbt_marco_g.stg_orders
    GROUP BY 1, 2
)
SELECT round(avg(order_count_per_hour), 3)
FROM orders_per_hour;
```

# On average, how long does an order take from being placed to being delivered?
Answer: **3 days, 22 hours and 13 minutes (~ 94h)**

Query:
``` sql
WITH orders_delivery_times AS (
    SELECT delivered_at - created_at as delivery_time
    FROM dbt_marco_g.stg_orders
    WHERE status = 'delivered'
)
SELECT avg(delivery_time)
FROM orders_delivery_times;
```

# How many users have only made one purchase? Two purchases? Three+ purchases?
Answer:
| # purchases | # users |
|-------------|---------|
|            1|       25|
|            2|       25|
|           3+|       78|

Query:
``` sql
WITH orders_by_user AS (
    SELECT
        user_id,
        count(distinct order_id) as order_count
    FROM dbt_marco_g.stg_orders
    GROUP BY 1
)
SELECT
    CASE
        WHEN order_count >= 3 THEN '3+'
        ELSE order_count::VARCHAR
    END AS number_of_purchases,
    count(*) AS number_of_users
FROM orders_by_user
GROUP BY 1
ORDER BY 1;
```

# On average, how many unique sessions do we have per hour?
Answer: **7.270**

Query:
``` sql
WITH sessions_per_hour AS (
    SELECT
        date(created_at),
        date_part('hour', created_at),
        count(distinct session_id) AS unique_session_per_hour
    FROM dbt_marco_g.stg_events
    WHERE created_at IS NOT NULL
    GROUP BY 1, 2
)
SELECT round(avg(unique_session_per_hour), 3)
FROM sessions_per_hour;
```
