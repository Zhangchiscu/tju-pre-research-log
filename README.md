# 天津大学研究生科研预备工作

这个仓库用来存放入学前接触 RoboDojo 平台时的学习和测试记录。**工作记录、整理后的说明、原始运行结果和软件环境清单分别存放**，避免把不同性质的文件混在一起。

## 一、本次工作概况（2026 年 10 月 8 日—11 日）

这段时间主要熟悉 RoboDojo 的 `stack_bowls`（三碗堆叠）任务配置和动作接口，并在云服务器上配置仿真环境、使用 `demo_policy` 进行了一次示例仿真。程序正常完成 800 步运行，但**没有完成叠碗操作：1 次评测，成功率 0%，得分 0**。本次结果只能说明示例仿真运行完成，不能视为有效抓取策略的实验成果。

## 二、第一次查看，可以从这里开始

- **想了解做了什么**：看 [科研工作记录](daily/2026-10-08_科研工作记录.md)，是一份简短记录。
- **想知道仿真结果**：看 [评测结果 JSON](evidence/2026-10-08/real_simulation/_result.json)、[最终运行日志](evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log) 和 [三个相机视频所在文件夹](evidence/2026-10-08/real_simulation/)。
- **想了解任务要求**：看 [叠碗任务配置与评价说明](docs/叠碗任务配置与评价说明.md)。
- **想了解当时的部署环境**：看 [仿真运行记录](docs/仿真运行记录.md) 和 [云服务器环境恢复说明](docs/云服务器环境恢复说明.md)。

## 三、文件夹层级

```text
tju-pre-research-log/
├── README.md                       仓库首页与全部文件说明
├── .gitignore                      Git 忽略规则
├── daily/                          科研工作记录（人工记录、前期记录、自动摘要）
├── docs/                           任务规则、仿真过程和环境恢复说明
├── evidence/                       测试和仿真的原始文件
│   ├── README.md                   原始资料入口
│   └── 2026-10-08/                本次实验归档目录
│       ├── README.md               本次保留文件的分类说明
│       ├── real_simulation/         最终运行日志、评测结果、三路视频、补丁
│       └── restore_manifest/        服务器与 Python/Conda 环境版本清单
└── scripts/                        源码检查与本地日志同步脚本
```

其中 `2026-10-08` 是资料最初使用的归档目录名，本次工作记录的时间范围仍为 10 月 8 日—11 日。

## 四、全部文件逐项说明

### 根目录：仓库入口与规则

仓库最外层的两个文件。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`README.md`](README.md) | 仓库总说明 | 本页。先说明本次工作结果，再按目录解释仓库的全部文件。 |
| [`.gitignore`](.gitignore) | Git 忽略规则 | 指定不上传的文件，例如本地密钥、模型权重、缓存和大型 Assets 目录。 |

### `daily/`：工作记录

这里写的是实际做过的工作，和后面的原始日志不同。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`2026-10-08_科研工作记录.md`](daily/2026-10-08_科研工作记录.md) | 本次简短工作记录 | 记录 10 月 8 日—11 日熟悉任务、配置仿真和试跑示例策略的情况；适合先阅读。 |
| [`2026-10-08_前期检查记录.md`](daily/2026-10-08_前期检查记录.md) | 前期检查过程 | 记录早期对观测/动作接口和 WebSocket 的检查；其中“当时尚未完成仿真”指早期状态，不是最终结论。 |
| [`2026-10-08.auto.md`](daily/2026-10-08.auto.md) | 脚本自动生成的旧摘要 | 同步脚本根据当时若干测试输出生成的统计记录；涉及的部分旧日志已精简，不能用于判断最后的仿真结果。 |

### `docs/`：整理后的说明文档

侧重解释任务、实验过程或环境信息，内容比简短工作记录更详细。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`仿真运行记录.md`](docs/仿真运行记录.md) | 仿真过程与结果 | 记录云服务器使用的环境、运行方式、主要参数、一次完整示例评测及三路视频链接。 |
| [`叠碗任务配置与评价说明.md`](docs/叠碗任务配置与评价说明.md) | 任务规则和评分方式 | 根据 RoboDojo 源码整理三碗堆叠任务的机器人配置、场景参数、成功条件和评分规则。 |
| [`云服务器环境恢复说明.md`](docs/云服务器环境恢复说明.md) | 原服务器与本地备份 | 记录 Ubuntu/Isaac Sim/Isaac Lab 等版本、服务器环境、本地大型压缩包和环境恢复方式。 |
| [`文件说明与目录.md`](docs/文件说明与目录.md) | 简版分类索引 | 此前整理的按主题分类的简短链接目录；需要完整逐文件解释时以本首页为准。 |

### `evidence/`：原始资料入口

这里保存实际运行生成的日志、视频、结果和环境清单；英文文件名保留原样以免影响追溯。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`README.md`](evidence/README.md) | 实验资料总入口 | 说明 evidence 资料的范围，并链接到日期、仿真结果和环境清单子目录。 |

### `evidence/2026-10-08/`：本次归档的检查资料

目录名沿用最初归档日期，本次工作记录覆盖 10 月 8 日—11 日。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`README.md`](evidence/2026-10-08/README.md) | 本次归档说明 | 把现存的 15 份关键实验文件按最终仿真、前期检查、环境清单分类。 |
| [`stack_bowls_static_audit.md`](evidence/2026-10-08/stack_bowls_static_audit.md) | 任务源码静态检查 | 19 项任务配置、评分与机器人接口检查的摘要。只是读取源码，不能证明物理仿真成功。 |
| [`test_websocket.py`](evidence/2026-10-08/test_websocket.py) | 策略通信测试脚本 | 本机通过 WebSocket 与示例策略服务连接，检查观测发送、策略重置及动作返回的 Python 代码。 |
| [`websocket_e2e.log`](evidence/2026-10-08/websocket_e2e.log) | 通信测试输出 | 与上面脚本对应的端到端通信日志，记录连接、重置、观测和动作传输的测试结果。 |

