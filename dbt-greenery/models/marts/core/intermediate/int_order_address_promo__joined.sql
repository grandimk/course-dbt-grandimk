{{
    config(
        materialized='table'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

addresses AS (
    SELECT * FROM {{ ref('stg_addresses') }}
),

promos AS (
    SELECT * FROM {{ ref('stg_promos') }}
)

SELECT
    orders.order_id,
    orders.user_id,

    concat(
        addresses.address,
        addresses.zipcode,
        addresses.state,
        addresses.country
    ) AS delivery_address,

    orders.status,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    CASE
        WHEN orders.promo_id IS NOT NULL THEN promos.discount
        ELSE 0
    END AS discount,
    orders.order_total,
    orders.shipping_service,
    orders.tracking_id,
    orders.estimated_delivery_at,
    orders.delivered_at

FROM orders
INNER JOIN addresses
    ON orders.address_id = addresses.address_id
LEFT JOIN promos
    ON orders.promo_id = promos.promo_id
