#!/usr/bin/env python3
"""Generate the TPU trend figure used in Chapter 1.

The chart is drawn with matplotlib and seaborn, then imported by Typst as a
vector PDF. Keeping the data here makes the figure reproducible and avoids
manual canvas alignment inside the report source.
"""

from __future__ import annotations

from pathlib import Path

from matplotlib.lines import Line2D
import matplotlib.pyplot as plt
import seaborn as sns


REPORT_DIR = Path(__file__).resolve().parents[1]
OUT_DIR = REPORT_DIR / "assets" / "overview"
PDF_PATH = OUT_DIR / "tpu-trend.pdf"


# Peak numbers are public headline figures. Precision differs by generation:
# v1 uses INT8 TOPS, v2/v3 are floating-point TFLOPS, later generations use
# bf16/FP8, and TPU 8t is reported as a superpod-level FP4 figure. The chart
# therefore emphasizes trends, not strict apples-to-apples benchmarking.
TPU_DATA = [
    {"name": "TPU v1", "year": 2015, "chip_tflops": 92, "system_tflops": 92, "chips": 1, "note": "92 TOPS"},
    {"name": "TPU v2", "year": 2017, "chip_tflops": 45, "system_tflops": 11_500, "chips": 256, "note": "11.5 PFLOPS Pod"},
    {"name": "TPU v3", "year": 2018, "chip_tflops": 123, "system_tflops": 100_000, "chips": 1024, "note": "100+ PFLOPS Pod"},
    {"name": "TPU v4", "year": 2020, "chip_tflops": 275, "system_tflops": 1_100_000, "chips": 4096, "note": "1.1 EFLOPS"},
    {"name": "TPU v5e", "year": 2023, "chip_tflops": 197, "system_tflops": 50_400, "chips": 256, "note": "50.4 PFLOPS Pod"},
    {"name": "TPU v6e", "year": 2024, "chip_tflops": 918, "system_tflops": 235_000, "chips": 256, "note": "235 PFLOPS Pod"},
    {"name": "TPU7x", "year": 2025, "chip_tflops": 4614, "system_tflops": 42_500_000, "chips": 9216, "note": "42.5 EFLOPS Pod"},
    {"name": "TPU 8t", "year": 2026, "chip_tflops": 12_604, "system_tflops": 121_000_000, "chips": 9600, "note": "121 EFLOPS Superpod"},
]


MODEL_DATA = [
    {"name": "AlexNet", "year": 2012, "flops": 4.7e17},
    {"name": "Transformer", "year": 2017, "flops": 7.42e18},
    {"name": "BERT-Large", "year": 2018, "flops": 2.85e20},
    {"name": "GPT-3", "year": 2020, "flops": 3.14e23},
    {"name": "PaLM", "year": 2022, "flops": 2.53e24},
    {"name": "Llama 3.1 405B", "year": 2024, "flops": 3.8e25},
    {"name": "GPT-5", "year": 2025, "flops": 6.6e25},
    {"name": "DeepSeek V4-Pro", "year": 2026, "flops": 9.702e24},
]


def scale_bubble(chips: int) -> float:
    return 36 + chips ** 0.45 * 12


def annotate(ax, text: str, x: float, y: float, dx: float, dy: float, size: float = 8.2) -> None:
    ax.annotate(
        text,
        xy=(x, y),
        xytext=(dx, dy),
        textcoords="offset points",
        ha="center",
        va="center",
        fontsize=size,
        arrowprops={
            "arrowstyle": "-",
            "color": "#94a3b8",
            "lw": 0.65,
            "shrinkA": 4,
            "shrinkB": 4,
        },
    )


