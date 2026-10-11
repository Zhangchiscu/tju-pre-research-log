# 云服务器环境资料

保留当时运行 RoboDojo 示例仿真所需的主要版本信息。这里只是版本记录，不含完整 Isaac Sim 安装包或系统镜像。

| 文件 | 主要内容 |
| --- | --- |
| [`system_info.txt`](system_info.txt) | Ubuntu、RTX 3090、显卡驱动和 FFmpeg 版本。 |
| [`source_versions.txt`](source_versions.txt) | RoboDojo 主仓库及 XPolicyLab、Isaac Lab、CuRobo 的源码版本与子模块状态。 |
| [`isaaclab_conda.txt`](isaaclab_conda.txt) | 运行仿真客户端的 `isaaclab` 环境软件包列表。 |
| [`xpolicy_demo_pip_freeze.txt`](xpolicy_demo_pip_freeze.txt) | 运行示例策略服务的 `xpolicy_demo` 环境 Python 依赖及安装来源。 |

为了减少重复版本文件，当前只保留上述主要清单。需要精确比对原始完整依赖时，其他清单可通过 Git 历史找回。

三个大型资源备份压缩包不在 GitHub，相关名称和位置见 [云服务器环境恢复说明](../../../docs/云服务器环境恢复说明.md)。
