{% macro grant(role_name) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO {{ role_name }};
      GRANT SELECT ON {{ this }} TO {{ role_name }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}