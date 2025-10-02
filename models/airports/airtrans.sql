{{ config(
    materialized='table'
) }}

with airport as (

    select
        object_id,
        faa_identifier,
        name,
        airport_type,
        service_city,
        country,

    from `nileshdbt639.staging.airports`

)

select * from airport
where country = 'UK'

