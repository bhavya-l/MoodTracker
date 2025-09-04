# Mood Tracking App - Notes & Roadmap

## Core Concept
- Primary goal: Track and reflect user mood while respecting **privacy**.
- **User mood slider** is the primary input (70–90% weight).
- **Environmental sensors** (sound, light, activity, etc.) provide **context/insights**, not direct mood scoring.
  - Example: "Your mood was 4/10 today. We noticed it was noisy and dark – these factors might have contributed."

## Data & Privacy
- Data stored:
  - Mood scores (user-entered + aggregated insights).
  - General settings (notifications, sleep schedule).
- Data discarded:
  - Raw sensor readings (used only for generating context, then immediately discarded).
- User privacy is **top priority**.