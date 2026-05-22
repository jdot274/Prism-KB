# Push wiki content to GitHub
#
# Prerequisite (one-time, via browser):
#   Visit https://github.com/jdot274/Prism-KB/wiki and click
#   "Create the first page" — type anything, save. This initializes
#   the .wiki.git backing repo.
#
# Then run this script from the repo root:
#   ./scripts/push-wiki.ps1

$ErrorActionPreference = "Stop"

$repoRoot   = Split-Path -Parent $PSScriptRoot
$wikiSource = Join-Path $repoRoot "wiki-content"
$wikiStage  = Join-Path $env:TEMP "Prism-KB-wiki"

if (-not (Test-Path $wikiSource)) {
    throw "wiki-content/ not found at $wikiSource"
}

if (Test-Path $wikiStage) {
    Remove-Item -Recurse -Force $wikiStage
}

Write-Host "Cloning wiki..." -ForegroundColor Cyan
git clone https://github.com/jdot274/Prism-KB.wiki.git $wikiStage
if ($LASTEXITCODE -ne 0) {
    throw "Clone failed. Make sure you've initialized the wiki by visiting https://github.com/jdot274/Prism-KB/wiki and creating a first page."
}

Write-Host "Syncing content..." -ForegroundColor Cyan
Get-ChildItem $wikiStage -Force | Where-Object { $_.Name -ne ".git" } | Remove-Item -Recurse -Force
Copy-Item "$wikiSource\*" $wikiStage -Force -Recurse

cd $wikiStage
git add -A
git -c user.name="jdot274" -c user.email="jdot274@users.noreply.github.com" commit -m "Sync wiki content from main repo"
git push

Write-Host "Done — wiki updated." -ForegroundColor Green
