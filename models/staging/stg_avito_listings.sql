{{ config(
    materialized = 'view'
) }}

with source as (

    select *
    from {{ source('raw', 'FinalavitocardatasetALL') }}

),

cleaned as (

    select
        -- Identifiants
        _airbyte_raw_id                              as listing_id,
        trim("Lien")                                as url,

        -- Localisation
        trim("Ville")                               as city,
        trim("Etat")                                as state,
        trim("Secteur")                             as neighborhood,

        -- Véhicule
        trim("Marque")                              as brand,
        trim("Modele")                              as model,
        trim("Origine")                             as origin,

        -- Prix & année
        "Prix"::numeric                             as price,
        "Annee_Modele"::integer                     as year_model,

        -- Kilométrage (nettoyage robuste)
        case
            when "Kilometrage" ~ '^[0-9]+$'
                then "Kilometrage"::bigint
            when "Kilometrage" is null
                then null
            else
                regexp_replace("Kilometrage", '[^0-9]', '', 'g')::bigint
        end                                         as mileage,

        -- Caractéristiques techniques
        trim("Type_de_carburant")                   as fuel_type,
        trim("Boite_de_vitesses")                   as gearbox,
        "Nombre_de_portes"::integer                 as doors,
        "Puissance_fiscale"::integer                as horsepower,

        -- Booléens normalisés
        case when "Premiere_main"::text in ('Oui','TRUE','true','1') then true else false end as is_first_owner,
        case when "ABS"::text in ('Oui','TRUE','true','1') then true else false end as has_abs,
        case when "ESP"::text in ('Oui','TRUE','true','1') then true else false end as has_esp,
        case when "Camera_de_recul"::text in ('Oui','TRUE','true','1') then true else false end as has_rear_camera,
        case when "Radar_de_recul"::text in ('Oui','TRUE','true','1') then true else false end as has_parking_sensors,
        case when "Jantes_aluminium"::text in ('Oui','TRUE','true','1') then true else false end as has_alloy_wheels,
        case when "Climatisation"::text in ('Oui','TRUE','true','1') then true else false end as has_ac,
        case when "Toit_ouvrant"::text in ('Oui','TRUE','true','1') then true else false end as has_sunroof,
        case when "CD_MP3_Bluetooth"::text in ('Oui','TRUE','true','1') then true else false end as has_bluetooth,
        case when "Sieges_cuir"::text in ('Oui','TRUE','true','1') then true else false end as has_leather_seats,
        case when "Systeme_de_navigation_GPS"::text in ('Oui','TRUE','true','1') then true else false end as has_gps,

        -- Métadonnées ingestion
        _airbyte_extracted_at::timestamp             as scraped_at,
        _airbyte_generation_id                       as sync_id,
        _airbyte_meta::jsonb                         as meta

    from source

)

select *
from cleaned
