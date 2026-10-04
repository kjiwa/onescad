
/* [Parameters] */
scale_by = 3;

/* [Hidden] */

// onescad: lib.scad

scale_by__1 = 10;

function scaled(n, k = scale_by__1) = n * k;

// onescad: main.scad

echo(scaled(2));

echo(scaled(2, scale_by));

module box(s = scale_by) { cube(s); }

box();
