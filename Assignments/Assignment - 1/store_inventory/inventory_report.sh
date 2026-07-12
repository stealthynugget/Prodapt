INVENTORY_FILE="inventory.txt"
REPORT_DIR="reports"
ARCHIVE_DIR="archive"
DATE=$(date +"%Y%m%d_%H%M%S")
mkdir -p "$REPORT_DIR"
mkdir -p "$ARCHIVE_DIR"
if [ ! -f "$INVENTORY_FILE" ]; then
    echo "Inventory file not found."
    exit 1
fi
echo "======================================="
echo " Store Inventory Management Report"
echo "======================================="
echo
echo "Inventory File"
ls -lh "$INVENTORY_FILE"
echo
echo "Complete Inventory"
cat "$INVENTORY_FILE"
echo
echo "First Five Products"
head -5 "$INVENTORY_FILE"
echo
echo "Last Five Products"
tail -5 "$INVENTORY_FILE"
echo
echo "Total Products"
wc -l "$INVENTORY_FILE"
echo
echo "Sorted Inventory"
sort "$INVENTORY_FILE"
echo
echo "Unique Records"
sort "$INVENTORY_FILE" | uniq
echo
echo "Products Containing SSD"
grep "SSD" "$INVENTORY_FILE"
echo
echo "Low Stock Products (Quantity < 10)"
awk '$3<10 {print}' "$INVENTORY_FILE" > "$REPORT_DIR/low_stock.txt"
cat "$REPORT_DIR/low_stock.txt"
echo
echo "Inventory Value"
awk '{
total=$3*$4;
print $1,$2,$3,$4,total;
}' "$INVENTORY_FILE" > "$REPORT_DIR/inventory_value.txt"
cat "$REPORT_DIR/inventory_value.txt"
echo
echo "Replacing Underscore with Space"
sed 's/_/ /g' "$INVENTORY_FILE" > "$REPORT_DIR/updated_inventory.txt"
echo
echo "Updated Inventory"
cat "$REPORT_DIR/updated_inventory.txt"
echo
echo "Summary"
TOTAL_PRODUCTS=$(wc -l < "$INVENTORY_FILE")
LOW_STOCK=$(awk '$3<10' "$INVENTORY_FILE" | wc -l)
echo "Total Products : $TOTAL_PRODUCTS"
echo "Low Stock      : $LOW_STOCK"
cat > "$REPORT_DIR/summary.txt" <<EOF
Store Inventory Summary
Date : $(date)
Total Products : $TOTAL_PRODUCTS
Low Stock Items : $LOW_STOCK
EOF
echo
echo "Running Processes"
ps -ef | head
echo
echo "Disk Usage"
df -h
echo
echo "Compressing Reports"
gzip -f "$REPORT_DIR/summary.txt"
gzip -f "$REPORT_DIR/low_stock.txt"
echo
echo "Creating Archive"
tar -czf "$ARCHIVE_DIR/inventory_reports_$DATE.tar.gz" "$REPORT_DIR"
echo
echo "Archive Created"
ls -lh "$ARCHIVE_DIR"
CRON_JOB="0 8 * * * $(realpath "$0")"
if ! crontab -l 2>/dev/null | grep -qF "$CRON_JOB"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo
    echo "Daily report scheduled at 8:00 AM."
else
    echo
    echo "Cron job already exists."
fi
echo
echo "Inventory report generated successfully."
