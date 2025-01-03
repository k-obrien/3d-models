include <roundedcube.scad>

// drawer 377x263x35

module rear_left() {
    difference() {
        cube([173, 123, 35]);
        translate([2, 1, 2]) {
            roundedcube([170, 120, 35], radius = 2, apply_to = "x");
        }
    }
}

module front_left() {
    difference() {
        cube([173, 140, 35]);
        translate([2, 2, 2]) {
            roundedcube([170, 137, 35], radius = 2, apply_to = "zmin");
        }
    }
}

module rear_right() {
    difference() {
        cube([204, 158, 35]);
        // left cutout
        translate([1, 0, 2]) {
            roundedcube([47, 156, 35], radius = 2, apply_to = "y");
        }
        // middle cutout
        translate([50, 1, 2]) {
            roundedcube([50, 155, 35], radius = 2, apply_to = "y");
        }
        // right cutout
        translate([102, 1, 2]) {
            roundedcube([100, 155, 35], radius = 2, apply_to = "y");
        }
    }
}

module front_right() {
    difference() {
        cube([204, 105, 35]);
        // left cutout
        translate([1, 2, 2]) {
            roundedcube([47, 105, 35], radius = 2, apply_to = "y");
        }
        // middle cutout
        translate([50, 2, 2]) {
            roundedcube([50, 102, 35], radius = 2, apply_to = "zmin");
        }
        // right cutout
        translate([102, 2, 2]) {
            roundedcube([100, 102, 35], radius = 2, apply_to = "zmin");
        }
    }
}

front_left();
translate([173, 0, 0]) front_right();
translate([0, 140, 0]) rear_left();
translate([173, 105, 0]) rear_right();