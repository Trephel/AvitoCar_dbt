{{ config(materialized='table') }}

with listings as (
    select
        listing_id,
        has_abs,
        has_esp,
        has_rear_camera,
        has_parking_sensors,
        has_alloy_wheels,
        has_ac,
        has_sunroof,
        has_bluetooth,
        has_leather_seats,
        has_gps
    from {{ ref('int_avito_enriched') }}
),

unpivot as (

    select listing_id, 'ABS' as option_name from listings where has_abs
    union all select listing_id, 'ESP' from listings where has_esp
    union all select listing_id, 'Camera_de_recul' from listings where has_rear_camera
    union all select listing_id, 'Radar_de_recul' from listings where has_parking_sensors
    union all select listing_id, 'Jantes_aluminium' from listings where has_alloy_wheels
    union all select listing_id, 'Climatisation' from listings where has_ac
    union all select listing_id, 'Toit_ouvrant' from listings where has_sunroof
    union all select listing_id, 'CD_MP3_Bluetooth' from listings where has_bluetooth
    union all select listing_id, 'Sieges_cuir' from listings where has_leather_seats
    union all select listing_id, 'Systeme_de_navigation_GPS' from listings where has_gps

)

select
    md5(listing_id || option_name) as listing_option_key,
    listing_id,
    md5(option_name) as option_key,
    option_name
from unpivot
