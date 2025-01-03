$fn = 100;

function tol(value, tolerance = 0.5) = value + tolerance;

dimens = [88.44, 32.8, 14.68];
inner_dimens = [for (dimen = dimens) tol(dimen)];
outer_dimens = [inner_dimens.x + 4, inner_dimens.y + 4, inner_dimens.z + 2];
pwr_cutout_depth = 27;
side_cutout_width = 60;
end_cutout_depth = 15;

screw_shaft_dia = tol(4);
screw_head_dia = screw_shaft_dia + 2.6;
fixture_width = screw_head_dia + 4;
fixture_height = 4;

module Fixture() {
    difference() {
        union() {
            cylinder(h = fixture_height, d = fixture_width, center = false);
            translate([-(fixture_width / 2), 0, 0]) cube([fixture_width, (fixture_width / 2) + 0.5, fixture_height], center = false);
        }
        translate([0, 0, 0]) cylinder(h = fixture_height, d = screw_shaft_dia, center = false);
        translate([0, 0, 2]) cylinder(h = fixture_height / 2, d = screw_head_dia, center = false);
    }
}

translate([0, outer_dimens.y + fixture_width, outer_dimens.z])
rotate([180, 0, 0]) {
    difference() {
        cube(outer_dimens, center = false);
        translate([2, 2, 0]) cube(inner_dimens, center = false);
        translate([0, (inner_dimens.y - pwr_cutout_depth) + 2, 0]) cube([2, pwr_cutout_depth, inner_dimens.z], center = false); 
        translate([(outer_dimens.x - side_cutout_width) / 2, 0, 0]) cube([side_cutout_width, 2, inner_dimens.z], center = false); 
        translate([outer_dimens.x - 2, (outer_dimens.y - end_cutout_depth) / 2, 0]) cube([2, end_cutout_depth, inner_dimens.z], center = false); 
    }

    translate([(outer_dimens.x - side_cutout_width) / 4, outer_dimens.y + (fixture_width / 2), 0]) rotate(180) Fixture();
    translate([(outer_dimens.x - side_cutout_width) / 4, -4.5, 0]) Fixture();
    translate([outer_dimens.x - ((outer_dimens.x - side_cutout_width) / 4), -4.5, 0]) Fixture();
    translate([outer_dimens.x - ((outer_dimens.x - side_cutout_width) / 4), outer_dimens.y + (fixture_width / 2), 0]) rotate(180) Fixture();
}
