# Compile the LaTeX source files into a PDF document.
# Can be run from any directory; all paths are resolved relative to this script.
#
# Requirements: platex, bibtex, dvipdfmx must be available in PATH.
#   Recommended distribution: TeX Live (https://www.tug.org/texlive/)
#   Install via Chocolatey: choco install texlive
#
# Usage:
#   PowerShell:  .\utility\compile.ps1
#   Run from repo root or from the utility\ folder — both work.
#
# BibTeX is run automatically for every chapter .aux file found under
# build\chapters\, so new chapters are picked up without editing this script.

$ErrorActionPreference = "Stop"

$repoRoot    = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$buildDir    = Join-Path $repoRoot "build"
$srcDir      = Join-Path $repoRoot "src"
$chaptersDir = Join-Path $buildDir "chapters"

# Clean up previous build artifacts
if (Test-Path $buildDir) {
    Remove-Item -Recurse -Force $buildDir
}
New-Item -ItemType Directory -Force $chaptersDir | Out-Null

# First pass
Set-Location $srcDir
& platex -interaction=nonstopmode -output-directory="$buildDir" main.tex
New-Item -ItemType Directory -Force $chaptersDir | Out-Null

# Run BibTeX for each chapter that produced an .aux file
Set-Location $buildDir
$env:BSTINPUTS = "$srcDir;"
$env:BIBINPUTS = "$srcDir;"

Get-ChildItem (Join-Path $chaptersDir "*.aux") -ErrorAction SilentlyContinue | ForEach-Object {
    $auxNoExt = $_.FullName -replace '\.aux$', ''
    & bibtex $auxNoExt
}

Remove-Item Env:BSTINPUTS -ErrorAction SilentlyContinue
Remove-Item Env:BIBINPUTS -ErrorAction SilentlyContinue

# Second and third passes (resolves cross-references, index, etc.)
Set-Location $srcDir
& platex -interaction=nonstopmode -output-directory="$buildDir" main.tex
& platex -interaction=nonstopmode -output-directory="$buildDir" main.tex

# Convert DVI to PDF
& dvipdfmx -o (Join-Path $buildDir "main.pdf") (Join-Path $buildDir "main.dvi")
