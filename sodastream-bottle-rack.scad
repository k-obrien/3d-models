$fn = 100;

// ************
// *** RACK ***
// ************

module Cutout() {
    cube([6, 3.5, 5], center = false);
}

module Panel() {
    difference() {
        cube([140, 96, 3], center = false);
        translate([-1, 8.25, -1]) Cutout();
        translate([135, 3.25, -1]) Cutout();
        translate([-1, 84.25, -1]) Cutout();
        translate([135, 89.25, -1]) Cutout();
    }
}

module BottleBottom() {
    cylinder(5, d = 76, center = false);
}

module BottleNeck() {
    cylinder(5, d = 35.5, center = false);
}

module Bottle() {
    cylinder(5, d = 86, center = false);
}

module RearPanel() {
    difference() {
        Panel();
        translate([48, 48, -1]) BottleBottom();
        translate([140, 48, -1]) BottleBottom();
    }
}

module FrontPanel() {
    difference() {
        Panel();
        translate([48, 48, -1]) BottleNeck();
        translate([76.25, 48, -1]) Bottle();
        translate([140, 48, -1]) BottleNeck();
    }
}

// ************
// *** BASE ***
// ************

eps = 0.1;

module BottomBrace() {
    dimens = [9, 15, 15];
    cube([dimens.x, dimens.y, dimens.z + eps], center = false);
}

module Base() {
    dimens = [280, 102, 5];
    difference() {
        union() {
            cube([dimens.x, dimens.y, dimens.z]);
            translate([25, 0, dimens.z - eps]) BottomBrace();
            translate([25, dimens.y - 15, dimens.z - eps]) BottomBrace();
            translate([25 + 3 + 217, 0, dimens.z - eps]) BottomBrace();
            translate([25 + 3 + 217, dimens.y - 15, dimens.z - eps]) BottomBrace();
        }
        translate([31, 3, dimens.z]) rotate([0, 270, 0]) FrontPanel();
        translate([25 + 3 + 3 + 3 + 217, 3, dimens.z]) rotate([0, 270, 0]) RearPanel();
    }
}

module CutOff() {
    dimens = [142, 104, 30];
    cube([dimens.x, dimens.y, dimens.z], center = false);
}

module Key() {
    eps = 5;
    dimens = [140, 102, 2.5];
    key_diameter = dimens.y / 4;
    translate([dimens.x + (key_diameter / 2) - eps, key_diameter, 0]) cylinder(dimens.z, d = key_diameter, center = false);
}

module Lock() {
    eps = 5;
    dimens = [140, 102, 2.5];
    lock_diameter = dimens.y / 4;
    translate([dimens.x - (lock_diameter / 2) + eps, lock_diameter * 3, -0.1]) cylinder(dimens.z + 0.2, d = lock_diameter, center = false);
}

module FrontBase() {
    union() {
        difference() {
            Base();
            translate([140, -1, -1]) CutOff();
            Lock();
        }
        Key();
    }
}

module RearBase() {
    union() {
        difference() {
            rotate([0, 0, 180]) translate([-280, -102, 0]) Base();
            translate([140, -1, -1]) CutOff();
            Lock();
        }
        Key();
    }
}

// *************
// *** BRACE ***
// *************

module TopBrace() {
    translate([0, 0, 3]) {
        rotate([-90, 0, 0]) translate([-25, -6.75, -135]) {
            difference() {
                translate([25, 6.75, 135]) { translate([0, 3, 0]) rotate([90, 0, 0]) cube([229, 10, 3.5]); };
                translate([31, 3, 5]) rotate([0, 270, 0]) FrontPanel();
                translate([25 + 3 + 3 + 3 + 217, 3, 5]) rotate([0, 270, 0]) RearPanel();
            }
        }
    }
}

// *************
// *** MODEL ***
// *************

// FrontBase();
// translate([280, 102, 0]) rotate([0, 0, 180]) RearBase();
// translate([31, 3, 5]) rotate([0, 270, 0]) FrontPanel();
// translate([25 + 3 + 3 + 3 + 217, 3, 5]) rotate([0, 270, 0]) RearPanel();
// translate([25, 6.75, 135]) { translate([0, 3, 0]) rotate([90, 0, 0]) TopBrace(); };
// translate([25, 92.75, 135]) { translate([0, 3, 0]) rotate([90, 0, 0]) TopBrace(); };

// *************
// *** PRINT ***
// *************

// translate([30, 50, 0]) FrontBase();
// translate([30, 50, 0]) RearBase();
// FrontPanel();
// RearPanel();
translate([35, 20, 0]) rotate(45) {
    TopBrace();
    translate([0, 15, 0]) TopBrace();
}
