# `stack_bowls` 最小实验实施方案（工程闭环 → 研究闭环）

> 截至 2026-10-08，**物理仿真尚未运行**，以下内容为待执行方案，不能作为已经完成的实验结果。

## 1. 首先回答什么问题？

**研究问题 RQ-01（待基线运行后验证）：** 在 `stack_bowls` 标准任务、同一机器人配置与同一策略权重下，三个碗的初始空间布局分散程度是否与成功率/阶段评分有关？

- 自变量候选：三碗初始 XY 坐标的两两欧氏距离均值或最大值、布局中心与机器人工作空间中心的偏移。正式选择前先确认能可靠取得每个 `layout_id` 的初始 XYZ 位姿。
- 因变量：每回合 `success`、`score`、整体 `success_rate`；必要时补充执行步数，但该字段不是官方 `_result.json` 默认自带，需额外采集。
- 控制变量：任务类型、碗模型 ID 组合、机器人配置、策略权重、相机配置和评测软件版本。
- 样本：先跑 1 个布局验证链路；正常后运行官方 25 个布局。25 次可用于初步观察，但不足以轻率宣称显著规律；需要根据结果考虑更多种子/重复试验。
- 风险：若预存布局同时改变碗模型种类，空间分散度可能与物体形态混杂，需在分析时记录并控制，必要时采用专门生成的单变量布局。

## 2. 阶段 A：本机静态工程交付（现在可做）

**输入**：当前本机 RoboDojo 源码及已记录的 Git SHA。  
**动作**：运行附带的 `scripts/audit_stack_bowls.py`，不导入 Isaac Sim。  
**输出**：`stack_bowls_static_audit.json`、`stack_bowls_static_audit.md`、命令输出日志。  
**验收**：源代码结构、任务配置、评分阶段和机器人维度一致；脚本输出 `PASS: stack_bowls static audit; simulator NOT executed`。

把这些文件保存到每天统一目录 `D:\RoboDojo_Workspace\research_logs\YYYY-MM-DD\`，后续由现有的 `sync_daily.ps1` 归档到 GitHub。

## 3. 阶段 B：获取远程真实仿真环境（阻塞中）

资源申请至少要确认：

- Linux 系统与访问方式：能从校外 SSH 登录，必要时先连接校园 VPN；账号由老师/管理员授权。
- GPU：有可用于 Isaac Sim RTX 渲染的 NVIDIA GPU，最好至少 24 GB VRAM，系统 RAM、驱动、CPU 与存储配额同时满足安装要求；使用前运行官方兼容性检查。
- Docker 或 Conda/Isaac Sim 的安装权限；仓库和 Assets 的下载方式及磁盘剩余空间；端口与网络策略。
- 是否允许在服务器使用 RoboDojo 的示例策略和公开 Assets；是否有可用的真正叠碗基线模型及权重。

**不应在当前 8GB Windows 笔记本上再进行多百 GB Isaac Sim 下载。**

## 4. 阶段 C：首次真实仿真冒烟实验

完成服务器部署后，在 Linux RoboDojo 根目录执行前置检查（以实际安装环境名替换 `<SIM_ENV>`、`<POLICY_ENV>`）：

```bash
# 只检查静态任务、Assets 与 Isaac 安装是否完备；不启动评测
bash scripts/robodojo.sh doctor \
  --policy-dir XPolicyLab/policy/demo_policy \
  --task stack_bowls \
  --sim-env <SIM_ENV> \
  --policy-env <POLICY_ENV>

# 一次真实仿真：仅当 doctor 通过、Assets 齐备时执行
bash scripts/robodojo.sh eval \
  --policy-dir XPolicyLab/policy/demo_policy \
  --task stack_bowls \
  --ckpt demo \
  --env-cfg arx_x5 \
  --action-type joint \
  --seed 0 \
  --policy-env <POLICY_ENV> \
  --eval-env <SIM_ENV> \
  --eval-num 1
```

**注意**：`demo_policy` 依据官方 README 生成零动作，不加载真实模型权重。该实验的成功标准不是叠碗成功，而是从 Isaac 场景启动到评测文件落盘的运行链路能够完整完成。`--ckpt demo` 在此仅用于流程命名；真实策略另需权重。

**必须保存**：

1. 实际的原始启动命令、Git 主仓库及子模块 SHA、Python/Isaac/驱动版本。
2. 完整标准输出及标准错误日志；尤其是场景启动、机器人控制、模型调用及异常信息。
3. 至少一个真实仿真场景截图/视频，和 `eval_result/.../_result.json`（不要用本机 WebSocket 假观测结果冒充）。
4. `_result.json` 中的 `eval_time`、`success_rate`、`score` 以及 `details`，检查回合数是否等于 1；若实验异常退出，则如实报告失败状态。
5. 结果复现条件：随机种子、场景布局 ID、运行目录与必要的 Assets 版本信息。

**条件**：如果 `doctor` 未通过，不应立即安装/运行大量额外依赖；先定位明确缺失项。

## 5. 阶段 D：研究基线与布局分析（不能以 demo_policy 替代）

1. 确认具备叠碗操作能力的真实基线策略，记录架构、权重来源及对应动作接口。
2. 在固定模型权重及任务配置的情况下执行官方标准 25 布局评测（第一轮）。
3. 通过场景布局文件或者仿真初始化时的只读位姿采集，获得 `layout_id -> bowl0/bowl1/bowl2` 初始坐标映射。**这个能力目前尚未验证，也尚未写入评测程序。**
4. 关联布局特征与逐回合 `success`、`score`，绘制基础散点图与分层统计；按相同物体组合、可达性等控制潜在混杂因素。
5. 如需证明位置扰动的因果作用，应构建单变量控制实验，不应直接对比 `stack_bowls` 和 `_random` 的总体成功率。

## 6. 提交给齐老师的交付标准

| 交付对象 | 目前状态 | 完成条件 |
| --- | --- | --- |
| 固定源码版本/环境清单 | 已有本机记录 | 主仓库 SHA、子模块 SHA、依赖、运行平台一致 |
| 任务配置与评分方式 | 本次文档完成 | 可追溯到任务源码与 YAML |
| 一句可验证研究问题 | 本次方案完成（待实测） | 输入、输出、控制变量、基线、指标定义明确 |
| `stack_bowls` 真正跑起来 | PENDING | Isaac Sim 真实仿真日志、视频、`_result.json` |
| 基线实验数据 | BLOCKED | 有效策略可运行、布局与结果数据可对应 |

> 原则：工程冒烟测试、实际仿真成功、算法研究结果分开报告，避免用接口 PASS 替代任务完成度。
