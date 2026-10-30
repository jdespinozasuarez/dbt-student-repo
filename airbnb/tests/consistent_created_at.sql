SELECT * FROM {{ ref('dim_listing_cleansed') }}
INNER JOIN {{ ref ('fct_reviews') }} USING (listing_id)
WHERE fct_reviews.review_date < dim_listing_cleansed.created_at