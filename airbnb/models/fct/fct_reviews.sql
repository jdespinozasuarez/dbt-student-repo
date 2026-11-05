{{
config(
    materialized='incremental',
    on_schema_change='fail')
}}

WITH SRC_REVIEWS AS (
    SELECT * FROM {{ref('src_reviews')}}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['LISTING_ID', 'REVIEW_DATE', 'REVIEWER_NAME', 'REVIEWER_TEXT']) }} as sb_rog_key
  , *
FROM SRC_REVIEWS
WHERE REVIEWER_TEXT IS NOT NULL
{% if is_incremental() %}
    AND REVIEW_DATE > (SELECT MAX(REVIEW_DATE) FROM {{this}})
{% endif %}