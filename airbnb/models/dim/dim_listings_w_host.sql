{{
config(
    materialized='table')
}}

WITH h AS (
    SELECT * FROM {{ref('dim_host_cleansed')}}
),

l AS (
    SELECT * FROM {{ref('dim_listing_cleansed')}}
)

SELECT
    L.LISTING_ID
    , L.LISTING_NAME
    , L.ROOM_TYPE
    , L.MINIMUM_NIGHTS
    , L.PRICE
    , L.HOST_ID
    , H.HOST_NAME
    , H.IS_SUPERHOST AS HOST_IS_SUPERHOST
    , L.CREATED_AT AS LISTING_CREATED_AT
    , GREATEST(L.UPDATED_AT, H.UPDATED_AT) AS UPDATED_AT
FROM L
LEFT JOIN h
    ON L.HOST_ID = H.HOST_ID