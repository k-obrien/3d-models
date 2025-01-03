include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = 50;

arm_y = 150;
arm_x = 20;
arm_z = 2;

module peg(y) {
    peg_diameter = 3.8;
    peg_height = 1.45;
    move([arm_x / 2, y, arm_z - 0.1]) zcyl(h = peg_height, d = peg_diameter);
}

cube([arm_x, arm_y, arm_z]);
peg(5.5);
peg(arm_y - 5.5);

stem_y = 50;
difference() {
    move([arm_x - 1, arm_y - stem_y, 0]) {
        rotate([90]) {
            linear_extrude(height = stem_y) {
                polygon(
                    [
                        [0, 0], [0, 2], // top
                        [1, 2], [37, 7], [50, 7], // face
                        [50, 0], // bottom
                        [0, 0] // rear
                    ]
                );
            }
        }
    }
    magnet_size = 5;
    move([arm_x + 49 - magnet_size, arm_y / 2, (magnet_size / 2) + 1]) yspread(spacing = stem_y / 3, n = 3, l = stem_y) xcyl(l = magnet_size, d = magnet_size, center = false);
}
