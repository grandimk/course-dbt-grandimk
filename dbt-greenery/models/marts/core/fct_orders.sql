{{
    config(
        materialized='table'
    )
}}

WITH

orders AS (
    {{ with_address('ststg_ordersg_users') }}
),

promos AS (
    SELECT * FROM {{ ref('stg_promos') }}
)

SELECT
    order_id,
    user_id,
    delivery_address,
    status,
    created_at,
    order_cost,
    shipping_cost,
    CASE
        WHEN orders.promo_id IS NOT NULL THEN promos.discount
        ELSE 0
    END AS discount,
    order_total,
    shipping_service,
    tracking_id,
    estimated_delivery_at,
    delivered_at

FROM orders
LEFT JOIN promos
    ON orders.promo_id = promos.promo_id
