@echo off
setlocal enabledelayedexpansion

REM CLI Treasure Hunt - Master Workflow Script (Windows Batch Version)
REM Coordinates entire challenge creation process

set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..

REM Enable ANSI color codes for Windows 10+
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%VERSION%" geq "10.0" (
    REM Enable ANSI escape sequences
    reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
)

REM Color codes for output
set "RED=[31m"
set "GREEN=[32m"
set "YELLOW=[33m"
set "BLUE=[34m"
set "NC=[0m"

goto main

:log
echo %BLUE%[%date% %time%]%NC% %~1
goto :eof

:success
echo %GREEN%✓ %~1%NC%
goto :eof

:warning
echo %YELLOW%⚠ %~1%NC%
goto :eof

:error
echo %RED%✗ %~1%NC%
exit /b 1

:generate_words
REM Common 4-letter English words for treasure hunts
set words[0]=BEAR
set words[1]=CAVE
set words[2]=NEST
set words[3]=HUNT
set words[4]=GOLD
set words[5]=KEYS
set words[6]=MASK
set words[7]=ROPE
set words[8]=TOMB
set words[9]=RUNE
set words[10]=SHIP
set words[11]=MAPS
set words[12]=COIN
set words[13]=GEMS
set words[14]=PATH
set words[15]=DOOR
set words[16]=LOCK
set words[17]=CODE
set words[18]=SAGE
set words[19]=HERO
set words[20]=DAWN
set words[21]=MOON
set words[22]=STAR
set words[23]=FIRE
set words[24]=WIND
set words[25]=WAVE
set words[26]=TREE
set words[27]=ROCK
set words[28]=PEAK
set words[29]=LAKE
set words[30]=FORT
set words[31]=GATE
set words[32]=WALL
set words[33]=ARCH
set words[34]=HALL
set words[35]=ROOM
set words[36]=DESK
set words[37]=BOOK
set words[38]=PAGE
set words[39]=WORD
set words[40]=SIGN
set words[41]=MARK
set words[42]=SPOT
set words[43]=ZONE
set words[44]=AREA
set words[45]=SITE
set words[46]=PLOT
set words[47]=YARD
set words[48]=LAND
set words[49]=ISLE

set word_count=50

REM Select 5 unique random words
set selected_count=0
set used_indices=

:word_selection_loop
if !selected_count! geq 5 goto :word_selection_done

:find_unique_word
set /a "rand_idx=!RANDOM! %% !word_count!"

REM Check if index already used
echo !used_indices! | findstr /C:"!rand_idx!" >nul
if !errorlevel! equ 0 goto :find_unique_word

REM Add to selected words
call set "selected_word!selected_count!=%%words[!rand_idx!]%%"
set used_indices=!used_indices! !rand_idx!
set /a selected_count+=1
goto :word_selection_loop

:word_selection_done
set "generated_words=!selected_word0! !selected_word1! !selected_word2! !selected_word3! !selected_word4!"
goto :eof

:create_challenge_structure
set challenge_id=%~1

call :log "Creating challenge structure for %challenge_id%"

REM Create challenge branch
git checkout -b "%challenge_id%" 2>nul
if !errorlevel! neq 0 (
    call :error "Failed to create branch %challenge_id%"
    goto :eof
)

REM Create folder structure
mkdir "1-logs\clutter" 2>nul
mkdir "2-data\clutter" 2>nul
mkdir "3-images\clutter" 2>nul
mkdir "4-code\clutter" 2>nul
mkdir "5-network\clutter" 2>nul

REM Copy player and solver templates
copy "%PROJECT_ROOT%\agents\player\player-template.md" . >nul 2>&1
copy "%PROJECT_ROOT%\scripts\solve-challenge.sh" . >nul 2>&1

call :success "Challenge structure created"
goto :eof

:generate_metadata
set challenge_id=%~1
set word1=%~2
set word2=%~3
set word3=%~4
set word4=%~5
set word5=%~6

