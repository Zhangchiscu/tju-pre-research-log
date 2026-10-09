# RoboDojo 换机恢复指南

最后更新：2026-10-08

## 一、项目目前进展

2026年10月8日，已在智川云 RTX 3090 服务器上完成 RoboDojo stack_bowls 的首次真实物理仿真评测。

本次评测完成800个仿真步骤，生成三路相机视频和正式评测结果。

评测程序正常结束，但任务成功率为0%。

原因是当前使用的 demo_policy 仅用于验证程序通信，并不具备自主抓取和叠放碗的能力。

## 二、必须保存的资料

### 1. GitHub科研仓库

https://github.com/Zhangchiscu/tju-pre-research-log

包含：

- 每日科研记录
- stack_bowls 任务分析
- 早期离线测试结果
- 真实仿真日志与三路视频
- 正式评测JSON
- Fail-Fast源码补丁
- 环境依赖及版本清单

2026年10月8日实验归档提交：

260967d

### 2. Windows本地资源备份

以下三份压缩包已于2026年10月8日完成SHA-256校验：

1. robodojo_assets_20261008.tar.gz
   RoboDojo机器人和场景资源。

2. robodojo_third_party_20261008.tar.gz
   当前使用的XPolicyLab和CuRobo源码。

3. isaaclab_v2.3.2_source_20261008.tar.gz
   当前使用的Isaac Lab源码。

每份压缩包都有同名的 .sha256 校验文件。

重要：上述三份大型资源不在GitHub科研仓库中。
更换云服务器时，必须从Windows本地备份上传。

## 三、原服务器环境

系统：Ubuntu 24.04

GPU：NVIDIA RTX 3090，24 GB显存

Python：3.11

Isaac Sim：5.1.0

Isaac Lab：2.3.2

Isaac Lab Python包版本：0.54.2

Isaac Lab RL Python包版本：0.4.7

PyTorch：2.7.0，CUDA 12.8构建

CuRobo：当前源码采用editable方式安装

关键兼容性修复：cuda-bindings 12.9.4

视频录制：需要系统FFmpeg及libx264编码器

Conda环境：

- isaaclab：仿真执行
- xpolicy_demo：演示策略服务器

原服务器源码位置：

/root/rivermind-data/RoboDojo

原服务器Isaac Lab源码位置：

/root/IsaacLab-v2.3.2

详细软件包版本参考：

evidence/2026-10-08/restore_manifest/

注意：Conda和pip清单只是版本参考，不是完整系统镜像。

## 四、新云服务器恢复顺序

建议选择Ubuntu 24.04、兼容的NVIDIA驱动及至少24 GB显存的GPU环境。

第一步：安装并检查NVIDIA驱动、Conda及基础软件。

第二步：按照官方兼容要求配置Python 3.11、Isaac Sim 5.1.0和Isaac Lab运行环境。

第三步：克隆科研记录仓库：

git clone https://github.com/Zhangchiscu/tju-pre-research-log.git

第四步：获取RoboDojo源码，固定到本次实验版本：

git clone https://github.com/RoboDojo-Benchmark/RoboDojo.git

cd RoboDojo

git checkout 726e9aabfaa642203722eb126f5eaf0f37f3e1ad

第五步：从Windows上传三份tar.gz资源及SHA-256文件。

注意：上传位置可以自行选择，但下述解压命令必须与实际路径对应。

第六步：检查SHA-256，确认文件完好后恢复目录：

tar -xzf robodojo_assets_20261008.tar.gz -C /root/rivermind-data/RoboDojo

tar -xzf robodojo_third_party_20261008.tar.gz -C /root/rivermind-data/RoboDojo

tar -xzf isaaclab_v2.3.2_source_20261008.tar.gz -C /root

其中：

- Assets恢复到RoboDojo/Assets
- XPolicyLab恢复到RoboDojo/XPolicyLab
- CuRobo恢复到RoboDojo/third_party/curobo
- Isaac Lab恢复到/root/IsaacLab-v2.3.2

第七步：根据环境清单恢复依赖，并核查editable安装路径。

不要直接把pip freeze无差别安装到一个全新的环境中。
应首先安装兼容的Isaac Sim、Isaac Lab和PyTorch，再处理剩余依赖。

第八步：在RoboDojo中恢复必要的本地修改。

原始补丁：

evidence/2026-10-08/real_simulation/robodojo_failfast.patch

在确认源码版本一致后，先运行git apply --check，再决定是否应用补丁。

第九步：验证X5的CuRobo配置、GPU正向运动学、FFmpeg、策略服务器和WebSocket通信。

第十步：通过一次最小仿真测试核对恢复后的环境是否正常。

## 五、2026年10月8日已解决的问题

1. CuRobo CUDA绑定兼容问题。
2. X5机器人运动学配置及GPU正向运动学验证。
3. WebSocket策略服务器通信。
4. FFmpeg缺失导致视频保存失败。
5. 异常后持续更换随机种子的重复评测问题。
6. stack_bowls完整真实评测流程验证。

详细日志请查阅：

evidence/2026-10-08/real_simulation/

其中run_07主要用于追溯FFmpeg故障；
run_08是最终完整执行的评测。

## 六、恢复时必须注意

1. 本仓库并不包含完整的Conda二进制环境。
2. 本仓库不包含Isaac Sim安装包。
3. 三份大型压缩包需要独立保存和上传。
4. 不能认为更换GPU、驱动或CUDA版本后仍会直接兼容。
5. 不能将demo_policy的运行视为叠碗算法成功。
6. 尚未在第二台服务器上验证完整恢复流程。
