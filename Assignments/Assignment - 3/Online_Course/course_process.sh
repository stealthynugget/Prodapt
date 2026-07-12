INPUT_FILE="course_enrollment.txt"
OUTPUT_FILE="report_txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "FILE NOT FOUND!"
    exit 1
fi

total_revenue=0
python_count=0
java_count=0
linux_count=0

course_type() {
    case "$1" in
        Python|Java)
            echo "Programming Course"
            ;;
        Linux)
            echo "System Course"
            ;;
        *)
            echo "Other Course"
            ;;
    esac
}

echo "Course Enrollment Report" > "$REPORT_FILE"
echo "--------------------------" >> "$REPORT_FILE"

while read student course fee
do
    type=$(course_type "$course")
    echo "$student enrolled in $course Fee:$fee Type:$type" >> "$REPORT_FILE"
    total_revenue=$((total_revenue + fee))
    case "$course" in
        Python)
            python_count=$((python_count + 1))
            ;;
        Java)
            java_count=$((java_count + 1))
            ;;
        Linux)
            linux_count=$((linux_count + 1))
            ;;
    esac
done < "$INPUT_FILE"

echo "--------------------------" >> "$REPORT_FILE"
echo "Total Revenue: $total_revenue" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "Course Enrollments" >> "$REPORT_FILE"
echo "Python : $python_count" >> "$REPORT_FILE"
echo "Java   : $java_count" >> "$REPORT_FILE"
echo "Linux  : $linux_count" >> "$REPORT_FILE"

highest=$python_count
popular="Python"

if [ $java_count -gt $highest ]; then
    highest=$java_count
    popular="Java"
fi
if [ $linux_count -gt $highest ]; then
    highest=$linux_count
    popular="Linux"
fi

echo >> "$REPORT_FILE"
echo "Most Popular Course: $popular ($highest Students)" >> "$REPORT_FILE"
echo "Course report generated successfully."
echo

cat "$REPORT_FILE"