# Style Guide

> 🇯🇵 [日本語版はこちら](style-guide.md)

This document summarises the LaTeX markup and typographic conventions used in the stone-ship project.
See also `src/chapters/sample.tex` for working examples of every rule below.

---

## Table of Contents

- [Style Guide](#style-guide)
  - [Table of Contents](#table-of-contents)
  - [Heading Structure](#heading-structure)
  - [Citations](#citations)
  - [Figures](#figures)
    - [Rules](#rules)
  - [Tables](#tables)
    - [Rules](#rules-1)
  - [Equations](#equations)
    - [Inline equations](#inline-equations)
    - [Display equations (numbered)](#display-equations-numbered)
    - [Multi-line equations](#multi-line-equations)
    - [Rules](#rules-2)
  - [Source Code](#source-code)
    - [Rules](#rules-3)
  - [Cross-references](#cross-references)
  - [Bibliography (BibTeX)](#bibliography-bibtex)
    - [File management](#file-management)
    - [BibTeX entry format](#bibtex-entry-format)
    - [Rules](#rules-4)
  - [Japanese Typography](#japanese-typography)

---

## Heading Structure

`\chapter` is the top-level heading. Use the lower-level headings as needed.

| Command | Level | Notes |
|---|---|---|
| `\chapter{...}` | 1 | Exactly one per chapter file, at the very top |
| `\section{...}` | 2 | |
| `\subsection{...}` | 3 | |
| `\subsubsection{...}` | 4 | |
| `\subsubsubsection{...}` | 5 | Mapped to `\paragraph` in `main.tex` |
| `\subsubsubsubsection{...}` | 6 | Mapped to `\subparagraph` in `main.tex` |

> Avoid using headings below `\subsubsection` in normal writing.

---

## Citations

Use the `natbib` commands `\cite` / `\citet`.

```latex
% Parenthetical citation (author name in parentheses)
Stochastic traffic assignment has been studied\cite{Akamatsu1996}.

% In-text citation (author name integrated into the sentence)
\citet{Akamatsu1996} proposed a method based on Markov processes.

% Multiple citations at once
\cite{Akamatsu1996,Ben-Akiva1985}
```

- Always **distinguish** between `\cite{}` and `\citet{}` (do not use `\citep{}`).
- Recommended citation key format: `AuthorYear` (e.g. `Akamatsu1996`, `BenAkiva1985`).

---

## Figures

Combine the `figure` environment with `\includegraphics`.

```latex
\begin{figure}[hbtp]
  \centering
  \includegraphics[width=0.6\textwidth]{assets/my-figure.png}
  \caption{Caption goes \textbf{below} the figure.}
  \label{fig:my-figure}
\end{figure}
```

### Rules

- Place image files in `src/assets/`.
- Recommended formats: **PNG**, **PDF**, **EPS** (JPEG is discouraged due to lossy compression).
- Use the placement option `[hbtp]` (here → bottom → top → page order of preference).
- `\caption{}` goes **below** the figure; `\label{}` immediately after `\caption{}`.
- Use the `fig:` prefix for labels (e.g. `fig:network-structure`).
- Always reference the figure in the body text (e.g. `(Figure~\ref{fig:xxx})`).

---

## Tables

Combine the `table` and `tabular` environments; use `booktabs` rules.

```latex
\begin{table}[hbtp]
  \centering
  \caption{Caption goes \textbf{above} the table.}
  \label{tab:my-table}
  \begin{tabular}{llr}
    \toprule
    Header 1 & Header 2 & Header 3 \\
    \midrule
    Data A & Description & 123 \\
    Data B & Description & 456 \\
    \bottomrule
  \end{tabular}
\end{table}
```

### Rules

- Use `\toprule` / `\midrule` / `\bottomrule`; never use `\hline`.
- `\caption{}` goes **above** the table; `\label{}` immediately after `\caption{}`.
- Use the `tab:` prefix for labels (e.g. `tab:model-params`).
- Do not use vertical rules (`|`) as a general principle.

---

## Equations

### Inline equations

Use `$...$` to embed short expressions within a sentence.

```latex
The roots of $ax^2 + bx + c = 0$ are given by…
```

### Display equations (numbered)

Use the `equation` environment for standalone numbered equations.

```latex
\begin{equation}
  x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}.
  \label{eq:quadratic}
\end{equation}
```

### Multi-line equations

Use the `align` environment and align with `&`.

```latex
\begin{align}
  V_{ij} &= \beta_t t_{ij} + \beta_c c_{ij}, \label{eq:utility} \\
  P_{ij} &= \frac{\exp(V_{ij})}{\sum_k \exp(V_{ik})}. \label{eq:logit}
\end{align}
```

### Rules

- Trailing punctuation (`.` or `,`) belongs **inside** the equation environment.
- Use **`\eqref{}`** (not `\ref{}`) to reference equations (e.g. `Equation~\eqref{eq:quadratic}`).
- Use the `eq:` prefix for labels (e.g. `eq:logit-model`).
- Use the starred variants (`equation*` / `align*`) when numbering is not needed.

---

## Source Code

Use the `listings` + `jlisting` packages.

```latex
\begin{lstlisting}[language=Python, caption={Code caption}, label={lst:my-code}]
import numpy as np

def logit_prob(utilities):
    exp_v = np.exp(utilities)
    return exp_v / exp_v.sum()
\end{lstlisting}
```

### Rules

- Always specify `language=` (e.g. `Python`, `R`, `C`, `bash`).
- Always include both `caption={}` and `label={}`.
- Use the `lst:` prefix for labels (e.g. `lst:logit-algorithm`).

---

## Cross-references

| Target | Example label | Reference syntax |
|---|---|---|
| Chapter | `ch:intro` | `Chapter~\ref{ch:intro}` |
| Section (`\section`) | `sec:intro` | `\sref{sec:intro}` → 第\ref{sec:intro}節 |
| Subsection (`\subsection`) | `subsec:model` | `\ssref{subsec:model}` → 第\ref{subsec:model}小節 |
| Subsubsection (`\subsubsection`) | `subsubsec:item` | `\sssref{subsubsec:item}` → 第\ref{subsubsec:item}項 |
| Figure | `fig:result` | `Figure~\ref{fig:result}` |
| Table | `tab:data` | `Table~\ref{tab:data}` |
| Equation | `eq:model` | `Equation~\eqref{eq:model}` |
| Code listing | `lst:algorithm` | `Listing~\ref{lst:algorithm}` |

- Always place `\label{}` **inside** the target environment (immediately after `\caption{}` where applicable).
- Cross-chapter references work fine — you can reference a label defined in another chapter file.

---

## Bibliography (BibTeX)

### File management

- Create a **separate `.bib` file per chapter** under `src/bibliography/`.
  - Naming convention: match the chapter number (e.g. `1.bib`, `2.bib`).
- Add the following three lines at the **end** of every chapter file:

```latex
\addcontentsline{toc}{chapter}{References}
\bibliographystyle{stone-ship}
\bibliography{../src/bibliography/mychapter}
```

### BibTeX entry format

```bibtex
% English journal article
@article{Akamatsu1996,
  author  = {Akamatsu, T.},
  title   = {Cyclic flows, {Markov} process and stochastic traffic assignment},
  journal = {Transportation Research B},
  volume  = {30},
  number  = {5},
  pages   = {369--386},
  year    = {1996}
}

% Japanese article (wrap author names in double braces)
@article{Yamada2025,
  author  = {{山田太郎} and {鈴木次郎}},
  title   = {Paper title},
  journal = {Journal of JSCE},
  volume  = {1},
  pages   = {1--10},
  year    = {2025}
}

% Book
@book{BenAkiva1985,
  author    = {Ben-Akiva, M. and Lerman, S. R.},
  title     = {Discrete Choice Analysis},
  publisher = {MIT Press},
  address   = {Cambridge, MA},
  year      = {1985}
}
```

### Rules

- Citation key format: `AuthorYear` (e.g. `Akamatsu1996`).
- Always wrap Japanese author names in double braces `{{...}}`.
- Protect proper nouns and acronyms with braces `{...}` to preserve capitalisation (e.g. `{Markov}`).
- Use `--` (en-dash) for page ranges (e.g. `369--386`).

---

## Japanese Typography

- Use **`，` (fullwidth comma) and `．` (fullwidth period)** for Japanese punctuation — not `、` or `。`.
- Do not insert manual spaces between fullwidth and halfwidth characters (LaTeX adjusts spacing automatically).
- Numbers and Latin words use halfwidth characters; unit notation may use either fullwidth or halfwidth as appropriate.
- Use **fullwidth parentheses `（）`** in Japanese prose; use halfwidth `()` inside math environments.
