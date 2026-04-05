#!/usr/bin/env python3
"""tex2md.py – src/main.tex の内容をマークダウンに変換する。

変換エンジンとして pandoc を使用します。

依存ツール: pandoc  (https://pandoc.org/installing.html)
  macOS (Homebrew): brew install pandoc
  Linux (apt):      sudo apt install pandoc
  Windows:          winget install --id JohnMacFarlane.Pandoc
                    または choco install pandoc

使い方:
  python utility/tex2md.py [オプション]

オプション:
  --output PATH, -o PATH
      出力先マークダウンファイルのパス（省略時: build/main.md）
  --pandoc PATH
      pandoc 実行ファイルのパス（省略時: PATH 環境変数から自動検索）
  --format FORMAT, -f FORMAT
      出力フォーマット（省略時: gfm）
      例: gfm（GitHub Flavored Markdown）, markdown, commonmark
  --media-dir DIR, -m DIR
      画像等のメディアファイルを展開するディレクトリ（省略時: 展開しない）
"""

import argparse
import pathlib
import shutil
import subprocess
import sys
import tempfile


def find_repo_root() -> pathlib.Path:
    """スクリプトの位置（utility/）の親をリポジトリルートとして返す。"""
    return pathlib.Path(__file__).resolve().parent.parent


def locate_pandoc(hint: str | None) -> str | None:
    """pandoc 実行ファイルのパスを返す。見つからない場合は None。"""
    if hint:
        p = pathlib.Path(hint)
        return str(p) if p.is_file() else None
    return shutil.which("pandoc")


# テキストファイルとして扱う拡張子
_TEXT_SUFFIXES = {".tex", ".bib", ".sty", ".cls", ".bst"}
# UTF-8 解釈に失敗した場合に試みるフォールバックエンコーディング（順に試す）
_FALLBACK_ENCODINGS = ["cp1252", "latin-1"]


def sanitize_src_to_utf8(
    src_dir: pathlib.Path,
    dst_dir: pathlib.Path,
) -> None:
    """src_dir を dst_dir に複製し、テキストファイルをすべて UTF-8 に変換する。

    bib ファイルなどに含まれる Windows-1252 / Latin-1 バイト（例: \\x92）を
    pandoc が受け付けられる UTF-8 に変換するための前処理。
    テキスト以外のファイル（画像等）はそのままコピーする。
    """
    for src_file in src_dir.rglob("*"):
        if src_file.is_dir():
            continue
        rel = src_file.relative_to(src_dir)
        dst_file = dst_dir / rel
        dst_file.parent.mkdir(parents=True, exist_ok=True)

        if src_file.suffix.lower() in _TEXT_SUFFIXES:
            # まず UTF-8 で試み、失敗したらフォールバック
            content: str | None = None
            for enc in ["utf-8"] + _FALLBACK_ENCODINGS:
                try:
                    content = src_file.read_text(encoding=enc)
                    break
                except (UnicodeDecodeError, ValueError):
                    continue
            if content is None:
                # それでも読めない場合は置換モードで強制読み込み
                content = src_file.read_text(encoding="utf-8", errors="replace")
            dst_file.write_text(content, encoding="utf-8")
        else:
            shutil.copy2(src_file, dst_file)


def collect_bibs(bib_dir: pathlib.Path) -> list[pathlib.Path]:
    """bib_dir 内の .bib ファイルを列挙して返す。"""
    if bib_dir.is_dir():
        return sorted(bib_dir.glob("*.bib"))
    return []


def locate_pandoc_crossref() -> str | None:
    """pandoc-crossref 実行ファイルのパスを返す。見つからない場合は None。"""
    return shutil.which("pandoc-crossref")


