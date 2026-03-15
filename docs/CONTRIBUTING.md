# コントリビューションガイド

> 🇺🇸 [English version is here](CONTRIBUTING.en.md)

このドキュメントは stone-ship プロジェクトへ新たに参加する方向けに，
環境構築から章の追加・ビルド・プルリクエスト送付までの手順を説明します．

---

## 目次

- [コントリビューションガイド](#コントリビューションガイド)
  - [目次](#目次)
  - [プロジェクト概要](#プロジェクト概要)
  - [前提ソフトウェア](#前提ソフトウェア)
  - [リポジトリのセットアップ](#リポジトリのセットアップ)
  - [ディレクトリ構造](#ディレクトリ構造)
  - [章を追加する](#章を追加する)
    - [Step 1 — 章ファイルを作成する](#step-1--章ファイルを作成する)
    - [Step 2 — bib ファイルを作成する](#step-2--bib-ファイルを作成する)
    - [Step 3 — main.tex に章を登録する](#step-3--maintex-に章を登録する)
    - [Step 4 — 図を追加する場合](#step-4--図を追加する場合)
  - [ビルドする](#ビルドする)
    - [ビルドの仕組み](#ビルドの仕組み)
    - [よくあるエラー](#よくあるエラー)
  - [変更を提出する](#変更を提出する)
    - [ブランチの切り方](#ブランチの切り方)
    - [コミットメッセージの規則](#コミットメッセージの規則)
  - [CI（自動ビルド）](#ci自動ビルド)
  - [生成AIの利用について](#生成aiの利用について)

---

## プロジェクト概要

stone-ship は **BinN Studies シリーズ** の教科書を LaTeX で執筆・管理するリポジトリです．
複数の著者が独立した章を担当し，`main.tex` が各章をまとめて1冊の PDF を生成します．

---

## 前提ソフトウェア

| ソフトウェア | 役割 | macOS | Linux | Windows |
|---|---|---|---|---|
| **TeX Live** (フルインストール推奨) | LaTeX コンパイル・BibTeX | `brew install --cask mactex` | `sudo apt install texlive-full` | [公式インストーラ](https://www.tug.org/texlive/windows.html) または `choco install texlive` |
| **Git** | バージョン管理 | [git-scm.com](https://git-scm.com) | [git-scm.com](https://git-scm.com) | [Git for Windows](https://gitforwindows.org)（Git Bash 同梱） |
| **スクリプト実行環境** | ビルドスクリプト実行 | zsh（標準搭載） | `sudo apt install zsh` | PowerShell（標準搭載）`compile.ps1` を使用 |

> **注意**: `platex`・`bibtex`・`dvipdfmx` の3コマンドが PATH に存在することを確認してください．
>
> macOS / Linux:
> ```bash
> platex --version
> bibtex --version
> dvipdfmx --version
> ```
>
> Windows（PowerShell）:
> ```powershell
> platex --version
> bibtex --version
> dvipdfmx --version
> ```
>
> TeX Live インストール後に PATH が反映されない場合は，PowerShell を再起動するか，
> システムの環境変数（`C:\texlive\<year>\bin\windows`）が登録されているか確認してください．

---

## リポジトリのセットアップ

```bash
# 1. リポジトリをクローンする
git clone https://github.com/bin-utokyo/stone-ship.git
cd stone-ship

# 2. 作業ブランチを切る（mainへの直接コミットは禁止）
git checkout -b chapter/2
```

> ブランチの命名規則については[ブランチの切り方](#ブランチの切り方)を参照してください．

---

## ディレクトリ構造

```
stone-ship/
├── src/
│   ├── main.tex              # マスタードキュメント（章のincludeリストを管理）
│   ├── cover.tex             # 表紙
│   ├── chapters/             # 章ごとの .tex ファイル
│   │   ├── sample.tex        # 記法サンプル（読んでおくこと）
│   │   └── 1.tex             # 第1章
│   ├── bibliography/         # 章ごとの .bib ファイル
│   │   ├── 1.bib             # 第1章用
│   │   └── sample_refs.bib   # サンプル用
│   ├── assets/               # 図・画像（PNG / PDF / EPS）
│   └── *.sty / *.cls         # スタイルファイル（編集不要）
├── build/                    # コンパイル出力先（Git 管理外）
├── docs/
│   ├── CONTRIBUTING.md       # 本ドキュメント（日本語）
│   ├── CONTRIBUTING.en.md    # 本ドキュメント（英語）
│   ├── style-guide.md        # 表記・記法ガイド（日本語）
│   └── style-guide.en.md     # 表記・記法ガイド（英語）
└── utility/
    ├── compile.sh            # ビルドスクリプト（zsh）
    └── compile.ps1           # ビルドスクリプト（PowerShell）
```

---

## 章を追加する

### Step 1 — 章ファイルを作成する

`src/chapters/` 以下に新しい `.tex` ファイルを作成します．
ファイル名は章番号（例: `2.tex`）または内容を表す英単語（例: `demand.tex`）にしてください．

```latex
% src/chapters/2.tex

\chapter{需要分析の基礎}

本章では…

% -------------------------------------------------------
% 参考文献（末尾に必ず記述）
% -------------------------------------------------------
\addcontentsline{toc}{chapter}{参考文献}
\bibliographystyle{stone-ship}
\bibliography{../src/bibliography/2}
```

### Step 2 — bib ファイルを作成する

`src/bibliography/` 以下に章と対応する `.bib` ファイルを作成します．

```bibtex
% src/bibliography/2.bib

@article{YourKey2025,
  author  = {Yamada, Taro},
  title   = {論文タイトル},
  journal = {Transportation Research B},
  volume  = {1},
  pages   = {1--10},
  year    = {2025}
}
```

日本語著者名は二重ブレースで囲んでください（BibTeX の誤解析を防ぐため）．

```bibtex
author = {{山田太郎} and {鈴木次郎}}
```

### Step 3 — main.tex に章を登録する

`src/main.tex` の `\include` リストに追加します．

```latex
\include{chapters/sample}
\include{chapters/1}
\include{chapters/2}   % ← 追加
```

### Step 4 — 図を追加する場合

`src/assets/` 以下に章番号のサブフォルダ（例: `src/assets/2/`）を作成し，図ファイル（PNG / PDF / EPS 推奨）をその中に配置してください．
`\includegraphics` での参照パスは `src/` からの相対パスになります．

```latex
\includegraphics[width=0.6\textwidth]{assets/2/my-figure.png}
```

記法の詳細は [style-guide.md](style-guide.md) および `src/chapters/sample.tex` を参照してください．

---

## ビルドする

リポジトリルートで以下を実行します:

```bash
# macOS / Linux
zsh utility/compile.sh
```

```powershell
# Windows (PowerShell)
.\utility\compile.ps1
```

成功すると `build/main.pdf` が生成されます．

> **Windows の初回実行時 — 実行ポリシーの設定**
>
> PowerShell のデフォルト設定ではローカルスクリプトの実行がブロックされる場合があります．
> 以下を **一度だけ** 実行してください（管理者権限は不要）：
>
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
> ```
>
> 設定後，PowerShell を再起動してから `compile.ps1` を実行してください．

### ビルドの仕組み

1. `platex` を1回実行し，`.aux` ファイルを生成．
2. `build/chapters/*.aux` に対して `bibtex` を自動実行（新しい章を追加してもスクリプト編集不要）．
3. `platex` を2回再実行し，相互参照・目次・文献リストを確定．
4. `dvipdfmx` で `.dvi` を PDF に変換．

### よくあるエラー

| エラーメッセージ | 原因と対処 |
|---|---|
| `! LaTeX Error: File 'xxx.sty' not found.` | TeX Live のフルパッケージが未インストール．`tlmgr install xxx` を実行． |
| `I found no \citation commands` | `.bib` ファイルが空か，`\cite` が未使用．文献を追加するか警告を無視する． |
| `Overfull \hbox` | 行が余白からはみ出している．`\linebreak` や改行で調整する（警告のみ，ビルド自体は成功）． |

---

## 変更を提出する

以下のコマンドは macOS / Linux（bash/zsh）・Windows（PowerShell / Git Bash）共通です．

```bash
# 変更をステージング・コミット
git add src/chapters/2.tex src/bibliography/2.bib src/main.tex
git commit -m "Add chapter 2: 需要分析の基礎"

# リモートにプッシュ
git push origin chapter/2
```

GitHub 上でプルリクエストを作成し，レビューを依頼してください．

> **ブランチ保護ルール**: `main` ブランチにはブランチ保護が設定されています．
> - プルリクエストを経由しなければ `main` へのマージはできません（直接プッシュは禁止）．
> - マージには **最低1人のレビュアーによる承認**（Approve）が必要です．
>
> プルリクエストにより他のメンバーのレビューを得てから `main` へマージすることで，誤記入・ビルドの問題を事前に防ぎます．

### ブランチの切り方

ブランチは **章単位** で作成します．

| 目的 | ブランチ名の形式 | 例 |
|---|---|---|
| 章の執筆・編集 | `chapter/<章番号または章名>` | `chapter/2`，`chapter/demand` |
| 章内の細かいサブタスク | `chapter/<章番号>/<サブトピック>` | `chapter/2/figures`，`chapter/2/fix-refs` |

基本ルール:

1. `main` へ直接コミット・プッシュしてはなりません（リポジトリのブランチ保護により技術的にもブロックされます）．
2. 章ブランチを起点として，必要に応じてサブブランチを切ります．
3. サブブランチの作業が完了したら，章ブランチにマージしてから `main` へのプルリクエストを送ります．
4. `main` へのマージには必ずプルリクエストを作成し，**最低1人の承認**を得てください．

```bash
# 章ブランチを作成して移動
git checkout -b chapter/2

# 章ブランチからサブブランチを作成
git checkout -b chapter/2/figures

# ... 作業 ...

# 完了後，章ブランチへマージ
git checkout chapter/2
git merge chapter/2/figures
```

### コミットメッセージの規則

- `Add chapter N: <章タイトル>` — 新しい章を追加
- `Fix chapter N: <修正内容>` — 既存章の修正
- `Update main.tex: <変更内容>` — マスタードキュメントの変更
- `Add assets: <ファイル名>` — 図・画像の追加
- `Fix bib: <変更内容>` — 参考文献の修正

---

## CI（自動ビルド）

`main` ブランチへのプッシュ（またはマージ）時に，GitHub Actions が自動で PDF をビルドします．
ビルド成果物（`main.pdf`）は Actions の **Artifacts** からダウンロードできます．

設定ファイル: `.github/workflows/build.yml`

---

## 生成AIの利用について

文章・数式・コードの執筆補助に生成AIツール（ChatGPT，Claude，Geminiなど）を使用することは妨げません．
ただし，以下のルールを必ず守ってください．

- **自分でレビューする**: 生成されたテキスト・数式・コードをそのままコミットしないでください．
  内容の正確性・論理の一貫性・文体の統一性を必ず自身で確認してください．
- **品質に責任を持つ**: 生成AIの出力はあくまで補助です．
  プルリクエストに含まれるすべての記述の品質については，コミットした本人が責任を負います．
- **事実確認を行う**: 文献情報・数値・定理の記述は，一次資料に当たって正確性を確認してください．
  生成AIは誤った情報を自信をもって出力することがあります（ハルシネーション）．
- **BibTeX エントリを手動確認する**: 生成AIが出力した引用情報は誤りを含むことが多いため，
  必ず原著・データベース（Google Scholar，CiNii など）で著者・タイトル・誌名・年を照合してください．
