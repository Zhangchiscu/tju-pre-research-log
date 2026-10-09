# RoboDojo stack_bowls 仿真运行记录（2026.10.08—10.11）

## 1. 本次工作

这段时间主要在智川云服务器上配置 RoboDojo 的运行环境，并尝试运行了 `stack_bowls` 任务。

之前已经在本地看过任务配置和动作接口，也做过一些简单的通信测试。这次主要是想实际跑一遍仿真，看看从场景加载到策略执行、结果保存能不能正常完成。

最后使用 `demo_policy` 跑完了一个回合，生成了三路相机视频和评测结果。

## 2. 运行环境

这次使用的是智川云的 RTX 3090 服务器，系统为 Ubuntu 24.04。

主要软件环境如下：

- Python 3.11
- Isaac Sim 5.1.0
- Isaac Lab 2.3.2
- PyTorch 2.7.0
- CuRobo
- FFmpeg

运行过程中遇到过一些依赖兼容问题，主要涉及 CuRobo 的 CUDA 绑定，以及视频保存需要的 FFmpeg。处理完成后，仿真可以正常运行。

具体软件版本和依赖记录保存在 `evidence/2026-10-08/restore_manifest/`。

## 3. 操作过程

首先在云服务器上准备了 RoboDojo、XPolicyLab、Isaac Lab 和相关资源文件，并检查机器人配置和 Python 依赖。

随后测试了策略服务器与仿真客户端之间的 WebSocket 连接。确认能够正常通信后，开始运行 `stack_bowls`。

本次使用的主要参数：

| 参数 | 设置 |
| --- | --- |
| 任务 | `stack_bowls` |
| 机器人配置 | `arx_x5` |
| 策略 | `demo_policy` |
| 动作类型 | `ee` |
| 评测次数 | 1 |
| 仿真步数 | 800 |

运行时先启动策略服务器，再由仿真客户端加载场景和机器人。程序运行期间会持续接收观测、生成动作，并更新仿真状态。

本次没有单独保存完整的终端启动命令，实际运行参数可以在第 8 次运行日志中查看：

[stack_bowls_real_run_08.log](../evidence/2026-10-08/real_simulation/stack_bowls_real_run_08.log)

## 4. 运行结果

这次完整运行了 800 步，耗时约 271 秒，程序正常结束。

评测结果如下：

- 评测次数：1
- 成功次数：0
- 失败次数：1
- 成功率：0%
- 得分：0

使用的 `demo_policy` 只是一个简单的示例策略，主要用于测试动作接口和通信过程，没有真正执行抓取和叠碗操作。因此，这次只是完成了仿真运行测试，并没有完成叠碗任务。

评测结果文件：

[_result.json](../evidence/2026-10-08/real_simulation/_result.json)

## 5. 仿真视频

运行结束后保存了三个相机视角的视频，分别是机器人头部、左腕和右腕相机。

视频分辨率为 640×480，帧率为 25 FPS，每段共 801 帧。

- [头部相机视频](../evidence/2026-10-08/real_simulation/episode_0000000_cam_head_fail.mp4)
- [左腕相机视频](../evidence/2026-10-08/real_simulation/episode_0000000_cam_left_wrist_fail.mp4)
- [右腕相机视频](../evidence/2026-10-08/real_simulation/episode_0000000_cam_right_wrist_fail.mp4)

视频名称中的 `fail` 是程序根据任务结果自动添加的，表示本回合没有完成叠碗。

## 6. 相关代码和文件

这次使用及整理的部分测试代码已经保存在仓库中：

- [任务配置检查脚本](../scripts/audit_stack_bowls.py)
- [WebSocket 通信测试代码](../evidence/2026-10-08/test_websocket.py)
- [main.py 修改补丁](../evidence/2026-10-08/real_simulation/robodojo_failfast.patch)

其中 `main.py` 的修改主要是在出现异常时允许程序直接退出，避免反复重试。原始 RoboDojo 源码没有直接放进这个科研记录仓库，而是保留了原始 Git 版本号和修改补丁。

原始项目地址：

https://github.com/RoboDojo-Benchmark/RoboDojo

本次使用的主仓库 Commit：

`726e9aabfaa642203722eb126f5eaf0f37f3e1ad`

另外，之前几次运行过程中出现的问题和终端输出，也分别保存在 `real_simulation` 目录下的运行日志中。

## 7. 本次记录说明

这次主要完成了 RoboDojo 的环境配置、策略通信和一次完整的 `stack_bowls` 仿真运行。

目前只是使用示例策略进行了仿真测试，没有部署真实机械臂，也没有进行实际抓取控制或策略训练。

相关视频、日志、代码修改和环境信息都按照本次运行情况保存。
