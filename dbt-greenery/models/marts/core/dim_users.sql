{{
    config(
        materialized='table'
    )
}}

WITH

users AS (
    SELECT * FROM {{ ref('int_user_address__joined') }}
)

SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    address,
    created_at

FROM users
