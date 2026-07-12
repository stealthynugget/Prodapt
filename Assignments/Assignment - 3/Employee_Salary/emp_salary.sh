INPUT_FILE="emp_salary.txt"
OUTPUT_FILE="report.txt"

check_bonus(){
    base=$1
    bonus=$((base * 10 / 100))
    echo $bonus
}

echo "Employee Salary Report" > $OUTPUT_FILE
echo "------------------------" >> $OUTPUT_FILE

while read name dep salary
do
    bonus=$(check_bonus $salary)
    total_salary=$(( salary + bonus ))
    echo "$name $dep Basic:$salary Bonus:$bonus Total:$total_salary" >> $OUTPUT_FILE
done < $INPUT_FILE

echo "------------------------" >> $OUTPUT_FILE

echo "Report Generated!"
echo
cat $OUTPUT_FILE