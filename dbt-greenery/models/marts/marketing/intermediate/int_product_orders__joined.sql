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
    concat(order_items.order_id, '-', products.product_id) AS id,
    products.product_id,
    products.name,
    order_items.order_id,
    order_items.quantity,
    products.price AS unit_cost

FROM products
INNER JOIN order_items
    ON products.product_id = order_items.product_id
