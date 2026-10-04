function f(x) = x + 1;
function apply(f, v) = f(v);
module run(f) { echo(f(2)); }
echo(apply(function(x) x * 3, 4));
echo(apply(5, 4));
run(function(x) x - 1);
