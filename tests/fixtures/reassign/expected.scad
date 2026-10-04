
/* [Hidden] */

// onescad: main.scad

a = 5;

echo(a);

b = a + 1;

echo(b, a);

module m() { sphere(2); }

function f() = 2;

m();

echo(f());
