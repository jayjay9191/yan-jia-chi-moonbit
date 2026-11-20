"""Exercise the public CLI and measured second-review cases."""
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def run(*args, success=True):
    result = subprocess.run(["moon", "run", "cmd/main", "--", *args], cwd=ROOT,
                            capture_output=True, text=True, encoding="utf-8", timeout=90)
    assert result.returncode == (0 if success else 2), result.stdout + result.stderr
    return result.stdout


def main():
    assert "用法" in run("help")
    tana = run("trajectory", "Tana")
    assert "-21%" in tana and "降价" in tana
    glm = run("trajectory", "智谱清言 / GLM")
    assert "逐档核对" in glm and "71%" not in glm and "129%" not in glm
    assert "已下架，停止复核，保留历史" in run("trajectory", "Tabnine")
    summary = run("trajectory-summary")
    for label, count in (("无变化", 368), ("新档位", 160), ("涨价", 1),
                         ("降价", 3), ("下架", 6), ("未看到价", 404)):
        assert f"{label}：{count}" in summary
    classes = run("classes", "Midjourney")
    assert "Midjourney：4类" in classes and classes.count("年付节省20%") == 4
    assert "矛盾/待核对：0" in classes
    assert "20261115-R1 | 0类 | 缺少" in classes
    assert "20261115-R3 | 4类" in classes and "20261118-R5 | 4类" in classes
    queue = run("recheck-queue", "2026-11-20")
    assert len([line for line in queue.splitlines() if line.startswith("APV-")]) == 20
    for args in (("unknown-review-command",), ("trajectory",), ("trajectory", "missing"),
                 ("classes",), ("recheck-queue", "2026-02-30"),
                 ("trajectory-summary", "unexpected")):
        run(*args, success=False)
    print("PASS measured trajectories, 942 category counts, four plan classes, R1 evidence gap and top20 queue")


if __name__ == "__main__":
    main()
