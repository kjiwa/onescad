
/* [Hidden] */

// onescad: a.scad

function other(n) = n * 10;

// onescad: main.scad

x = later(2);

echo(x);

echo(other(1));

function later(n) = n + 100;
