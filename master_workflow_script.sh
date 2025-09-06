#!/bin/bash

# CLI Treasure Hunt - Master Workflow Script
# Coordinates entire challenge creation process

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# Function to generate random 4-letter English words
generate_words() {
    # Common 4-letter English words for treasure hunts
    local words=(
        "BEAR" "CAVE" "NEST" "HUNT" "GOLD" "KEYS" "MASK" "ROPE" "TOMB" "RUNE"
        "SHIP" "MAPS" "COIN" "GEMS" "PATH" "DOOR" "LOCK" "CODE" "SAGE" "HERO"
        "DAWN" "MOON" "STAR" "FIRE" "WIND" "WAVE" "TREE" "ROCK" "PEAK" "LAKE"
        "FORT" "GATE" "WALL" "ARCH" "HALL" "ROOM" "DESK" "BOOK" "PAGE" "WORD"
        "SIGN" "MARK" "SPOT" "ZONE" "AREA" "SITE" "PLOT" "YARD" "LAND" "ISLE"
    )
    
    # Shuffle and select 5 unique words
    local selected=()
    local used_indices=()
    
    for i in {1..5}; do
        while true; do
            local idx=$((RANDOM % ${#words[@]}))
            if [[ ! " ${used_indices[@]} " =~ " ${idx} " ]]; then
                selected+=("${words[$idx]}")
                used_indices+=($idx)
                break
            fi
        done
    done
    
    echo "${selected[@]}"
}

# Function to create challenge structure
create_challenge_structure() {
    local challenge_id="$1"
    
    log "Creating challenge structure for $challenge_id"
    
    # Create challenge branch
    git checkout -b "$challenge_id" || error "Failed to create branch $challenge_id"
    
    # Create folder structure
    mkdir -p {1-logs,2-data,3-images,4-code,5-network}/clutter
    
    # Copy player template
    cp "$PROJECT_ROOT/agents/player/player-template.md" ./
    
    success "Challenge structure created"
}

# Function to generate metadata
generate_metadata() {
    local challenge_id="$1"
    local words=("$@")
    local words_array=("${words[@]:1}")  # Remove first element (challenge_id)
    
    cat > "metadata.json" << EOF
{
  "challenge_id": "$challenge_id",
  "created_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "final_answer": "$(IFS=-; echo "${words_array[*]}")",
  "words": {
    "word1": "${words_array[0]}",
    "word2": "${words_array[1]}", 
    "word3": "${words_array[2]}",
    "word4": "${words_array[3]}",
    "word5": "${words_array[4]}"
  },
  "challenge_assignments": {
    "logs": {
      "agent": "log-challenge-agent",
      "target_word": "${words_array[0]}",
      "folder": "1-logs",
      "status": "pending"
    },
    "data": {
      "agent": "data-challenge-agent", 
      "target_word": "${words_array[1]}",
      "folder": "2-data",
      "status": "pending"
    },
    "images": {
      "agent": "image-challenge-agent",
      "target_word": "${words_array[2]}",
      "folder": "3-images",
      "status": "pending"
    },
    "code": {
      "agent": "code-challenge-agent",
      "target_word": "${words_array[3]}",
      "folder": "4-code",
      "status": "pending"
    },
    "network": {
      "agent": "network-challenge-agent",
      "target_word": "${words_array[4]}",
      "folder": "5-network", 
      "status": "pending"
    }
  }
}
EOF
    
    success "Metadata generated"
}

# Function to create verification script
create_verification_script() {
    local final_answer="$1"
    
    cat > "verify-solution.sh" << EOF
#!/bin/bash

# CLI Treasure Hunt - Solution Verification
# Challenge: $(basename $(pwd))

EXPECTED_ANSWER="$final_answer"
USER_ANSWER="\$1"

if [ -z "\$USER_ANSWER" ]; then
    echo "Usage: \$0 WORD1-WORD2-WORD3-WORD4-WORD5"
    echo "Submit your 5 four-letter words separated by hyphens"
    echo ""
    echo "Example: \$0 BEAR-CAVE-NEST-CULT-SENT"
    exit 1
fi

if [ "\$USER_ANSWER" = "\$EXPECTED_ANSWER" ]; then
    echo "🏆 CONGRATULATIONS! TREASURE FOUND!"
    echo "================================================"
    echo "You have successfully completed the CLI Treasure Hunt!"
    echo "Your digital investigation skills are excellent!"
    echo ""
    echo "Final Answer: \$USER_ANSWER"
    echo "Challenge completed at: \$(date)"
    echo "================================================"
    echo ""
    echo "🎯 Skills Demonstrated:"
    echo "• Log analysis and pattern recognition"
    echo "• Data mining and structured analysis" 
    echo "• Image forensics and metadata extraction"
    echo "• Code archaeology and reverse engineering"
    echo "• Network protocol investigation"
    echo ""
    echo "Ready for the next treasure hunt? 🔍"
else
    echo "❌ Incorrect answer: \$USER_ANSWER"
    echo "Expected format: WORD1-WORD2-WORD3-WORD4-WORD5"
    echo ""
    echo "💡 Tips:"
    echo "• Check hints.md for guidance"
    echo "• Each folder contains exactly one 4-letter word"
    echo "• Use CLI tools for analysis (grep, awk, jq, etc.)"
    echo "• Look for patterns, not just random searching"
    echo ""
    echo "Keep investigating... the treasure is still hidden! 🏴‍☠️"
fi
EOF
    
    chmod +x verify-solution.sh
    success "Verification script created"
}

# Function to create hints file
create_hints_file() {
    cat > "hints.md" << EOF
# CLI Treasure Hunt - Investigation Hints 🕵️

Welcome, Digital Detective! Your mission is to find 5 hidden four-letter words.

## The Investigation

Your target: **5 four-letter English words** hidden across different file types.

Each word is hidden using a different technique in a different folder:

### 🗂️ The Crime Scene
- **1-logs/** - System logs and operational records
- **2-data/** - Structured data files and databases  
- **3-images/** - Visual files and terminal outputs
- **4-code/** - Source code and configuration files
- **5-network/** - Network protocols and communications

## 🔍 Investigation Hints

### Step 1: Time Tells Tales
*Location: 1-logs/*
> "System administrators leave breadcrumbs in their logs. Sometimes the **when** matters more than the **what**. Numbers can represent more than just time..."

### Step 2: Data Points the Way  
*Location: 2-data/*
> "Structured data has structure for a reason. Look for the **organization within the organization**. Hierarchies often spell out their secrets..."

### Step 3: Pictures Worth Thousands
*Location: 3-images/*
> "Not all treasures are visible to the naked eye. Sometimes you need to look at the **text differently**. Art forms can be found in the most technical places..."

### Step 4: Code Speaks Volumes
*Location: 4-code/*
> "Developers hide messages in plain sight. The **names they choose** are rarely random. First impressions matter, especially in code..."

### Step 5: Network Knows All
*Location: 5-network/*
> "Protocols carry more than just data. **Headers can be quite revealing** about intentions. Communication patterns often form readable sequences..."

## 🛠️ Detective's Toolkit

You have access to all standard CLI investigation tools:
- **Text Analysis**: \`grep\`, \`awk\`, \`sed\`, \`cut\`, \`sort\`, \`uniq\`
- **Data Processing**: \`jq\`, \`csvkit\`, \`sqlite3\`, \`python3\`
- **File Analysis**: \`file\`, \`hexdump\`, \`strings\`, \`exiftool\`
- **Network Tools**: \`dig\`, \`curl\`, \`openssl\`

## 📋 Investigation Tips

1. **Start systematically** - explore each folder methodically
2. **Look for patterns** - hidden data often follows logical rules
3. **Check file types** - use \`file\` command to verify what you're looking at
4. **Combine techniques** - solutions may require multiple commands
5. **Document findings** - keep track of what you discover

## 🎯 Submission

When you find all 5 words, submit using:
\`\`\`bash
./verify-solution.sh WORD1-WORD2-WORD3-WORD4-WORD5
\`\`\`

**Example**: \`./verify-solution.sh BEAR-CAVE-NEST-CULT-SENT\`

## 🏆 Success Criteria

- Each word is exactly **4 letters**
- All words are **common English words**
- Solutions require **logical analysis**, not guessing
- Standard CLI tools are **sufficient** for all challenges

---

**Good luck, detective! The digital treasure awaits your analytical skills.** 🏴‍☠️💎

*Remember: Real treasure hunters are patient, methodical, and persistent.*
EOF
    
    success "Hints file created"
}

# Main workflow function
main() {
    local mode="${1:-create}"
    
    case "$mode" in
        "create")
            create_new_challenge
            ;;
        "test")
            test_challenge "$2"
            ;;
        "cleanup")
            cleanup_challenge "$2"
            ;;
        *)
            show_usage
            ;;
    esac
}

create_new_challenge() {
    log "Starting CLI Treasure Hunt challenge creation"
    
    # Generate challenge ID
    local challenge_id="challenge$(date +%s)"
    log "Challenge ID: $challenge_id"
    
    # Generate random words
    local words=($(generate_words))
    local final_answer=$(IFS=-; echo "${words[*]}")
    
    log "Generated words: ${words[@]}"
    log "Final answer: $final_answer"
    
    # Create challenge structure
    create_challenge_structure "$challenge_id"
    
    # Generate metadata
    generate_metadata "$challenge_id" "${words[@]}"
    
    # Create verification script
    create_verification_script "$final_answer"
    
    # Create hints file
    create_hints_file
    
    # Create solution tracking directory on main branch
    git checkout main
    mkdir -p "challenges/$challenge_id"
    cp "$challenge_id/metadata.json" "challenges/$challenge_id/"
    
    success "Challenge $challenge_id created successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Switch to branch: git checkout $challenge_id"
    echo "2. Deploy organizer agent to coordinate challenge creation"
    echo "3. Deploy challenge agents to create puzzles"
    echo "4. Test solution path before player deployment"
    echo ""
    echo "Branch: $challenge_id"
    echo "Final Answer: $final_answer"
}

test_challenge() {
    local challenge_id="$1"
    if [ -z "$challenge_id" ]; then
        error "Please specify challenge ID to test"
    fi
    
    log "Testing challenge: $challenge_id"
    
    # Switch to challenge branch
    git checkout "$challenge_id" || error "Challenge branch $challenge_id not found"
    
    # Check if all required files exist
    local required_files=("hints.md" "verify-solution.sh" "player-template.md")
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            error "Required file missing: $file"
        fi
    done
    
    # Check folder structure
    local required_folders=("1-logs" "2-data" "3-images" "4-code" "5-network")
    for folder in "${required_folders[@]}"; do
        if [ ! -d "$folder" ]; then
            error "Required folder missing: $folder"
        fi
    done
    
    success "Challenge $challenge_id structure validation passed"
    
    # Test verification script
    if [ -x "verify-solution.sh" ]; then
        ./verify-solution.sh "TEST-WORD-PATTERN-HERE" || true
        success "Verification script is executable"
    else
        error "Verification script is not executable"
    fi
}

cleanup_challenge() {
    local challenge_id="$1"
    if [ -z "$challenge_id" ]; then
        error "Please specify challenge ID to cleanup"
    fi
    
    warning "This will permanently delete challenge: $challenge_id"
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log "Cleaning up challenge: $challenge_id"
        
        # Switch to main branch
        git checkout main
        
        # Delete challenge branch
        git branch -D "$challenge_id" 2>/dev/null || warning "Branch $challenge_id not found"
        
        # Remove challenge folder
        rm -rf "challenges/$challenge_id"
        
        success "Challenge $challenge_id cleaned up successfully"
    else
        log "Cleanup cancelled"
    fi
}

show_usage() {
    echo "CLI Treasure Hunt - Master Workflow Script"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  create              Create new treasure hunt challenge"
    echo "  test <challenge_id> Test existing challenge structure"  
    echo "  cleanup <challenge_id> Remove challenge and cleanup"
    echo ""
    echo "Examples:"
    echo "  $0 create"
    echo "  $0 test challenge1703123456"
    echo "  $0 cleanup challenge1703123456"
}

# Run main function
main "$@"