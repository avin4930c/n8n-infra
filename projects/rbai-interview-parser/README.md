# RBAI Dataset Collection System

**Rider Behavior & Attitude Insight (RBAI) Dataset** - A behavioral-psychological dataset for understanding how people think about and interact with two-wheelers.

## About the Dataset

The RBAI Dataset explores the **multi-layered human side of riding** by capturing:

- **Observable behaviors**: How riders maintain, use, and care for their vehicles
- **Attitudinal profiles**: Psychological dimensions like responsibility, curiosity, and emotional attachment
- **Personal interests**: Lifestyle factors (tech use, spending habits, hobbies)
- **Contextual factors**: Family influence, social dynamics, gender perspectives

### Why This Dataset Exists

Most motorcycle datasets focus on accidents, traffic violations, or sales data. **None explore the psychological and behavioral dimensions** that define how a person interacts with their vehicle.

**RBAI fills four critical gaps:**

1. **Care & Responsibility** - How much someone respects vehicle ownership and takes initiative
2. **Knowledge & Curiosity** - Whether they notice issues, learn mechanics, track maintenance
3. **Personal Interest & Lifestyle** - Passions, risk-taking styles, AI tool usage, spending patterns
4. **Contextual Influence** - Family bike culture, social influence, practical vs emotional reasoning

### Analytical Applications

- **Exploratory Factor Analysis (EFA)** - Reveal hidden dimensions (care/responsibility, knowledge/curiosity)
- **Behavioral Clustering** - Create personas (Pragmatic Commuter, Responsible Caretaker, Enthusiast)
- **Predictive Modeling** - Map behavior patterns (e.g., high responsibility → regular service tracking)
- **AI Use Cases** - Conversational persona detection, personalized recommendations, user modeling

---

## Workflow Overview

This n8n automation pipeline extracts structured behavioral data from interview transcripts.

### Process Flow

1. **Receive** interview text via chat interface
2. **Preprocess** and clean raw text
3. **Extract** structured attributes using LLM (Groq Llama 3.3 70B)
4. **Validate** data types, ranges, and completeness
5. **Generate** AI summaries, tags, and persona labels
6. **Append** structured row to Google Sheets dataset

### Workflow Architecture

```
┌─────────────────────┐
│  Chat Interface     │  ← Paste interview transcript
│  (n8n Chat Trigger) │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Preprocess Text    │  ← Clean whitespace, normalize
└──────────┬──────────┘
           │
           ├──────────────────────┐
           │                      │
           ▼                      ▼
┌─────────────────────┐  ┌─────────────────┐
│  Get Latest Row ID  │  │  Groq LLM       │
│  (Auto-increment)   │  │  Extract Data   │
└──────────┬──────────┘  └────────┬────────┘
           │                      │
           │                      ▼
           │          ┌─────────────────────┐
           │          │  JSON Schema        │
           │          │  Validation         │
           │          └────────┬────────────┘
           │                   │
           └───────┬───────────┘
                   ▼
        ┌─────────────────────┐
        │  Merge & Generate   │
        │  Respondent ID      │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │  Data Validation    │
        │  (28+ fields check) │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │  Append to Google   │
        │  Sheets             │
        └─────────────────────┘
```

---

## Setup Instructions

### 1. Configure Credentials
Before using this workflow, set up these credentials in n8n:
- **Google Sheets OAuth2**: For data storage
- **LLM API** (Groq/OpenAI/etc): For text processing

### 2. Update Configuration
Replace placeholders in `workflow.json`:
- `YOUR_GOOGLE_SHEET_ID`
- `YOUR_CREDENTIAL_ID`
- `YOUR_WEBHOOK_ID`
- etc.

### 3. Customize AI Prompt
Update the prompt in the "Basic LLM Chain" node to match:
- Your specific data schema
- Extraction rules
- Validation requirements

### 4. Import to n8n
1. Import `workflow.json` into n8n
2. Connect all credentials
3. Test with sample data

## Inputs

- Raw interview transcripts
- Metadata (interviewer, timestamp)

## Outputs

**Structured Dataset Row** containing:
- Demographics (age, gender, location, occupation)
- Vehicle context (type, ownership, usage patterns)
- Behavioral indicators (maintenance habits, decision-making autonomy)
- Attitudinal scales (1-5 Likert ratings on responsibility, knowledge interest, emotional attachment)
- Qualitative insights (free-text behavioral and attitudinal notes)
- AI enhancements (generated summary, inferred tags, behavior score, persona label)

**Persona Labels** (auto-assigned):
- The Enthusiast
- The Pragmatist
- The Delegator
- The Casual User
- The Aspirational Rider
- The Responsible Commuter

---

## Dataset Dimensions

The RBAI schema captures **52 attributes** across multiple dimensions:

1. **Demographics & Context** - Age, gender, location, occupation, personal interests, AI/OTT usage
2. **Vehicle Ownership & Usage** - Type, ownership status, frequency, distance, ride purpose
3. **Observable Behaviors** - Maintenance tracking, issue detection, decision autonomy, washing frequency
4. **Attitudinal Scales** - 1-5 Likert ratings on responsibility, knowledge, emotional attachment, risk-taking
5. **Qualitative Insights** - Free-text behavioral notes, attitudinal notes, interviewer observations
6. **AI-Generated Intelligence** - Summary, tags, behavior score (0-35), persona label

---

## Notes

This is a **personal research project** collecting behavioral-psychological data for rider analysis and ML modeling. The full interview methodology, detailed prompts, and schema logic are kept private during the data collection phase.