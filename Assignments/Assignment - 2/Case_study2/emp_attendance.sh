NORMAL_HOURS=8

echo "==================================="
echo " Employee Attendance System"
echo "==================================="

echo "Enter Employee ID:"
read emp_id
echo "Enter Employee Name:"
read emp_name
echo "Enter Working Hours:"
read work_hours
echo
echo "Attendance Details"
echo "---------------------------"
echo "Employee ID   : $emp_id"
echo "Employee Name : $emp_name"
echo "Working Hours : $work_hours"

if [ "$work_hours" -gt "$NORMAL_HOURS" ]; then
    overtime=$((work_hours - NORMAL_HOURS))
    echo "Status         : Overtime"
    echo "Extra Hours    : $overtime"

elif [ "$work_hours" -eq "$NORMAL_HOURS" ]; then
    echo "Status         : Full Day"
    echo "Extra Hours    : 0"

elif [ "$work_hours" -ge 4 ]; then
    echo "Status         : Half Day"
    echo "Extra Hours    : 0"

elif [ "$work_hours" -gt 0 ]; then
    echo "Status         : Less than Half Day"
    echo "Extra Hours    : 0"
    
else
    echo "Status         : Absent"
    echo "Extra Hours    : 0"
fi


echo
echo "Attendance verification completed successfully."
