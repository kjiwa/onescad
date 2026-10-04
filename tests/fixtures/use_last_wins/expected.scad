
/* [Hidden] */

// onescad: b.scad

function shared(n) = n * 20;

// onescad: main.scad

echo(shared(1), own(1));

function own(n) = n + 5;
