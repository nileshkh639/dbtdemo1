{{ config(
    materialized='table'
) }}

with products as (

    select
        product_id,
        product_name,
        category,
        price,
        stock_quantity,
        supplier,
        case 
            when stock_quantity = 0 then 'Out of Stock'
            when stock_quantity < 50 then 'Low Stock'
            else 'In Stock'
        end as stock_status
    from `nileshdbt639.staging.products`

)

select * from products

