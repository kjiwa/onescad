// Edge cases for the Customizer.

/* [Dimensions] */
// Width in mm
width = 10; // [1:50]
// Height
height = 0x1F;
depth = 1e2;
neg = -3;
size = [1, 2, 3];
flag = true;
$fn = 24;
dup = 1;
dup = 2;
computed = width * 2;
label = "a{b";

/* [Other] */
inner = "x";
module m() {
  cube(width);
}
after = 9;
dropped = 4;
dropped = 5;
m();
echo(width, height, depth, neg, size, flag, dup, computed, label, inner, after, dropped);
