{{
config(
    materialized='view',
    event_time='created_at'
    )
}}

WITH SRC_LISTING AS (
    SELECT * FROM {{ref('src_listing')}}
)

SELECT
    LISTING_ID
    , LISTING_NAME
    , CASE WHEN MINIMUM_NIGHTS = 0 THEN 1 ELSE MINIMUM_NIGHTS END AS MINIMUM_NIGHTS
    , HOST_ID
    , REPLACE(PRICE_STR, '$')::NUMBER(10, 2) AS PRICE
    , ROOM_TYPE
    , CREATED_AT
    , UPDATED_AT
FROM SRC_LISTING