@echo off
echo ===================================
echo The Protest Record Auto-Publisher
echo ===================================
echo.

echo [1/3] Building the static site...
node scripts/build-site.js
if %errorlevel% neq 0 (
  echo Build failed! Aborting.
  pause
  exit /b %errorlevel%
)

echo.
echo [2/4] Committing changes to Git...
git add .
git commit -m "Update archive"

echo.
echo [3/4] Syncing with GitHub server...
git pull origin main --rebase
if %errorlevel% neq 0 (
  echo Sync failed! You might have a merge conflict.
  pause
  exit /b %errorlevel%
)

echo.
echo [4/4] Pushing to GitHub...
git push origin main
if %errorlevel% neq 0 (
  echo Push failed! Check your internet or GitHub permissions.
  pause
  exit /b %errorlevel%
)

echo.
echo ===================================
echo SUCCESS! Your archive is now live.
echo ===================================
pause
