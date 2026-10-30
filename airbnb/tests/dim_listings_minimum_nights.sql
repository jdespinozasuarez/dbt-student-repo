WITH BASE AS 
    (select * from {{ref('dim_listing_cleansed')}})

SELECT * FROM BASE
WHERE MINIMUM_NIGHTS < 0