{{ config(
    materialized = 'table'
) }}

with base as (

    select *
    from {{ ref('stg_avito_listings') }}

),

enriched as (

    select
        -- Identifiant technique
        listing_id,

        -- Dimensions texte
        brand,
        model,
        city,
        state,
        neighborhood,
        origin,
        fuel_type,
        gearbox,

        -- Clés techniques (hash)
        md5(coalesce(brand, ''))                                         as brand_key,
        md5(coalesce(brand, '') || '|' || coalesce(model, ''))           as model_key,
        md5(coalesce(city, '') || '|' || coalesce(neighborhood, ''))     as city_key,
        md5(coalesce(fuel_type, ''))                                     as fuel_key,
        md5(coalesce(gearbox, ''))                                       as gearbox_key,
        md5(coalesce(state, ''))                                         as state_key,

        -- Mesures
        price,
        mileage,
        year_model,
        doors,
        horsepower,

        -- Flags business
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

        -- Métriques dérivées (business ready)
        case
            when price is not null and mileage is not null and mileage > 0
                then round(price / mileage, 2)
            else null
        end                                                             as price_per_km,

        case
            when year_model is not null
                then extract(year from current_date) - year_model
            else null
        end                                                             as vehicle_age,

        -- Score équipement (exploitable BI)
        (
            coalesce(has_abs::int, 0) +
            coalesce(has_esp::int, 0) +
            coalesce(has_rear_camera::int, 0) +
            coalesce(has_parking_sensors::int, 0) +
            coalesce(has_alloy_wheels::int, 0) +
            coalesce(has_ac::int, 0) +
            coalesce(has_sunroof::int, 0) +
            coalesce(has_bluetooth::int, 0) +
            coalesce(has_leather_seats::int, 0) +
            coalesce(has_gps::int, 0)
        )                                                               as equipment_score,

        -- Métadonnées
        scraped_at,
        sync_id,
        meta

    from base

)

select *
from enriched
