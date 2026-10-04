// Doubles things.
use <lib.scad>
use <mid.scad>
/* [Size] */
w = 10; // [1:20]
cube(helper(w));
echo(viaMid(2));
