# 云服务器环境清单说明

这个文件夹主要保存当时运行 RoboDojo 时的软件版本和源码版本，属于环境核对材料。这里没有完整的操作系统镜像，也没有把 Isaac Sim 安装程序或机器人 Assets 放进 GitHub。

同一套仿真分别用到了 `isaaclab` 和 `xpolicy_demo` 两个 Conda 环境：前者主要运行仿真客户端，后者主要运行演示策略服务器。

## 文件逐项说明

| 文件 | 内容和用途 |
| --- | --- |
| [`assets_size.txt`](assets_size.txt) | 当时 `RoboDojo/Assets` 的目录大小，记录约 548 MB。它只记录容量，不包含实际的机器人模型、场景资源。Assets 压缩包此前单独保存到 Windows。 |
| [`isaaclab_conda.txt`](isaaclab_conda.txt) | 仿真端 `isaaclab` Conda 环境的完整包清单，包含 Linux 平台包、包版本及部分构建信息，适合检查当时有哪些依赖。 |
| [`isaaclab_pip_freeze.txt`](isaaclab_pip_freeze.txt) | 同一仿真环境中 Python 包的版本列表。能查到 `cuda-bindings==12.9.4` 等当时用到的依赖，用于补充核对 Python 包版本。 |
| [`xpolicy_demo_conda.txt`](xpolicy_demo_conda.txt) | 策略服务器 `xpolicy_demo` Conda 环境的包列表。包含 `msgpack-numpy`、`websockets`、`xpolicylab` 等通信和策略接口相关依赖。 |
| [`xpolicy_demo_pip_freeze.txt`](xpolicy_demo_pip_freeze.txt) | 策略服务器 Python 包清单，保留了 `websockets==14.2`、`msgpack-numpy==0.4.8`，以及 XPolicyLab 当时的 editable 安装来源条目。 |
| [`source_versions.txt`](source_versions.txt) | RoboDojo 主仓库提交编号和 XPolicyLab、Isaac Lab、CuRobo 在主仓库记录的子模块提交编号。文件还注明了子模块当时未初始化的情况，不能把记录的子模块编号直接当成实际第三方工作目录的校验结论。 |
| [`system_info.txt`](system_info.txt) | 云服务器基础信息，包括 Ubuntu 24.04.1、Linux 内核、RTX 3090、驱动 `580.119.02` 和 FFmpeg 版本等。 |

## 文件名里常见的词

- `conda`：Conda 管理的软件环境及包列表。
- `pip_freeze`：从 Python 安装环境导出的软件包版本列表。
- `restore_manifest`：供恢复环境时核对的清单，不是恢复程序。
- `assets`：机器人、场景等仿真资源；`source_versions`：源码版本记录。

## 使用时需要注意

这些信息主要用于对照当时的运行条件。不能直接认为复制包列表就能重新获得一个可运行的 Isaac Sim 环境，因为显卡驱动、Isaac Sim 安装方式、编辑安装的源码目录和本地资源也会影响运行。

完整的备份位置和恢复过程见 [云服务器环境恢复说明](../../../docs/云服务器环境恢复说明.md)。

三个大型压缩包并不在 GitHub 中：RoboDojo Assets、XPolicyLab + CuRobo 源码、Isaac Lab 源码分别保存于此前的 Windows 本地备份。
