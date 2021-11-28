{{
    config(
        materialized='view'
    )
}}

WITH

products AS (
    SELECT * FROM {{ source('greenery', 'products') }}
)

SELECT
    product_id,
    name,
    price,
    quantity

FROM products
