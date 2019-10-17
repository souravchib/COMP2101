#!/bin/bash
#
# this script demonstrates doing arithmetic
# Improve this script by asking the user to supply the two numbers
# Improve this script by demonstrating using subtraction and multiplication
# Improve this script by demonstrating the modulus operation
#   - the output should look something like:
#   - first divided by second gives X with a remainder of Y
# Improve this script by calculating and displaying the first number raised to the power of the second number
read -p "Input1? " firststinput
read -p "Input2? " secondinput
sum=$((firststinput + secondinput))
sub=$((firststinput - secondinput))
dividend=$((firststinput / secondinput))
multiply=$((firststinput * secondinput))
remainder=$((firststinput % secondinput))
power=$((firststinput**secondinput))
fpdividend=$(awk "BEGIN{printf \"%.2f\", $firststinput/$secondinput}")
cat <<EOF
$firststinput plus $secondinput is $sum
$firststinput divided by $secondinput gives $dividend with reminder of $remainder
  - More precisely, dividend is $fpdividend
$firststinput multiply by $secondinput is $multiply
$firststinput subtracting by $secondinput is $sub
Displaying the $firststinput raised to the power of the $secondinput is $power
EOF