def draw() -> None:
    sns.set_theme(style="whitegrid", context="paper", font_scale=1.0)
    plt.rcParams["font.family"] = "Arial"
    plt.rcParams["axes.unicode_minus"] = False
    plt.rcParams["pdf.fonttype"] = 42
    plt.rcParams["ps.fonttype"] = 42

    fig = plt.figure(figsize=(7.35, 5.58), constrained_layout=False)
    gs = fig.add_gridspec(2, 1, height_ratios=[2.25, 1.0], hspace=0.26)
    ax_top = fig.add_subplot(gs[0])
    ax_bottom = fig.add_subplot(gs[1], sharex=ax_top)

    years = [d["year"] for d in TPU_DATA]
    chip_points = [(d["year"], d["chip_tflops"]) for d in TPU_DATA if d["chip_tflops"] is not None]
    system_points = [(d["year"], d["system_tflops"]) for d in TPU_DATA]

    ax_top.plot(*zip(*chip_points), color="#2563eb", lw=1.8, marker="o", ms=4.4, label="Chip peak")
    ax_top.plot(*zip(*system_points), color="#ea580c", lw=2.0, marker="o", ms=4.4, label="System peak")
    ax_top.scatter(
        years,
        [d["system_tflops"] for d in TPU_DATA],
        s=[scale_bubble(d["chips"]) for d in TPU_DATA],
        facecolor="#fed7aa",
        edgecolor="#ea580c",
        linewidth=1.0,
        alpha=0.58,
        label="Chip count",
        zorder=2,
    )
    ax_top.scatter(
        years,
        [d["system_tflops"] for d in TPU_DATA],
        s=28,
        color="#ea580c",
        zorder=3,
    )

    callout_offsets = {
        "TPU v2": (-38, 30),
        "TPU v3": (-34, 28),
        "TPU v4": (0, 34),
        "TPU v5e": (-48, -30),
        "TPU v6e": (55, 23),
        "TPU7x": (-70, -36),
        "TPU 8t": (-58, 24),
    }
    for item in TPU_DATA:
        if item["name"] in callout_offsets:
            text = f'{item["note"]}\n{item["chips"]} chips'
            annotate(ax_top, text, item["year"], item["system_tflops"], *callout_offsets[item["name"]], size=7.2)

    ax_top.set_yscale("log")
    ax_top.set_ylim(25, 1.0e10)
    ax_top.set_ylabel("Peak compute (TFLOPS / TOPS)", fontsize=8.5)
    ax_top.set_title("TPU system scale and model training compute", fontsize=12.3, weight="bold", pad=8)
    legend_handles = [
        Line2D([0], [0], color="#2563eb", marker="o", lw=1.8, ms=4.8, label="Chip peak"),
        Line2D([0], [0], color="#ea580c", marker="o", lw=2.0, ms=4.8, label="System peak"),
        Line2D([0], [0], color="#ea580c", marker="o", lw=0, ms=10, markerfacecolor="#fed7aa", label="Bubble area = chip count"),
    ]
    ax_top.legend(
        handles=legend_handles,
        loc="upper left",
        bbox_to_anchor=(0.015, 0.89),
        frameon=True,
        framealpha=0.94,
        borderpad=0.55,
        fontsize=7.5,
    )
    for item in TPU_DATA:
        ax_top.text(
            item["year"],
            0.06,
            item["name"],
            transform=ax_top.get_xaxis_transform(),
            ha="right",
            va="bottom",
            rotation=35,
            fontsize=5.2,
            color="#334155",
            clip_on=True,
        )
    ax_top.text(
        2011.6,
        0.06,
        "TPU generation",
        transform=ax_top.get_xaxis_transform(),
        ha="left",
        va="bottom",
        fontsize=6.2,
        color="#64748b",
        clip_on=True,
    )

    model_years = [d["year"] for d in MODEL_DATA]
    model_flops = [d["flops"] for d in MODEL_DATA]
    ax_bottom.plot(model_years, model_flops, color="#7c3aed", lw=1.9, marker="o", ms=4.5)
    model_offsets = {
        "AlexNet": (0, 15),
        "Transformer": (0, 15),
        "BERT-Large": (0, -16),
        "GPT-3": (0, 16),
        "PaLM": (0, 15),
        "Llama 3.1 405B": (-22, -19),
        "GPT-5": (4, 22),
        "DeepSeek V4-Pro": (-28, -25),
    }
    for item in MODEL_DATA:
        annotate(ax_bottom, item["name"], item["year"], item["flops"], *model_offsets[item["name"]], size=7.3)

    ax_bottom.set_yscale("log")
    ax_bottom.set_ylim(1e17, 2e27)
    ax_bottom.set_ylabel("Training compute (FLOP)", fontsize=8.5)
    ax_bottom.set_xlabel("Year", fontsize=8.5)
    for ax in (ax_top, ax_bottom):
        ax.set_xlim(2011.6, 2026.8)
        ax.grid(True, which="major", axis="y", color="#dbe3ea", linewidth=0.6)
        ax.grid(False, axis="x")
        ax.tick_params(axis="both", labelsize=7.4)
        sns.despine(ax=ax, top=True, right=True)

    ax_bottom.set_xticks([2012, 2015, 2017, 2018, 2020, 2023, 2024, 2025, 2026])
    ax_bottom.set_xticklabels(["2012", "2015", "2017", "2018", "2020", "2023", "2024", "2025", "2026"])

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    fig.savefig(PDF_PATH, format="pdf", bbox_inches="tight", pad_inches=0.08)
    plt.close(fig)


if __name__ == "__main__":
    draw()
