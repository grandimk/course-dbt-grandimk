{{
    config(
        materialized='table'
    )
}}

WITH

user_orders AS (
    SELECT * FROM {{ ref('int_user_orders__joined') }}
)

SELECT
    user_id,
    first_name,
    last_name,
    order_id,
    order_total,
    created_at,
    delivered_at,
    number_of_items

FROM user_orders
