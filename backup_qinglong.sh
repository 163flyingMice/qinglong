#!/bin/sh
QL_DATA=/ql/data
QL_BACKUP=${QL_BACKUP_DIR:-/ql/backup}
KEEP=${QL_BACKUP_KEEP:-10}

mkdir -p "$QL_BACKUP"
STAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE="$QL_BACKUP/ql_data_$STAMP.tar.gz"

echo "[backup] $(date) 打包 $QL_DATA -> $ARCHIVE"
tar -czf "$ARCHIVE" -C "$QL_DATA" .

# 仅保留最近 KEEP 份，避免备份目录无限膨胀
ls -t "$QL_BACKUP"/ql_data_*.tar.gz 2>/dev/null | tail -n +"$((KEEP+1))" | xargs -r rm -f
echo "[backup] 完成，保留最近 $KEEP 份"
