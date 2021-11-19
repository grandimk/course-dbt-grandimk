{% snapshot promos_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='promo_id',
      check_cols=['status']
    )
  }}

  SELECT * 
  FROM {{ source('greenery', 'promos') }}

{% endsnapshot %}
