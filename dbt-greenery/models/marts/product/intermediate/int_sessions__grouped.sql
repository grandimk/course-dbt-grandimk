{{
    config(
        materialized='table'
    )
}}

WITH

events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

SELECT
    session_id,
    -- user_id,
    min(created_at) AS started_at,
    max(created_at) AS finished_at

FROM events
WHERE
    created_at IS NOT NULL
GROUP BY session_id
