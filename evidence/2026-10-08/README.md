# 本次保留的实验资料

这里主要放三部分：**最终仿真结果、少量接口与任务检查记录、软件环境清单**。不再把每次环境报错和重复导出的检查结果都放在当前目录中。

## 1. 最终仿真结果

| 文件 | 内容 |
| --- | --- |
| [评测结果 JSON](real_simulation/_result.json) | 一次 `stack_bowls` 评测，成功率和得分均为 0。 |
| [头部相机视频](real_simulation/episode_0000000_cam_head_fail.mp4) | 头部相机视角，保留整个仿真过程的画面。 |
| [左腕相机视频](real_simulation/episode_0000000_cam_left_wrist_fail.mp4) | 左机械臂腕部相机视角。 |
| [右腕相机视频](real_simulation/episode_0000000_cam_right_wrist_fail.mp4) | 右机械臂腕部相机视角。 |
| [最终运行日志](real_simulation/stack_bowls_real_run_08.log) | 第 8 次运行完成 800 步并保存视频的原始终端输出。 |
| [运行异常处理补丁](real_simulation/robodojo_failfast.patch) | 原始程序的局部源码修改，用于异常时及时退出。 |

[查看仿真结果文件的详细说明](real_simulation/README.md)

## 2. 前期检查

| 文件 | 内容 |
| --- | --- |
| [任务静态核查摘要](stack_bowls_static_audit.md) | 根据任务源码检查任务配置、机械臂维度和评分规则；只是静态检查。 |
| [WebSocket 测试代码](test_websocket.py) | 检查策略服务连接、观测数据传递与动作回复。 |
| [WebSocket 测试日志](websocket_e2e.log) | 上述通信测试的实际输出。 |

## 3. 环境资料

| 文件 | 内容 |
| --- | --- |
| [服务器信息](restore_manifest/system_info.txt) | Ubuntu、RTX 3090、显卡驱动和 FFmpeg 的信息。 |
| [源码版本记录](restore_manifest/source_versions.txt) | RoboDojo 主仓库以及相关子模块的版本说明。 |
| [仿真环境 Conda 清单](restore_manifest/isaaclab_conda.txt) | `isaaclab` 环境的 Conda 软件包记录。 |
| [仿真环境 pip 清单](restore_manifest/isaaclab_pip_freeze.txt) | `isaaclab` 环境的 Python 包版本。 |
| [策略服务 Conda 清单](restore_manifest/xpolicy_demo_conda.txt) | `xpolicy_demo` 环境的 Conda 软件包记录。 |
| [策略服务 pip 清单](restore_manifest/xpolicy_demo_pip_freeze.txt) | `xpolicy_demo` 环境的 Python 包版本。 |

[查看环境文件的详细说明](restore_manifest/README.md)

## 关于早期报错

前几次运行分别碰到过 Linux 脚本换行符、WebSocket 依赖、Python 模块、X5 配置、CUDA 绑定及 FFmpeg 等问题。最终第 8 次运行已经完成评测，因此当前只保留这次完整运行的原始日志。

被精简的旧日志没有在当前目录显示，但可以从 Git 提交历史中恢复。原始三路视频、结果和最终日志未删减。
