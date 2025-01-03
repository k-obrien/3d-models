$fn = 100;

function tol(value, tolerance = 0.5) = value + tolerance;

module Cutout() {
    translate([10, 10, 0]) cylinder(h = 1, d = tol(9.52), center = false);
    translate([10 - (tol(8.7) / 2), 0, 0]) cube([tol(8.7), 10, 1], center = false);
}

union() {
    difference() {
        cube([60, tol(20), 1], center = false);
        translate([0, 0, 0]) Cutout();
        translate([20, 0, 0]) Cutout();
        translate([40, 0, 0]) Cutout();
    }
    translate([0, 20, 0]) cube([60, 3, 15]);
}
