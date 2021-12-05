{% macro with_address(model_name) -%}

    WITH

    addresses AS (
        SELECT * FROM {{ ref('stg_addresses') }}
    ),

    entities_with_address_id AS (
        SELECT * FROM {{ ref(model_name) }}
    )

    SELECT
        {{ dbt_utils.star(from=ref(model_name), except=["address_id"]) }},
        concat(
            addresses.address,
            addresses.zipcode,
            addresses.state,
            addresses.country
        ) AS full_address
    FROM entities_with_address_id
    INNER JOIN addresses
        ON entities_with_address_id.address_id = addresses.address_id

{%- endmacro %}
