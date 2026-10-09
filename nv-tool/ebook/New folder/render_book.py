#!/usr/bin/env python3
"""
render_book.py

Usage:
  python render_book.py [input.txt] [out_dir]

Defaults:
  input.txt = book.txt
  out_dir   = bmp_pages
"""

from PIL import Image, ImageDraw, ImageFont
import os
import sys
import textwrap

# ------------ CONFIG ------------
WIDTH = 128
HEIGHT = 160
MARGIN_LEFT = 2
MARGIN_TOP = 2
MARGIN_RIGHT = 2
MARGIN_BOTTOM = 2

DEFAULT_FONTFILES = [
    r"C:\Windows\Fonts\times.ttf",            # times
    r"C:\Windows\Fonts\times New Roman.ttf", # sometimes named like this
    r"C:\Windows\Fonts\arial.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
]
DEFAULT_FONTSIZE = 12
LINE_SPACING = 2   # extra pixels between lines (in addition to font height)
FORCE_HYPHEN = True   # when forcing a break inside a very long word, append '-' to line
# ---------------------------------

def find_font(fontsize=DEFAULT_FONTSIZE):
    for p in DEFAULT_FONTFILES:
        try:
            if os.path.exists(p):
                return ImageFont.truetype(p, fontsize)
        except Exception:
            continue
    # fallback to default PIL font (may not support all unicode)
    return ImageFont.load_default()

def collapse_blank_lines(lines):
    """Collapse multiple blank lines into a single blank line, and trim leading/trailing blanks."""
    out = []
    prev_empty = False
    for ln in lines:
        if ln.strip() == "":
            if not prev_empty:
                out.append("")   # keep one blank line
                prev_empty = True
            else:
                # skip extra blank
                continue
        else:
            out.append(ln.rstrip())
            prev_empty = False
    # trim leading/trailing blank lines
    while out and out[0] == "":
        out.pop(0)
    while out and out[-1] == "":
        out.pop()
    return out

def measure_text(draw, text, font):
    # returns (width, height)
    # we use textbbox for accurate measurement
    bbox = draw.textbbox((0,0), text, font=font)
    w = bbox[2] - bbox[0]
    h = bbox[3] - bbox[1]
    return w, h

def wrap_paragraph(paragraph, max_width, draw, font):
    """
    Wrap a paragraph (string without internal newlines) into lines that fit max_width.
    We avoid cutting words. If a single word is longer than max_width, we force-break it.
    """
    words = paragraph.split()
    if not words:
        return [""]   # preserved blank line as paragraph

    lines = []
    cur = ""
    for word in words:
        if cur == "":
            test = word
        else:
            test = cur + " " + word
        w, _ = measure_text(draw, test, font)
        if w <= max_width:
            cur = test
        else:
            if cur == "":
                # single word longer than max_width -> forced break
                pieces = break_long_word(word, max_width, draw, font)
                lines.extend(pieces[:-1])
                cur = pieces[-1]
            else:
                lines.append(cur)
                # start new line with the word
                # check whether word alone fits
                w2, _ = measure_text(draw, word, font)
                if w2 <= max_width:
                    cur = word
                else:
                    pieces = break_long_word(word, max_width, draw, font)
                    lines.extend(pieces[:-1])
                    cur = pieces[-1]
    if cur != "":
        lines.append(cur)
    return lines

def break_long_word(word, max_width, draw, font):
    """
    Break a long word into pieces that fit max_width.
    Returns list of pieces (strings). The last piece may be shorter.
    Optionally append hyphen '-' to pieces except last when FORCE_HYPHEN True.
    """
    pieces = []
    start = 0
    n = len(word)
    while start < n:
        # binary search for longest substring word[start:mid] that fits
        lo = start + 1
        hi = n
        best = start
        while lo <= hi:
            mid = (lo + hi) // 2
            candidate = word[start:mid]
            # if we will add hyphen we must consider its width
            cand = candidate + ("-" if FORCE_HYPHEN and mid < n else "")
            w, _ = measure_text(draw, cand, font)
            if w <= max_width:
                best = mid
                lo = mid + 1
            else:
                hi = mid - 1
        if best == start:
            # Can't fit even one character (!) — to avoid infinite loop, force one char
            best = start + 1
        piece = word[start:best]
        if FORCE_HYPHEN and best < n:
            piece = piece + "-"
        pieces.append(piece)
        start = best
    return pieces

def paginate_lines(lines, max_lines_per_page):
    """Split list of lines into pages (list of list-of-lines)."""
    pages = []
    for i in range(0, len(lines), max_lines_per_page):
        pages.append(lines[i:i+max_lines_per_page])
    if not pages:
        pages = [[" "]]
    return pages

def main(argv):
    # parse args
    input_file = argv[1] if len(argv) > 1 else "book.txt"
    out_dir = argv[2] if len(argv) > 2 else "bmp_pages"

    if not os.path.exists(input_file):
        print(f"ERROR: input file not found: {input_file}")
        return 2

    os.makedirs(out_dir, exist_ok=True)

    # load text, keep lines
    with open(input_file, "r", encoding="utf8") as f:
        raw_lines = f.read().splitlines()

    # collapse multiple blanks
    lines_collapsed = collapse_blank_lines(raw_lines)

    # We'll treat paragraphs separated by blank lines.
    paragraphs = []
    cur_para = []
    for ln in lines_collapsed:
        if ln.strip() == "":
            if cur_para:
                paragraphs.append(" ".join(cur_para))
                cur_para = []
            # represent a blank-paragraph marker
            paragraphs.append("")  
        else:
            cur_para.append(ln.strip())
    if cur_para:
        paragraphs.append(" ".join(cur_para))

    # prepare drawing context for measurement
    tmp_img = Image.new("RGB", (10,10), "black")
    draw = ImageDraw.Draw(tmp_img)
    font = find_font(DEFAULT_FONTSIZE)

    max_text_width = WIDTH - MARGIN_LEFT - MARGIN_RIGHT

    wrapped_lines = []
    for para in paragraphs:
        if para == "":
            # blank line -> preserve as a single blank line
            wrapped_lines.append("")
        else:
            wrapped = wrap_paragraph(para, max_text_width, draw, font)
            wrapped_lines.extend(wrapped)

    # compute line height
    _, lh = measure_text(draw, "Hg", font)
    line_height = lh + LINE_SPACING

    max_lines_per_page = (HEIGHT - MARGIN_TOP - MARGIN_BOTTOM) // line_height
    if max_lines_per_page <= 0:
        print("ERROR: font size / spacing too large for page height.")
        return 3

    pages = paginate_lines(wrapped_lines, max_lines_per_page)

    print(f"Total lines after wrap: {len(wrapped_lines)}")
    print(f"Lines per page: {max_lines_per_page}, Total pages: {len(pages)}")

    # render pages
    for idx, page_lines in enumerate(pages, start=1):
        img = Image.new("RGB", (WIDTH, HEIGHT), "white")
        d = ImageDraw.Draw(img)

        y = MARGIN_TOP
        for ln in page_lines:
            text = ln if ln != "" else " "  # ensure draw has something (some fonts need it)
            d.text((MARGIN_LEFT, y), text, font=font, fill="black")
            y += line_height

        outpath = os.path.join(out_dir, f"page_{idx:04d}.bmp")
        img.save(outpath)
        print(f"Saved {outpath}")

    print("DONE. pages:", len(pages))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))