{{
    config(
        materialized='table'
    )
}}

SELECT
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at
FROM {{ source('greenery', 'events') }}
WHERE created_at IS NOT NULL
