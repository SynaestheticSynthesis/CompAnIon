from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from core.analyzer import analyze_entry
from core.profile import update_profile

app = FastAPI(title="CompAnIon Reflective API")

class JournalEntry(BaseModel):
    text: str

@app.post("/analyze")
def analyze_journal(entry: JournalEntry):
    try:
        analysis_result = analyze_entry(entry.text)
        updated_profile = update_profile(analysis_result)
        return {
            "analysis": analysis_result,
            "profile": updated_profile
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))