{{
    config(
        materialized='view'
    )
}}

SELECT
    promo_id,
    discout,
    status
FROM {{ source('greenery', 'promos') }}
