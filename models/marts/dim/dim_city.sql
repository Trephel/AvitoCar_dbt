{{ config(materialized='table') }}

with cities as (
    select distinct city, neighborhood
    from {{ ref('int_avito_enriched') }}
)

select
    md5(coalesce(city,'') || '|' || coalesce(neighborhood,'')) as city_key,
    city,
    neighborhood
from cities
