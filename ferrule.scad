include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn = 100;

string_diameter = 5;
knot_diameter = 8;
ferrule_diameter = 25;

move(x = 30, y = 15, z = 11.8) xspread(l = 30) difference() {
    onion(d = ferrule_diameter, maxang = 20, cap_h = 26);
    up(z = 40) downcyl(h = 60, d = string_diameter);
    up(z = 8.6) downcyl(h = 21, d = knot_diameter);
}
