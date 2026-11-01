#!/usr/bin/env python3
"""Compute SOML colorscheme colors with perceptual uniformity and contrast compliance.

Constraints:
- APCA Lc 60+ against terminal background (#0d0d0d) for all foreground colors
- WCAG AA 4.5:1 against all dark surfaces (#0d0d0d, #1a1a1a, #363636)
- Equal OKLCH L within each tier across all 6 chromatic hues
- Maximize chroma per hue within sRGB gamut
"""

import math


# --- Color conversion functions ---

def oklch_to_oklab(L, C, h_deg):
    h = math.radians(h_deg)
    return L, C * math.cos(h), C * math.sin(h)


def oklab_to_linear_srgb(L, a, b):
    l_ = L + 0.3963377774 * a + 0.2158037573 * b
    m_ = L - 0.1055613458 * a + 0.0638541728 * b
    s_ = L - 0.0894841775 * a - 1.2914855480 * b

    l = l_ ** 3
    m = m_ ** 3
    s = s_ ** 3

    r = +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s
    g = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s
    b_ = -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s

    return r, g, b_


def linear_to_srgb(c):
    if c <= 0.0031308:
        return 12.92 * c
    return 1.055 * (c ** (1.0 / 2.4)) - 0.055


def srgb_to_linear(c):
    if c <= 0.04045:
        return c / 12.92
    return ((c + 0.055) / 1.055) ** 2.4


def oklch_to_srgb(L, C, h_deg):
    lab_L, lab_a, lab_b = oklch_to_oklab(L, C, h_deg)
    lr, lg, lb = oklab_to_linear_srgb(lab_L, lab_a, lab_b)
    return linear_to_srgb(lr), linear_to_srgb(lg), linear_to_srgb(lb)


def in_srgb_gamut(r, g, b, tol=0.001):
    return all(-tol <= c <= 1 + tol for c in (r, g, b))


def clamp(v, lo=0.0, hi=1.0):
    return max(lo, min(hi, v))


def rgb_to_hex(r, g, b):
    return "#{:02x}{:02x}{:02x}".format(
        round(clamp(r) * 255),
        round(clamp(g) * 255),
        round(clamp(b) * 255),
    )


def hex_to_srgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


# --- Contrast functions ---

def relative_luminance(r, g, b):
    return 0.2126 * srgb_to_linear(r) + 0.7152 * srgb_to_linear(g) + 0.0722 * srgb_to_linear(b)


def wcag_contrast(lum1, lum2):
    lighter = max(lum1, lum2)
    darker = min(lum1, lum2)
    return (lighter + 0.05) / (darker + 0.05)


def apca_lc(fg_rgb, bg_rgb):
    """APCA Lc (SAPC method)."""
    def to_y(rgb):
        r, g, b = rgb
        return 0.2126729 * srgb_to_linear(r) + 0.7151522 * srgb_to_linear(g) + 0.0721750 * srgb_to_linear(b)

    y_fg = max(to_y(fg_rgb), 0.0)
    y_bg = max(to_y(bg_rgb), 0.0)

    Ntx = 0.022
    Nbg = 0.022

    y_fg_c = y_fg if y_fg >= Ntx else y_fg + (Ntx - y_fg) ** 1.45
    y_bg_c = y_bg if y_bg >= Nbg else y_bg + (Nbg - y_bg) ** 1.45

    if y_bg_c < y_fg_c:
        S = (y_fg_c ** 0.56 - y_bg_c ** 0.57) * 1.14
        Lc = (S - 0.027) * 100.0 if S >= 0.1 else 0.0
    else:
        S = (y_bg_c ** 0.65 - y_fg_c ** 0.62) * 1.14
        Lc = (S - 0.027) * 100.0 if S >= 0.1 else 0.0

    return abs(Lc)


# --- Core computation ---

def max_chroma_for_hue(L, h_deg, tol=0.0005):
    lo, hi = 0.0, 0.4
    while hi - lo > tol:
        mid = (lo + hi) / 2
        r, g, b = oklch_to_srgb(L, mid, h_deg)
        if in_srgb_gamut(r, g, b):
            lo = mid
        else:
            hi = mid
    return lo


