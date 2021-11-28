{{
    config(
        materialized='view'
    )
}}

WITH

addresses AS (
    SELECT * FROM {{ source('greenery', 'addresses') }}
)

SELECT
    address_id,
    address,
    zipcode,
    state,
    country

FROM addresses
