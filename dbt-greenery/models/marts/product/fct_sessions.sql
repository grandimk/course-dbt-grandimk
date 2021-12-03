{{
    config(
        materialized='table'
    )
}}

WITH

events AS (
    SELECT * FROM {{ ref('int_events__unique_user') }}
)

SELECT
    session_id,
    user_id,
    min(created_at) AS started_at,
    max(created_at) AS finished_at

FROM events
GROUP BY 1, 2