# Dark surfaces
TERM_BG = "#0d0d0d"
BLACK = "#1a1a1a"
GRAY = "#363636"
ALL_SURFACES = [(TERM_BG, "Terminal BG"), (BLACK, "Black"), (GRAY, "Gray")]


def passes_constraints(L, hues):
    """Check revised constraints:
    - APCA Lc 60+ against terminal bg (#0d0d0d) only
    - WCAG 4.5:1 against all 3 dark surfaces
    """
    term_bg_rgb = hex_to_srgb(TERM_BG)
    term_bg_lum = relative_luminance(*term_bg_rgb)

    for h in hues:
        C = max_chroma_for_hue(L, h)
        r, g, b = oklch_to_srgb(L, C, h)
        r, g, b = clamp(r), clamp(g), clamp(b)
        fg_rgb = (r, g, b)
        fg_lum = relative_luminance(r, g, b)

        # APCA Lc 60+ against terminal bg only
        lc = apca_lc(fg_rgb, term_bg_rgb)
        if lc < 60.0:
            return False

        # WCAG 4.5:1 against all 3 surfaces
        for surf_hex, _ in ALL_SURFACES:
            bg_rgb = hex_to_srgb(surf_hex)
            bg_lum = relative_luminance(*bg_rgb)
            ratio = wcag_contrast(fg_lum, bg_lum)
            if ratio < 4.5:
                return False
    return True


def find_min_L(hues, tol=0.001):
    lo, hi = 0.5, 0.95
    while hi - lo > tol:
        mid = (lo + hi) / 2
        if passes_constraints(mid, hues):
            hi = mid
        else:
            lo = mid
    return hi


