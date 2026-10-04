//
// Doubles things.

/* [Size] */
w = 10; // [1:20]

/* [Hidden] */

// onescad: lib.scad

function helper(x) = x * 2;

// onescad: mid.scad

function viaMid(x) = helper(x) + 1;

// onescad: main.scad

cube(helper(w));

echo(viaMid(2));
