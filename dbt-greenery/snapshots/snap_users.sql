{% snapshot users_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='timestamp',
      unique_key='user_id',
      updated_at='updated_at'
    )
  }}

  SELECT *
  FROM {{ source('greenery', 'users') }}

{% endsnapshot %}
