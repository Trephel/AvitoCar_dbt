{{ config(materialized='table') }}

with models as (
    select distinct model, brand
    from {{ ref('stg_finalavito') }}
    where model is not null
)

select
    md5(coalesce(brand,'') || '|' || coalesce(model,'')) as model_key,
    brand,
    model
from models
