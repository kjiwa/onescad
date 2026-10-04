
/* [Parameters] */
g = 100;
v = 7;

/* [Hidden] */

// onescad: main.scad

function g(x) = x + 1;

module t() {
  a = 1;
  b = a + 1;
  echo(a, b, c);
  c = 3;
  echo(g(1), g);
  v = 8;
  echo(v);
  echo(h(2));
  function h(n) = n * v;
}

t();

echo(g(1), g);

function inner_var(f) = let(len = 5) len + f;

echo(inner_var(1));
