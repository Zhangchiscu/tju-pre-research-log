param(
    [string]$Day = (Get-Date -Format "yyyy-MM-dd")
)

$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
$source = Join-Path "D:\RoboDojo_Workspace\research_logs" $Day
$evidence = Join-Path $repo "evidence\$Day"
$daily = Join-Path $repo "daily\$Day.auto.md"
$notes = Join-Path $source "notes.md"

if (!(Test-Path $source)) {
    Write-Host "[SKIP] No research logs for $Day"
    exit 0
}

$allowed = @(".log", ".txt", ".json", ".md", ".py", ".csv")

$files = @(
    Get-ChildItem -LiteralPath $source -File -Recurse |
    Where-Object {
        $allowed -contains $_.Extension.ToLowerInvariant() -and
        $_.FullName -ne $notes -and
        $_.Length -le 5MB -and
        $_.Name -notmatch '(?i)(token|secret|password|credential|id_rsa)'
    } |
    Sort-Object FullName
)

$noteText = ""
if (Test-Path $notes) {
    $noteText = (Get-Content $notes -Raw).Trim()
}

if ($files.Count -eq 0 -and !$noteText) {
    Write-Host "[INFO] No new logs; retrying pending GitHub uploads."
    & git -C $repo push origin main
    if ($LASTEXITCODE -ne 0) {
        throw "GitHub upload failed; local commits remain saved."
    }
    exit 0
}

New-Item -ItemType Directory -Force $evidence | Out-Null
New-Item -ItemType Directory -Force (Split-Path $daily) | Out-Null

$rows = @()
$successCount = 0
$errorCount = 0

foreach ($file in $files) {
    $relative = $file.FullName.Substring($source.Length).TrimStart([char]92)
    $target = Join-Path $evidence $relative

    New-Item -ItemType Directory -Force (Split-Path $target) | Out-Null
    Copy-Item -LiteralPath $file.FullName -Destination $target -Force

    $status = "已归档，未判定"
    $passCount = 0

    if ($file.Extension -in @(".log", ".txt")) {
        $lines = @(Get-Content -LiteralPath $file.FullName)

        $passLines = @($lines | Where-Object {
            $_ -match '^\s*PASS\s*:'
        })

        $errorLines = @($lines | Where-Object {
            $_ -match '(?i)(^\s*FAIL\s*:|Traceback \(most recent call last\)|ModuleNotFoundError:|AssertionError:)'
        })

        $passCount = $passLines.Count

        if ($errorLines.Count -gt 0) {
            $status = "发现错误，需检查"
            $errorCount++
        }
        elseif ($passCount -gt 0) {
            $status = "存在 PASS 记录"
            $successCount++
        }
    }

    $relative = $relative.Replace('\', '/')
    $rows += "| $relative | $status | $passCount |"
}

$report = @(
    "# $Day 自动科研进度"
    ""
    "> 本报告由本机脚本根据实际文件生成，不代表 Isaac Sim 或科研实验已经成功。"
    ""
    "## 一、当日客观记录"
    ""
    "- 归档文件数：$($files.Count)"
    "- 包含 PASS 标记且未发现指定错误的日志数：$successCount"
    "- 检测到错误的日志数：$errorCount"
    ""
    "## 二、运行证据"
    ""
    "| 文件 | 自动识别状态 | PASS 标记数 |"
    "| --- | --- | ---: |"
)

$report += $rows

$report += @(
    ""
    "## 三、工作进展、阻塞和下一步"
    ""
)

if ($noteText) {
    $report += $noteText
}
else {
    $report += "未提供人工工作备注。仅凭测试日志不能确认科研任务整体进度。"
}

$report += @(
    ""
    "## 四、记录说明"
    ""
    "- 原始文件保存在 evidence/$Day/。"
    "- 状态来自日志文本匹配，不能代替完整测试结论。"
    "- 此文件为自动生成报告，人工日报独立保存。"
)

$report | Set-Content -LiteralPath $daily -Encoding UTF8

$addPaths = @("daily/$Day.auto.md")
if ($files.Count -gt 0) {
    $addPaths += "evidence/$Day"
}

& git -C $repo add -- @addPaths
if ($LASTEXITCODE -ne 0) {
    throw "Git add failed."
}

$changes = @(& git -C $repo diff --cached --name-only -- @addPaths)
if ($LASTEXITCODE -ne 0) {
    throw "Git diff failed."
}

if ($changes.Count -gt 0) {
    & git -C $repo commit --only -m "logs: archive research progress $Day" -- @addPaths
    if ($LASTEXITCODE -ne 0) {
        throw "Git commit failed."
    }
}

& git -C $repo push origin main
if ($LASTEXITCODE -ne 0) {
    throw "GitHub upload failed; local commits remain saved. Retry later."
}

Write-Host "[SUCCESS] Research logs synchronized: $Day"
