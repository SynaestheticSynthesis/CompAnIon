# reflective_core/profile_generator.py

from analyzer import extract_insights

def generate_profile(conversation_text):
    insights = extract_insights(conversation_text)

    profile = {
        "self_awareness_level": "High" if insights["introspective_prompts"] >= 3 else "Medium",
        "emotional_depth": insights["emotional_references"],
        "initiator": "Yes" if insights["calls_to_action"] else "No",
        "raw_insights": insights
    }

    return profile


# Για δοκιμή
if __name__ == "__main__":
    with open("example_conversation.txt", "r", encoding="utf-8") as f:
        text = f.read()
        profile = generate_profile(text)
        for k, v in profile.items():
            print(f"{k}: {v}")
