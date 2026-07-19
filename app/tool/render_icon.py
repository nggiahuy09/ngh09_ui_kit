#!/usr/bin/env python3
"""Render the ngh09_ui_kit app-icon master PNG from the same geometry as
assets/branding/app_icon.svg.

Pillow cannot rasterise SVG, so the shapes are drawn here directly at high
supersampling and downscaled for crisp anti-aliasing. Keep the numbers in sync
with app_icon.svg. Output feeds flutter_launcher_icons.

Usage:  python3 tool/render_icon.py
"""

from pathlib import Path

from PIL import Image, ImageDraw

SIZE = 1024          # final icon edge, px
SS = 4               # supersampling factor
BLACK = (0, 0, 0, 255)
WHITE = (255, 255, 255, 255)

OUT = Path(__file__).resolve().parent.parent / "assets" / "branding" / "app_icon.png"


def circle(draw, cx, cy, r, fill=None, outline=None, width=0):
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=fill, outline=outline, width=width)


def main():
    s = SIZE * SS
    img = Image.new("RGBA", (s, s), BLACK)
    d = ImageDraw.Draw(img)

    def px(v):
        return v * SS

    # Zero: white ring (stroke width 80 straddling r=186).
    circle(d, px(376), px(496), px(186), outline=WHITE, width=px(80))

    # Nine: solid bowl with a punched-out counter, plus a descending stem.
    circle(d, px(672), px(440), px(150), fill=WHITE)
    circle(d, px(672), px(440), px(66), fill=BLACK)
    d.rounded_rectangle(
        [px(742), px(430), px(742 + 80), px(430 + 330)],
        radius=px(40),
        fill=WHITE,
    )

    img = img.resize((SIZE, SIZE), Image.LANCZOS)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    img.save(OUT)
    print(f"wrote {OUT} ({SIZE}x{SIZE})")


if __name__ == "__main__":
    main()
