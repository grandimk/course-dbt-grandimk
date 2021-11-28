{{
    config(
        materialized='view'
    )
}}

SELECT
    product_id,
    name,
    price,
    quantity
FROM {{ source('greenery', 'products') }}
