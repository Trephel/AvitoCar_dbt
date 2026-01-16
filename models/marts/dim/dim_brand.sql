{{ config(materialized='table') }}

with brands as (
    select distinct brand
    from {{ ref('int_avito_enriched') }}
    where brand is not null
)

select
    md5(brand) as brand_key,
    brand
from brands
