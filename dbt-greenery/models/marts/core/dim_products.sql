{{
    config(
        materialized='table'
    )
}}

WITH

products AS (
    SELECT * FROM {{ ref('stg_products') }}
)

SELECT
    product_id,
    name,
    price

FROM products
