# Generates values for TOKEN_SECRET and LIGHTRAG_API_KEY (paste into Render, do not commit).
# Usage: pwsh -File scripts/generate-render-secrets.ps1

$bytes = [byte[]]::new(48)
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
$tokenSecret = [Convert]::ToBase64String($bytes)
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
$apiKey = [Convert]::ToBase64String($bytes)

Write-Host "Add these in Render -> LightRAG -> Environment (Secret):" -ForegroundColor Cyan
Write-Host ""
Write-Host "TOKEN_SECRET=$tokenSecret"
Write-Host "LIGHTRAG_API_KEY=$apiKey"
Write-Host ""
Write-Host "Set AUTH_ACCOUNTS=admin:YourPassword  (choose password yourself)." -ForegroundColor Yellow
Write-Host "Copy LIGHTRAG_API_KEY to the telegram-bot service env." -ForegroundColor Yellow
