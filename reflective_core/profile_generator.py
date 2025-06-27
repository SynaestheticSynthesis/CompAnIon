# profile_generator.py

import json
from analyzer import analyze_conversation
from utils import save_json

def main():
    with open("example_conversation.txt", "r", encoding="utf-8") as f:
        conversation = f.read()

    result = analyze_conversation(conversation)
    print("\n🧠 Reflective Analysis Result:\n")
    print(json.dumps(result, indent=4, ensure_ascii=False))

    save_json("profile_output.json", result)

if __name__ == "__main__":
    main()
