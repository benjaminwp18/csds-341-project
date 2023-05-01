@echo off
setlocal enabledelayedexpansion
>sources.txt (
  for /f "tokens=*" %%f in ('dir src /b /a-d /s') do (
    set "f=%%f"
    set "f=!f:\=/!"
    echo "!f!"
  )
)
javac -d ./out/ @sources.txt
endlocal