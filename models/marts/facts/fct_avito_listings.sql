{{ 
  config(
    materialized='incremental',
    unique_key='listing_id',
    on_schema_change='append_new_columns'
  ) 
}}

with source as (

    select *
    from {{ ref('int_avito_enriched') }}

    {% if is_incremental() %}
        -- On ne prend que les nouvelles annonces
        where scraped_at > (
            select max(scraped_at) from {{ this }}
        )
    {% endif %}

),

final as (

    select
        listing_id,
        brand_key,
        model_key,
        city_key,
        fuel_key,
        gearbox_key,

        price,
        mileage,
        year_model,

        has_abs,
        has_esp,
        has_ac,
        has_gps,
        has_sunroof,
        has_bluetooth,

        scraped_at

    from source

)

select * from final
