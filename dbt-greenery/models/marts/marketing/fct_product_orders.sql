{{
    config(
        materialized='table'
    )
}}

WITH

product_orders AS (
    SELECT * FROM {{ ref('int_product_orders__joined') }}
)

SELECT
    product_id,
    name,
    order_id,
    quantity

FROM product_orders
