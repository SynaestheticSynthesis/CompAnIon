# analyzer.py

def analyze_conversation(text):
    lines = text.strip().split("\n")
    insights = []
    self_awareness_score = 0
    emotional_depth_score = 0
    initiator = None

    for i, line in enumerate(lines):
        if "θέλω" in line or "θέλω να" in line:
            self_awareness_score += 1
        if "φοβάμαι" in line or "νιώθω" in line or "πίεση" in line:
            emotional_depth_score += 1
        if i == 0 and "user" in line.lower():
            initiator = "user"

        insights.append({
            "line": line,
            "insight": "contains self-awareness" if "θέλω" in line else "neutral"
        })

    profile = {
        "self_awareness_level": "High" if self_awareness_score > 2 else "Medium",
        "emotional_depth": emotional_depth_score,
        "initiator": initiator == "user",
        "raw_insights": insights
    }

    return profile
