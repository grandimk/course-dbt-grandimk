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
    event_id AS page_view_id,
    page_url,
    session_id,
    user_id,
    created_at AS viewed_at

FROM events
WHERE event_type = 'page_view'
