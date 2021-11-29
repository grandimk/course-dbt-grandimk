{{
    config(
        materialized='table'
    )
}}

WITH

sessions AS (
    SELECT * FROM {{ ref('int_sessions__grouped') }}
)

SELECT
    session_id,
    user_id,
    started_at,
    finished_at

FROM sessions
