{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

orders_with_quantity AS (
    SELECT
        orders.order_id,
        orders.order_total,
        orders.created_at,
        orders.delivered_at,
        sum(order_items.quantity) as number_of_items

    FROM orders
    INNER JOIN order_items
        ON orders.order_id = order_items.order_id
    WHERE orders.created_at IS NOT NULL
        AND orders.status = 'delivered'
    GROUP BY 1, 2, 3, 4
),

users AS (
    SELECT * FROM {{ ref('stg_users') }}
)

SELECT
    concat(order_items.order_id, '-', users.user_id) AS id,
    users.user_id,
    users.first_name,
    users.last_name,
    orders_wq.order_id,
    orders_wq.order_total,
    orders_wq.created_at,
    orders_wq.delivered_at,
    orders_wq.number_of_items

FROM users
INNER JOIN orders_with_quantity as orders_wq
    ON users.user_id = orders_wq.user_id
