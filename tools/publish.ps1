# 提交并发布
$ErrorActionPreference = 'Continue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$status = git status --porcelain
if ($status) {
  git add -A
  $msg = '更新文章 ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')
  git -c user.name='zszq' -c user.email='3416844074@qq.com' commit -m $msg | Out-Null
  Write-Host '已提交本地改动' -ForegroundColor Green
} else {
  Write-Host '没有新的改动'
}

git pull --rebase --autostash | Out-Null
$push = git push 2>&1
if ($LASTEXITCODE -eq 0) {
  Write-Host ''
  Write-Host '已推送，等 1 分钟去看：' -ForegroundColor Green
  Write-Host 'https://ljyxyx.github.io/blog/'
} else {
  Write-Host ''
  Write-Host '推送失败，把下面的内容发给我：' -ForegroundColor Red
  $push
}
