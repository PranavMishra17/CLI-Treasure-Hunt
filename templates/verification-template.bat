@echo off
setlocal

REM CLI Treasure Hunt - Solution Verification
REM This script will be customized by organizer agent with actual answer

set "EXPECTED_ANSWER=WORD1-WORD2-WORD3-WORD4-WORD5"
set "USER_ANSWER=%~1"

if "%USER_ANSWER%"=="" (
    echo Usage: %~nx0 WORD1-WORD2-WORD3-WORD4-WORD5
    echo Submit your 5 four-letter words separated by hyphens
    exit /b 1
)

if "%USER_ANSWER%"=="%EXPECTED_ANSWER%" (
    echo 🏆 CONGRATULATIONS! TREASURE FOUND!
    echo You have successfully completed the CLI Treasure Hunt!
    echo Your digital investigation skills are excellent!
    echo.
    echo Final Answer: %USER_ANSWER%
    echo Challenge completed at: %date% %time%
) else (
    echo ❌ Incorrect answer: %USER_ANSWER%
    echo Expected format: WORD1-WORD2-WORD3-WORD4-WORD5
    echo Keep investigating... the treasure is still hidden!
)

endlocal