{{
    config(
        materialized='incremental',
        unique_key='page_view_id'
    )
}}

WITH

orders AS (
    SELECT * FROM {{ ref('stg_events') }}
)

SELECT
    event_id AS page_view_id,
    page_url,
    user_id,
    created_at AS viewed_at

FROM events
WHERE created_at IS NOT NULL
    AND event_type = 'page_view'
