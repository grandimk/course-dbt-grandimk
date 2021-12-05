{{
    config(
        materialized='table'
    )
}}

WITH

users AS (
    {{ with_address('stg_users') }}
)

SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    full_address AS main_address,
    created_at

FROM users
