# Contribution Guide

> 🇯🇵 [日本語版はこちら](CONTRIBUTING.md)

This document explains the workflow for new contributors to the stone-ship project,
covering environment setup, adding chapters, building, and submitting pull requests.

---

## Table of Contents

- [Contribution Guide](#contribution-guide)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Prerequisites](#prerequisites)
  - [Repository Setup](#repository-setup)
  - [Directory Structure](#directory-structure)
  - [Adding a Chapter](#adding-a-chapter)
    - [Step 1 — Create a chapter file](#step-1--create-a-chapter-file)
    - [Step 2 — Create a bib file](#step-2--create-a-bib-file)
    - [Step 3 — Register the chapter in main.tex](#step-3--register-the-chapter-in-maintex)
    - [Step 4 — Adding figures](#step-4--adding-figures)
  - [Building](#building)
    - [How the build works](#how-the-build-works)
    - [Common errors](#common-errors)
  - [Submitting Changes](#submitting-changes)
    - [Branch naming](#branch-naming)
    - [Commit message conventions](#commit-message-conventions)
  - [CI (Automated Build)](#ci-automated-build)
  - [Use of Generative AI](#use-of-generative-ai)

---

## Project Overview

stone-ship is a repository for writing and managing textbooks in the **BinN Studies series** using LaTeX.
Multiple authors contribute independent chapters, and `main.tex` compiles them into a single PDF.

---

## Prerequisites

| Software | Role | macOS | Linux | Windows |
|---|---|---|---|---|
| **TeX Live** (full install recommended) | LaTeX compilation & BibTeX | `brew install --cask mactex` | `sudo apt install texlive-full` | [Official installer](https://www.tug.org/texlive/windows.html) or `choco install texlive` |
| **Git** | Version control | [git-scm.com](https://git-scm.com) | [git-scm.com](https://git-scm.com) | [Git for Windows](https://gitforwindows.org) (includes Git Bash) |
| **Script runtime** | Build script execution | zsh (bundled) | `sudo apt install zsh` | PowerShell (bundled) — use `compile.ps1` |

> **Note**: Verify that `platex`, `bibtex`, and `dvipdfmx` are available in your PATH.
>
> macOS / Linux:
> ```bash
> platex --version
> bibtex --version
> dvipdfmx --version
> ```
>
> Windows (PowerShell):
> ```powershell
> platex --version
> bibtex --version
> dvipdfmx --version
> ```
>
> If the commands are not found after installing TeX Live, restart PowerShell or verify that
> `C:\texlive\<year>\bin\windows` is listed in your system `PATH` environment variable.

---

## Repository Setup

```bash
# 1. Clone the repository
git clone https://github.com/bin-utokyo/stone-ship.git
cd stone-ship

# 2. Create a working branch (direct commits to main are not allowed)
git checkout -b chapter/2
```

> For branch naming rules, see [Branch naming](#branch-naming).

---

## Directory Structure

```
stone-ship/
├── src/
│   ├── main.tex              # Master document (manages the \include list)
│   ├── cover.tex             # Cover page
│   ├── chapters/             # Per-chapter .tex files
│   │   ├── sample.tex        # Markup sample (please read this first)
│   │   └── 1.tex             # Chapter 1
│   ├── bibliography/         # Per-chapter .bib files
│   │   ├── 1.bib             # For Chapter 1
│   │   └── sample_refs.bib   # For the sample
│   ├── assets/               # Figures and images (PNG / PDF / EPS)
│   └── *.sty / *.cls         # Style files (do not edit)
├── build/                    # Compilation output (not tracked by Git)
├── docs/
│   ├── CONTRIBUTING.md       # Contribution guide (Japanese)
│   ├── CONTRIBUTING.en.md    # Contribution guide (English / this file)
│   ├── style-guide.md        # Typography and markup guide (Japanese)
│   └── style-guide.en.md     # Typography and markup guide (English)
└── utility/
    ├── compile.sh            # Build script (zsh)
    └── compile.ps1           # Build script (PowerShell)
```

---

## Adding a Chapter

### Step 1 — Create a chapter file

Create a new `.tex` file under `src/chapters/`.
Name it after the chapter number (e.g. `2.tex`) or a descriptive English word (e.g. `demand.tex`).

```latex
% src/chapters/2.tex

\chapter{Fundamentals of Demand Analysis}

This chapter covers…

% -------------------------------------------------------
% Bibliography (must appear at the end of every chapter)
% -------------------------------------------------------
\addcontentsline{toc}{chapter}{References}
\bibliographystyle{stone-ship}
\bibliography{../src/bibliography/2}
```

### Step 2 — Create a bib file

Create a corresponding `.bib` file under `src/bibliography/`.

```bibtex
% src/bibliography/2.bib

@article{YourKey2025,
  author  = {Yamada, Taro},
  title   = {Paper Title},
  journal = {Transportation Research B},
  volume  = {1},
  pages   = {1--10},
  year    = {2025}
}
```

Wrap Japanese author names in double braces to prevent BibTeX from misinterpreting them.

```bibtex
author = {{山田太郎} and {鈴木次郎}}
```

### Step 3 — Register the chapter in main.tex

Add an `\include` entry in `src/main.tex`.

```latex
\include{chapters/sample}
\include{chapters/1}
\include{chapters/2}   % ← add this line
```

### Step 4 — Adding figures

Create a chapter-specific subdirectory under `src/assets/` (e.g. `src/assets/2/`) and place figure files (PNG / PDF / EPS recommended) there.
Reference them with `\includegraphics` using a path relative to `src/`.

```latex
\includegraphics[width=0.6\textwidth]{assets/2/my-figure.png}
```

See [style-guide.md](style-guide.md) and `src/chapters/sample.tex` for detailed markup conventions.

---

## Building

Run the following command from the repository root:

```bash
# macOS / Linux
zsh utility/compile.sh
```

```powershell
# Windows (PowerShell)
.\utility\compile.ps1
```

On success, `build/main.pdf` is generated.

> **Windows — first-time script execution policy**
>
> PowerShell may block local scripts by default.
> Run the following **once** (no administrator privileges required):
>
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
> ```
>
> Restart PowerShell after applying the setting, then run `compile.ps1`.

### How the build works

1. Run `platex` once to generate `.aux` files.
2. Run `bibtex` automatically against every `build/chapters/*.aux` file
   (no script edits needed when adding new chapters).
3. Run `platex` twice more to resolve cross-references, table of contents, and bibliographies.
4. Convert the `.dvi` to PDF with `dvipdfmx`.

### Common errors

| Error message | Cause and fix |
|---|---|
| `! LaTeX Error: File 'xxx.sty' not found.` | The full TeX Live package set is not installed. Run `tlmgr install xxx`. |
| `I found no \citation commands` | The `.bib` file is empty or `\cite` is unused. Add references or ignore the warning. |
| `Overfull \hbox` | A line overflows the margin. Adjust with `\linebreak` or a manual line break (warning only — the build succeeds). |

---

## Submitting Changes

The following commands work the same on macOS / Linux (bash/zsh) and Windows (PowerShell or Git Bash).

```bash
# Stage and commit changes
git add src/chapters/2.tex src/bibliography/2.bib src/main.tex
git commit -m "Add chapter 2: Fundamentals of Demand Analysis"

# Push to remote
git push origin chapter/2
```

Open a pull request on GitHub and request a review.

> **Branch protection rules**: The `main` branch is protected.
> - Merging into `main` requires a pull request — direct pushes are not allowed.
> - At least **one approving review** is required before a pull request can be merged.
>
> Merging into `main` only after review by other members helps catch mistakes and prevent broken builds before they affect everyone.

### Branch naming

Create one branch **per chapter**.

| Purpose | Branch name format | Examples |
|---|---|---|
| Writing or editing a chapter | `chapter/<number-or-name>` | `chapter/2`, `chapter/demand` |
| A focused sub-task within a chapter | `chapter/<number>/<topic>` | `chapter/2/figures`, `chapter/2/fix-refs` |

Rules:

1. Never commit or push directly to `main` (the repository's branch protection enforces this technically as well).
2. Create sub-branches off the chapter branch as needed.
3. Merge sub-branches back into the chapter branch before opening a pull request to `main`.
4. Always open a pull request to merge into `main` and obtain **at least one approving review**.

```bash
# Create and switch to a chapter branch
git checkout -b chapter/2

# Create a sub-branch from the chapter branch
git checkout -b chapter/2/figures

# ... work ...

# Merge the sub-branch back into the chapter branch when done
git checkout chapter/2
git merge chapter/2/figures
```

### Commit message conventions

- `Add chapter N: <chapter title>` — add a new chapter
- `Fix chapter N: <description>` — fix an existing chapter
- `Update main.tex: <description>` — change the master document
- `Add assets: <filename>` — add figures or images
- `Fix bib: <description>` — fix bibliography entries

---

## CI (Automated Build)

When code is pushed (or merged) to the `main` branch, GitHub Actions automatically builds the PDF.
The artifact (`main.pdf`) can be downloaded from the **Artifacts** section of the Actions run.

Configuration file: `.github/workflows/build.yml`

---

## Use of Generative AI

Using generative AI tools (ChatGPT, Claude, Gemini, etc.) to assist with writing text, equations, or code is permitted.
However, the following rules must be observed.

- **Always review the output yourself**: Do not commit AI-generated text, equations, or code as-is.
  Verify the accuracy of the content, the consistency of the logic, and conformance with the project's writing style.
- **Take responsibility for quality**: AI output is a writing aid, not a final product.
  The person who commits a change is responsible for the quality of everything included in that pull request.
- **Verify facts against primary sources**: Check all figures, theorems, and bibliographic details against
  original sources. Generative AI can produce confidently stated but incorrect information (hallucination).
- **Manually check BibTeX entries**: AI-generated citation data frequently contains errors.
  Always cross-check author names, titles, journal names, and publication years against the original
  paper or a reliable database (Google Scholar, etc.).
