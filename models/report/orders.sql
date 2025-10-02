

{{ config(materialized='table') }}


WITH base_orders AS (
  SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount
  FROM {{ source('bigquery_source', 'orders') }}
)

SELECT
  order_id,
  customer_id,
  order_date,
  order_status,
  order_amount,
  DATE_DIFF(CURRENT_DATE(), order_date, DAY) AS days_since_order,
  CASE
    WHEN order_status = 'Completed' THEN TRUE
    ELSE FALSE
  END AS is_completed,
  CASE
    WHEN order_amount > 300 THEN 'High'
    WHEN order_amount > 150 THEN 'Medium'
    ELSE 'Low'
  END AS order_value_tier
FROM base_orders