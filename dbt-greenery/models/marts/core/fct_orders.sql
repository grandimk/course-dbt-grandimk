{{
    config(
        materialized='table'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ ref('int_order_address_promo__joined') }}
)

SELECT
    order_id,
    user_id,
    delivery_address,
    status,
    created_at,
    order_cost,
    shipping_cost,
    discount,
    order_total,
    shipping_service,
    tracking_id,
    estimated_delivery_at,
    delivered_at

FROM orders
