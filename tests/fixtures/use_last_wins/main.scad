use <a.scad>
use <b.scad>
echo(shared(1), own(1));
function own(n) = n + 5;
