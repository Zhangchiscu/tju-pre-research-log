# 真实仿真运行文件说明

这里保存的是 RoboDojo `stack_bowls` 任务在云服务器上的实际运行记录。文件名沿用当时程序生成的名称，方便和原始日志、视频以及程序输出互相对应。

本次使用 `arx_x5` 机器人配置和 `demo_policy` 示例策略。第 8 次运行完成一个 800 步回合，程序正常结束，但没有完成叠碗任务，成功率为 0%。这是运行链路测试结果，不是训练后策略的实验结果。

## 运行日志：第 1～8 次分别记录了什么

| 文件 | 主要内容 |
| --- | --- |
| [第 1 次：`stack_bowls_real_run_01.log`](stack_bowls_real_run_01.log) | 策略服务器还没有正常启动。日志出现 `set: -\r: invalid option`、`pipefail\r` 等错误，原因是部分 Linux Shell 脚本含有 Windows 风格的 CRLF 换行符。 |
| [第 2 次：`stack_bowls_real_run_02.log`](stack_bowls_real_run_02.log) | 运行到策略服务依赖加载，报 `ModuleNotFoundError: No module named 'msgpack_numpy'`。属于 Python 依赖缺失，策略服务器未能正常开放端口。 |
| [第 3 次：`stack_bowls_real_run_03.log`](stack_bowls_real_run_03.log) | 缺失 `websockets.asyncio` 模块。说明策略服务器使用的 WebSocket API 与当时安装的依赖版本不匹配，尚未进入仿真运行。 |
| [第 4 次：`stack_bowls_real_run_04.log`](stack_bowls_real_run_04.log) | WebSocket 策略服务器已连接，Isaac Sim 启动，随后在加载仿真客户端代码时出现 `No module named 'transforms3d'`。 |
| [第 5 次：`stack_bowls_real_run_05.log`](stack_bowls_real_run_05.log) | 策略连接和仿真启动进一步推进，但初始化 CuRobo 规划器时找不到 `Assets/Robots/x5/curobo.yml` 机器人配置文件。 |
| [第 6 次：`stack_bowls_real_run_06.log`](stack_bowls_real_run_06.log) | 机器人相关资源加载后，CuRobo 在 CUDA 后端初始化时报 `No module named 'cuda.bindings.cynvvm'`，属于 CUDA Python 绑定兼容问题。 |
| [第 7 次：`stack_bowls_real_run_07.log`](stack_bowls_real_run_07.log) | 已推进到相机图像流与视频写入过程，但多次出现 `FileNotFoundError: 'ffmpeg'`。由于程序异常后继续重试，日志较长。这次并未得到完整有效的评测结果。 |
| [第 8 次：`stack_bowls_real_run_08.log`](stack_bowls_real_run_08.log) | 最终一次完整运行：策略服务器连接、场景加载、800 步执行及三路视频写入均已完成，日志末尾显示 `Success nums: 0, Fail nums: 1`，运行约 271 秒。**查看最终运行过程优先打开这个文件。** |

上面是根据各次日志实际出现的报错和结果整理的概要，并不是把每份日志中的警告都视为独立问题。日志中的彩色终端控制字符也属于原始记录的一部分。

## 三个相机视频

| 文件 | 内容 |
| --- | --- |
| [`episode_0000000_cam_head_fail.mp4`](episode_0000000_cam_head_fail.mp4) | 头部相机视角。观察整个场景与机器人双臂的位置关系。 |
| [`episode_0000000_cam_left_wrist_fail.mp4`](episode_0000000_cam_left_wrist_fail.mp4) | 左机械臂腕部相机视角，记录左腕相机所看到的画面。 |
| [`episode_0000000_cam_right_wrist_fail.mp4`](episode_0000000_cam_right_wrist_fail.mp4) | 右机械臂腕部相机视角，记录右腕相机所看到的画面。 |

每个视频为 801 帧，分辨率 640×480、帧率 25 FPS。`fail` 是程序根据本回合任务未完成自动添加的文件名后缀，并不表示视频本身损坏。

## 结果文件和代码补丁

| 文件 | 内容 |
| --- | --- |
| [`_result.json`](_result.json) | 正式评测结果。包含 `success_rate=0.0`（成功率 0%）、`eval_time=1`（评测 1 次）、`score=0.0`，以及布局编号、是否成功和单回合得分。 |
| [`robodojo_failfast.patch`](robodojo_failfast.patch) | RoboDojo `src/eval_client/main.py` 的局部修改差异：当环境变量 `ROBODOJO_FAIL_FAST=1` 时，评测发生异常会直接抛出错误，避免在排障时持续自动重试。它不是独立程序；应用时必须核对原始源码版本。 |

## 这份目录与其他文件的关系

- [仿真运行记录](../../../docs/仿真运行记录.md)：用中文描述整次实验的运行环境、过程和结果。
- [科研工作记录](../../../daily/2026-10-08_科研工作记录.md)：较简短的工作过程记录。
- [环境恢复说明](../../../docs/云服务器环境恢复说明.md)：保存软件环境、源码版本及资源恢复方法。

这些文件保留当时的实际输出，不会为了让结果更好看而删掉失败记录。
