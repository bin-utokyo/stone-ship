# スタイルガイド

> 🇺🇸 [English version is here](style-guide.en.md)

このドキュメントは stone-ship プロジェクトにおける LaTeX の記法・表記規則をまとめたものです．
記法の理解には `src/chapters/sample.tex` も合わせて参照してください．

---

## 目次

1. [見出し構造](#見出し構造)
2. [引用](#引用)
3. [図](#図)
4. [表](#表)
5. [数式](#数式)
6. [ソースコード](#ソースコード)
7. [相互参照](#相互参照)
8. [参考文献（BibTeX）](#参考文献bibtex)
9. [日本語表記](#日本語表記)

---

## 見出し構造

`\chapter` を最上位とし，必要に応じて下位見出しを使用します．

| コマンド | レベル | 備考 |
|---|---|---|
| `\chapter{...}` | 1 | 各章ファイルの先頭に1つだけ記述 |
| `\section{...}` | 2 | |
| `\subsection{...}` | 3 | |
| `\subsubsection{...}` | 4 | |
| `\subsubsubsection{...}` | 5 | `main.tex` で `\paragraph` に割り当て |
| `\subsubsubsubsection{...}` | 6 | `main.tex` で `\subparagraph` に割り当て |

> 通常の執筆では `\subsubsection` 以下は使用しないことを推奨します．

---

## 引用

`natbib` パッケージの `\cite` / `\citet` を使います．

```latex
% 文末引用（著者名を括弧内に表示）
確率的交通量配分の手法がある\cite{Akamatsu1996}．

% 文中引用（著者名を文章に組み込む）
\citet{Akamatsu1996} はマルコフ過程を用いた手法を提案した．

% 複数文献を同時に引用
\cite{Akamatsu1996,Ben-Akiva1985}
```

- `\cite{}` と `\citet{}` を**使い分けること**（どちらも `\citep{}` ではなく `\cite{}` を使う）．
- 引用キーは `著者名西暦` の形式（例: `Akamatsu1996`，`BenAkiva1985`）を推奨．

---

## 図

`figure` 環境と `\includegraphics` を組み合わせます．

```latex
\begin{figure}[hbtp]
  \centering
  \includegraphics[width=0.6\textwidth]{assets/my-figure.png}
  \caption{キャプションは図の\textbf{下}に置く．}
  \label{fig:my-figure}
\end{figure}
```

### ルール

- 画像ファイルは `src/assets/` に配置する．
- 推奨フォーマット: **PNG**・**PDF**・**EPS**（JPEG は品質劣化するため非推奨）．
- 配置オプション `[hbtp]` を標準とする（here → bottom → top → page の優先順）．
- `\caption{}` は**図の下**，`\label{}` は `\caption{}` の直後に記述する．
- ラベルは `fig:` プレフィックスを付ける（例: `fig:network-structure`）．
- 本文中で必ず `（図\ref{fig:xxx}）` のように参照する．

---

## 表

`table` 環境と `tabular` 環境を組み合わせ，`booktabs` の罫線を使用します．

```latex
\begin{table}[hbtp]
  \centering
  \caption{キャプションは表の\textbf{上}に置く．}
  \label{tab:my-table}
  \begin{tabular}{llr}
    \toprule
    列見出し1 & 列見出し2 & 列見出し3 \\
    \midrule
    データA & 説明 & 123 \\
    データB & 説明 & 456 \\
    \bottomrule
  \end{tabular}
\end{table}
```

### ルール

- `\toprule` / `\midrule` / `\bottomrule` を使い，`\hline` は使わない．
- `\caption{}` は**表の上**，`\label{}` は `\caption{}` の直後に記述する．
- ラベルは `tab:` プレフィックスを付ける（例: `tab:model-params`）．
- 縦罫線（`|`）は原則使用しない．

---

## 数式

### インライン数式

文中に短い数式を挿入する場合は `$...$` を使います．

```latex
二次方程式 $ax^2 + bx + c = 0$ の解は…
```

### ディスプレイ数式（単独行）

番号付きの独立した数式は `equation` 環境を使います．

```latex
\begin{equation}
  x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}.
  \label{eq:quadratic}
\end{equation}
```

### 複数行の数式

`align` 環境を使い，`&` で揃えます．

```latex
\begin{align}
  V_{ij} &= \beta_t t_{ij} + \beta_c c_{ij}, \label{eq:utility} \\
  P_{ij} &= \frac{\exp(V_{ij})}{\sum_k \exp(V_{ik})}. \label{eq:logit}
\end{align}
```

### ルール

- 数式末尾の句読点（`.` / `,`）は数式環境**内**に入れる．
- 参照には `\ref{}` ではなく **`\eqref{}`** を使う（例: `式\eqref{eq:quadratic}`）．
- ラベルは `eq:` プレフィックスを付ける（例: `eq:logit-model`）．
- 番号不要の場合は `equation*` / `align*` 環境を使う．

---

## ソースコード

`listings` + `jlisting` パッケージを使用します．

```latex
\begin{lstlisting}[language=Python, caption={コードのキャプション}, label={lst:my-code}]
import numpy as np

def logit_prob(utilities):
    exp_v = np.exp(utilities)
    return exp_v / exp_v.sum()
\end{lstlisting}
```

### ルール

- `language=` に言語名を指定する（`Python`・`R`・`C`・`bash` など）．
- `caption={}` と `label={}` を必ず付ける．
- ラベルは `lst:` プレフィックスを付ける（例: `lst:logit-algorithm`）．

---

## 相互参照

| 対象 | ラベル例 | 参照構文 |
|---|---|---|
| 章 | `ch:intro` | `第\ref{ch:intro}章` |
| 節（`\section`） | `sec:intro` | `\sref{sec:intro}` → 第\ref{sec:intro}節 |
| 小節（`\subsection`） | `subsec:model` | `\ssref{subsec:model}` → 第\ref{subsec:model}小節 |
| 項（`\subsubsection`） | `subsubsec:item` | `\sssref{subsubsec:item}` → 第\ref{subsubsec:item}項 |
| 図 | `fig:result` | `図\ref{fig:result}` |
| 表 | `tab:data` | `表\ref{tab:data}` |
| 数式 | `eq:model` | `式\eqref{eq:model}` |
| コード | `lst:algorithm` | `リスト\ref{lst:algorithm}` |

- `\label{}` は必ず対象環境**内**（`\caption{}` の直後など）に記述する．
- 参照先と参照元が同一ファイルでなくても問題ありません（章をまたいで参照可能）．

---

## 参考文献（BibTeX）

### ファイル管理

- **章ごとに独立した `.bib` ファイル**を `src/bibliography/` に作成する．
  - 命名規則: 章番号に対応した名前（例: `1.bib`，`2.bib`）．
- 各章ファイルの**末尾**に以下の3行を記述する:

```latex
\addcontentsline{toc}{chapter}{参考文献}
\bibliographystyle{stone-ship}
\bibliography{../src/bibliography/mychapter}
```

### BibTeX エントリの書き方

```bibtex
% 英語論文
@article{Akamatsu1996,
  author  = {Akamatsu, T.},
  title   = {Cyclic flows, {Markov} process and stochastic traffic assignment},
  journal = {Transportation Research B},
  volume  = {30},
  number  = {5},
  pages   = {369--386},
  year    = {1996}
}

% 日本語論文（著者名は二重ブレースで囲む）
@article{Yamada2025,
  author  = {{山田太郎} and {鈴木次郎}},
  title   = {論文タイトル},
  journal = {土木学会論文集},
  volume  = {1},
  pages   = {1--10},
  year    = {2025}
}

% 書籍
@book{BenAkiva1985,
  author    = {Ben-Akiva, M. and Lerman, S. R.},
  title     = {Discrete Choice Analysis},
  publisher = {MIT Press},
  address   = {Cambridge, MA},
  year      = {1985}
}
```

### ルール

- 引用キーは `著者名西暦` 形式（例: `Akamatsu1996`）．
- 日本語著者名は必ず二重ブレース `{{...}}` で囲む．
- 固有名詞・頭字語はブレース `{...}` で囲んで大文字を保護する（例: `{Markov}`）．
- ページ範囲は `--`（en-dash）で記述する（例: `369--386`）．

---

## 日本語表記

- 句読点は**「，」（全角カンマ）・「．」（全角ピリオド）**を使用する（「、」「。」は使わない）．
- 全角と半角の間にはスペースを入れない（LaTeX が自動調整する）．
- 数値・英単語は半角，単位は適宜全角・半角を使い分ける．
- 括弧は原則**全角**（`（）`）を使用し，数式内では半角 `()` を使う．
