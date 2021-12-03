{{
    config(
        materialized='table'
    )
}}

WITH

events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

sessions_with_unique_user AS (
    SELECT
        session_id

    FROM events
    GROUP BY 1
    HAVING count(distinct user_id) = 1
)

SELECT
    events.session_id,
    events.user_id,
    min(events.created_at) AS started_at,
    max(events.created_at) AS finished_at

FROM events
INNER JOIN sessions_with_unique_user AS sessions_wuu
    ON events.session_id = sessions_wuu.session_id
GROUP BY 1, 2
