{{ config(materialized='table') }}

with base as (
    select
        listing_id,
        url,
        price,
        mileage,
        year_model as year,
        doors,
        horsepower,
        scraped_at,
        brand,
        model,
        city,
        neighborhood,
        fuel_type,
        gearbox,
        state,
        is_first_owner,
        has_abs,
        has_esp,
        has_rear_camera,
        has_parking_sensors,
        has_alloy_wheels,
        has_ac,
        has_sunroof,
        has_bluetooth,
        has_leather_seats,
        has_gps,
        meta
    from {{ ref('stg_finalavito') }}
)

, keys as (

    select
        b.*,
        md5(coalesce(b.brand,'') ) as brand_key,
        md5(coalesce(b.brand,'') || '|' || coalesce(b.model,'')) as model_key,
        md5(coalesce(b.city,'') || '|' || coalesce(b.neighborhood,'')) as city_key,
        md5(coalesce(b.fuel_type,'')) as fuel_key,
        md5(coalesce(b.gearbox,'')) as gearbox_key,
        md5(coalesce(b.state,'')) as state_key
    from base b

)

select
    listing_id as listing_id,
    brand_key,
    model_key,
    city_key,
    fuel_key,
    gearbox_key,
    state_key,
    price,
    mileage,
    year,
    doors,
    horsepower,
    scraped_at,
    is_first_owner,
    has_abs,
    has_esp,
    has_rear_camera,
    has_parking_sensors,
    has_alloy_wheels,
    has_ac,
    has_sunroof,
    has_bluetooth,
    has_leather_seats,
    has_gps,
    meta
from keys
