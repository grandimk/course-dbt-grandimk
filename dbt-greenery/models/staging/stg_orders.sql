{{
    config(
        materialized='view'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ source('greenery', 'orders') }}
)

SELECT
    order_id,
    promo_id,
    user_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status

FROM orders
