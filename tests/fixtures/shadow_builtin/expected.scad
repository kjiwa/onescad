
/* [Hidden] */

// onescad: a.scad

function norm__1(v) = 99;

// onescad: b.scad

function bn(v) = norm__1(v);

function len(v) = 0;

// onescad: main.scad

echo(norm([3, 4]), bn([3, 4]));

cube(len([1, 2, 3]));
