{{
    config(
        materialized='table'
    )
}}

WITH

promos AS (
    SELECT * FROM {{ ref('stg_promos') }}
)

SELECT
    promo_id,
    discount

FROM promos
