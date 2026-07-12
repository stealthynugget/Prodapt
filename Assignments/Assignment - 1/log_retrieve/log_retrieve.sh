LOG_FILE="server.log"
PROCESSED_DIR="processed_logs"
ARCHIVE_DIR="archive"
DATE=$(date +"%Y%m%d_%H%M%S")
mkdir -p "$PROCESSED_DIR" "$ARCHIVE_DIR"
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found."
    exit 1
fi
echo "========== Linux Log Analysis =========="
echo
echo "Log File"
ls -lh "$LOG_FILE"
echo
echo "First 5 Log Entries"
head -5 "$LOG_FILE"
echo
echo "Last 5 Log Entries"
tail -5 "$LOG_FILE"
echo
echo "Total Log Entries"
wc -l "$LOG_FILE"
echo
echo "Error Logs"
grep "ERROR" "$LOG_FILE"
echo
echo "Warning Logs"
grep "WARNING" "$LOG_FILE"
echo
echo "Extracting Important Logs..."
grep -E "ERROR|WARNING" "$LOG_FILE" > "$PROCESSED_DIR/important_logs.txt"
echo
echo "Important Logs"
cat "$PROCESSED_DIR/important_logs.txt"
echo
echo "Summary"
ERRORS=$(grep -c "ERROR" "$LOG_FILE")
WARNINGS=$(grep -c "WARNING" "$LOG_FILE")
INFO=$(grep -c "INFO" "$LOG_FILE")
echo "Errors   : $ERRORS"
echo "Warnings : $WARNINGS"
echo "Info     : $INFO"
echo
echo "Saving Summary"
cat > "$PROCESSED_DIR/summary.txt" << EOF
Errors    : $ERRORS
Warnings  : $WARNINGS
Info      : $INFO
EOF
echo
echo "AWK Output"
awk '{print NR, $1, $2}' "$LOG_FILE"
echo
echo "Replacing ERROR with CRITICAL"
sed 's/ERROR/CRITICAL/g' "$PROCESSED_DIR/important_logs.txt" > "$PROCESSED_DIR/final_logs.txt"
echo
echo "Final Log"
cat "$PROCESSED_DIR/final_logs.txt"
echo
echo "Running Processes"
ps -ef | head
echo
echo "Logged-in Users"
who
echo
echo "Disk Usage"
df -h
echo
echo
echo "Compressing Files"
gzip -f "$PROCESSED_DIR/final_logs.txt"
gzip -f "$PROCESSED_DIR/summary.txt"
echo
echo "Creating Archive"
tar -czf "$ARCHIVE_DIR/log_backup_$DATE.tar.gz" "$PROCESSED_DIR"
echo
echo "Archive"
ls -lh "$ARCHIVE_DIR"
CRON_JOB="0 2 * * * $(realpath "$0")"
if ! crontab -l 2>/dev/null | grep -qF "$CRON_JOB"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo
    echo "Daily cron job scheduled at 2:00 AM."
else
    echo
    echo "Cron job already exists."
fi
echo
echo "Log analysis, backup, compression, archiving and scheduling completed successfully."
