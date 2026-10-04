big = 1;
function dead() = big;
module unused() { cube(big); }
module used() { sub(); }
module sub() { sphere(2); }
