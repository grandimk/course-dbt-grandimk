{{
    config(
        materialized='table'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ ref('int_order_address__joined') }}
)

SELECT
    order_id,
    user_id,
    delivery_address,
    created_at,
    order_cost,
    shipping_cost,
    discount,
    order_total,
    shipping_service,
    delivered_at

FROM orders
WHERE created_at IS NOT NULL
    AND status = 'delivered'
