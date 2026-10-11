# 天津大学研究生科研预备工作

这个仓库记录入学前对 RoboDojo 平台的学习和示例测试。文件主要分为工作记录、任务与环境说明、原始仿真结果和辅助脚本四类。

## 本次工作（2026 年 10 月 8 日—11 日）

这段时间主要查看了 RoboDojo 的 `stack_bowls`（三碗堆叠）任务配置和动作接口，并在云服务器上使用 `demo_policy` 完成了一次示例仿真。程序能够正常运行，但没有完成实际叠碗操作，**本次成功率为 0%**。这是示例策略运行记录，不代表已经得到有效的抓取控制方法。

想看简短经过可打开 [科研工作记录](daily/2026-10-08_科研工作记录.md)；想确认实验结果可直接查看 [评测结果](evidence/2026-10-08/real_simulation/_result.json) 或 [最终日志](evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log)。

## 文件夹结构

```text
tju-pre-research-log/
├── README.md                       本页：所有文件的中文说明
├── .gitignore                      Git 忽略配置
├── daily/                          简短科研工作记录
├── docs/                           任务、仿真及环境说明
├── evidence/                       核心原始实验资料
│   ├── README.md                   资料入口
│   └── 2026-10-08/                 原始资料归档日期
│       ├── real_simulation/         最终评测、日志、三路视频和补丁
│       └── restore_manifest/        服务器及软件环境版本
└── scripts/                        日志同步脚本
```

`2026-10-08` 是原始资料的归档文件夹名；本次工作记录的日期范围仍是 10 月 8 日—11 日。

## 全部文件说明

| 文件（点击打开） | 主要内容 |
| --- | --- |
| [`README.md`](README.md) | 仓库首页。说明本次工作、文件夹结构和全部保留文件的用途。 |
| [`.gitignore`](.gitignore) | Git 的忽略配置，避免误提交缓存、私密配置和大型模型资源。 |
| [`daily/2026-10-08_科研工作记录.md`](daily/2026-10-08_科研工作记录.md) | 10 月 8 日—11 日的简短工作记录：熟悉叠碗任务、示例仿真及其结果。 |
| [`docs/仿真运行记录.md`](docs/仿真运行记录.md) | 较详细地记录本次仿真的环境、运行过程、测试参数及结果链接。 |
| [`docs/叠碗任务配置与评价说明.md`](docs/叠碗任务配置与评价说明.md) | 解释 `stack_bowls` 的场景参数、机器人配置、成功条件和评分依据；属于源码资料整理。 |
| [`docs/云服务器环境恢复说明.md`](docs/云服务器环境恢复说明.md) | 记录当时的软件版本、环境依赖、Windows 本地资源备份及重新搭建方式。 |
| [`evidence/README.md`](evidence/README.md) | 原始实验资料的简短中文入口。 |
| [`evidence/2026-10-08/real_simulation/README.md`](evidence/2026-10-08/real_simulation/README.md) | 解释最终仿真文件中的日志、结果、视频和代码补丁。 |
| [`evidence/2026-10-08/real_simulation/_result.json`](evidence/2026-10-08/real_simulation/_result.json) | 正式评测结果：1 次示例评测，成功率 0%，得分 0。 |
| [`evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log`](evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log) | 最终一次完整仿真的原始日志，记录 800 步执行、视频生成及结果统计。 |
| [`evidence/2026-10-08/real_simulation/episode_0000000_cam_head_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_head_fail.mp4) | 仿真中机器人头部相机的录像；`fail` 指该回合任务没有成功。 |
| [`evidence/2026-10-08/real_simulation/episode_0000000_cam_left_wrist_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_left_wrist_fail.mp4) | 同一回合左机械臂腕部相机的录像。 |
| [`evidence/2026-10-08/real_simulation/episode_0000000_cam_right_wrist_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_right_wrist_fail.mp4) | 同一回合右机械臂腕部相机的录像。 |
| [`evidence/2026-10-08/real_simulation/robodojo_failfast.patch`](evidence/2026-10-08/real_simulation/robodojo_failfast.patch) | 对 RoboDojo 评测程序的局部异常处理修改；保留以便环境恢复时核对。 |
| [`evidence/2026-10-08/restore_manifest/README.md`](evidence/2026-10-08/restore_manifest/README.md) | 说明服务器、源码及软件依赖的版本清单。 |
| [`evidence/2026-10-08/restore_manifest/system_info.txt`](evidence/2026-10-08/restore_manifest/system_info.txt) | 云服务器 Ubuntu、RTX 3090、驱动及 FFmpeg 版本。 |
| [`evidence/2026-10-08/restore_manifest/source_versions.txt`](evidence/2026-10-08/restore_manifest/source_versions.txt) | RoboDojo 主程序与子模块的版本号和状态。 |
| [`evidence/2026-10-08/restore_manifest/isaaclab_conda.txt`](evidence/2026-10-08/restore_manifest/isaaclab_conda.txt) | 仿真环境 `isaaclab` 的 Conda 包清单，供核对完整软件依赖。 |
| [`evidence/2026-10-08/restore_manifest/xpolicy_demo_pip_freeze.txt`](evidence/2026-10-08/restore_manifest/xpolicy_demo_pip_freeze.txt) | 示例策略服务器 `xpolicy_demo` 的 Python 包版本及安装来源。 |
| [`scripts/sync_daily.ps1`](scripts/sync_daily.ps1) | Windows 日志整理与 Git 同步脚本。只在手动运行时执行；沿用原文件名避免破坏既有操作。 |

## 几点说明

- `daily/` 是简短工作记录；`docs/` 是任务和环境的详细说明；`evidence/` 是原始程序输出。查看研究进展时，不必逐份阅读软件依赖清单。
- `real_simulation/` 中只保留了最终一次完整运行的日志。评测成功率为 0% 是**叠碗任务没有成功**，不表示日志或视频损坏。
- `restore_manifest/` 只保存版本核对资料，不是完整的环境镜像。大型资源备份此前另存于 Windows 本地，没有上传本仓库。
- 为避免重复，早期自动汇总、重复的测试代码与日志、辅助检查结果及部分软件包清单已从当前目录精简。**原始文件仍可从 Git 历史提交中查阅**。
- `sync_daily.ps1` 是保留的旧同步脚本，运行它可能重新生成自动摘要及导入本地日志；该脚本不是自动定时运行的服务。

原始 RoboDojo 项目：[RoboDojo-Benchmark/RoboDojo](https://github.com/RoboDojo-Benchmark/RoboDojo)。
