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
    *

FROM user_orders
