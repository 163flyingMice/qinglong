#!/bin/sh
set -e

QL_DATA=/ql/data
QL_BACKUP=${QL_BACKUP_DIR:-/ql/backup}
RESTORE_ON_BOOT=${QL_RESTORE_ON_BOOT:-false}

# 确保数据目录与备份目录存在
mkdir -p "$QL_DATA"/config "$QL_DATA"/db "$QL_DATA"/scripts "$QL_DATA"/log \
         "$QL_DATA"/raw "$QL_DATA"/repo "$QL_DATA"/deps "$QL_BACKUP"

# 首次启动且开启恢复：从备份还原到 /ql/data
if [ "$RESTORE_ON_BOOT" = "true" ] && [ -z "$(ls -A "$QL_DATA"/config 2>/dev/null)" ]; then
  LATEST=$(ls -t "$QL_BACKUP"/ql_data_*.tar.gz 2>/dev/null | head -n1)
  if [ -n "$LATEST" ]; then
    echo "[entrypoint] 发现备份，正在恢复: $LATEST"
    tar -xzf "$LATEST" -C "$QL_DATA"
  else
    echo "[entrypoint] 未找到备份，使用空数据目录首次启动"
  fi
fi

# 后台每小时备份一次（不依赖 cron 守护进程）
(
  while true; do
    sleep 3600
    /usr/bin/backup_qinglong.sh >> "$QL_DATA"/log/backup.log 2>&1
  done
) &

echo "[entrypoint] 启动青龙主进程..."
exec /usr/bin/qinglong
