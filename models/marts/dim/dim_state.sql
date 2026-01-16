{{ config(materialized='table') }}

with states as (
    select distinct state
    from {{ ref('int_avito_enriched') }}
    where state is not null
)

select
    md5(coalesce(state,'')) as state_key,
    state
from states
