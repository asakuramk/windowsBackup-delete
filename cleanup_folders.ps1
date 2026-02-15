# フォルダの自動削除スクリプト
# 3つ以上のフォルダがある場合、最も古いものを削除します

$targetPath = "C:\jdl_backup\jdl_backup"

# ターゲットパスにアクセス可能か確認
if (-not (Test-Path $targetPath)) {
    Write-Host "エラー: パス $targetPath が見つかりません" | Tee-Object -FilePath "$targetPath\..\cleanup.log" -Append
    exit 1
}

# フォルダの一覧を取得（作成日時でソート）
$folders = Get-ChildItem -Path $targetPath -Directory | Sort-Object -Property CreationTime

# ログファイルのパス
$logFile = Join-Path (Split-Path $targetPath -Parent) "cleanup.log"

# フォルダ数をチェック
if ($folders.Count -ge 3) {
    # 最も古いフォルダを取得
    $oldestFolder = $folders[0]
    
    try {
        # フォルダをゴミ箱に移動（完全削除ではなく）
        Remove-Item -Path $oldestFolder.FullName -Recurse -Force
        $logMessage = "2026-02-15 13:19:11 - 削除: $($oldestFolder.Name) (作成日: $($oldestFolder.CreationTime))"
        Add-Content -Path $logFile -Value $logMessage
        Write-Host $logMessage
    } catch {
        $errorMsg = "2026-02-15 13:19:11 - エラー: $($oldestFolder.Name) を削除できません: $_"
        Add-Content -Path $logFile -Value $errorMsg
        Write-Host $errorMsg
    }
} else {
    $logMessage = "2026-02-15 13:19:11 - フォルダ数: $($folders.Count) (削除不要)"
    Add-Content -Path $logFile -Value $logMessage
}
