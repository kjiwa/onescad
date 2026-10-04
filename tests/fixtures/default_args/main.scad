use <lib.scad>
scale_by = 3;
echo(scaled(2));
echo(scaled(2, scale_by));
module box(s = scale_by) { cube(s); }
box();
