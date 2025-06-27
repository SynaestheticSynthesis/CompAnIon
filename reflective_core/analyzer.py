from textblob import TextBlob

def analyze_entry(text):
    blob = TextBlob(text)
    polarity = blob.sentiment.polarity
    subjectivity = blob.sentiment.subjectivity

    emotions = []
    if polarity > 0.2:
        emotions.append("Positive")
    elif polarity < -0.2:
        emotions.append("Negative")
    else:
        emotions.append("Neutral")

    if subjectivity > 0.5:
        emotions.append("Personal")
    else:
        emotions.append("Objective")

    return {
        "polarity": polarity,
        "subjectivity": subjectivity,
        "emotions": emotions,
        "keywords": blob.noun_phrases
    }
