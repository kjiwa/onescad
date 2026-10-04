
/* [Hidden] */

// onescad: a.scad

function norm(v) = 99;

// onescad: b.scad

function mk() = function(v) norm(v);

// onescad: main.scad

echo(mk());

echo(mk()([3, 4]));
