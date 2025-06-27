from core.analyzer import analyze_entry
from core.profile import update_profile

if __name__ == "__main__":
    print("Welcome to CompAnIon Reflective Core.")
    sample_input = input("Enter journal or thought: ")
    analysis = analyze_entry(sample_input)
    profile = update_profile(analysis)
    
    print("\n--- Emotional Analysis ---")
    print(analysis)
    
    print("\n--- Updated Profile ---")
    print(profile)
