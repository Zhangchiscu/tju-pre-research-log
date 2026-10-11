# 云服务器环境资料

这个文件夹只保留当时运行仿真相关的系统信息、源码版本和两套软件环境清单。

| 文件 | 主要内容 |
| --- | --- |
| [`system_info.txt`](system_info.txt) | Ubuntu 24.04.1、RTX 3090、显卡驱动及 FFmpeg 版本。 |
| [`source_versions.txt`](source_versions.txt) | RoboDojo 主仓库与 XPolicyLab、Isaac Lab、CuRobo 的源码版本和子模块状态。 |
| [`isaaclab_conda.txt`](isaaclab_conda.txt) | 用于仿真端的 `isaaclab` Conda 环境包清单。 |
| [`isaaclab_pip_freeze.txt`](isaaclab_pip_freeze.txt) | 仿真端 Python 包版本表，包括 CUDA 绑定相关版本。 |
| [`xpolicy_demo_conda.txt`](xpolicy_demo_conda.txt) | 用于示例策略服务器的 `xpolicy_demo` Conda 环境清单。 |
| [`xpolicy_demo_pip_freeze.txt`](xpolicy_demo_pip_freeze.txt) | 策略服务器 Python 依赖清单，包括 WebSocket 等相关依赖。 |

Conda 清单与 pip 清单都保留，是因为它们记录的信息并不完全一样。这里没有安装包或完整系统镜像。

当时的三个大型资源备份压缩包保存在 Windows 本地，没有上传 GitHub。关于备份和恢复路径，可查看 [云服务器环境恢复说明](../../../docs/云服务器环境恢复说明.md)。
