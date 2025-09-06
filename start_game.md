# 🎮 CLI Treasure Hunt - Game Orchestrator

**Welcome, Game Master!** You are about to create a new CLI Treasure Hunt challenge.

## 🎯 Your Mission
Create a complete 5-step treasure hunt with hidden 4-letter words across different file types and investigation techniques.

---

## 📋 Phase 1: Initialize Challenge

First, you need to understand your role. Read and internalize this:
```
Reference File: agents/organizer/main-organizer.md
```

After reading the organizer template, you will:
1. Generate a unique challenge ID (timestamp-based)
2. Pick 5 random 4-letter English words
3. Create the challenge folder structure
4. Coordinate all 5 challenge agents

---

## 🔧 Phase 2: Create All Challenges Sequentially

The main organizer will guide you through creating each challenge by reading templates and implementing them directly:

### Sequential Challenge Creation Process:
The organizer will instruct you to:

1. **Read** each challenge agent template file
2. **Select** a random subtopic from the 6 available techniques  
3. **Implement** the challenge directly in the appropriate folder
4. **Generate** realistic clutter files for authenticity
5. **Document** the solution method for final metadata

**Flow:**
```
agents/challenges/log-challenge-agent.md → Create 1-logs/ challenge
agents/challenges/data-challenge-agent.md → Create 2-data/ challenge  
agents/challenges/image-challenge-agent.md → Create 3-images/ challenge
agents/challenges/code-challenge-agent.md → Create 4-code/ challenge
agents/challenges/network-challenge-agent.md → Create 5-network/ challenge
```

**Note**: You'll be working as a single CLI assistant implementing all challenges sequentially, not deploying separate agents.

---

## 🎯 Phase 3: Finalize Challenge

After all challenge agents complete their work:

1. **Create Verification Script**
   ```
   Reference File: templates/verify-solution-template.sh
   Update with final answer: WORD1-WORD2-WORD3-WORD4-WORD5
   Save as: challenges/[CHALLENGE_ID]/verify-solution.sh
   ```

2. **Generate Hints File**
   ```
   Reference File: templates/hints-template.md
   Customize with cryptic clues for each challenge
   Save as: challenges/[CHALLENGE_ID]/hints.md
   ```

3. **Create Metadata**
   ```
   Reference File: templates/challenge-metadata-template.json
   Document challenge details and solutions
   Save as: challenges/[CHALLENGE_ID]/metadata.json
   ```

---

## ✅ Success Criteria

When complete, the challenge folder should contain:
- 5 challenge directories (1-logs/, 2-data/, 3-images/, 4-code/, 5-network/)
- Each directory has puzzle files + realistic clutter
- verify-solution.sh script with correct answer
- hints.md with cryptic clues
- metadata.json with full documentation

---

## 🚀 Ready to Start?

**Action**: Reference `agents/organizer/main-organizer.md` to begin!

The treasure hunt creation begins now... 🏴‍☠️💎