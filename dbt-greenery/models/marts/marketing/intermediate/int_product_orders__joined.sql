{{
    config(
        materialized='table'
    )
}}

WITH

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
)

SELECT
    products.product_id,
    products.name,
    order_items.order_id,
    order_items.quantity

FROM products
INNER JOIN order_items
    ON products.product_id = order_items.product_id
