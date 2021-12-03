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
    events.*

FROM events
INNER JOIN sessions_with_unique_user AS sessions_wuu
    ON events.session_id = sessions_wuu.session_id
