echo "========================================"
echo "     Welcome to Online Food Ordering"
echo "========================================"
echo "Available Food Items"
echo "1. Pizza      - Rs.250"
echo "2. Burger     - Rs.150"
echo "3. Biryani    - Rs.220"
echo "4. Dosa       - Rs.100"
echo "5. FriedRice  - Rs.180"
echo "========================================"
echo -n "Enter Customer Name: "
read customer
echo -n "Enter Food Item: "
read food
echo -n "Enter Quantity: "
read quantity

case "$food" in
    Pizza)
        price=250
        ;;
    Burger)
        price=150
        ;;
    Biryani)
        price=220
        ;;
    Dosa)
        price=100
        ;;
    FriedRice)
        price=180
        ;;
    *)
        echo "Invalid Food Item."
        exit 1
        ;;
esac
if [ "$quantity" -lt 1 ] || [ "$quantity" -gt 10 ]; then
    echo "Quantity should be between 1 and 10."
    exit 1
fi
total=$((price * quantity))
if [ "$total" -ge 1000 ]; then
    delivery=0
elif [ "$total" -ge 500 ]; then
    delivery=30
else
    delivery=50
fi
final=$((total + delivery))
echo
echo "========================================"
echo "          Order Summary"
echo "========================================"
echo "Customer Name : $customer"
echo "Food Item     : $food"
echo "Price         : Rs.$price"
echo "Quantity      : $quantity"
echo "Order Amount  : Rs.$total"
echo "Delivery Fee  : Rs.$delivery"
echo "Final Amount  : Rs.$final"
echo "========================================"
echo "Order Placed Successfully!"
echo "========================================"
