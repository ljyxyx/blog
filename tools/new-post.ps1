# 新建一篇文章
param([string]$Title, [string]$Slug, [switch]$NoOpen)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$root = Split-Path -Parent $PSScriptRoot
$postsDir = Join-Path $root 'src\content\posts'

if (-not $Title) { $Title = Read-Host '标题（中文可以）' }
$title = $Title
if ([string]::IsNullOrWhiteSpace($title)) { $title = '未命名' }

if (-not $Slug) { $Slug = Read-Host '英文短名（直接回车就用 note）' }
$slug = $Slug
if ([string]::IsNullOrWhiteSpace($slug)) { $slug = 'note' }
$slug = ($slug -replace '[^a-zA-Z0-9\-]', '-').Trim('-').ToLower()
if ([string]::IsNullOrWhiteSpace($slug)) { $slug = 'note' }

$date = Get-Date -Format 'yyyy-MM-dd'
$file = Join-Path $postsDir ("{0}-{1}.md" -f $date, $slug)
if (Test-Path $file) {
  $file = Join-Path $postsDir ("{0}-{1}-{2}.md" -f $date, $slug, (Get-Date -Format 'HHmmss'))
}

$content = @"
---
title: $title
date: $date
---

在这里写正文。
"@
[System.IO.File]::WriteAllText($file, $content, (New-Object System.Text.UTF8Encoding($false)))

Write-Host ''
Write-Host ('已创建：' + $file) -ForegroundColor Green
Write-Host '写完保存，然后双击桌面上的「发布博客」。'
Write-Host ''

if (-not $NoOpen) {
  $code = Get-Command code -ErrorAction SilentlyContinue
  if ($code) { & $code.Source $file } else { Start-Process notepad.exe $file }
}