def run_pandoc(
    pandoc: str,
    src_tex: pathlib.Path,
    output_md: pathlib.Path,
    src_dir: pathlib.Path,
    fmt: str,
    bib_files: list[pathlib.Path],
    media_dir: pathlib.Path | None,
) -> int:
    """pandoc を呼び出して LaTeX → Markdown 変換を実行する。"""
    cmd: list[str] = [
        pandoc,
        str(src_tex),
        "--from", "latex",
        "--to", fmt,
        "--standalone",
        "--wrap", "none",
        "--output", str(output_md),
        "--resource-path", str(src_dir),
    ]

    if locate_pandoc_crossref():
        cmd += ["--filter", "pandoc-crossref"]

    cmd += ["--citeproc"]

    for bib in bib_files:
        cmd += ["--bibliography", str(bib)]

    if media_dir is not None:
        cmd += ["--extract-media", str(media_dir)]

    result = subprocess.run(
        cmd,
        cwd=str(src_dir),
        capture_output=True,
        text=True,
        encoding="utf-8",
    )

    if result.stdout:
        print(result.stdout, end="")
    if result.stderr:
        print(result.stderr, file=sys.stderr, end="")

    return result.returncode


def main() -> None:
    parser = argparse.ArgumentParser(
        description="src/main.tex をマークダウンに変換する。",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument(
        "--output", "-o",
        type=pathlib.Path,
        default=None,
        metavar="PATH",
        help="出力ファイルパス（省略時: build/main.md）",
    )
    parser.add_argument(
        "--pandoc",
        type=str,
        default=None,
        metavar="PATH",
        help="pandoc 実行ファイルのパス",
    )
    parser.add_argument(
        "--format", "-f",
        type=str,
        default="gfm",
        metavar="FORMAT",
        help="出力フォーマット（省略時: gfm）",
    )
    parser.add_argument(
        "--media-dir", "-m",
        type=pathlib.Path,
        default=None,
        metavar="DIR",
        help="画像等のメディアファイルを展開するディレクトリ（省略時: 展開しない）",
    )
    args = parser.parse_args()

    repo_root = find_repo_root()
    src_dir   = repo_root / "src"
    src_tex   = src_dir / "main.tex"
    build_dir = repo_root / "build"
    output_md = args.output or build_dir / "main.md"

    if not src_tex.is_file():
        print(f"エラー: {src_tex} が見つかりません。", file=sys.stderr)
        sys.exit(1)

    pandoc = locate_pandoc(args.pandoc)
    if pandoc is None:
        print("エラー: pandoc が見つかりません。以下のいずれかでインストールしてください：", file=sys.stderr)
        print("  macOS:   brew install pandoc", file=sys.stderr)
        print("  Linux:   sudo apt install pandoc", file=sys.stderr)
        print("  Windows: winget install --id JohnMacFarlane.Pandoc", file=sys.stderr)
        print("  詳細:    https://pandoc.org/installing.html", file=sys.stderr)
        sys.exit(1)

    output_md.parent.mkdir(parents=True, exist_ok=True)

    bib_files  = collect_bibs(src_dir / "bibliography")
    media_dir  = args.media_dir

    try:
        rel_src = src_tex.relative_to(repo_root)
        rel_out = output_md.relative_to(repo_root)
    except ValueError:
        rel_src = src_tex
        rel_out = output_md

    crossref = locate_pandoc_crossref()
    print(f"変換中: {rel_src} → {rel_out}  (フォーマット: {args.format})")
    print(f"  pandoc-crossref: {'有効 (' + crossref + ')' if crossref else '不使用（未インストール）'}")
    if bib_files:
        print(f"  参考文献: {', '.join(b.name for b in bib_files)}")
    if media_dir:
        print(f"  メディア出力先: {media_dir}")

    with tempfile.TemporaryDirectory() as _tmp:
        tmp_src = pathlib.Path(_tmp) / "src"
        sanitize_src_to_utf8(src_dir, tmp_src)
        tmp_tex      = tmp_src / "main.tex"
        tmp_bib_dir  = tmp_src / "bibliography"
        tmp_bib_files = collect_bibs(tmp_bib_dir)

        rc = run_pandoc(
            pandoc, tmp_tex, output_md, tmp_src,
            args.format, tmp_bib_files, media_dir,
        )

    if rc == 0:
        print(f"完了: {output_md}")
    else:
        print("変換に失敗しました。pandoc の出力を確認してください。", file=sys.stderr)
        sys.exit(rc)


if __name__ == "__main__":
    main()
