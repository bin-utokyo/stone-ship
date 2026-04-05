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


def find_repo_root() -> pathlib.Path:
    """スクリプトの位置（utility/）の親をリポジトリルートとして返す。"""
    return pathlib.Path(__file__).resolve().parent.parent


def locate_pandoc(hint: str | None) -> str | None:
    """pandoc 実行ファイルのパスを返す。見つからない場合は None。"""
    if hint:
        p = pathlib.Path(hint)
        return str(p) if p.is_file() else None
    return shutil.which("pandoc")


def collect_bibs(bib_dir: pathlib.Path) -> list[pathlib.Path]:
    """bib_dir 内の .bib ファイルを列挙して返す。"""
    if bib_dir.is_dir():
        return sorted(bib_dir.glob("*.bib"))
    return []


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
        "--citeproc",
    ]

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

    print(f"変換中: {rel_src} → {rel_out}  (フォーマット: {args.format})")
    if bib_files:
        print(f"  参考文献: {', '.join(b.name for b in bib_files)}")
    if media_dir:
        print(f"  メディア出力先: {media_dir}")

    rc = run_pandoc(pandoc, src_tex, output_md, src_dir, args.format, bib_files, media_dir)

    if rc == 0:
        print(f"完了: {output_md}")
    else:
        print("変換に失敗しました。pandoc の出力を確認してください。", file=sys.stderr)
        sys.exit(rc)


if __name__ == "__main__":
    main()
