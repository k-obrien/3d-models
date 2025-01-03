include <BOSL/constants.scad>
use <BOSL/math.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>

$fn = 50;

module wrench_rack(
    wrench_widths,
    divider_widths,
    rack_start_height,
    rack_end_height,
    magnet_holes
) {
    assert(len(divider_widths) == len(wrench_widths) + 1);
    rack_width = 40;
    rack_base_height = 4;
    rack_height_max = rack_base_height + rack_start_height;
    rack_height_min = rack_base_height + rack_end_height;
    rack_length = sum(wrench_widths) + sum(divider_widths);
    difference() {
        ymove(rack_width / 2) zmove(rack_height_max / 2) yrot(90) rounded_prismoid(
            size1 = [rack_height_max, rack_width], 
            size2 = [rack_height_min, rack_width], 
            h = rack_length, 
            r = 0,
            shift = [(rack_height_max - rack_height_min) / 2, 0]
        );
        angle = atan((rack_height_max - rack_height_min) / rack_length);
        zmove(rack_height_max) yrot(angle) fillet_mask_x(l = 146, r = 5, align = V_RIGHT);
        ymove(rack_width) zmove(rack_height_max) yrot(angle) fillet_mask_x(l = 146, r = 5, align = V_RIGHT);
        for(
            i = [0 : len(wrench_widths) - 1], 
            start = sum(slice(divider_widths, 0, i + 1)) + sum(array_pad(slice(wrench_widths, 0, i), minlen = 1, fill = 0)),
            end = start + wrench_widths[i]
        ) {
            span_cube(xspan = [start, end], yspan = [0, rack_width], zspan = [rack_base_height, rack_height_max]);
        }
        xmove(rack_length / 2) ymove(rack_width / 2) zmove(1.5) xspread(spacing = rack_length / magnet_holes, n = magnet_holes) zcyl(l = 3, d = 10);
    }
}

module combo_wrench_rack() {
    wrench_rack(
        wrench_widths = [5.5, 5.5, 5.5, 5.5, 5, 5, 4.5, 4.5, 4, 3.5, 3.5, 3.5, 3],
        divider_widths = [5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5],
        rack_start_height = 27,
        rack_end_height = 12,
        magnet_holes = 4
    );
}

module socket_wrench_rack() {
    wrench_rack(
        wrench_widths = [6.5, 6, 6, 6],
        divider_widths = [5, 13, 12, 7, 5],
        rack_start_height = 18,
        rack_end_height = 12,
        magnet_holes = 2
    );
}

zmove(40) xrot(-90)
socket_wrench_rack();
// combo_wrench_rack();
