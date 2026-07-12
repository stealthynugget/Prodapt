if [ $# -ne 7 ]; then
    echo "Usage: ./student_result.sh <ID> <Name> <Maths> <Science> <English> <Social> <Computer>"
    exit 1
fi

id=$1
name=$2
maths=$3
sci=$4
eng=$5
social=$6
computer=$7

get_grade() {
    mark=$1
    if [ $mark -ge 90 ]; then
        echo "A+"
    elif [ $mark -ge 80 ]; then
        echo "A"
    elif [ $mark -ge 70 ]; then
        echo "B"
    elif [ $mark -ge 60 ]; then
        echo "C"
    elif [ $mark -ge 50 ]; then
        echo "D"
    elif [ $mark -ge 35 ]; then
        echo "E"
    else
        echo "F"
    fi
}
get_result() {
    mark=$1
    if [ $mark -ge 35 ]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}
math_grade=$(get_grade $maths)
sci_grade=$(get_grade $sci)
eng_grade=$(get_grade $eng)
social_grade=$(get_grade $social)
computer_grade=$(get_grade $computer)
math_result=$(get_result $maths)
sci_result=$(get_result $sci)
eng_result=$(get_result $eng)
social_result=$(get_result $social)
computer_result=$(get_result $computer)
total=$((maths + sci + eng + social + computer))
percentage=$((total / 5))
overall_grade=$(get_grade $percentage)
if [ $maths -ge 35 ] && [ $sci -ge 35 ] && [ $eng -ge 35 ] && [ $social -ge 35 ] && [ $computer -ge 35 ]; then
    overall_result="PASS"
else
    overall_result="FAIL"
    overall_grade="F"
fi
echo "========================================="
echo "      Student Result Evaluation"
echo "========================================="
echo "Student ID   : $id"
echo "Student Name : $name"
echo
printf "%-12s %-8s %-8s %-8s\n" "Subject" "Marks" "Result" "Grade"
echo "-----------------------------------------"
printf "%-12s %-8s %-8s %-8s\n" "Maths" "$maths" "$math_result" "$math_grade"
printf "%-12s %-8s %-8s %-8s\n" "Science" "$sci" "$sci_result" "$sci_grade"
printf "%-12s %-8s %-8s %-8s\n" "English" "$eng" "$eng_result" "$eng_grade"
printf "%-12s %-8s %-8s %-8s\n" "Social" "$social" "$social_result" "$social_grade"
printf "%-12s %-8s %-8s %-8s\n" "Computer" "$computer" "$computer_result" "$computer_grade"
echo "-----------------------------------------"
echo "Total Marks : $total / 500"
echo "Percentage  : $percentage%"
echo "Overall Result : $overall_result"
echo "Overall Grade  : $overall_grade"
echo "========================================="
