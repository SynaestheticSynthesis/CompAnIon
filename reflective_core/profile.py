profile_state = {
    "positive": 0,
    "negative": 0,
    "neutral": 0,
    "personal": 0,
    "objective": 0,
    "entries": 0
}

def update_profile(analysis):
    profile_state["entries"] += 1

    for emotion in analysis["emotions"]:
        if emotion.lower() in profile_state:
            profile_state[emotion.lower()] += 1

    return profile_state
