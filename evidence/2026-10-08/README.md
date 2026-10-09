# 这次科研记录的原始文件说明

这里保存的是原始测试和仿真资料，不是需要从头到尾阅读的报告。文件名基本保持程序输出的原样，下面按内容分组，逐个说明每个文件是什么。

**先看哪里**：要看这次实际仿真，建议先打开 [第 8 次运行日志](real_simulation/stack_bowls_real_run_08.log)、[评测结果](real_simulation/_result.json) 和三个视频；要找故障的处理经过，再看第 1～7 次日志。

- [仿真日志、视频及结果的详细说明](real_simulation/README.md)
- [Conda、pip 和源码版本清单的详细说明](restore_manifest/README.md)
- [科研工作记录](../../daily/2026-10-08_科研工作记录.md)

## 文件名和后缀

- `.log`：程序在终端打印的原始日志；`.txt`：检查信息或软件包清单；`.md`：可直接阅读的说明；`.json`：结构化检查与结果数据。
- `.py`：Python 测试脚本；`.mp4`：摄像机录像；`.patch`：代码修改差异。
- `static_audit` 是不启动物理仿真的源码静态检查；`real_run` 是云端实际启动仿真的尝试；`restore_manifest` 是环境记录。

## 本机最早保存的环境资料

| 文件 | 具体内容 |
| --- | --- |
| [`dependency_check.txt`](dependency_check.txt) | 本机依赖检查的简短输出：`No broken requirements found.`，只说明检查当时没有报告破损依赖。 |
| [`environment_summary.txt`](environment_summary.txt) | Windows 本机 Python 3.11.16、PyTorch 2.7.0+cu128、CUDA 12.8，以及 NumPy、OpenCV 等版本和 CUDA 可用性。 |
| [`git_commit.txt`](git_commit.txt) | RoboDojo 主代码仓库在当时记录的提交编号 `726e9aab...`，用于标识所用源码。 |
| [`git_status.txt`](git_status.txt) | 当时保存的 Git 状态输出；该文件为空，不能从中推断后续代码是否被改动。 |
| [`gpu_info.txt`](gpu_info.txt) | 当时执行 GPU 检查产生的详细硬件、驱动及运行信息，文件内容较长，属于原始系统输出。 |
| [`pip_freeze.txt`](pip_freeze.txt) | Windows 早期 Python 环境的软件包版本表；并非云服务器的 Isaac Sim 完整环境。 |
| [`submodules.txt`](submodules.txt) | 早期保存的 RoboDojo 子模块提交编号和状态摘要，涵盖 XPolicyLab、Isaac Lab、CuRobo。 |

## 离线与通信测试

| 文件 | 具体内容 |
| --- | --- |
| [`robodojo_offline_test.log`](robodojo_offline_test.log) | 模拟策略 reset、接收观测、输出动作和环境执行的过程，末尾 `PASS: offline policy control loop`；没有启动真实仿真。 |
| [`robodojo_demo_policy_test.log`](robodojo_demo_policy_test.log) | 演示策略在 joint 模式下生成动作，记录左右机械臂各 6 个关节、左右夹爪各 1 个维度。 |
| [`robodojo_action_interface_test.log`](robodojo_action_interface_test.log) | 动作接口测试记录：关节动作通过、末端动作通过、错误动作维度被拒绝，均是接口层面的检查。 |
| [`test_websocket.py`](test_websocket.py) | 在本地启动 WebSocket 策略服务，发送模拟观测，执行 reset、获取动作并检查维度的 Python 测试代码。脚本中使用了当时 Windows 的 RoboDojo 本地目录。 |
| [`websocket_e2e.log`](websocket_e2e.log) | 上述端到端通信测试的日志，显示握手、策略重置、观测发送及动作回复等检查通过。 |
| [`stack_bowls_static_audit.json`](stack_bowls_static_audit.json) | 静态核查脚本导出的结构化数据，含 19 项检查结果、任务参数及所检查源码的 SHA-256。 |
| [`stack_bowls_static_audit.log`](stack_bowls_static_audit.log) | 同一次静态核查的终端输出，包含任务登记、机器人维度、评分条件等 PASS 记录。 |
| [`stack_bowls_static_audit.md`](stack_bowls_static_audit.md) | 便于直接阅读的静态核查摘要；文中的“尚未验证”对应当时的本机静态检查阶段，不代表后来的最终运行状态。 |

## 云服务器的真实仿真资料

