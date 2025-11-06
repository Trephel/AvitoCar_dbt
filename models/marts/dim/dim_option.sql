{{ config(materialized='table') }}

with options as (
    select distinct unnest(array[
        'ABS','ESP','Camera_de_recul','Radar_de_recul','Jantes_aluminium',
        'Climatisation','Toit_ouvrant','CD_MP3_Bluetooth','Sieges_cuir','Systeme_de_navigation_GPS'
    ]) as option_name
)

select
    md5(option_name) as option_key,
    option_name
from options
