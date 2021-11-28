{{
    config(
        materialized='table'
    )
}}

WITH

users AS (
    SELECT * FROM {{ ref('stg_users') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)

SELECT
    users.user_id,
    orders.order_id

FROM users
INNER JOIN orders
    ON users.user_id = orders.user_id