REM Get current timestamp in ISO format
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set mydate=%%c-%%a-%%b
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set mytime=%%a:%%b
set "timestamp=%mydate%T%mytime%:00Z"

set "final_answer=%word1%-%word2%-%word3%-%word4%-%word5%"

(
echo {
echo   "challenge_id": "%challenge_id%",
echo   "created_timestamp": "%timestamp%",
echo   "final_answer": "%final_answer%",
echo   "words": {
echo     "word1": "%word1%",
echo     "word2": "%word2%",
echo     "word3": "%word3%",
echo     "word4": "%word4%",
echo     "word5": "%word5%"
echo   },
echo   "challenge_assignments": {
echo     "logs": {
echo       "agent": "log-challenge-agent",
echo       "target_word": "%word1%",
echo       "folder": "1-logs",
echo       "status": "pending"
echo     },
echo     "data": {
echo       "agent": "data-challenge-agent",
echo       "target_word": "%word2%",
echo       "folder": "2-data",
echo       "status": "pending"
echo     },
echo     "images": {
echo       "agent": "image-challenge-agent",
echo       "target_word": "%word3%",
echo       "folder": "3-images",
echo       "status": "pending"
echo     },
echo     "code": {
echo       "agent": "code-challenge-agent",
echo       "target_word": "%word4%",
echo       "folder": "4-code",
echo       "status": "pending"
echo     },
echo     "network": {
echo       "agent": "network-challenge-agent",
echo       "target_word": "%word5%",
echo       "folder": "5-network",
echo       "status": "pending"
echo     }
echo   }
echo }
) > metadata.json

call :success "Metadata generated"
goto :eof

:create_verification_script
set final_answer=%~1

(
echo @echo off
echo setlocal
echo.
echo REM CLI Treasure Hunt - Solution Verification
echo REM Challenge: %%CD%%
echo.
echo set "EXPECTED_ANSWER=%final_answer%"
echo set "USER_ANSWER=%%~1"
echo.
echo if "%%USER_ANSWER%%"=="" ^(
echo     echo Usage: %%0 WORD1-WORD2-WORD3-WORD4-WORD5
echo     echo Submit your 5 four-letter words separated by hyphens
echo     echo.
echo     echo Example: %%0 BEAR-CAVE-NEST-CULT-SENT
echo     exit /b 1
echo ^)
echo.
echo if /i "%%USER_ANSWER%%"=="%%EXPECTED_ANSWER%%" ^(
echo     echo 🏆 CONGRATULATIONS! TREASURE FOUND!
echo     echo ================================================
echo     echo You have successfully completed the CLI Treasure Hunt!
echo     echo Your digital investigation skills are excellent!
echo     echo.
echo     echo Final Answer: %%USER_ANSWER%%
echo     echo Challenge completed at: %%date%% %%time%%
echo     echo ================================================
echo     echo.
echo     echo 🎯 Skills Demonstrated:
echo     echo • Log analysis and pattern recognition
echo     echo • Data mining and structured analysis
echo     echo • Image forensics and metadata extraction
echo     echo • Code archaeology and reverse engineering
echo     echo • Network protocol investigation
echo     echo.
echo     echo Ready for the next treasure hunt? 🔍
echo ^) else ^(
echo     echo ❌ Incorrect answer: %%USER_ANSWER%%
echo     echo Expected format: WORD1-WORD2-WORD3-WORD4-WORD5
echo     echo.
echo     echo 💡 Tips:
echo     echo • Check hints.md for guidance
echo     echo • Each folder contains exactly one 4-letter word
echo     echo • Use CLI tools for analysis ^(grep, awk, jq, etc.^^)
echo     echo • Look for patterns, not just random searching
echo     echo.
echo     echo Keep investigating... the treasure is still hidden! 🏴‍☠️
echo ^)
) > verify-solution.bat

call :success "Verification script created"
goto :eof

