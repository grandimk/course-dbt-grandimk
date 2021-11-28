{{
    config(
        materialized='view'
    )
}}

WITH

promos AS (
    SELECT * FROM {{ source('greenery', 'promos') }}
)

SELECT
    promo_id,
    discout AS discount,
    status

FROM promos
