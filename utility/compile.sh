#!/bin/zsh
# Compile the LaTeX source files into a PDF document.
# Can be run from any directory; all paths are resolved relative to this script.
#
# Requirements: platex, bibtex, dvipdfmx must be available in PATH.
#   Recommended distribution: TeX Live (https://www.tug.org/texlive/)
#   macOS (Homebrew): brew install --cask mactex
#   Linux (apt):      sudo apt install texlive-full
#
# BibTeX is run automatically for every chapter .aux file found under
# build/chapters/, so new chapters are picked up without editing this script.

REPO_ROOT=$(cd "${0:A:h}/.." && pwd)
BUILD_DIR="${REPO_ROOT}/build"
SRC_DIR="${REPO_ROOT}/src"
CHAPTERS_DIR="${BUILD_DIR}/chapters"

# Clean up previous build artifacts
rm -rf "${BUILD_DIR}"
mkdir -p "${CHAPTERS_DIR}"

# First pass
cd "${SRC_DIR}"
platex -interaction=nonstopmode -output-directory="${BUILD_DIR}" main.tex
mkdir -p "${CHAPTERS_DIR}"

# Run BibTeX for each chapter that produced an .aux file
cd "${BUILD_DIR}"
for aux in chapters/*.aux(N); do
    BSTINPUTS="${SRC_DIR}:" BIBINPUTS="${SRC_DIR}:" bibtex "${aux%.aux}"
done

# Second and third passes (resolves cross-references, index, etc.)
cd "${SRC_DIR}"
platex -interaction=nonstopmode -output-directory="${BUILD_DIR}" main.tex
platex -interaction=nonstopmode -output-directory="${BUILD_DIR}" main.tex
dvipdfmx -o "${BUILD_DIR}/main.pdf" "${BUILD_DIR}/main.dvi"