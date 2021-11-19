{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='order_id',
      check_cols=['tracking_id', 'shipping_service','estimated_delivery_at', 'delivered_at', 'status']
    )
  }}

  SELECT * 
  FROM {{ source('greenery', 'orders') }}

{% endsnapshot %}
