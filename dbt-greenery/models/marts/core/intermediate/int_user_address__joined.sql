{{
    config(
        materialized='table'
    )
}}

WITH

users AS (
    SELECT * FROM {{ ref('stg_users') }}
),

addresses AS (
    SELECT * FROM {{ ref('stg_addresses') }}
)

SELECT
    users.user_id,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,

    concat(
        addresses.address,
        addresses.zipcode,
        addresses.state,
        addresses.country
    ) AS address,

    users.created_at

FROM users
INNER JOIN addresses
    ON users.address_id = addresses.address_id
