INPUT_FILE="lib_books.txt"
OUTPUT_FILE="report.txt"

stock_status() {
    stock=$1
    if [ $stock -ge 6 ]; then
        echo "High Stock"
    elif [ $stock -ge 3 ]; then
        echo "Medium Stock"
    else
        echo "Low Stock"
    fi
}

echo "Library Book Report" > "$OUTPUT_FILE"
echo "---------------------" >> "$OUTPUT_FILE"

while read id book stock
do
    status=$(stock_status "$stock")
    echo "$id $book $stock Status:$status" >> "$OUTPUT_FILE"
done < $INPUT_FILE

echo "---------------------" >> "$OUTPUT_FILE"

echo

cat "$OUTPUT_FILE"