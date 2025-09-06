# 🕵️ Solve CLI Treasure Hunt Challenge

You are about to solve a CLI Treasure Hunt! Your goal is to find 5 hidden 4-letter words across different challenge types and combine them for final verification.

---

## 🎯 Phase 1: Understand Your Mission

### 1.1 Read Player Role
```
Reference File: agents/player/player-agent.md
```
Read this file to understand your role as a Digital Detective and available investigation tools.

### 1.2 Study Challenge Hints
Navigate to the challenge directory and read:
```
File: challenges/[CHALLENGE_ID]/hints.md
```
This contains cryptic clues for each of the 5 puzzles.

### 1.3 Examine Verification Method
Check the submission process:
```
File: challenges/[CHALLENGE_ID]/verify-solution.sh
```
Understand the format: `./verify-solution.sh WORD1-WORD2-WORD3-WORD4-WORD5`

---

## 🔍 Phase 2: Systematic Investigation

Navigate to the challenge folder: `challenges/[CHALLENGE_ID]/`

### Challenge 1: Log Analysis 🗂️
**Directory**: `1-logs/`
**Skills**: System log forensics, timestamp analysis, pattern recognition
**Tools**: `grep`, `awk`, `sed`, `cut`, `python3`

**Investigation Steps**:
1. List all files: `ls -la 1-logs/`
2. Examine main log files for patterns
3. Look for timestamp anomalies or ASCII encoding
4. Check error patterns and stack traces
5. Extract the hidden 4-letter word

### Challenge 2: Data Mining 📊
**Directory**: `2-data/`  
**Skills**: Structured data analysis, database forensics
**Tools**: `jq`, `csvkit`, `sqlite3`, `python pandas`

**Investigation Steps**:
1. List all data files: `ls -la 2-data/`
2. Identify file formats (JSON, CSV, XML, SQL)
3. Look for nested data patterns
4. Check coordinate data or key relationships
5. Extract the hidden 4-letter word

### Challenge 3: Image Forensics 🖼️
**Directory**: `3-images/`
**Skills**: Digital forensics, metadata analysis
**Tools**: `exiftool`, `file`, `hexdump`, `strings`

**Investigation Steps**:
1. List all visual files: `ls -la 3-images/`
2. Extract metadata from images
3. Analyze ASCII art patterns
4. Check hex dumps for hidden data
5. Extract the hidden 4-letter word

### Challenge 4: Code Archaeology 💻
**Directory**: `4-code/`
**Skills**: Source code analysis, reverse engineering
**Tools**: `grep`, `python3`, language-specific tools

**Investigation Steps**:
1. List all source files: `ls -la 4-code/`
2. Analyze variable naming patterns
3. Check comments and string data
4. Look for function sequences
5. Extract the hidden 4-letter word

### Challenge 5: Network Investigation 🌐
**Directory**: `5-network/`
**Skills**: Network forensics, protocol analysis  
**Tools**: `dig`, `curl`, `openssl`, `grep`

**Investigation Steps**:
1. List all network files: `ls -la 5-network/`
2. Analyze DNS records and HTTP headers
3. Check SSL certificates and logs
4. Look for protocol patterns
5. Extract the hidden 4-letter word

---

## 🎯 Phase 3: Final Submission

### 3.1 Assemble Answer
Combine your 5 discovered words in order:
```
Format: WORD1-WORD2-WORD3-WORD4-WORD5
Example: BEAR-CAVE-NEST-CULT-SENT
```

### 3.2 Submit Solution
Execute the verification script:
```bash
cd challenges/[CHALLENGE_ID]/
./verify-solution.sh YOUR-FIVE-WORDS-HERE
```

### 3.3 Report Result
Announce the verification script output:
- **Success**: Celebrate your treasure hunt victory! 🏆
- **Failure**: Review your analysis and try again

---

## 💡 Pro Detective Tips

- **Start with hints**: Each cryptic clue points to a specific technique
- **Use multiple tools**: Try different approaches if first method fails
- **Look for patterns**: Hidden data follows logical rules
- **Think forensically**: Consider how data might be encoded
- **Be systematic**: Document your discoveries as you investigate

**Good luck, Digital Detective! The treasure awaits your analytical skills!** 🏴‍☠️💎