### `evidence/2026-10-08/real_simulation/`：最终仿真结果

最值得优先查看的原始数据都在这里。文件名中的 `fail` 表示任务没有完成，并非录像文件损坏。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`README.md`](evidence/2026-10-08/real_simulation/README.md) | 仿真结果说明 | 在本文件夹内解释最终运行日志、评测 JSON、三路视频和补丁分别是什么。 |
| [`_result.json`](evidence/2026-10-08/real_simulation/_result.json) | 正式评测统计 | 程序生成的结构化结果：1 个回合、成功率 0%、得分 0，包含该回合的成功标记。 |
| [`stack_bowls_real_run_08.log`](evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log) | 最终一次完整运行日志 | 记录第 8 次运行的仿真启动、800 步执行、视频保存和统计输出；早期排障日志已从当前目录精简。 |
| [`episode_0000000_cam_head_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_head_fail.mp4) | 头部相机视频 | 记录该回合机器人头部相机的仿真画面。 |
| [`episode_0000000_cam_left_wrist_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_left_wrist_fail.mp4) | 左腕相机视频 | 记录同一回合左机械臂腕部相机的画面。 |
| [`episode_0000000_cam_right_wrist_fail.mp4`](evidence/2026-10-08/real_simulation/episode_0000000_cam_right_wrist_fail.mp4) | 右腕相机视频 | 记录同一回合右机械臂腕部相机的画面。 |
| [`robodojo_failfast.patch`](evidence/2026-10-08/real_simulation/robodojo_failfast.patch) | 程序异常处理补丁 | 记录对 RoboDojo `main.py` 的局部改动；启用相应环境变量时，异常发生后直接退出，便于排障。 |

### `evidence/2026-10-08/restore_manifest/`：环境版本资料

这是辅助复现环境的清单，不含 Isaac Sim 安装包或完整系统镜像。Conda 和 pip 文件不完全重复，所以分别保留。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`README.md`](evidence/2026-10-08/restore_manifest/README.md) | 环境清单说明 | 解释本目录的用途，以及两个 Conda 环境、系统信息和源码版本的对应关系。 |
| [`system_info.txt`](evidence/2026-10-08/restore_manifest/system_info.txt) | 云服务器系统信息 | 记录 Ubuntu、Linux 内核、RTX 3090、驱动与 FFmpeg 版本。 |
| [`source_versions.txt`](evidence/2026-10-08/restore_manifest/source_versions.txt) | 所用源码版本 | 记录 RoboDojo 主仓库及 XPolicyLab、Isaac Lab、CuRobo 子模块的版本与初始化状态。 |
| [`isaaclab_conda.txt`](evidence/2026-10-08/restore_manifest/isaaclab_conda.txt) | 仿真环境 Conda 清单 | `isaaclab` 环境中 Conda 软件包及版本/构建信息。 |
| [`isaaclab_pip_freeze.txt`](evidence/2026-10-08/restore_manifest/isaaclab_pip_freeze.txt) | 仿真环境 pip 清单 | `isaaclab` 中 Python 包的版本列表，包括部分 CUDA 依赖。 |
| [`xpolicy_demo_conda.txt`](evidence/2026-10-08/restore_manifest/xpolicy_demo_conda.txt) | 策略服务 Conda 清单 | 运行示例策略服务器的 `xpolicy_demo` 环境包列表。 |
| [`xpolicy_demo_pip_freeze.txt`](evidence/2026-10-08/restore_manifest/xpolicy_demo_pip_freeze.txt) | 策略服务 pip 清单 | 同一策略服务环境的 Python 包版本和 XPolicyLab 安装来源。 |

### `scripts/`：辅助脚本

这里是代码文件，不是实验结果。保留英文名称，避免影响原有运行方式。

| 文件（可点击） | 用途 | 具体内容 |
| --- | --- | --- |
| [`audit_stack_bowls.py`](scripts/audit_stack_bowls.py) | 任务源码检查脚本 | 不启动 Isaac Sim，直接读取源码和配置，检查 `stack_bowls` 的任务结构与评分逻辑。 |
| [`sync_daily.ps1`](scripts/sync_daily.ps1) | 本地记录同步脚本 | PowerShell 脚本：按日期收集 Windows 上指定目录的日志、生成自动摘要，并通过 Git 同步；不会仅因存放在 GitHub 就自动执行。 |

## 五、如何理解这些记录

- **工作记录（`daily/`）**：只写当时做过什么及基本结果，适合快速了解进度。
- **说明文档（`docs/`）**：解释任务规则、仿真过程和恢复所需条件。
- **原始资料（`evidence/`）**：是实际生成的程序输出；静态检查通过不等于叠碗成功，`demo_policy` 仿真程序正常结束也不等于任务成功。
- **环境清单（`restore_manifest/`）**：是版本参考，不是完整安装包。RoboDojo Assets、XPolicyLab/CuRobo 源码及 Isaac Lab 的大型备份压缩包另外保存在 Windows，本仓库没有上传这些压缩包。
- **早期文件**：部分排障日志和重复检查输出已经从当前目录精简，仍可通过 Git 提交历史追溯；`daily/2026-10-08.auto.md` 仍是当时自动生成的旧摘要。

原始 RoboDojo 项目：[RoboDojo-Benchmark/RoboDojo](https://github.com/RoboDojo-Benchmark/RoboDojo)。这个仓库保存个人记录和必要的测试资料，并不包含整个 RoboDojo/Isaac Sim 安装环境。
