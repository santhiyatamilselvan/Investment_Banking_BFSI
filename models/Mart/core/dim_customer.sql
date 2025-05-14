{{
    config
    (
        materialized='table'
    )
}}

with customer as
(
    select*from {{(ref('stg_customers'))}}
),

order_1 as
(
   select*from {{ref('fct_orders')}}
),

customer_order as
(
    select  
            customer_id,
            min(order_date) as first_order_date,
            max(order_date) as recent_order_date,
            count(order_id) as number_of_orders,
            sum(amount) as lifetime_value
    from order_1
    group by 1
),

final as
(
    select 
        c.customer_id,
        c.first_name,
        c.last_name,
        o.first_order_date,
        o.recent_order_date,
        coalesce(o.number_of_orders,0) as number_of_orders,
        o.lifetime_value
    from customer c
    left join customer_order o
    on c.customer_id=o.customer_id
)

select*from final
