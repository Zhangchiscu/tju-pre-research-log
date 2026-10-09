# 天津大学研究生科研预备工作

这个仓库主要用来记录入学前做过的科研准备，包括平时看的任务代码、环境配置、测试记录和仿真结果。遇到过的问题以及对应的处理方法也一并保留下来，方便之后继续使用。

## 目前的工作内容

最近在熟悉 RoboDojo 平台，主要查看 `stack_bowls`（三碗堆叠）任务的配置、机器人动作接口和仿真运行方式。

### 2026 年 10 月 8 日—11 日

这次在智川云 RTX 3090 服务器上配置了 Isaac Sim、Isaac Lab 和 RoboDojo 的运行环境，并用 `demo_policy` 完整运行了一次 `stack_bowls` 仿真评测。

本次运行了 800 步，生成了头部、左腕和右腕三个相机视角的视频。程序正常结束，但没有完成实际叠碗操作，评测成功率为 0%。这次主要验证了仿真程序和策略通信能正常运行，没有训练抓取策略，也没有使用真实机械臂。

- [工作记录](daily/2026-10-08.md)
- [仿真运行过程、视频和相关代码](docs/REAL_SIMULATION_RUNBOOK.md)
- [三路视频与完整运行日志](evidence/2026-10-08/real_simulation/)
- [环境备份与恢复记录](docs/RESTORE_ON_NEW_CLOUD.md)

## 文件整理

- `daily/`：按日期整理的工作记录
- `docs/`：任务代码分析、实验记录和环境恢复说明
- `evidence/`：测试输出、仿真视频、结果文件及环境信息
- `scripts/`：整理过的测试和同步脚本

原始 RoboDojo 源码来自 [RoboDojo-Benchmark/RoboDojo](https://github.com/RoboDojo-Benchmark/RoboDojo)。本仓库保存了所用的源码版本和部分修改补丁，没有直接复制整套第三方工程。

Isaac Sim 安装环境和部分大型资源也不在本仓库中，相关备份位置已写在恢复记录里。
