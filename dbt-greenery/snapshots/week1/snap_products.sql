{% snapshot products_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='product_id',
      check_cols=['price', 'quantity']
    )
  }}

  SELECT *
  FROM {{ source('greenery', 'products') }}

{% endsnapshot %}
