from textblob import TextBlob

def get_sentiment(text):
    return TextBlob(text).sentiment.polarity


def model(dbt, session):
    dbt.config(
        materialized="table",
        packages=["textblob", "snowflake-connector-python[pandas]"]
        # enabled=False # We are adding this line in the Model Lifecycle / Disabling Models section
    )

    fct_df = dbt.ref("fct_reviews")

    df = fct_df.to_pandas()

    df["SENTIMENT_SCORE"] = df["REVIEWER_TEXT"].apply(get_sentiment)

    # return final dataset (Pandas DataFrame)
    return df