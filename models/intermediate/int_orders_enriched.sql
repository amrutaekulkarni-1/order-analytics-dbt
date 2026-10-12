
{{ config(materialized='view') }}

SELECT
    o.order_id,
    o.order_date,
    o.ship_date,
    o.customer_id,
    o.customer_tier,
    o.region,
    o.product,
    o.quantity,
    o.order_value,
    ct.discount_percentage,

    ROUND(
        o.order_value * COALESCE(ct.discount_percentage, 0) / 100,
        2
    ) AS discount_amount,

    ROUND(
        o.order_value -
        (o.order_value * COALESCE(ct.discount_percentage, 0) / 100),
        2
    ) AS net_order_value,

    o.processing_time_hours,
    o.shipping_time_hours,
    o.order_status

FROM {{ ref('stg_orders') }} AS o

LEFT JOIN {{ ref('customer_tier') }} AS ct
    ON o.customer_tier = ct.customer_tier
