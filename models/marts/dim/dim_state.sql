{{ config(materialized='table') }}

with states as (
    select distinct state
    from {{ ref('stg_finalavito') }}
    where state is not null
)

select
    md5(coalesce(state,'')) as state_key,
    state
from states
