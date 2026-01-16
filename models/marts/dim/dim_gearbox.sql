{{ config(materialized='table') }}

with boxes as (
    select distinct gearbox
    from {{ ref('int_avito_enriched') }}
    where gearbox is not null
)

select
    md5(coalesce(gearbox,'')) as gearbox_key,
    gearbox
from boxes
