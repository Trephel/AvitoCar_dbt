{{ config(materialized='view') }}

with source as (
    select *
    from "public"."FinalavitocardatasetALL"
),

normalized as (
    select
        "_airbyte_raw_id" as listing_id,
        "Lien" as url,
        "Prix"::numeric as price,
        "Ville" as city,
        "Etat" as state,
        "Marque" as brand,
        "Modele" as model,
        "Origine" as origin,
        "Secteur" as neighborhood,
        "Unnamed__0" as unnamed__0,
        NULLIF(trim("Kilometrage"), '') as raw_mileage,
        case
            when "Kilometrage" ~ '^[0-9]+$' then cast("Kilometrage" as bigint)
            when "Kilometrage" is null then null
            else cast(regexp_replace("Kilometrage", '[^0-9]', '', 'g') as bigint)
        end as mileage,
        "Annee_Modele"::integer as year_model,
        "Type_de_carburant" as fuel_type,
        "Boite_de_vitesses" as gearbox,
        "Nombre_de_portes"::integer as doors,
        "Puissance_fiscale"::integer as horsepower,
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
        case when "Verrouillage_centralise_a_distance"::text in ('Oui','TRUE','true','1') then true else false end as has_remote_lock,
        case when "Ordinateur_de_bord"::text in ('Oui','TRUE','true','1') then true else false end as has_computer,
        case when "Limiteur_de_vitesse"::text in ('Oui','TRUE','true','1') then true else false end as has_speed_limiter,
        case when "Vitres_electriques"::text in ('Oui','TRUE','true','1') then true else false end as has_power_windows,
        case when "Regulateur_de_vitesse"::text in ('Oui','TRUE','true','1') then true else false end as has_cruise_control,
        _airbyte_extracted_at::timestamp as scraped_at,
        _airbyte_generation_id as sync_id,
        _airbyte_meta::jsonb as meta
    from source
)

select * from normalized
