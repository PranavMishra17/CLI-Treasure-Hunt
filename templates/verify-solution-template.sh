#!/bin/bash

# CLI Treasure Hunt - Solution Verification Script
# Template to be customized by organizer agent with actual answer

# PLACEHOLDER - Organizer agent will replace this with actual final answer
EXPECTED_ANSWER="REPLACE-WITH-FINAL-ANSWER"
CHALLENGE_ID="REPLACE-WITH-CHALLENGE-ID"

USER_ANSWER="$1"

echo "🏴‍☠️ CLI Treasure Hunt - Solution Verification"
echo "=============================================="
echo ""

if [ -z "$USER_ANSWER" ]; then
    echo "❌ No answer provided!"
    echo ""
    echo "Usage: $0 WORD1-WORD2-WORD3-WORD4-WORD5"
    echo "Submit your 5 four-letter words separated by hyphens"
    echo ""
    echo "💡 Example: $0 BEAR-CAVE-NEST-CULT-SENT"
    echo ""
    echo "📋 Remember:"
    echo "• Each word must be exactly 4 letters"
    echo "• Words must be separated by hyphens (-)"
    echo "• Order matters: logs, data, images, code, network"
    echo "• Check hints.md for guidance if stuck"
    echo ""
    exit 1
fi

echo "🔍 Checking your answer: $USER_ANSWER"
echo "🎯 Challenge: $CHALLENGE_ID"
echo ""

if [ "$USER_ANSWER" = "$EXPECTED_ANSWER" ]; then
    echo "🏆 CONGRATULATIONS! TREASURE FOUND! 🏆"
    echo "================================================"
    echo ""
    echo "🎉 SUCCESS! You have completed the CLI Treasure Hunt!"
    echo "Your digital investigation skills are excellent!"
    echo ""
    echo "📊 Challenge Statistics:"
    echo "• Final Answer: $USER_ANSWER"
    echo "• Challenge ID: $CHALLENGE_ID" 
    echo "• Completed at: $(date)"
    echo "• Detective Level: Expert Investigator"
    echo ""
    echo "🎯 Skills Demonstrated:"
    echo "• 🗂️  Log analysis and pattern recognition"
    echo "• 📊  Data mining and structured analysis"
    echo "• 🖼️  Image forensics and metadata extraction"
    echo "• 💻  Code archaeology and reverse engineering"
    echo "• 🌐  Network protocol investigation"
    echo ""
    echo "🌟 Professional Skills Unlocked:"
    echo "• Cybersecurity SOC analyst techniques"
    echo "• Digital forensics investigation methods"
    echo "• Business intelligence data analysis"
    echo "• Network security monitoring practices"
    echo ""
    echo "🚀 Ready for the next treasure hunt? 🔍"
    echo "Create a new challenge with: start_game.md"
    echo ""
    echo "================================================"
    echo "🎊 TREASURE HUNT MASTER ACHIEVED! 🎊"
else
    echo "❌ Incorrect answer: $USER_ANSWER"
    echo "✅ Expected format: WORD1-WORD2-WORD3-WORD4-WORD5"
    echo ""
    echo "🔍 Investigation Tips:"
    echo "• Review hints.md for technique guidance"
    echo "• Each challenge folder contains exactly one 4-letter word" 
    echo "• Use CLI analysis tools (grep, awk, jq, exiftool, etc.)"
    echo "• Look for patterns, not random searching"
    echo "• Think like a digital forensic investigator"
    echo ""
    echo "📂 Challenge Structure:"
    echo "• 1-logs/    → System log forensics"
    echo "• 2-data/    → Structured data analysis"
    echo "• 3-images/  → Visual/metadata forensics"
    echo "• 4-code/    → Source code archaeology"
    echo "• 5-network/ → Network protocol investigation"
    echo ""
    echo "💪 Keep investigating... the treasure is still hidden! 🏴‍☠️"
    echo ""
fi