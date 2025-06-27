# profile_generator.py

import json
from .analyzer import analyze_entry
from utils import save_json

def main():
    with open("example_conversation.txt", "r", encoding="utf-8") as f:
        conversation = f.read()

    result = analyze_conversation(conversation)
    print("\n🧠 Reflective Analysis Result:\n")
    print(json.dumps(result, indent=4, ensure_ascii=False))

    # Update the profile based on the analysis result
    profile_result = update_profile(result)

    save_json("profile_output.json", profile_result)  # Save the updated profile

if __name__ == "__main__":
    main()

# profile.py

profile_state = {
    "high_self_awareness": 0,
    "medium_self_awareness": 0,
    "entries": 0,
    "total_emotional_depth": 0
}

def update_profile(analysis):
    profile_state["entries"] += 1
    if analysis["self_awareness_level"] == "High":
        profile_state["high_self_awareness"] += 1
    else:
        profile_state["medium_self_awareness"] += 1
    profile_state["total_emotional_depth"] += analysis["emotional_depth"]
    return profile_state
