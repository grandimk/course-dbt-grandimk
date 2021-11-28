{{
    config(
        materialized='view'
    )
}}

WITH

events AS (
    SELECT * FROM {{ source('greenery', 'events') }}
)

SELECT
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at

FROM events