:create_hints_file
(
echo # CLI Treasure Hunt - Investigation Hints 🕵️
echo.
echo Welcome, Digital Detective! Your mission is to find 5 hidden four-letter words.
echo.
echo ## The Investigation
echo.
echo Your target: **5 four-letter English words** hidden across different file types.
echo.
echo Each word is hidden using a different technique in a different folder:
echo.
echo ### 🗂️ The Crime Scene
echo - **1-logs/** - System logs and operational records
echo - **2-data/** - Structured data files and databases
echo - **3-images/** - Visual files and terminal outputs
echo - **4-code/** - Source code and configuration files
echo - **5-network/** - Network protocols and communications
echo.
echo ## 🔍 Investigation Hints
echo.
echo ### Step 1: Time Tells Tales
echo *Location: 1-logs/*
echo ^> "System administrators leave breadcrumbs in their logs. Sometimes the **when** matters more than the **what**. Numbers can represent more than just time..."
echo.
echo ### Step 2: Data Points the Way
echo *Location: 2-data/*
echo ^> "Structured data has structure for a reason. Look for the **organization within the organization**. Hierarchies often spell out their secrets..."
echo.
echo ### Step 3: Pictures Worth Thousands
echo *Location: 3-images/*
echo ^> "Not all treasures are visible to the naked eye. Sometimes you need to look at the **text differently**. Art forms can be found in the most technical places..."
echo.
echo ### Step 4: Code Speaks Volumes
echo *Location: 4-code/*
echo ^> "Developers hide messages in plain sight. The **names they choose** are rarely random. First impressions matter, especially in code..."
echo.
echo ### Step 5: Network Knows All
echo *Location: 5-network/*
echo ^> "Protocols carry more than just data. **Headers can be quite revealing** about intentions. Communication patterns often form readable sequences..."
echo.
echo ## 🛠️ Detective's Toolkit
echo.
echo You have access to all standard CLI investigation tools:
echo - **Text Analysis**: `findstr`, `powershell`, `type`
echo - **Data Processing**: `jq`, `powershell`, `python`
echo - **File Analysis**: `certutil`, `powershell`, `python`
echo - **Network Tools**: `nslookup`, `curl`, `powershell`
echo.
echo ## 📋 Investigation Tips
echo.
echo 1. **Start systematically** - explore each folder methodically
echo 2. **Look for patterns** - hidden data often follows logical rules
echo 3. **Check file types** - use appropriate tools for each file format
echo 4. **Combine techniques** - solutions may require multiple commands
echo 5. **Document findings** - keep track of what you discover
echo.
echo ## 🎯 Submission
echo.
echo When you find all 5 words, submit using:
echo ```batch
echo verify-solution.bat WORD1-WORD2-WORD3-WORD4-WORD5
echo ```
echo.
echo **Example**: `verify-solution.bat BEAR-CAVE-NEST-CULT-SENT`
echo.
echo ## 🏆 Success Criteria
echo.
echo - Each word is exactly **4 letters**
echo - All words are **common English words**
echo - Solutions require **logical analysis**, not guessing
echo - Standard CLI tools are **sufficient** for all challenges
echo.
echo ---
echo.
echo **Good luck, detective! The digital treasure awaits your analytical skills.** 🏴‍☠️💎
echo.
echo *Remember: Real treasure hunters are patient, methodical, and persistent.*
) > hints.md

call :success "Hints file created"
goto :eof

:create_new_challenge
call :log "Starting CLI Treasure Hunt challenge creation"

REM Generate challenge ID
for /f "tokens=1-4 delims=:.," %%a in ('echo %time%') do (
    set /a "timestamp=%%a*3600+%%b*60+%%c"
)
for /f "tokens=1-3 delims=/" %%a in ('echo %date%') do (
    set /a "timestamp=!timestamp!+%%c*86400"
)
set "challenge_id=challenge!timestamp!"

call :log "Challenge ID: !challenge_id!"

REM Generate random words
call :generate_words

call :log "Generated words: !generated_words!"
set "final_answer=!selected_word0!-!selected_word1!-!selected_word2!-!selected_word3!-!selected_word4!"
call :log "Final answer: !final_answer!"

REM Create challenge structure
call :create_challenge_structure "!challenge_id!"

REM Generate metadata
call :generate_metadata "!challenge_id!" "!selected_word0!" "!selected_word1!" "!selected_word2!" "!selected_word3!" "!selected_word4!"

REM Create verification script
call :create_verification_script "!final_answer!"

REM Create hints file
call :create_hints_file

REM Create solution tracking directory on main branch
git checkout main
if not exist "challenges\!challenge_id!" mkdir "challenges\!challenge_id!"
copy "metadata.json" "challenges\!challenge_id!\" >nul 2>&1

call :success "Challenge !challenge_id! created successfully!"
echo.
echo Next steps:
echo 1. Switch to branch: git checkout !challenge_id!
echo 2. Deploy organizer agent to coordinate challenge creation
echo 3. Deploy challenge agents to create puzzles
echo 4. Test solution path before player deployment
echo.
echo Branch: !challenge_id!
echo Final Answer: !final_answer!
goto :eof

:test_challenge
set challenge_id=%~1
if "%challenge_id%"=="" (
    call :error "Please specify challenge ID to test"
    goto :eof
)

call :log "Testing challenge: %challenge_id%"

REM Switch to challenge branch
git checkout "%challenge_id%" 2>nul
if !errorlevel! neq 0 (
    call :error "Challenge branch %challenge_id% not found"
    goto :eof
)

REM Check if all required files exist
set required_files=hints.md verify-solution.bat player-template.md
for %%f in (%required_files%) do (
    if not exist "%%f" (
        call :error "Required file missing: %%f"
        goto :eof
    )
)

REM Check folder structure
set required_folders=1-logs 2-data 3-images 4-code 5-network
for %%d in (%required_folders%) do (
    if not exist "%%d" (
        call :error "Required folder missing: %%d"
        goto :eof
    )
)

call :success "Challenge %challenge_id% structure validation passed"

REM Test verification script
if exist "verify-solution.bat" (
    call verify-solution.bat "TEST-WORD-PATTERN-HERE" >nul 2>&1
    call :success "Verification script is executable"
) else (
    call :error "Verification script is not executable"
)
goto :eof

:cleanup_challenge
set challenge_id=%~1
set force_flag=%~2
if "%challenge_id%"=="" (
    call :error "Please specify challenge ID to cleanup"
    goto :eof
)
if /i not "%force_flag%"=="/force" (
    call :error "Cleanup cancelled. You must use the /force flag to delete a challenge."
    echo Usage: %~nx0 cleanup [challenge_id] /force
    goto :eof
)

call :warning "This will permanently delete challenge: %challenge_id%"
call :log "Cleaning up challenge: %challenge_id%"
    
REM Switch to main branch
git checkout main 2>nul
    
REM Delete challenge branch
git branch -D "%challenge_id%" 2>nul
if !errorlevel! neq 0 call :warning "Branch %challenge_id% not found"
    
REM Remove challenge folder
if exist "challenges\%challenge_id%" rmdir /s /q "challenges\%challenge_id%"
    
call :success "Challenge %challenge_id% cleaned up successfully"
goto :eof

:show_usage
echo CLI Treasure Hunt - Master Workflow Script (Windows)
echo.
echo Usage: %~nx0 [command] [options]
echo.
echo Commands:
echo   create              Create new treasure hunt challenge
echo   test ^<challenge_id^> Test existing challenge structure
echo   cleanup ^<challenge_id^> /force  Remove challenge and cleanup
echo.
echo Examples:
echo   %~nx0 create
echo   %~nx0 test challenge1703123456
echo   %~nx0 cleanup challenge1703123456
goto :eof

:main
set mode=%~1
if "%mode%"=="" set mode=create

if /i "%mode%"=="create" (
    call :create_new_challenge
) else if /i "%mode%"=="test" (
    call :test_challenge "%~2"
) else if /i "%mode%"=="cleanup" (
    call :cleanup_challenge "%~2" "%~3"
) else (
    call :show_usage
)

endlocal