def compute_palette():
    hue_defs = [
        ("Red", 13.0),
        ("Green", 149.0),
        ("Gold", 45.0),
        ("Blue", 217.0),
        ("Magenta", 349.0),
        ("Orange", 23.0),
    ]

    hues = [h for _, h in hue_defs]
    min_L = find_min_L(hues)

    # Round up for safety margin
    default_L = math.ceil(min_L * 1000) / 1000
    bright_L = default_L + 0.11

    print(f"Minimum L satisfying all constraints: {min_L * 100:.1f}%")
    print(f"Default tier L: {default_L * 100:.1f}%")
    print(f"Bright tier L:  {bright_L * 100:.1f}%")

    # Identify binding constraints per hue at default L
    print(f"\n--- Binding analysis at L = {default_L * 100:.1f}% ---")
    term_bg_rgb = hex_to_srgb(TERM_BG)
    gray_rgb = hex_to_srgb(GRAY)
    gray_lum = relative_luminance(*gray_rgb)
    for name, h in hue_defs:
        C = max_chroma_for_hue(default_L, h)
        r, g, b = oklch_to_srgb(default_L, C, h)
        r, g, b = clamp(r), clamp(g), clamp(b)
        fg_rgb = (r, g, b)
        fg_lum = relative_luminance(r, g, b)
        wcag_gray = wcag_contrast(fg_lum, gray_lum)
        lc_term = apca_lc(fg_rgb, term_bg_rgb)
        hex_val = rgb_to_hex(r, g, b)
        print(f"  {name:<10} C={C:.4f} {hex_val}  WCAG vs Gray={wcag_gray:.2f}  APCA vs TermBG={lc_term:.1f}")

    slot_order = [
        ("Red", 13.0, "Red", "Bright Red"),
        ("Green", 149.0, "Green", "Bright Green"),
        ("Gold", 45.0, "Gold", "Yellow"),
        ("Blue", 217.0, "Blue", "Bright Blue"),
        ("Magenta", 349.0, "Magenta", "Bright Magenta"),
        ("Orange", 23.0, "Orange", "Bright Orange"),
    ]

    results = {}

    print("\n" + "=" * 80)
    print("COMPUTED COLORS")
    print("=" * 80)

    for tier_name, L in [("Default", default_L), ("Bright", bright_L)]:
        print(f"\n--- {tier_name} Tier (L = {L * 100:.1f}%) ---")
        print(f"{'Name':<18} {'OKLCH L':>7} {'C':>7} {'h':>7}  {'Hex':<10}")
        for hue_name, h_deg, default_name, bright_name in slot_order:
            C = max_chroma_for_hue(L, h_deg)
            r, g, b = oklch_to_srgb(L, C, h_deg)
            r, g, b = clamp(r), clamp(g), clamp(b)
            hex_val = rgb_to_hex(r, g, b)
            name = default_name if tier_name == "Default" else bright_name
            results[(hue_name, tier_name)] = (hex_val, L, C, h_deg, (r, g, b))
            print(f"{name:<18} {L*100:>6.1f}% {C:>7.4f} {h_deg:>7.1f}  {hex_val}")

    # Full contrast matrix
    print("\n" + "=" * 80)
    print("CONTRAST VERIFICATION")
    print("=" * 80)

    all_pass = True
    for surf_hex, surf_name in ALL_SURFACES:
        bg_rgb = hex_to_srgb(surf_hex)
        bg_lum = relative_luminance(*bg_rgb)
        is_term_bg = (surf_hex == TERM_BG)
        constraint = "WCAG 4.5:1 + APCA Lc 60" if is_term_bg else "WCAG 4.5:1"
        print(f"\n--- Against {surf_name} ({surf_hex}) [{constraint}] ---")
        print(f"{'Color':<18} {'Hex':<10} {'WCAG':>6} {'APCA':>6} {'Pass?':>6}")
        for hue_name, h_deg, default_name, bright_name in slot_order:
            for tier_name in ["Default", "Bright"]:
                hex_val, L, C, h, rgb = results[(hue_name, tier_name)]
                name = default_name if tier_name == "Default" else bright_name
                lum = relative_luminance(*rgb)
                ratio = wcag_contrast(lum, bg_lum)
                lc = apca_lc(rgb, bg_rgb)
                wcag_ok = ratio >= 4.5
                apca_ok = lc >= 60.0 if is_term_bg else True
                passed = wcag_ok and apca_ok
                if not passed:
                    all_pass = False
                mark = "OK" if passed else "FAIL"
                print(f"{name:<18} {hex_val}  {ratio:>5.2f}  {lc:>5.1f}  {mark:>5}")

    print(f"\n{'ALL PASS' if all_pass else 'SOME FAILURES'}")

    # Config-ready output
    terminal_map = [
        ("red", "Red"),
        ("green", "Green"),
        ("yellow", "Gold"),
        ("blue", "Blue"),
        ("magenta", "Magenta"),
        ("cyan", "Orange"),
    ]

    print("\n" + "=" * 80)
    print("ALACRITTY CONFIG")
    print("=" * 80)

    print("\n[colors.normal]")
    print('black = "#1a1a1a"')
    for term_name, hue_name in terminal_map:
        print(f'{term_name} = "{results[(hue_name, "Default")][0]}"')
    print('white = "#c7c7c7"')

    print("\n[colors.bright]")
    print('black = "#363636"')
    for term_name, hue_name in terminal_map:
        print(f'{term_name} = "{results[(hue_name, "Bright")][0]}"')
    print('white = "#e6e6e6"')

    print("\n" + "=" * 80)
    print("HELIX PALETTE")
    print("=" * 80)

    # Helix palette: 6 hues mapped to semantic names for syntax highlighting.
    # cyan = Gold (not Orange) so constants are distinct from cursor/emphasis.
    # bright_cyan = Gold bright (parallels cyan = Gold default).
    helix_entries = [
        ("red", "Red", "Default"),
        ("green", "Green", "Default"),
        ("orange", "Orange", "Default"),
        ("blue", "Blue", "Default"),
        ("magenta", "Magenta", "Default"),
        ("cyan", "Gold", "Default"),
        ("bright_red", "Red", "Bright"),
        ("yellow", "Gold", "Bright"),
        ("bright_yellow", "Orange", "Bright"),
        ("bright_blue", "Blue", "Bright"),
        ("bright_magenta", "Magenta", "Bright"),
        ("bright_green", "Green", "Bright"),
        ("bright_cyan", "Gold", "Bright"),
    ]

    print("\n[palette]")
    for pal_name, hue_name, tier in sorted(helix_entries):
        print(f'{pal_name} = "{results[(hue_name, tier)][0]}"')

    return results, all_pass


if __name__ == "__main__":
    compute_palette()
