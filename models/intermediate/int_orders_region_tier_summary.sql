
{{ config(materialized='view') }}

SELECT
    region,
    customer_tier,

    COUNT(*) AS total_orders,

    ROUND(SUM(order_value), 2) AS total_order_value,

    ROUND(AVG(order_value), 2) AS average_order_value,

    SUM(
        CASE
            WHEN shipping_time_hours > 48 THEN 1
            ELSE 0
        END
    ) AS delayed_orders,

    SUM(
        CASE
            WHEN order_value > 500 THEN 1
            ELSE 0
        END
    ) AS high_value_orders

FROM {{ ref('int_orders_enriched') }}

GROUP BY
    region,
    customer_tier
