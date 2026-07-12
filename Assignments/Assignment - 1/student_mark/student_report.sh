MARKS_FILE="student_marks.txt"
REPORT_DIR="reports"
ARCHIVE_DIR="archive"
DATE=$(date +"%Y%m%d_%H%M%S")
mkdir -p "$REPORT_DIR"
mkdir -p "$ARCHIVE_DIR"
if [ ! -f "$MARKS_FILE" ]; then
    echo "Student marks file not found."
    exit 1
fi
echo "======================================="
echo " Student Marks Processing"
echo "======================================="
echo
echo "File Details"
ls -lh "$MARKS_FILE"
echo
echo "Complete Student Marks"
cat "$MARKS_FILE"
echo
echo "First 5 Records"
head -5 "$MARKS_FILE"
echo
echo "Last 5 Records"
tail -5 "$MARKS_FILE"
echo
echo "Total Students"
wc -l "$MARKS_FILE"
echo
echo "Sorted Records"
sort "$MARKS_FILE"
echo
echo "Unique Records"
sort "$MARKS_FILE" | uniq
echo
echo "Search Student Rahul"
grep "Rahul" "$MARKS_FILE"
echo
echo "Students Having Marks Below 40"
awk '$3<40 || $4<40 || $5<40 || $6<40 || $7<40 {print}' "$MARKS_FILE" > "$REPORT_DIR/low_marks.txt"
cat "$REPORT_DIR/low_marks.txt"
echo
echo "Generating Student Report"
awk '
{
    total=$3+$4+$5+$6+$7;
    average=total/5;

    if(average>=90)
        grade="A";
    else if(average>=75)
        grade="B";
    else if(average>=60)
        grade="C";
    else if(average>=40)
        grade="D";
    else
        grade="F";

    printf "%-5s %-10s Total:%3d Average:%6.2f Grade:%s\n",$1,$2,total,average,grade;
}
' "$MARKS_FILE" > "$REPORT_DIR/student_report.txt"

cat "$REPORT_DIR/student_report.txt"

echo
echo "Replacing Grade F with FAIL"

sed 's/Grade:F/Grade:FAIL/g' "$REPORT_DIR/student_report.txt" > "$REPORT_DIR/final_report.txt"

cat "$REPORT_DIR/final_report.txt"

echo
echo "Summary Report"

TOTAL=$(wc -l < "$MARKS_FILE")

PASS=$(awk '
{
avg=($3+$4+$5+$6+$7)/5
if(avg>=40)
count++
}
END{
print count
}' "$MARKS_FILE")

FAIL=$(awk '
{
avg=($3+$4+$5+$6+$7)/5
if(avg<40)
count++
}
END{
print count
}' "$MARKS_FILE")

echo "Total Students : $TOTAL"
echo "Pass Students  : $PASS"
echo "Fail Students  : $FAIL"
cat > "$REPORT_DIR/summary.txt" << EOF
Student Report Summary
Date : $(date)
Total Students : $TOTAL
Pass Students  : $PASS
Fail Students  : $FAIL
EOF
echo
echo "Logged-in Users"
who
echo
echo "Running Processes"
ps -ef | head
echo
echo "Disk Usage"
df -h
echo
echo "Compressing Reports"
gzip -f "$REPORT_DIR/final_report.txt"
gzip -f "$REPORT_DIR/summary.txt"
gzip -f "$REPORT_DIR/low_marks.txt"
echo
echo "Creating Archive"
tar -czf "$ARCHIVE_DIR/student_report_$DATE.tar.gz" "$REPORT_DIR"
echo
echo "Archive Details"
ls -lh "$ARCHIVE_DIR"
echo
echo "Scheduling Weekly Report"
CRON_JOB="0 9 * * 1 $(realpath "$0")"
if ! crontab -l 2>/dev/null | grep -qF "$CRON_JOB"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Cron job added successfully."
else
    echo "Cron job already exists."
fi
echo
echo "======================================="
echo "Student Report Generated Successfully"
echo "======================================="
