# reflective_core/analyzer.py

import re

def extract_insights(conversation_text):
    insights = {}

    # Count how often the user uses introspective prompts
    introspective_patterns = [
        r"\b(ποιος είμαι|τι θέλω|πώς νιώθω|γιατί φοβάμαι|τι με κρατά)\b",
        r"\b(who am I|what do I want|why am I stuck|how do I feel)\b"
    ]
    insights["introspective_prompts"] = sum(
        len(re.findall(p, conversation_text, re.IGNORECASE))
        for p in introspective_patterns
    )

    # Check for emotional tone shifts
    tone_shift_count = conversation_text.lower().count("i feel") + conversation_text.lower().count("νιώθω")
    insights["emotional_references"] = tone_shift_count

    # Detect calls to action
    if "let's do it" in conversation_text.lower() or "ξεκινάμε" in conversation_text.lower():
        insights["calls_to_action"] = True
    else:
        insights["calls_to_action"] = False

    return insights
