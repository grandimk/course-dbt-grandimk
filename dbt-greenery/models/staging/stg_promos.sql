{{
    config(
        materialized='view'
    )
}}

SELECT
    promo_id,
    discout AS discount,
    status
FROM {{ source('greenery', 'promos') }}
