from core.analyzer import analyze_entry
from utils import save_json

if __name__ == "__main__":
    print("Welcome to CompAnIon Reflective Core.")
    print("Type your journal entry (or paste multiple lines). Finish with an empty line:")

    # Multi-line input
    lines = []
    while True:
        line = input()
        if line.strip() == "":
            break
        lines.append(line)
    sample_input = "\n".join(lines)

    analysis = analyze_entry(sample_input)

    print("\n--- Emotional Analysis ---")
    print(analysis)

    save_json("last_analysis.json", analysis)
    print("\nResults saved to last_analysis.json")