| 文件 | 具体内容 |
| --- | --- |
| [`real_simulation/stack_bowls_real_run_01.log`](real_simulation/stack_bowls_real_run_01.log) | 第 1 次运行，Shell 脚本换行符 CRLF 引起报错，启动失败。 |
| [`real_simulation/stack_bowls_real_run_02.log`](real_simulation/stack_bowls_real_run_02.log) | 第 2 次运行，`msgpack_numpy` 模块缺失，策略服务未能正常启动。 |
| [`real_simulation/stack_bowls_real_run_03.log`](real_simulation/stack_bowls_real_run_03.log) | 第 3 次运行，缺少 `websockets.asyncio`，属于 WebSocket 依赖兼容问题。 |
| [`real_simulation/stack_bowls_real_run_04.log`](real_simulation/stack_bowls_real_run_04.log) | 第 4 次运行，策略连接成功，仿真启动后报 `transforms3d` 模块缺失。 |
| [`real_simulation/stack_bowls_real_run_05.log`](real_simulation/stack_bowls_real_run_05.log) | 第 5 次运行，CuRobo 规划器找不到 X5 的 `curobo.yml` 配置。 |
| [`real_simulation/stack_bowls_real_run_06.log`](real_simulation/stack_bowls_real_run_06.log) | 第 6 次运行，CuRobo CUDA 后端缺少 `cuda.bindings.cynvvm`。 |
| [`real_simulation/stack_bowls_real_run_07.log`](real_simulation/stack_bowls_real_run_07.log) | 第 7 次运行，视频写入需要的 `ffmpeg` 不存在，异常后反复重试导致日志较长。 |
| [`real_simulation/stack_bowls_real_run_08.log`](real_simulation/stack_bowls_real_run_08.log) | 第 8 次最终完整运行日志：800 步执行结束，生成三路视频，成功 0 次、失败 1 次，耗时约 271 秒。 |
| [`real_simulation/_result.json`](real_simulation/_result.json) | 第 8 次正式评测统计：评测次数 1，成功率 0，得分 0，包含布局与单回合明细。 |
| [`real_simulation/episode_0000000_cam_head_fail.mp4`](real_simulation/episode_0000000_cam_head_fail.mp4) | 第 8 次运行的头部相机录像，共 801 帧，640×480、25 FPS。 |
| [`real_simulation/episode_0000000_cam_left_wrist_fail.mp4`](real_simulation/episode_0000000_cam_left_wrist_fail.mp4) | 第 8 次运行的左腕相机录像；`fail` 指该回合任务失败，不是视频损坏。 |
| [`real_simulation/episode_0000000_cam_right_wrist_fail.mp4`](real_simulation/episode_0000000_cam_right_wrist_fail.mp4) | 第 8 次运行的右腕相机录像，与头部和左腕视频来自同一回合。 |
| [`real_simulation/robodojo_failfast.patch`](real_simulation/robodojo_failfast.patch) | `main.py` 源码修改补丁，设置 `ROBODOJO_FAIL_FAST=1` 时出现异常直接退出，便于排查。 |

## 云服务器环境记录

| 文件 | 具体内容 |
| --- | --- |
| [`restore_manifest/assets_size.txt`](restore_manifest/assets_size.txt) | RoboDojo Assets 在服务器上的目录容量（约 548 MB），不是 Assets 文件本体。 |
| [`restore_manifest/isaaclab_conda.txt`](restore_manifest/isaaclab_conda.txt) | 仿真端 `isaaclab` 的 Conda 软件包完整版本表。 |
| [`restore_manifest/isaaclab_pip_freeze.txt`](restore_manifest/isaaclab_pip_freeze.txt) | 仿真端 `isaaclab` 的 pip 软件包版本表，包含 CUDA 绑定依赖。 |
| [`restore_manifest/xpolicy_demo_conda.txt`](restore_manifest/xpolicy_demo_conda.txt) | 演示策略服务器 `xpolicy_demo` 的 Conda 包清单。 |
| [`restore_manifest/xpolicy_demo_pip_freeze.txt`](restore_manifest/xpolicy_demo_pip_freeze.txt) | 演示策略服务器的 pip 包清单，包括 WebSocket、msgpack 等依赖。 |
| [`restore_manifest/source_versions.txt`](restore_manifest/source_versions.txt) | RoboDojo 主程序及第三方子模块记录的版本和初始化状态。 |
| [`restore_manifest/system_info.txt`](restore_manifest/system_info.txt) | Ubuntu、内核、显卡和驱动、FFmpeg 等云服务器环境信息。 |

## 这些记录的时间关系

早期 `static_audit`、`offline_test`、`websocket_e2e` 用来检查源码、动作接口或通信，本身不证明 Isaac Sim 已启动。随后第 1～7 次实际运行遇到了不同的环境问题，第 8 次才完成了整个仿真评测。保留所有日志是为了追溯实际操作，不代表每次运行都成功。

本次的 `demo_policy` 是示例策略，不会自主完成叠碗。因此正式结果是 **运行链路完成、叠碗任务没有成功**。本文件夹不是已训练策略的性能数据集。

三个大型资源压缩包此前另外保存在 Windows 本机，**不在 GitHub**。环境恢复相关内容见 [云服务器环境恢复说明](../../docs/云服务器环境恢复说明.md)。
