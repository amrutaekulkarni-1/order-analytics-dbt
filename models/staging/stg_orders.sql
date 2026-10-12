
{{ config(materialized='view') }}

SELECT
    order_id,
    CAST(order_date AS DATE) AS order_date,
    CAST(ship_date AS DATE) AS ship_date,
    customer_id,
    customer_tier,
    region,
    product,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(order_value AS DECIMAL(10, 2)) AS order_value,
    CAST(processing_time_hours AS INTEGER) AS processing_time_hours,
    CAST(shipping_time_hours AS INTEGER) AS shipping_time_hours,
    order_status
FROM {{ ref('orders') }}
