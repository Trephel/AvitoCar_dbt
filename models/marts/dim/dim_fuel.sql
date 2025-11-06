{{ config(materialized='table') }}

with fuels as (
    select distinct fuel_type
    from {{ ref('stg_finalavito') }}
    where fuel_type is not null
)

select
    md5(coalesce(fuel_type,'')) as fuel_key,
    fuel_type as fuel
from fuels
