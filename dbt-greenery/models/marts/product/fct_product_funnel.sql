{{
    config(
        materialized='table'
    )
}}

WITH

events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

{%
    set levels = {
        'total': ['delete_from_cart', 'package_shipped', 'account_created', 'page_view', 'add_to_cart', 'checkout'],
        'product_page_view': ['page_view', 'add_to_cart', 'checkout'],
        'add_to_cart': ['add_to_cart', 'checkout'],
        'checkout': ['checkout']
    }
%}

session_count_by_level AS(
    SELECT
     {% for (level_name, event_type_list) in levels.items() %}
        (
            SELECT count(distinct session_id)
            FROM events
            WHERE event_type IN ('{{ "', '".join(event_type_list) }}')
        ) AS {{ level_name }}_session_count
        {%- if not loop.last -%}
            ,
        {%- endif -%}
    {% endfor %}
)

SELECT *
FROM session_count_by_level
